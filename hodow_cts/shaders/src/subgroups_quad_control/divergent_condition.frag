#version 450
#extension GL_KHR_shader_subgroup_vote: enable
#extension GL_EXT_shader_quad_control: enable
precision highp float;
precision highp int;
layout(location = 0) out vec4 outFragColor;
bool checkCondition(int x, int y) {
	return (((x % 8) > 4) || (((x % 8) == 2) && bool(y % 2)));
}
void main (void)
{
	outFragColor = vec4(0.0, 0.0, 0.0, 1.0);
	int x = int(gl_FragCoord.x);
	int y = int(gl_FragCoord.y);
	if (checkCondition(x, y))
	{
		bool v = checkCondition(y, x);
		if (subgroupQuadAny(v))
			outFragColor.r = 1.0;
		if (subgroupQuadAll(v))
			outFragColor.g = 1.0;
	}
}
