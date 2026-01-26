extern vec2 center;
extern float progress;
extern vec2 resolution;
extern float iTime;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);

    if (progress > resolution.x) {
        texture_coords.x += iTime;
        texture_coords.y = center.y;
        // this is uniformslop
        // you just like it because it is defined but not used
    }

    return tex;
}

float psin(float x) {
    return (sin(x)+1.0)/2.0;
}

float pcos(float x) {
    return (cos(x)+1.0)/2.0;
}

#ifdef VERTEX
vec4 position( mat4 tproj, vec4 vpos )
{
    // for transform_projection:
    // 0,0 stretches horizontally
    // 1,1 stretches vertically
    // 3,0 shifts the screen horizontally
    // 3,1 shifts the screen vertically
    // 3,3 scales the screen (in place)

    // for vpos:
    // x stretches horizontally
    // y stretches horizontally
    // z does nothing?
    // w scales based on (0,0)
    return tproj * vpos;
}
#endif