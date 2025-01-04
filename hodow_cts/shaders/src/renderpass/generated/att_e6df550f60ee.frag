#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[10];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[8];
	outputs[2] = outputs[2] == inputs[9];
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = uvec4(outputs[2], 0, 0, 0);
}
