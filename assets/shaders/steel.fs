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
extern PRECISION vec2 steel;

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
extern PRECISION float lines_offset;

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
#define TWO_PI 6.28318530718
vec4 steel_color = vec4(225., 238., 255., 255.)/ 255.;
bool line(vec2 uv, float offset, float width) {
    uv.x = uv.x * texture_details.z / texture_details.w;

    offset = offset + 0.35 * sin(steel.x + TWO_PI * lines_offset);
    width = width + 0.005 * sin(steel.x);

    float min_y = -uv.x + offset;
    float max_y = -uv.x + offset + width;

    return uv.y > min_y && uv.y < max_y;
}
// This is what actually changes the look of card
vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    // Take pixel color (rgba) from `texture` at `texture_coords`, equivalent of texture2D in GLSL
    vec4 img = Texel(texture, texture_coords);
    vec3 img2 = img.rgb;
    float ogtrans = img.a;
    // Position of a pixel within the sprite
	vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    vec4 tex = vec4(0.9, 0.9, 0.9, 0.1);

    //Pixel basis, hopefully independent of card size
    float shiftExact = 1.5;
    float sprite_width = texture_details.z / image_details.x; // Normalized width
    float sprite_height = texture_details.w / image_details.y; // Normalized height
    float min_x = texture_details.x * sprite_width; // min X
    float max_x = (texture_details.x + 1.) * sprite_width; // max X
    float min_y = texture_details.y * sprite_height; // min Y
    float max_y = (texture_details.y + 1.) * sprite_height; // max Y

    float shiftX = 4.  / image_details.x; // shift X so normalize by X
    float shiftY = 4.  / image_details.y; // shift Y so normalize by Y
    float shiftX2 = 0.5  / image_details.x; // shift X so normalize by X
    float shiftY2 = 0.5  / image_details.y; // shift Y so normalize by Y
    float newX = min(max_x, max(min_x, texture_coords.x + shiftX));
    float newY = min(max_y, max(min_y, texture_coords.y + shiftY));
    float newX2 = min(max_x, max(min_x, texture_coords.x - shiftX));
    float newY2 = min(max_y, max(min_y, texture_coords.y - shiftY));

    float newX3 = min(max_x, max(min_x, texture_coords.x + shiftX2));
    float newY3 = min(max_y, max(min_y, texture_coords.y + shiftY2));
    float newX4 = min(max_x, max(min_x, texture_coords.x - shiftX2));
    float newY4 = min(max_y, max(min_y, texture_coords.y - shiftY2));

    
    //Emboss texture to make it actually look convincingly like a steel card instead of a simple bezeled greyscale
    float avg = (img.r + img.g + img.b) / 3.;
    vec3 a = Texel(texture,vec2(newX3,newY3)).rgb;
    vec3 b = Texel(texture,vec2(newX4,newY4)).rgb;
    float avgA = (a.r + a.g + a.b) / 3.;
    float avgB = (b.r + b.g + b.b) / 3.;
    float differenceX = (avgA - avgB) * 3.5;
    float lighting = differenceX * 0.2 + 0.8;
    

    float borderFactor = 0.0;
    
    if (

        (Texel(texture,vec2(newX,newY)).a <= 0.2 )

    ){
        tex = tex - 0.25;
        borderFactor = borderFactor + 0.17;
        tex.b = tex.b + 0.06;
        tex.r = tex.r - 0.03;
        lighting = 0.8;
    }
    if (

        (Texel(texture,vec2(newX2,newY2)).a <= 0.2 )

    ){
        tex = tex + 0.1;
        tex.b = tex.b + 0.01;
        lighting = 0.8;
    }

    if (
        lines_offset >  0. && (line(uv, 0.0, 0.07) || line(uv, 0.4, 0.1) || line(uv, 0.55, 0.1) || line(uv, 1.3, 0.05) || line(uv, 1.8, 0.1)) ||
        lines_offset <= 0. && (line(uv, -0.2, 0.13) || line(uv, 0.3, 0.05) || line(uv, 0.8, 0.1) || line(uv, 1.3, 0.11) || line(uv, 1.7, 0.07))
    ) {
        tex = tex + 0.03;
        tex.b = tex.b + 0.01;
    } else if (
        lines_offset >  0.02 && (line(uv, 0.0, 0.04) || line(uv, 0.4, 0.1) || line(uv, 0.55, 0.1) || line(uv, 1.3, 0.05) || line(uv, 1.8, 0.1)) ||
        lines_offset <= 0.01 && (line(uv, -0.15, 0.25) || line(uv, 0.5, 0.4) || line(uv, 0.5, 0.05) || line(uv, 1.1, 0.001) || line(uv, 1.2, 0.9))
    ) {
        tex = tex + 0.02;
        tex.b = tex.b + 0.01;
    }
    
    else {
        tex = tex - 0.025;
        tex.b = tex.b + 0.01;
    }
    img = vec4(steel_color.rgb * vec3(lighting) + 0.06 + tex.rgb * tex.a - borderFactor, ogtrans);

	return dissolve_mask(img, texture_coords, uv);

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
