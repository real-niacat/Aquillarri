
#define PI 3.14159265358979323846

extern float iTime;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float noise(vec2 p, float freq ){
	float unit = 1./freq;
	vec2 ij = floor(p/unit);
	vec2 xy = mod(p,unit)/unit;
	//xy = 3.*xy*xy-2.*xy*xy*xy;
	xy = .5*(1.-cos(PI*xy));
	float a = rand((ij+vec2(0.,0.)));
	float b = rand((ij+vec2(1.,0.)));
	float c = rand((ij+vec2(0.,1.)));
	float d = rand((ij+vec2(1.,1.)));
	float x1 = mix(a, b, xy.x);
	float x2 = mix(c, d, xy.x);
	return mix(x1, x2, xy.y);
}

vec2 shift(vec2 pos, float x, float y) {
    return vec2(pos.x+x, pos.y+y);
}

float pos_sin(float i) {
    return (1.+sin(i))/2.;
}



vec4 RGBtoHSV(vec4 rgb)
{
    vec4 hsv;
    float minVal = min(min(rgb.r, rgb.g), rgb.b);
    float maxVal = max(max(rgb.r, rgb.g), rgb.b);
    float delta = maxVal - minVal;

    // Value
    hsv.z = maxVal;

    // Saturation
    if (maxVal != 0.0)
        hsv.y = delta / maxVal;
    else {
        // r = g = b = 0, s = 0, v is undefined
        hsv.y = 0.0;
        hsv.x = -1.0;
        return hsv;
    }

    // Hue
    if (rgb.r == maxVal)
        hsv.x = (rgb.g - rgb.b) / delta;      // between yellow & magenta
    else if (rgb.g == maxVal)
        hsv.x = 2.0 + (rgb.b - rgb.r) / delta;  // between cyan & yellow
    else
        hsv.x = 4.0 + (rgb.r - rgb.g) / delta;  // between magenta & cyan

    hsv.x = hsv.x * (1.0 / 6.0);
    if (hsv.x < 0.0)
        hsv.x += 1.0;

    // Alpha
    hsv.w = rgb.a;

    return hsv;
}

vec4 HSVtoRGB(vec4 hsv) {
    vec4 rgb;

    float h = hsv.x * 6.0;
    float c = hsv.z * hsv.y;
    float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
    float m = hsv.z - c;

    if (h < 1.0) {
        rgb = vec4(c, x, 0.0, hsv.a);
    } else if (h < 2.0) {
        rgb = vec4(x, c, 0.0, hsv.a);
    } else if (h < 3.0) {
        rgb = vec4(0.0, c, x, hsv.a);
    } else if (h < 4.0) {
        rgb = vec4(0.0, x, c, hsv.a);
    } else if (h < 5.0) {
        rgb = vec4(x, 0.0, c, hsv.a);
    } else {
        rgb = vec4(c, 0.0, x, hsv.a);
    }

    rgb.rgb += m;

    return rgb;
}

vec4 hueshift(vec4 color, float amount) {
    color = RGBtoHSV(color);
    color.r = mod(amount+color.r, 1.);
    color = HSVtoRGB(color);
    return color;
}

float get_stars(vec2 uv) {
    return pow(noise(shift(uv,(iTime*0.01) + uv.x,0.), 35.),11.);
}

vec3 powvec(vec3 a, float e) {
    return vec3(pow(a.x,e), pow(a.y,e), pow(a.z,e));
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // Take pixel color (rgba) from `texture` at `texture_coords`, equivalent of texture2D in GLSL
    vec4 tex = vec4(1);
    // Position of a pixel within the sprite
	vec2 uv = texture_coords * 8.0; //used for bg shader, doesnt matter
    //tex = texture(iChannel0, uv);
    float mul = 5.;
    uv *= mul;
    uv.x *= mul;

    vec2 screen = vec2(0);


    // tex.b += noise(uv, 2);
    float ex = 5.;
    tex = vec4(pow(tex.x,ex),pow(tex.y,ex),pow(tex.z,ex),tex.w);
    tex = RGBtoHSV(tex);
    tex.z = 0.9 - tex.z;
    // -0.1 to 0.9
    float v = 0.9 - tex.z;
    uv += screen*(v*2.);
    tex = HSVtoRGB(tex);

    //slow-moving blue layer
    float dampen_speed = 3.;
    vec4 blue_layer = vec4(0.,0.,noise(shift(uv,-iTime/(dampen_speed*25.0),dampen_speed), 3.0)/2.,0.);
    
    //faster-moving purple layer
    float purple_strength = noise(shift(uv,iTime/dampen_speed,0.), 2.0);
    vec4 purple_layer = vec4(purple_strength*0.3,0.,purple_strength*0.8,0.);
    
    // twinkling star layer
    float star_strength = 0.;
    float orthoavg = 0.;
    float diagavg = 0.;
    float scale = 5.;
    float pixels_looped = 0.;
    vec2 pixel = vec2(1.,1.) / vec2(100.,100.);
    for (float i = -scale; i <= scale; i++) {
        orthoavg += get_stars(shift(uv,pixel.x*i,0.));
        pixels_looped++;
    }

    for (float j = -scale; j <= scale; j++) {
        orthoavg += get_stars(shift(uv,0.,pixel.y*j));
        pixels_looped++;
    }

    float circle_pixels = 0.;
    for (float i = -scale; i <= scale; i++) {
        for (float j = -scale; j <= scale; j++) {
            diagavg += get_stars(shift(uv,pixel.x*i,pixel.y*j));
            circle_pixels++;
        }
    }

    orthoavg /= pixels_looped;
    circle_pixels /= 3.;
    star_strength = (orthoavg*5.) + (diagavg/circle_pixels);
    vec4 star_layer = vec4(star_strength, star_strength, star_strength, 0.0);
    
    //orange gas layer
    vec4 orange_colour = vec4(0.8,0.6,0.1,0);
    
    float rdist = 0.2;
    float rspeed = 0.8;
    float rx = sin(iTime*rspeed)*rdist;
    float ry = cos(iTime*rspeed)*rdist;
    rx += iTime*(rspeed/5.0); //prevents rotating around the same thing forever
    float orange_noise = noise(shift(uv,rx,ry), 0.5);
    float dampen = pow(orange_noise, 2.0);
    float dampdiv = max(dampen*4.0, 1.0);
 
    
    float gas_strength = pow(orange_noise,3.0);
    //debug line
    //tex.rgb = vec3(gas_strength);
    
    
    
    // final color modification
    //combine previous layers
    tex += blue_layer / dampdiv;
    tex += purple_layer / dampdiv;
    tex += star_layer / (pow(dampdiv, 1.3)*1.2);
    
    tex /= max(dampen*1.25, 1.0);
    tex += orange_noise*orange_colour*pow(dampdiv, 0.9);
    
    
    float value = RGBtoHSV(tex).z;
    tex += (purple_layer+blue_layer)*(0.25*value);


    
    return vec4(tex.rgb, 1.0);
}
