#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

// !! change this variable name to your Shader's name
// YOU MUST USE THIS VARIABLE IN THE vec4 effect AT LEAST ONCE

// Values of this variable:
// self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + (math.sin(G.TIMERS.REAL/28) + 1) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
// self.ARGS.send_to_shader[2] = G.TIMERS.REAL
extern PRECISION vec2 positive;

extern PRECISION number dissolve;
extern PRECISION number time;
// [Note] sprite_pos_x _y is not a pixel position!
//        To get pixel position, you need to multiply  
//        it by sprite_width _height (look flipped.fs)
// (sprite_pos_x, sprite_pos_y, sprite_width, sprite_height) [not normalized]
extern PRECISION vec4 texture_details;
// (width, height) for atlas texture [not normalized]
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

// [Required] 
// Apply dissolve effect (when card is being "burnt", e.g. when consumable is used)
vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

number hue(number s, number t, number h)
{
	number hs = mod(h, 1.)*6.;
	if (hs < 1.) return (t-s) * hs + s;
	if (hs < 3.) return t;
	if (hs < 4.) return (t-s) * (4.-hs) + s;
	return s;
}

vec4 RGB(vec4 c)
{
	if (c.y < 0.0001)
		return vec4(vec3(c.z), c.a);

	number t = (c.z < .5) ? c.y*c.z + c.z : -c.y*c.z + (c.y+c.z);
	number s = 2.0 * c.z - t;
	return vec4(hue(s,t,c.x + 1./3.), hue(s,t,c.x), hue(s,t,c.x - 1./3.), c.w);
}

vec4 HSL(vec4 c)
{
	number low = min(c.r, min(c.g, c.b));
	number high = max(c.r, max(c.g, c.b));
	number delta = high - low;
	number sum = high+low;

	vec4 hsl = vec4(.0, .0, .5 * sum, c.a);
	if (delta == .0)
		return hsl;

	hsl.y = (hsl.z < .5) ? delta / sum : delta / (2.0 - sum);

	if (high == c.r)
		hsl.x = (c.g - c.b) / delta;
	else if (high == c.g)
		hsl.x = (c.b - c.r) / delta + 2.0;
	else
		hsl.x = (c.r - c.g) / delta + 4.0;

	hsl.x = mod(hsl.x / 6., 1.);
	return hsl;
}
extern PRECISION mat3 YIQ_CONVERT = mat3(
    0.299, 0.596, 0.211,
    0.587, -0.274, -0.523,
    0.114, -0.322, 0.312
);
extern PRECISION mat3 RGB_CONVERT = mat3(
    1.0, 1.0, 1.0,
    0.956, -0.272, -1.106,
    0.621, -0.647, 1.703
);
//https://agatedragon.blog/2024/04/02/hue-shift-shader/
vec3 ToYIQ(vec3 colour)
{
    return YIQ_CONVERT * colour;
}
vec3 ToRGB(vec3 colour)
{
    return RGB_CONVERT * colour;
}
vec3 HueShift(vec3 colour,float shift)
{
    //to pi
    
    vec3 yiq = ToYIQ(colour);
 
    mat2 rotMatrix = mat2(
        cos(shift), -sin(shift),
        sin(shift), cos(shift)
    );
    yiq.yz *= rotMatrix;
 
    return ToRGB(yiq);
}

// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // Take pixel color (rgba) from `texture` at `texture_coords`, equivalent of texture2D in GLSL
    vec4 tex = Texel(texture, texture_coords);
    // Position of a pixel within the sprite
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    //Do shit here

    
    // // For all vectors (vec2, vec3, vec4), .rgb is equivalent of .xyz, so uv.y == uv.g
    // // .a is last parameter for vec4 (usually the alpha channel - transparency)
    float shift = 3.1415926535897932384626433832795;
    if (positive.g > 0.0 || positive.g < 0.0) {
		shift = 3.1415926535897932384626433832795 + positive.x * 0.000000001;
	}
    tex = vec4(HueShift(vec3(tex.r,tex.g,tex.b),shift),tex.a);

    // number low = min(tex.r, min(tex.g, tex.b));
    // number high = max(tex.r, max(tex.g, tex.b));
    // number delta = high-low -0.1;

    // number fac = 0.8 + 0.9*sin(11.*uv.x+4.32*uv.y + positive.r*12. + cos(positive.r*5.3 + uv.y*4.2 - uv.x*4.));
    // number fac2 = 0.5 + 0.5*sin(8.*uv.x+2.32*uv.y + positive.r*5. - cos(positive.r*2.3 + uv.x*8.2));
    // number fac3 = 0.5 + 0.5*sin(10.*uv.x+5.32*uv.y + positive.r*6.111 + sin(positive.r*5.3 + uv.y*3.2));
    // number fac4 = 0.5 + 0.5*sin(3.*uv.x+2.32*uv.y + positive.r*8.111 + sin(positive.r*1.3 + uv.y*11.2));
    // number fac5 = sin(0.9*16.*uv.x+5.32*uv.y + positive.r*12. + cos(positive.r*5.3 + uv.y*4.2 - uv.x*4.));

    // number maxfac = 0.7*max(max(fac, max(fac2, max(fac3,0.0))) + (fac+fac2+fac3*fac4), 0.);

    // //tex.rgb = tex.rgb*0.5 + vec3(0.4, 0.4, 0.8);

    // tex.r = tex.r-delta + delta*maxfac*(0.7 + fac5*0.27) - 0.1;
    // tex.g = tex.g-delta + delta*maxfac*(0.7 - fac5*0.27) - 0.1;
    // tex.b = tex.b-delta + delta*maxfac*0.7 - 0.1;
    // tex.a = tex.a*(0.5*max(min(1., max(0.,0.3*max(low*0.2, delta)+ min(max(maxfac*0.1,0.), 0.4)) ), 0.) + 0.15*maxfac*(0.1+delta));


    // vec4 SAT = HSL(tex);
    // vec4 SAT2 = HSL(tex);



     //tex = tex + 0.8*vec4((103.+(0.01*positive.y -0.01*positive.x))/255., 103.+(0.01*positive.y -0.01*positive.x)/255.,103.+(0.01*positive.y -0.01*positive.x)/255.,0.);
    // if (positive.r > 0.0 || positive.r < 0.0) {
	// 	SAT.r = (SAT.g);
	// }
    
	// SAT.b = SAT.g;
    // SAT.r = (SAT.b);
    // generic shimmer copied straight from positive.fs
    	// if (positive.g > 0.0 || positive.g < 0.0) {




	if (tex[3] < 0.7)
		tex[3] = tex[3]/3.;
    // required
	return dissolve_mask(tex*colour, texture_coords, uv);

}


vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01; //Adjusting 0.0-1.0 to fall to -0.1 - 1.1 scale so the mask does not pause at extreme values

	float t = time * 10.0 + 2003.;
	vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
	
	vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
	vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
	vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

// for transforming the card while your mouse is on it
extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif
