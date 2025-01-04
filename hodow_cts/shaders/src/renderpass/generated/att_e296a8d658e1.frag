#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[5];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
