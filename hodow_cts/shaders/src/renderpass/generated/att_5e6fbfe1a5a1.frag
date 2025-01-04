#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
