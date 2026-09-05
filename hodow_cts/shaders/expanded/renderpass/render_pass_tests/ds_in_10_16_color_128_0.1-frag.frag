#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(128.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
