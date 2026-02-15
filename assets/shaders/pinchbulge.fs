extern vec2 center_pos;
extern float intensity;
extern float radius;
extern vec2 res;

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec2 offset = screen_coords - center_pos;
    float dist = distance(screen_coords, center_pos);

    if (dist < radius) {
        float perc = dist / radius;
        float effect = pow(perc, 1.0 - (intensity*0.5)) * radius;
        screen_coords = center_pos + (normalize(offset)*effect);
    }

    return Texel(texture, screen_coords / res);
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif