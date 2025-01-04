#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub0;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data2 != 9) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
