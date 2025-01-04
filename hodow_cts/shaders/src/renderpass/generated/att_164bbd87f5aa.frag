#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[9];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color1 = ivec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	gl_FragDepth = outputs[8] ? 1.0f/255.0f : 0.0f/255.0f;
}
