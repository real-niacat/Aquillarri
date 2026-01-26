#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float dist;

float rand(vec2 c){
    return fract(sin(dot(c.xy,vec2(12.9898,78.233)))*43758.5453);
}

float lindist(float a,float b){
    return abs(a-b);
}

vec2 polar_coords(vec2 pos,vec2 origin){
    vec2 normalized=pos-origin;
    origin=vec2(0.,0.);
    float r=distance(normalized,origin);
    float theta=atan(normalized.y,normalized.x);
    
    return vec2(r,theta);
}

float min_dist=dist;
float max_dist=2*dist;

float get_t(vec2 pos){
    float d=distance(center_pos,pos);
    float t=0.;
    if(min_dist<d&&d<max_dist){
        t=1.;
    }
    return t;
}

// This is what actually changes the look of card
vec4 effect(vec4 colour,Image texture,vec2 tc,vec2 screen_coords)
{
    vec4 tex=Texel(texture,tc);
    
    float t=0.;
    float c=3;
    float iterated=0.;
    vec2 sc=screen_coords;//alias
    vec2 cep=center_pos;//ditto
    
    for(float ix=-c;ix<=c;ix++){
        for(float iy=-c;iy<=c;iy++){
            t+=get_t(vec2(screen_coords.x+ix,screen_coords.y+iy));
            iterated++;
        }
    }
    t/=iterated;
    
    vec4 inverted=tex;
    inverted.rgb=1.-inverted.rgb;
    
    tex=(t*inverted)+((1-t)*tex);
    
    float strength=lindist(t,0.5);
    if(strength<.2){
        tex.rgb=vec3(0);
    }
    
    float cdist=distance(center_pos,screen_coords);
    float max_mult = 2;
    float rad = dist / 10.0;
    if (cdist < min_dist) {
        float str = (rad - abs(min_dist-cdist)) / rad;
        tex.rgb *= max(str*max_mult,1.0);
    }

    if (cdist > max_dist) {
        float str = (rad - abs(max_mult-cdist)) / rad;
        tex.rgb *= max(str*max_mult,1.0);
    }
    
    return tex;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
    return transform_projection*vertex_position;
}
#endif