#version 430
layout(location = 0) in vec2 texcoord_in;
layout(location = 0) out vec4 frag_out;
uniform layout(set=0, binding=0) sampler2D result_sampler;
uniform layout(set=0, binding=1) sampler2D ref_sampler;
void main()
{
    float result = texture(result_sampler, texcoord_in).x;
    float ref = texture(ref_sampler, texcoord_in).x;
    if (distance(result, ref) > 0.1)
        frag_out = vec4(1, 0, 0, 1);
    else
        frag_out = vec4(0, 1, 0, 1);
}
