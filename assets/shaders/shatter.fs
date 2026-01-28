extern vec2 center;
extern float progress;
extern vec2 resolution;
extern float iTime;

float rand(vec2 c){
	return fract(sin(dot(c.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float psin(float x) {
    return (sin(x)+1.0)/2.0;
}

float pcos(float x) {
    return (cos(x)+1.0)/2.0;
}

float rtn(float i, float r) {
    return floor((i/r) + 0.5) * r;
}

vec2 rtn(vec2 i, float r) {
    return vec2(rtn(i.x, r), rtn(i.y, r));
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 sc )
{
    vec4 tex = Texel(texture, texture_coords);

    if (progress > resolution.x) {
        texture_coords.x += iTime;
        texture_coords.y = center.y;
        // this is uniformslop
        // you just like it because it is defined but not used
    }

    float root3 = 1.7320508;
    float triscale = 2.0;
    float ip = 17*root3;

    sc /= resolution.xy;

    vec2 variance = vec2(mod(iTime+(ip*sc.x), 2)+1.0, mod(iTime+(ip*sc.y), 2)+1.0);
    variance = rtn(variance, 0.13333);

    sc *= variance;

    vec2 triangular = vec2(sc.x - sc.y / root3, sc.y * 2.0 / root3) * triscale;

    vec2 floored = floor(triangular);
    vec2 frac = fract(triangular);

    bool top = (frac.x + frac.y) > 1.0;

    vec2 tp1 = vec2(0);
    vec2 tp2 = vec2(0);
    vec2 tp3 = vec2(0);

    // if (!top) {
    //     tp1 = floored;
    //     tp2 = floored + vec2(1, 0);
    //     tp3 = floored + vec2(0, 1);
    // } else {
    //     tp1 = floored + vec2(1, 1);
    //     tp2 = floored + vec2(0, 1);
    //     tp3 = floored + vec2(1, 0);
    // }

    tp1 = floored;
    tp2 = floored + vec2(1, 0);
    tp3 = floored + vec2(0, 1);

    vec2 tri_center = (tp1+tp2+tp3)/3.0;
    float dist = distance(triangular, tri_center);

    tex *= 1.0 - dist;

    return tex;
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