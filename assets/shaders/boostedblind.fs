#if defined(VERTEX)||__VERSION__>100||defined(GL_FRAGMENT_PRECISION_HIGH)
#define PRECISION highp
#else
#define PRECISION mediump
#endif

// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 boostedblind;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply
//        it by sprite_width _height (look flipped.fs)
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// [Required]
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex,vec2 texture_coords,vec2 uv);

#define PI 3.14159265358979323846
float rand(vec2 c){
    return fract(sin(dot(c.xy,vec2(12.9898,78.233)))*43758.5453);
}

float noise(vec2 p,float freq){
    float unit=1./freq;
    vec2 ij=floor(p/unit);
    vec2 xy=mod(p,unit)/unit;
    //xy = 3.*xy*xy-2.*xy*xy*xy;
    xy=.5*(1.-cos(PI*xy));
    float a=rand((ij+vec2(0.,0.)));
    float b=rand((ij+vec2(1.,0.)));
    float c=rand((ij+vec2(0.,1.)));
    float d=rand((ij+vec2(1.,1.)));
    float x1=mix(a,b,xy.x);
    float x2=mix(c,d,xy.x);
    return mix(x1,x2,xy.y);
}

float pNoise(vec2 p,int res){
    float persistance=.5;
    float n=0.;
    float normK=0.;
    float f=4.;
    float amp=1.;
    int iCount=0;
    for(int i=0;i<50;i++){
        n+=amp*noise(p,f);
        f*=2.;
        normK+=amp;
        amp*=persistance;
        if(iCount==res)break;
        iCount++;
    }
    float nf=n/normK;
    return nf*nf*nf*nf;
}

vec4 RGBtoHSV(vec4 rgb)
{
    vec4 hsv;
    float minVal=min(min(rgb.r,rgb.g),rgb.b);
    float maxVal=max(max(rgb.r,rgb.g),rgb.b);
    float delta=maxVal-minVal;
    
    // Value
    hsv.z=maxVal;
    
    // Saturation
    if(maxVal!=0.)
    hsv.y=delta/maxVal;
    else{
        // r = g = b = 0, s = 0, v is undefined
        hsv.y=0.;
        hsv.x=-1.;
        return hsv;
    }
    
    // Hue
    if(rgb.r==maxVal)
    hsv.x=(rgb.g-rgb.b)/delta;// between yellow & magenta
    else if(rgb.g==maxVal)
    hsv.x=2.+(rgb.b-rgb.r)/delta;// between cyan & yellow
    else
    hsv.x=4.+(rgb.r-rgb.g)/delta;// between magenta & cyan
    
    hsv.x=hsv.x*(1./6.);
    if(hsv.x<0.)
    hsv.x+=1.;
    
    // Alpha
    hsv.w=rgb.a;
    
    return hsv;
}

vec4 HSVtoRGB(vec4 hsv){
    vec4 rgb;
    
    float h=hsv.x*6.;
    float c=hsv.z*hsv.y;
    float x=c*(1.-abs(mod(h,2.)-1.));
    float m=hsv.z-c;
    
    if(h<1.){
        rgb=vec4(c,x,0.,hsv.a);
    }else if(h<2.){
        rgb=vec4(x,c,0.,hsv.a);
    }else if(h<3.){
        rgb=vec4(0.,c,x,hsv.a);
    }else if(h<4.){
        rgb=vec4(0.,x,c,hsv.a);
    }else if(h<5.){
        rgb=vec4(x,0.,c,hsv.a);
    }else{
        rgb=vec4(c,0.,x,hsv.a);
    }
    
    rgb.rgb+=m;
    
    return rgb;
}

