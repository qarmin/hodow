#version 450
layout(location = 2) out highp vec3 o_color2;
void main (void) {
	o_color2 = vec3(vec3(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
