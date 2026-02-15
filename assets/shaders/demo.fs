extern float nums[3];
extern float num_singular;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    if (texture_coords.x < 0.5) {
        tex.r = nums[0];
        tex.g = nums[1];
        tex.b = nums[2];
    } else {
        tex.rgb = vec3(num_singular);
    }

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif