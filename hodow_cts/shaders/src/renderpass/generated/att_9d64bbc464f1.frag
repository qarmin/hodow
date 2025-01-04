#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[5];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color1 = ivec4(outputs[2], outputs[3], 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	o_color2 = vec4(outputs[4], outputs[5], 0, 0);
}
