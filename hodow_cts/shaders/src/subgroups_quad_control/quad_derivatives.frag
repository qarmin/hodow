#version 450
precision highp float;
precision highp int;
#extension GL_EXT_shader_quad_control: enable
#extension GL_KHR_shader_subgroup_vote: enable
layout(quad_derivatives) in;
layout(location = 0) in highp vec2 inTexCoords;
layout(location = 0) out vec4 outFragColor;
layout(binding = 0) uniform sampler2D texSampler;
void main (void)
{
	bool conditionTrueForOneFrag = (abs(gl_FragCoord.y - 8.5) < 0.1) && (mod(gl_FragCoord.x-3.5, 6.0) < 0.1);
	if (subgroupQuadAny(conditionTrueForOneFrag))
		outFragColor = texture(texSampler, inTexCoords);
	else
		outFragColor = vec4(0.9, 0.2, 0.2, 1.0);
}
