#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 128.0f/255.0f;
}
