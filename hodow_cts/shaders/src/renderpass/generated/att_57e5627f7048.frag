#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_depth1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth1).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	gl_FragDepth = outputs[5] ? 1.0f/255.0f : 0.0f/255.0f;
}
