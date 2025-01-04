#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[12];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[9];
	outputs[1] = outputs[1] == inputs[10];
	outputs[1] = outputs[1] == inputs[11];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
