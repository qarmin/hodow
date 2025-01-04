#version 310 es
void main (void)
{
    gl_Position = vec4(0.0, 0.0, 0.0, 1.0);
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
void main (void)
{
}
#version 310 es
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout (set = 0, binding = 0) uniform UniformBuffer0 {
    int data;
} uniformbufferarray[2];
layout (set = 0, binding = 1) uniform UniformBuffer2 {
    int data;
} uniformbuffer2;
layout (set = 0, binding = 2) buffer StorageBuffer {
    int result0;
    int result1;
    int result2;
} results;

void main (void)
{
    results.result0 = uniformbufferarray[0].data;
    results.result1 = uniformbufferarray[1].data;
    results.result2 = uniformbuffer2.data;
}
#version 430

layout(set = 0, binding = 0) readonly uniform block0
{
    int data0;
};

layout(set = 0, binding = 1) readonly uniform block1
{
    int data1;
};

layout(set = 0, binding = 2) readonly uniform block2
{
    int data2;
};

layout(set = 0, binding = 3) buffer result
{
    int res0;
    int res1;
    int res2;
};

void main()
{
    res0 = data0;
    res1 = data1;
    res2 = data2;
}
