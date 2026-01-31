#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float iTime;
extern float width;
extern float height;
extern vec2 resolution;

float rand(vec2 c){
    return fract(sin(dot(c.xy,vec2(12.9898,78.233)))*43758.5453);
}

float lindist(float a,float b){
    return abs(a-b);
}

float psin(float x) {
    return (1.0+sin(x))/2.0;
}

float map(float v, float imi, float ima, float omi, float oma) {
    return (v - imi) * (oma - omi) / (ima - imi) + omi;
}

vec2 polar_coords(vec2 pos, vec2 origin){
    vec2 normalized=pos-origin;
    origin=vec2(0.,0.);
    float r=distance(normalized,origin);
    float theta=atan(normalized.y,normalized.x);
    
    return vec2(r,theta);
}

vec2 cartesian_coords(vec2 pos, vec2 origin) {
    float x = pos.x * cos(pos.y);
    float y = pos.x * sin(pos.y);
    return vec2(x, y) - origin;
}

float lerp(float a, float b, float t) {
    return a + (t * (b - a));
}

vec2 lerp(vec2 a, vec2 b, float t) {
    return vec2(lerp(a.x, b.x, t), lerp(a.y, b.y, t));
}

vec3 square(vec3 i) {
    return vec3(pow(i.x, 2), pow(i.y, 2), pow(i.z, 2));
}

// This is what actually changes the look of card
vec4 effect(vec4 colour,Image texture,vec2 tc,vec2 screen_coords)
{
    vec4 tex=Texel(texture,tc);
    
    vec2 sc=screen_coords;//alias
    vec2 cep=center_pos;//alias

    float speed = 3.0;
    float radius = 14.0;

    cep.x += sin(iTime*speed)*width;
    cep.y += cos(iTime*speed)*height;

    float dist = distance(sc, cep);
    float variance = 1.1;
    float rVariance = map(psin(iTime), 0.0, 1.0, variance, 1.0 / variance);
    float t = radius * rVariance;

    float extra = radius*3.0;
    float exmul = 2.0;

    if (dist <= t) {
        vec2 new_tc = polar_coords(tc * resolution, cep);
        new_tc.y = pow(abs(new_tc.y), 1.5) * sign(new_tc.y);
        new_tc = cartesian_coords(new_tc, -cep);
        tex = Texel(texture, new_tc / resolution);

        tex.rgb = 1.0 - tex.rgb;
        tex.rgb = square(tex.rgb);
    }

    if (dist <= t+extra) {
        tex.rgb *= (t+extra) / dist; 
    }
    
    
    
    return tex;
}

#ifdef VERTEX
vec4 position(mat4 transform_projection,vec4 vertex_position)
{
    return transform_projection*vertex_position;
}
#endif