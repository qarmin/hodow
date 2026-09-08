#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 128.0f/255.0f;
}