// This is what actually changes the look of card
vec4 effect(vec4 colour,Image texture,vec2 texture_coords,vec2 screen_coords)
{
    vec4 tex=Texel(texture,texture_coords);
    vec2 uv=(((texture_coords)*(image_details))-texture_details.xy*texture_details.ba)/texture_details.ba;
    
    float vshift=(1.5-uv.y)/4.;//strength
    float sign_noise=(pNoise(vec2(uv.x,uv.y),1)-.5);
    vshift*=sign_noise;
    float noise_value=pNoise(vec2(uv.x+vshift,uv.y+(boostedblind.y*.7)),1.);
    float boost=RGBtoHSV(tex).z;
    boost=pow(boost,2.)*1.5;
    noise_value=pow(2.*noise_value,(.9-uv.y)*1.5)/(1.+(1.-uv.y));
    noise_value*=.5+sin(uv.x*PI);
    tex*=vec4(.8+(uv.y),1.-.2,1.+(1.-uv.y),1.)*(noise_value*boost)*3.;
    
    // tex = vec4(noise_value,noise_value,noise_value,1);
    
    return dissolve_mask(tex*colour,texture_coords,uv);
}

vec4 dissolve_mask(vec4 tex,vec2 texture_coords,vec2 uv)
{
    if(dissolve<.001){
        return vec4(shadow?vec3(0.,0.,0.):tex.xyz,shadow?tex.a*.3:tex.a);
    }
    
    float adjusted_dissolve=(dissolve*dissolve*(3.-2.*dissolve))*1.02-.01;//Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values
    
    float t=time*10.+2003.;
    vec2 floored_uv=(floor((uv*texture_details.ba)))/max(texture_details.b,texture_details.a);
    vec2 uv_scaled_centered=(floored_uv-.5)*2.3*max(texture_details.b,texture_details.a);
    
    vec2 field_part1=uv_scaled_centered+50.*vec2(sin(-t/143.6340),cos(-t/99.4324));
    vec2 field_part2=uv_scaled_centered+50.*vec2(cos(t/53.1532),cos(t/61.4532));
    vec2 field_part3=uv_scaled_centered+50.*vec2(sin(-t/87.53218),sin(-t/49.));
    
    float field=(1.+(
            cos(length(field_part1)/19.483)+sin(length(field_part2)/33.155)*cos(field_part2.y/15.73)+
            cos(length(field_part3)/27.193)*sin(field_part3.x/21.92)))/2.;
            vec2 borders=vec2(.2,.8);
            
            float res=(.5+.5*cos((adjusted_dissolve)/82.612+(field+-.5)*3.14))
            -(floored_uv.x>borders.y?(floored_uv.x-borders.y)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.y>borders.y?(floored_uv.y-borders.y)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.x<borders.x?(borders.x-floored_uv.x)*(5.+5.*dissolve):0.)*(dissolve)
            -(floored_uv.y<borders.x?(borders.x-floored_uv.y)*(5.+5.*dissolve):0.)*(dissolve);
            
            if(tex.a>.01&&burn_colour_1.a>.01&&!shadow&&res<adjusted_dissolve+.8*(.5-abs(adjusted_dissolve-.5))&&res>adjusted_dissolve){
                if(!shadow&&res<adjusted_dissolve+.5*(.5-abs(adjusted_dissolve-.5))&&res>adjusted_dissolve){
                    tex.rgba=burn_colour_1.rgba;
                }else if(burn_colour_2.a>.01){
                    tex.rgba=burn_colour_2.rgba;
                }
            }
            
            return vec4(shadow?vec3(0.,0.,0.):tex.xyz,res>adjusted_dissolve?(shadow?tex.a*.3:tex.a):.0);
        }
        
        extern PRECISION vec2 mouse_screen_pos;
        extern PRECISION float hovering;
        extern PRECISION float screen_scale;
        
        #ifdef VERTEX
        vec4 position(mat4 transform_projection,vec4 vertex_position)
        {
            if(hovering<=0.){
                return transform_projection*vertex_position;
            }
            float mid_dist=length(vertex_position.xy-.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
            vec2 mouse_offset=(vertex_position.xy-mouse_screen_pos.xy)/screen_scale;
            float scale=.2*(-.03-.3*max(0.,.3-mid_dist))
            *hovering*(length(mouse_offset)*length(mouse_offset))/(2.-mid_dist);
            
            return transform_projection*vertex_position+vec4(0,0,0,scale);
        }
        #endif
        