#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
