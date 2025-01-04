#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
