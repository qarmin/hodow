#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
