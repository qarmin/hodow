#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 128.0f/255.0f : 255.0f/255.0f);
}
