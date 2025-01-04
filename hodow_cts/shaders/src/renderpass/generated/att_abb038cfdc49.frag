#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_depth3;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[10];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[9] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth3).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	outputs[0] = outputs[0] == inputs[9];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
