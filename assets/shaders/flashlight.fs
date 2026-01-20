#define PI 3.14159265358979323846

extern vec2 center_pos;
extern float dist;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float psin(float x) {
    return (1+sin(x))/2;
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 tc, vec2 screen_coords )
{

    vec4 tex = Texel(texture, tc);
    

    tex.rgb *= ((dist - distance(center_pos, screen_coords))/dist);

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif