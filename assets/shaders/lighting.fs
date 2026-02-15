extern vec2 center_pos;
extern float intensity;
extern vec4 cards[32];

bool in_bounds(vec2 pos) {
    // x
    for (int i = 0; i < 32; i++) {
        vec4 card = cards[i];
        if (pos.x >= card.x &&
            pos.y >= card.y &&
            pos.x <= card.z &&
            pos.y <= card.w) {
                return true;
            }
    }
    return false;

}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    float lighting = intensity - sqrt(distance(screen_coords, center_pos));
    lighting = (lighting/intensity)+1;
    lighting = max(lighting, 1);
    if (in_bounds(screen_coords)) {
        lighting = 0.9;
        // tex.g = 1.0/0.9;
    }

    tex.rgb *= lighting;

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif