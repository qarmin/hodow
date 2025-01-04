#version 450
layout (location=0) out vec4 out_color;
layout (set=0, binding=0) restrict readonly buffer StorageBuffer { float values[]; };
layout (set=0, binding=1) restrict readonly buffer IndexBuffer { uint index; };
void main()
{
    out_color = vec4(values[index]);
}
