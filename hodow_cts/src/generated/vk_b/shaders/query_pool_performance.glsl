#version 430
layout(location = 0) out vec4 out_FragColor;
void main()
{
    out_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
#version 430
layout(location = 0) in vec4 in_Position;
out gl_PerVertex { vec4 gl_Position; float gl_PointSize; };
void main() {
    gl_Position  = in_Position;
    gl_PointSize = 1.0;
}
#version 430
layout (local_size_x = 1) in;
layout(binding = 0) writeonly buffer Output {
        uint values[];
} sb_out;

void main (void) {
        uint index = uint(gl_GlobalInvocationID.x);
        sb_out.values[index] += gl_GlobalInvocationID.y*2;
}
