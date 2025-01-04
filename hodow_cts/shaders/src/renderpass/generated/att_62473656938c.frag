#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = ivec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
}
