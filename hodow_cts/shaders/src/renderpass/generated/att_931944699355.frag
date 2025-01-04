#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(input_attachment_index = 1, set=0, binding=2) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=3) uniform highp subpassInput i_color2;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[7];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
