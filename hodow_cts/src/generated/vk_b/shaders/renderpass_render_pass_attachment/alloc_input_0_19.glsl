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
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
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
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = vec4(outputs[0], 0, 0, 0);
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
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
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
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
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
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
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
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
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
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
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
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
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
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[5];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[3];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[4];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[8];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = ivec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = uvec4(outputs[9], outputs[10], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	o_color2 = uvec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[6];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	outputs[5] = outputs[5] == inputs[3];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[4];
	outputs[6] = outputs[6] == inputs[5];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[2];
	outputs[5] = outputs[5] == inputs[3];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[4];
	outputs[6] = outputs[6] == inputs[5];
	o_color2 = vec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[14];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[12] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[13] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[12];
	outputs[6] = outputs[6] == inputs[13];
	o_color2 = vec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[10];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[7];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[14];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[3];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	o_color3 = uvec4(outputs[12], outputs[13], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[9];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[5] = outputs[5] == inputs[2];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[3];
	outputs[6] = outputs[6] == inputs[4];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[5];
	outputs[7] = outputs[7] == inputs[6];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[6] = outputs[6] == inputs[3];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[4];
	outputs[7] = outputs[7] == inputs[5];
	o_color3 = uvec4(outputs[7], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[11];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[7] = outputs[7] == inputs[4];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[5];
	outputs[8] = outputs[8] == inputs[6];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[7];
	outputs[9] = outputs[9] == inputs[8];
	o_color2 = ivec4(outputs[8], outputs[9], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[16];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = uvec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	outputs[14] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[14] = outputs[14] == inputs[2];
	outputs[15] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[15] = outputs[15] == inputs[3];
	o_color3 = vec4(outputs[12], outputs[13], outputs[14], outputs[15]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[12];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color1 = uvec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[2];
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[4];
	outputs[8] = outputs[8] == inputs[5];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[6];
	outputs[9] = outputs[9] == inputs[7];
	o_color3 = ivec4(outputs[9], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[10];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[6] = outputs[6] == inputs[3];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[4];
	outputs[7] = outputs[7] == inputs[5];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[6];
	outputs[8] = outputs[8] == inputs[7];
	o_color2 = uvec4(outputs[5], outputs[6], outputs[7], outputs[8]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[12];
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = uvec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[1];
	o_color3 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[8], outputs[9], 0, 0);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = ivec4(outputs[10], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[1];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[2];
	bool outputs[8];
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
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[16];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[12] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[13] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[14] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[15] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[9];
	outputs[1] = outputs[1] == inputs[10];
	outputs[1] = outputs[1] == inputs[11];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[12];
	outputs[2] = outputs[2] == inputs[13];
	outputs[2] = outputs[2] == inputs[14];
	outputs[2] = outputs[2] == inputs[15];
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[6];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = uvec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
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
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[6];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[2];
	o_color3 = uvec4(outputs[7], outputs[8], 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[12];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color2 = uvec4(outputs[3], 0, 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color3 = ivec4(outputs[4], outputs[5], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[5];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	outputs[3] = outputs[3] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = uvec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color2 = ivec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = vec4(outputs[8], outputs[9], outputs[10], 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[12];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[10];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[11];
	o_color2 = ivec4(outputs[8], outputs[9], outputs[10], outputs[11]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[6] = outputs[6] == inputs[3];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[4];
	outputs[7] = outputs[7] == inputs[5];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[6];
	outputs[8] = outputs[8] == inputs[7];
	o_color3 = vec4(outputs[7], outputs[8], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = uvec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	o_color3 = ivec4(outputs[10], outputs[11], outputs[12], outputs[13]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[12];
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
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = uvec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = ivec4(outputs[8], outputs[9], 0, 0);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[3];
	o_color3 = vec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color2 = vec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[13];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = ivec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[1];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	o_color3 = vec4(outputs[9], outputs[10], outputs[11], outputs[12]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[6];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = ivec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[2];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[3];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[4];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color2 = ivec4(outputs[3], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[6];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color1 = vec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color2 = ivec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[1];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color1 = vec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color2 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	o_color3 = uvec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[3];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[2];
	o_color3 = vec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[10];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[8];
	outputs[2] = outputs[2] == inputs[9];
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = ivec4(outputs[2], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[5];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	o_color2 = vec4(outputs[6], 0, 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[2];
	o_color3 = uvec4(outputs[7], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[2];
	o_color1 = ivec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color2 = ivec4(outputs[5], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = ivec4(outputs[5], 0, 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	o_color3 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = vec4(outputs[9], outputs[10], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[13];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[12] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color1 = vec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color2 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[12];
	outputs[6] = outputs[6] == inputs[0];
	o_color3 = vec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[12];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[10];
	outputs[3] = outputs[3] == inputs[11];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[5];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	o_color2 = uvec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	o_color3 = ivec4(outputs[7], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[14];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], 0);
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[0];
	o_color3 = ivec4(outputs[11], outputs[12], 0, 0);
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	gl_FragDepth = outputs[13] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	gl_FragDepth = outputs[1] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
void main (void) {
	bool inputs[9];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[10];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[6] = outputs[6] == inputs[3];
	o_color1 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[4];
	outputs[7] = outputs[7] == inputs[5];
	gl_FragDepth = outputs[7] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[1];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[0];
	o_color2 = uvec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], 0);
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	gl_FragDepth = outputs[11] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[3];
	outputs[5] = outputs[5] == inputs[4];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[2];
	gl_FragDepth = outputs[8] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	gl_FragDepth = outputs[3] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
void main (void) {
	bool inputs[9];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[0];
	gl_FragDepth = outputs[2] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_depth2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[7];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth2).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	gl_FragDepth = outputs[3] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[2];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = uvec4(outputs[6], outputs[7], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_depth3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[9];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth3).x), 0.000000000000);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[5] = outputs[5] == inputs[2];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[3];
	outputs[6] = outputs[6] == inputs[4];
	gl_FragDepth = outputs[6] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[15];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = uvec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[1];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[2];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[3];
	o_color3 = ivec4(outputs[10], outputs[11], outputs[12], outputs[13]);
	outputs[14] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[14] = outputs[14] == inputs[4];
	gl_FragDepth = outputs[14] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
void main (void) {
	bool inputs[8];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[2];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[2];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[12];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[10];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[11];
	o_color3 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
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
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = vec4(outputs[4], outputs[5], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color3 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = uvec4(outputs[9], outputs[10], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	o_color1 = ivec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[9];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[1];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[12];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[10];
	outputs[3] = outputs[3] == inputs[11];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color2 = ivec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[11];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[8];
	outputs[2] = outputs[2] == inputs[9];
	outputs[2] = outputs[2] == inputs[10];
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[2], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[6];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[12];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color1 = ivec4(outputs[4], outputs[5], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[9];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[5] = outputs[5] == inputs[2];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[3];
	outputs[6] = outputs[6] == inputs[4];
	o_color2 = uvec4(outputs[5], outputs[6], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = uvec4(outputs[9], outputs[10], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[1];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = uvec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[0];
	o_color2 = ivec4(outputs[6], outputs[7], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[5];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[3];
	o_color3 = uvec4(outputs[7], outputs[8], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[10];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color1 = vec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color2 = ivec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[6];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[2];
	o_color3 = uvec4(outputs[7], outputs[8], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[10];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[12];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[10];
	outputs[3] = outputs[3] == inputs[11];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[2];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	o_color1 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	o_color2 = ivec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = vec4(outputs[8], outputs[9], outputs[10], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[1];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[0];
	o_color2 = ivec4(outputs[8], outputs[9], 0, 0);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[0];
	o_color3 = uvec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[12];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[10];
	outputs[3] = outputs[3] == inputs[11];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[9];
	bool outputs[13];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[1];
	o_color2 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[2];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[3];
	o_color3 = vec4(outputs[11], outputs[12], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[12];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[9];
	outputs[1] = outputs[1] == inputs[10];
	outputs[1] = outputs[1] == inputs[11];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[3];
	outputs[5] = outputs[5] == inputs[4];
	o_color2 = uvec4(outputs[5], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[5];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[11];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[10];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[0];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[1];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[13] = outputs[13] == inputs[2];
	o_color3 = vec4(outputs[12], outputs[13], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[8];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	o_color2 = ivec4(outputs[5], outputs[6], 0, 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	o_color3 = uvec4(outputs[7], outputs[8], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	o_color2 = uvec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[6];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[8];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = uvec4(outputs[3], outputs[4], 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[2];
	outputs[5] = outputs[5] == inputs[3];
	o_color2 = uvec4(outputs[5], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[3];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[2];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[2];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[1];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[2];
	o_color2 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	o_color3 = uvec4(outputs[12], outputs[13], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[6];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[2];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[3];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[4];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[5];
	o_color3 = vec4(outputs[8], outputs[9], outputs[10], outputs[11]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[7];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color3).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = ivec4(outputs[8], outputs[9], 0, 0);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[13] = outputs[13] == inputs[1];
	o_color3 = vec4(outputs[10], outputs[11], outputs[12], outputs[13]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	outputs[5] = outputs[5] == inputs[3];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[4];
	outputs[6] = outputs[6] == inputs[5];
	o_color1 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[1];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	o_color3 = uvec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[9];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	outputs[3] = outputs[3] == inputs[2];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[9];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	o_color3 = uvec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[7];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[1];
	o_color3 = uvec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[6];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[9];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[5] = outputs[5] == inputs[2];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[3];
	outputs[6] = outputs[6] == inputs[4];
	o_color2 = vec4(outputs[5], outputs[6], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[2];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color2 = vec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color2 = vec4(outputs[3], outputs[4], 0, 0);
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
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	outputs[3] = outputs[3] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[7];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[0];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[7];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[1];
	o_color3 = uvec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = uvec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = uvec4(outputs[2], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	o_color2 = vec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color1 = vec4(outputs[2], outputs[3], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[9];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	o_color2 = vec4(outputs[6], outputs[7], 0, 0);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	o_color3 = uvec4(outputs[8], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[8];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	o_color2 = vec4(outputs[3], outputs[4], outputs[5], 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color3 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[5];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = ivec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[3];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], 0);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[4];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = vec4(outputs[9], outputs[10], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	o_color1 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[11];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[7] = outputs[7] == inputs[4];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[11];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color1 = ivec4(outputs[2], outputs[3], 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	o_color2 = vec4(outputs[4], outputs[5], outputs[6], 0);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[10];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	o_color2 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[2];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = ivec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = vec4(outputs[5], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = ivec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	o_color3 = uvec4(outputs[10], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color1 = uvec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	o_color2 = uvec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color3 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[5];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = ivec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	o_color2 = uvec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	o_color3 = uvec4(outputs[7], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[2];
	o_color1 = ivec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = ivec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = uvec4(outputs[2], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[9];
	bool outputs[13];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	o_color2 = uvec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[1];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[2];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[3];
	o_color3 = vec4(outputs[9], outputs[10], outputs[11], outputs[12]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[3];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color1 = ivec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color2 = uvec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	outputs[3] = outputs[3] == inputs[2];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color1 = vec4(outputs[4], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp isubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	o_color2 = vec4(outputs[8], 0, 0, 0);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	o_color3 = vec4(outputs[9], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[9];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	o_color2 = vec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[9];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = ivec4(outputs[8], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	o_color1 = uvec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = ivec4(outputs[5], 0, 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	o_color3 = uvec4(outputs[6], 0, 0, 0);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[16];
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
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	o_color1 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	o_color2 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[1];
	outputs[14] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[14] = outputs[14] == inputs[2];
	o_color3 = vec4(outputs[11], outputs[12], outputs[13], outputs[14]);
	outputs[15] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[15] = outputs[15] == inputs[3];
	gl_FragDepth = outputs[15] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
void main (void) {
	bool inputs[8];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
void main (void) {
	bool inputs[4];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[5];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	o_color1 = uvec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[3];
	gl_FragDepth = outputs[8] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[0];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[6];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	gl_FragDepth = outputs[1] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color2 = ivec4(outputs[5], 0, 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color3 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	gl_FragDepth = outputs[10] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[3];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[1];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[2];
	o_color1 = ivec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	gl_FragDepth = outputs[6] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[4];
	bool outputs[13];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[0];
	o_color3 = vec4(outputs[9], outputs[10], outputs[11], outputs[12]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_depth0;
layout(input_attachment_index = 0, set=0, binding=1) uniform highp usubpassInput i_stencil0;
layout(input_attachment_index = 1, set=0, binding=2) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;

bool depthsEqual(float a, float b, float epsilon) {
	return abs(a - b) <= epsilon;
}

void main (void) {
	bool inputs[6];
	bool outputs[11];
	inputs[0] = depthsEqual(1.0f/255.0f, float(subpassLoad(i_depth0).x), 0.000000059605);
	inputs[1] = 255u == subpassLoad(i_stencil0).x;
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[2];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[3];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[4];
	o_color3 = ivec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[1];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[0];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[13] = outputs[13] == inputs[1];
	o_color3 = vec4(outputs[10], outputs[11], outputs[12], outputs[13]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	outputs[4] = outputs[4] == inputs[2];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[8];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[4] = outputs[4] == inputs[1];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[12];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color1 = uvec4(outputs[1], 0, 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color2 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[6] = outputs[6] == inputs[1];
	gl_FragDepth = outputs[6] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[1];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = uvec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	o_color2 = vec4(outputs[5], 0, 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[2];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color1 = uvec4(outputs[1], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[2];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = uvec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = vec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[4];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[7];
	bool outputs[3];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[0];
	outputs[2] = outputs[2] == inputs[1];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	o_color1 = uvec4(outputs[1], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[7];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	o_color2 = uvec4(outputs[6], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[1];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	o_color2 = uvec4(outputs[3], outputs[4], 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[0];
	o_color3 = vec4(outputs[5], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	bool inputs[10];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	outputs[0] = outputs[0] == inputs[9];
	o_color0 = uvec4(outputs[0], 0, 0, 0);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
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
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp uvec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[1];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	o_color1 = uvec4(outputs[4], outputs[5], 0, 0);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[0];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[0];
	o_color2 = ivec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
void main (void) {
	bool inputs[6];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = uvec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color1 = ivec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[12];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[9];
	outputs[1] = outputs[1] == inputs[10];
	outputs[1] = outputs[1] == inputs[11];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[8];
	bool outputs[14];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = ivec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = ivec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[4];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[13] = outputs[13] == inputs[5];
	o_color3 = ivec4(outputs[10], outputs[11], outputs[12], outputs[13]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[1];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	o_color2 = vec4(outputs[3], outputs[4], outputs[5], outputs[6]);
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[0];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	o_color3 = vec4(outputs[7], outputs[8], outputs[9], outputs[10]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp subpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[9];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	outputs[3] = outputs[3] == inputs[2];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
void main (void) {
	bool inputs[6];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	o_color1 = ivec4(outputs[1], outputs[2], 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[2];
	outputs[4] = outputs[4] == inputs[3];
	o_color2 = ivec4(outputs[3], outputs[4], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[11];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[8] = 1.0 == float(subpassLoad(i_color3).y);
	inputs[9] = 1.0 == float(subpassLoad(i_color3).z);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[1];
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	outputs[7] = outputs[7] == inputs[4];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[5];
	outputs[8] = outputs[8] == inputs[6];
	o_color2 = vec4(outputs[8], 0, 0, 0);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[7];
	outputs[9] = outputs[9] == inputs[8];
	o_color3 = vec4(outputs[9], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[12];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[10] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[11] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[9];
	bool outputs[13];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[4], 0, 0, 0);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	o_color2 = ivec4(outputs[5], outputs[6], outputs[7], outputs[8]);
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[0];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[1];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[2];
	outputs[12] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[12] = outputs[12] == inputs[3];
	o_color3 = ivec4(outputs[9], outputs[10], outputs[11], outputs[12]);
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
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
#version 450
layout(location = 0) out highp uvec4 o_color0;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp uvec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[5];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = ivec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[1];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[0];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
void main (void) {
	bool inputs[8];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[5];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	o_color1 = ivec4(outputs[2], 0, 0, 0);
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[3];
	o_color2 = vec4(outputs[3], 0, 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	o_color3 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[3];
	gl_FragDepth = outputs[8] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[5];
	bool outputs[9];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[3];
	o_color2 = vec4(outputs[5], outputs[6], outputs[7], outputs[8]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[7];
	bool outputs[11];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[5] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = uvec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[0];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[1];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[2];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[3];
	gl_FragDepth = outputs[10] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp uvec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp usubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp usubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp ivec4 o_color2;
layout(location = 3) out highp vec4 o_color3;
void main (void) {
	bool inputs[10];
	bool outputs[17];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[7];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[9];
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[1];
	o_color2 = ivec4(outputs[8], outputs[9], outputs[10], outputs[11]);
	outputs[12] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[12] = outputs[12] == inputs[2];
	outputs[13] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[13] = outputs[13] == inputs[3];
	outputs[14] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[14] = outputs[14] == inputs[4];
	outputs[15] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[15] = outputs[15] == inputs[5];
	o_color3 = vec4(outputs[12], outputs[13], outputs[14], outputs[15]);
	outputs[16] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[16] = outputs[16] == inputs[6];
	gl_FragDepth = outputs[16] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp usubpassInput i_color3;
void main (void) {
	bool inputs[12];
	bool outputs[1];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[0] = outputs[0] == inputs[6];
	outputs[0] = outputs[0] == inputs[7];
	outputs[0] = outputs[0] == inputs[8];
	outputs[0] = outputs[0] == inputs[9];
	outputs[0] = outputs[0] == inputs[10];
	outputs[0] = outputs[0] == inputs[11];
	gl_FragDepth = outputs[0] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
void main (void) {
	gl_FragDepth = ((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0f/255.0f : 0.0f/255.0f);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[3];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[1];
	gl_FragDepth = outputs[4] ? 1.0f/255.0f : 0.0f/255.0f;
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[2];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
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
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[11] = outputs[11] == inputs[1];
	o_color3 = ivec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp isubpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[8];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[2];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[3];
	o_color3 = ivec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp isubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[12];
	bool outputs[10];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[0];
	outputs[6] = outputs[6] == inputs[1];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[2];
	outputs[7] = outputs[7] == inputs[3];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[4];
	outputs[8] = outputs[8] == inputs[5];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[6];
	outputs[9] = outputs[9] == inputs[7];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[2];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[10];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[0];
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[6];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[2];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[1];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[0];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[1];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[8] = outputs[8] == inputs[0];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[9] = outputs[9] == inputs[1];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[0];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[1];
	o_color3 = ivec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp isubpassInput i_color3;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[12];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	outputs[0] = outputs[0] == inputs[4];
	outputs[0] = outputs[0] == inputs[5];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	outputs[1] = outputs[1] == inputs[8];
	outputs[1] = outputs[1] == inputs[9];
	outputs[1] = outputs[1] == inputs[10];
	outputs[1] = outputs[1] == inputs[11];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp ivec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	bool inputs[4];
	bool outputs[8];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color1 = ivec4(outputs[2], outputs[3], 0, 0);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color2 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp isubpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(location = 0) out highp vec4 o_color0;
void main (void) {
	bool inputs[10];
	bool outputs[4];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[6];
	outputs[2] = outputs[2] == inputs[7];
	outputs[2] = outputs[2] == inputs[8];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[9];
	outputs[3] = outputs[3] == inputs[0];
	outputs[3] = outputs[3] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp isubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[12];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[2];
	outputs[1] = outputs[1] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[4];
	outputs[2] = outputs[2] == inputs[5];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[6];
	outputs[3] = outputs[3] == inputs[7];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[8];
	outputs[4] = outputs[4] == inputs[9];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[10];
	outputs[5] = outputs[5] == inputs[11];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp subpassInput i_color1;
layout(input_attachment_index = 2, set=0, binding=2) uniform highp subpassInput i_color2;
layout(input_attachment_index = 3, set=0, binding=3) uniform highp isubpassInput i_color3;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	bool inputs[12];
	bool outputs[12];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[3] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).w);
	inputs[6] = 1.0 == float(subpassLoad(i_color2).x);
	inputs[7] = 1.0 == float(subpassLoad(i_color2).y);
	inputs[8] = 1.0 == float(subpassLoad(i_color2).z);
	inputs[9] = 1.0 == float(subpassLoad(i_color2).w);
	inputs[10] = 1.0 == float(subpassLoad(i_color3).x);
	inputs[11] = 1.0 == float(subpassLoad(i_color3).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[1];
	o_color0 = vec4(outputs[0], outputs[1], 0, 0);
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[4];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[5];
	o_color1 = vec4(outputs[2], outputs[3], outputs[4], outputs[5]);
	outputs[6] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[6] = outputs[6] == inputs[6];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[7] = outputs[7] == inputs[7];
	outputs[8] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[8] = outputs[8] == inputs[8];
	outputs[9] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[9] = outputs[9] == inputs[9];
	o_color2 = vec4(outputs[6], outputs[7], outputs[8], outputs[9]);
	outputs[10] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[10] = outputs[10] == inputs[10];
	outputs[11] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[11] = outputs[11] == inputs[11];
	o_color3 = ivec4(outputs[10], outputs[11], 0, 0);
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
layout(location = 3) out highp ivec4 o_color3;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color3 = ivec4(ivec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp uvec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
layout(location = 2) out highp vec4 o_color2;
void main (void) {
	o_color0 = uvec4(uvec4(((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color2 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	o_color0 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
	o_color1 = vec4(vec4(((int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0),
		((int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0) ? 1.0 : 0.0)));
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[8];
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
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[5] = outputs[5] == inputs[1];
	outputs[6] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[6] = outputs[6] == inputs[2];
	outputs[7] = (int(gl_FragCoord.x) % 2 == 1) && (int(gl_FragCoord.y) % 2 == 0);
	outputs[7] = outputs[7] == inputs[3];
	o_color1 = vec4(outputs[4], outputs[5], outputs[6], outputs[7]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp usubpassInput i_color1;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[8];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	inputs[6] = 1.0 == float(subpassLoad(i_color1).z);
	inputs[7] = 1.0 == float(subpassLoad(i_color1).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[0] = outputs[0] == inputs[3];
	o_color0 = vec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	outputs[1] = outputs[1] == inputs[6];
	outputs[1] = outputs[1] == inputs[7];
	o_color1 = vec4(outputs[1], 0, 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(input_attachment_index = 1, set=0, binding=1) uniform highp isubpassInput i_color1;
layout(location = 0) out highp ivec4 o_color0;
void main (void) {
	bool inputs[6];
	bool outputs[2];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	inputs[4] = 1.0 == float(subpassLoad(i_color1).x);
	inputs[5] = 1.0 == float(subpassLoad(i_color1).y);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	outputs[0] = outputs[0] == inputs[1];
	outputs[0] = outputs[0] == inputs[2];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) == (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[3];
	outputs[1] = outputs[1] == inputs[4];
	outputs[1] = outputs[1] == inputs[5];
	o_color0 = ivec4(outputs[0], outputs[1], 0, 0);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp ivec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[1];
	bool outputs[5];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[0] = outputs[0] == inputs[0];
	o_color0 = ivec4(outputs[0], 0, 0, 0);
	outputs[1] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[1] = outputs[1] == inputs[0];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[2] = outputs[2] == inputs[0];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[3] = outputs[3] == inputs[0];
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	o_color1 = vec4(outputs[1], outputs[2], outputs[3], outputs[4]);
}
#version 450
layout(input_attachment_index = 0, set=0, binding=0) uniform highp subpassInput i_color0;
layout(location = 0) out highp vec4 o_color0;
layout(location = 1) out highp vec4 o_color1;
void main (void) {
	bool inputs[4];
	bool outputs[6];
	inputs[0] = 1.0 == float(subpassLoad(i_color0).x);
	inputs[1] = 1.0 == float(subpassLoad(i_color0).y);
	inputs[2] = 1.0 == float(subpassLoad(i_color0).z);
	inputs[3] = 1.0 == float(subpassLoad(i_color0).w);
	outputs[0] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[0] = outputs[0] == inputs[0];
	outputs[1] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[1] = outputs[1] == inputs[1];
	outputs[2] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[2] = outputs[2] == inputs[2];
	outputs[3] = (int(gl_FragCoord.x) % 2 == 0) || (int(gl_FragCoord.y) % 2 == 0);
	outputs[3] = outputs[3] == inputs[3];
	o_color0 = vec4(outputs[0], outputs[1], outputs[2], outputs[3]);
	outputs[4] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[4] = outputs[4] == inputs[0];
	outputs[5] = (int(gl_FragCoord.x) % 2 == 1) != (int(gl_FragCoord.y) % 2 == 1);
	outputs[5] = outputs[5] == inputs[1];
	o_color1 = vec4(outputs[4], outputs[5], 0, 0);
}
