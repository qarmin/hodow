#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_depth1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[3];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth1).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
