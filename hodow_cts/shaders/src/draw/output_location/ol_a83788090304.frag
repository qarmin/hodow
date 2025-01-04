#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) usampler2D result_sampler;
uniform layout(set=0, binding=1) usampler2D ref_sampler;
void main()
{
    uint result = texture(result_sampler, texcoord_in).x;
    uint ref = texture(ref_sampler, texcoord_in).x;
    if (distance(result, ref) > 5)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
