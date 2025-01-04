#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
layout(location = 4) out highp uvec4 o_color4;
layout(location = 5) out highp vec4 o_color5;
layout(location = 6) out highp vec4 o_color6;
layout(location = 7) out highp vec4 o_color7;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color4 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color5 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color6 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color7 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 255.0f/255.0f : 1.0f/255.0f);
}
