#version 310 es
layout(location = 0) in highp vec2 a_position;
void main (void) {
	gl_Position = vec4(a_position, 1.0, 1.0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInputMS i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInputMS i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInputMS i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInputMS i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInputMS i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInputMS i_color0;
layout(location = 0) out highp ivec4 o_color0;
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInputMS i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInputMS i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0, gl_SampleID).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInputMS i_color0;
layout(location = 0) out highp uvec4 o_color0;
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
void main (void) {
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 0.0f/255.0f : 255.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 0.0f/255.0f : 1.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 255.0f/255.0f : 0.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 255.0f/255.0f : 1.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 255.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
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
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
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
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_stencil0;
void main (void) {
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000000000);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000015259022);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(location = 0) out highp vec4 o_color0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 255.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(0.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 0.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(255.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 255.0f/255.0f : 1.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 255.0f/255.0f;
}
