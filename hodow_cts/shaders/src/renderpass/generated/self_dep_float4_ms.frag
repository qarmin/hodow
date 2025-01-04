#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInputMS i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
