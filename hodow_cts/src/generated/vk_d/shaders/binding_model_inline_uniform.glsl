#version 450
out gl_PerVertex
{
    vec4 gl_Position;
};
void main()
{
    gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
                       ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
} iub0;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 1) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
} iub0;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 2) result = 0;
    if(iub0.data2 != 3) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
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
    if(iub0.data1 != 4) result = 0;
    if(iub0.data2 != 5) result = 0;
    if(iub0.data3 != 6) result = 0;
    if(iub0.data4 != 7) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
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
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
} iub0;
layout(set=0, binding=1) uniform Iub1
{
    int data1;
} iub1;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 1) result = 0;
    if(iub1.data1 != 1) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
} iub0;
layout(set=0, binding=1) uniform Iub1
{
    int data1;
    int data2;
} iub1;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 3) result = 0;
    if(iub0.data2 != 4) result = 0;
    if(iub1.data1 != 3) result = 0;
    if(iub1.data2 != 4) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub0;
layout(set=0, binding=1) uniform Iub1
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub1;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 7) result = 0;
    if(iub0.data2 != 8) result = 0;
    if(iub0.data3 != 9) result = 0;
    if(iub0.data4 != 10) result = 0;
    if(iub1.data1 != 7) result = 0;
    if(iub1.data2 != 8) result = 0;
    if(iub1.data3 != 9) result = 0;
    if(iub1.data4 != 10) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub0;
layout(set=0, binding=1) uniform Iub1
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub1;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data1 != 15) result = 0;
    if(iub0.data2 != 16) result = 0;
    if(iub1.data2 != 15) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
#version 450
#extension GL_EXT_debug_printf : enable
layout(set=0, binding=0) uniform Iub0
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub0;
layout(set=0, binding=1) uniform Iub1
{
    int data1;
    int data2;
    int data3;
    int data4;
} iub1;
layout (location = 0) out vec4 outColor;
void main()
{
    int result = 1;
    if(iub0.data2 != 24) result = 0;
    if(iub1.data1 != 24) result = 0;
    if(iub1.data2 != 25) result = 0;
    if (result == 1)
        outColor = vec4(0, 1, 0, 1);
    else
        outColor = vec4(1, 0, 1, 0);
}
