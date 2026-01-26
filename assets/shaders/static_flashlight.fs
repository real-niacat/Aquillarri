#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float dist;
extern float iTime;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float psin(float x) {
    return (1+sin(x))/2;
}

float noise(vec2 texCoord, float t)
{
    const float e = 2.7182818284590452353602874713527;
    float G = e + (t * 0.1);
    vec2 r = (G * sin(G * texCoord.xy));
    return fract(r.x * r.y * (1.0 + texCoord.x));
}

float lerp(float a, float b, float t) {
    return a + (t * (b - a));
}

vec4 lerp(vec4 a, vec4 b, float t) {
    return vec4(lerp(a.x, b.x, t), lerp(a.y, b.y, t), lerp(a.z, b.z, t), lerp(a.w, b.w, t));
}

vec4 vector_smoothstep(vec4 a, vec4 b, float t) {
    return vec4(smoothstep(a.x, b.x, t), smoothstep(a.y, b.y, t), smoothstep(a.z, b.z, t), smoothstep(a.w, b.w, t));
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 tc, vec2 screen_coords )
{

    vec4 tex = Texel(texture, tc);
    

    float static_intensity = 1.0 - ((dist - distance(center_pos, screen_coords))/dist);
    static_intensity = pow(static_intensity, 2.0);
    float n = noise(screen_coords, iTime);
    tex = lerp(tex, vec4(n,n,n,1.0), static_intensity);

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif