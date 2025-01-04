#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_depth1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[5];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth1).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
}
