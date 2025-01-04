#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
