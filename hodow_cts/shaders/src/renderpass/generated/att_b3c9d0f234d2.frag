#version 450
layout(location = 7) out highp vec2 o_color7;
void main (void) {
	o_color7 = vec2(vec2(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
