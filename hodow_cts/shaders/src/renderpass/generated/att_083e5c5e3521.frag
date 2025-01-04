#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_depth2;
layout(input_attachment_index = 2, set=0, binding=3) uniform highp usubpassInput i_stencil2;
layout(input_attachment_index = 3, set=0, binding=4) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[12];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth2).x), 0.000000000000);
	inputs[7] = 255u == subpassLoad(i_stencil2).x;
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[10];
	outputs[3] = outputs[3] == inputs[11];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
