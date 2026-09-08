#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define MY_HIGHP_OR_MEDIUMP highp
#else
    #define MY_HIGHP_OR_MEDIUMP mediump
#endif

extern MY_HIGHP_OR_MEDIUMP vec2 badge_shader;
extern MY_HIGHP_OR_MEDIUMP vec4 uie_details;
extern MY_HIGHP_OR_MEDIUMP number uie_scale;
extern MY_HIGHP_OR_MEDIUMP number uie_rot;

extern MY_HIGHP_OR_MEDIUMP float real_time;

extern MY_HIGHP_OR_MEDIUMP vec2 badge_pos;
extern MY_HIGHP_OR_MEDIUMP vec2 badge_size;


float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

bool square(vec2 p, float w){
	return (abs(p.x) < w && abs(p.y) < w);
}
float randomNumber(float seed){
	float numberrr = seed * seed * 16070.;
    float finalrr = mod(numberrr, 100.);
    return 0.01 * finalrr;
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = colour;
    vec2 uv = (screen_coords - badge_pos.xy) / (badge_size.xy * uie_scale);
    uv.x = uv.x *1.25 - 0.3;
    uv.y = uv.y *0.25;

    float iTime = badge_shader.g / 1;
    number important_value_trust_me_compiler = uie_scale + uie_rot + uie_details.x + badge_shader.x;
    if (important_value_trust_me_compiler == important_value_trust_me_compiler * 2) {
        uv.x = uv.x + 0.000001;
    }
    //Add your own afterwards
    vec3 col = vec3(sin(iTime + uv.y)*0.5 + 0.7,sin(iTime + uv.y)*0.2 + 0.2,sin(iTime + uv.y)*0.5 + 0.8+badge_shader.x*0.0001 + uv.x*0.00001) * .6;
    
    //vec4 col = vec4(0.) * .6;
    col = col + vec3(sin(iTime + uv.y - 10.)*0.7 + 0.3,sin(iTime + uv.y - 10.)*0.5,sin(iTime + uv.y - 10.)*0.7 + 0.9) * .6;
    
    //SQUARES
    for(int i = 0; i < 9; i++){
        for(int j = 0; j < 6; j++){
            
            vec2 moveduv = uv + vec2(.25 * float(i - 7), -1.2 + mod(.25 * float(j + 1) - iTime * .1, 1.5));

            //ROTATION
            vec2 rotateduv = vec2(0.0);
            
            float rot = iTime * 2.8 * (.5 - randomNumber(float(i + j + 185))); 

            vec2 newuv = mat2(cos(rot), -sin(rot), sin(rot), cos(rot)) * moveduv;

            if(square(newuv, mod(iTime / 15. + float(i) / 7. + float(j) /  13., .2)) == true){
                col += vec3(1. - mod(iTime / 15. + float(i) / 7. + float(j) /  13., .2) * 5.,
                0.5 - mod(iTime / 15. + float(i) / 7. + float(j) /  13., .2) * 2.5,
                1. - mod(iTime / 15. + float(i) / 7. + float(j) /  13., .2) * 5.); 
            }
        }
    }

    tex.rgb = col;
    
    
    return tex;
}