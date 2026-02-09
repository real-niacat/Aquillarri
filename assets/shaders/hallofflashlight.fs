// extern vec2 mouse_pos;
// extern vec2 res;
extern float iTime;

#define PI 3.14159265358979323846
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

float pNoise(vec2 p, int res, int power){
	float persistance = .5;
	float n = 0.;
	float normK = 0.;
	float f = 4.;
	float amp = 1.;
	int iCount = 0;
	for (int i = 0; i<50; i++){
		n+=amp*noise(p, f);
		f*=2.;
		normK+=amp;
		amp*=persistance;
		if (iCount == res) break;
		iCount++;
	}
	float nf = n/normK;
	return pow(nf, power);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{

    vec2 off = vec2((pNoise(texture_coords + vec2(72.,13.), 32, 2) * 4.5) - 1., (pNoise(texture_coords, 8, 2) * 4.5) - 1.);

    float div = 200.;
    off /= div;
    

    off.x *= sin(iTime);
    off.y *= cos(iTime*1.2);

    float theta = mod(iTime, PI*2.);
    off = vec2((off.x * cos(theta)) - (off.y * sin(theta*2.)), (off.x * sin(theta*2.)) + (off.y * cos(theta)));
    vec4 tex = Texel(texture, texture_coords+off);
    

    return tex;
}



#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    return transform_projection * vertex_position;
}
#endif