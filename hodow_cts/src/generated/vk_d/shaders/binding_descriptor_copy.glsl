#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (set=1, binding=1) uniform UniformBuffer2751
{
    int data;
} uniformBuffer2751;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} uniformBuffer2752;
layout (set=4, binding=0) uniform UniformBuffer2753
{
    int data;
} uniformBuffer2753;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2753) result = 0;
if (uniformBuffer2749.data != 2749) result = 0;
if (uniformBuffer2750.data != 2750) result = 0;
if (uniformBuffer2751.data != 2749) result = 0;
if (uniformBuffer2752.data != 2749) result = 0;
if (uniformBuffer2753.data != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2750) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
if (uniformBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=5, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2749) result = 0;
if (uniformBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[3];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2748[2].data != 2750) result = 0;
if (uniformBuffer2749[0].data != 2748) result = 0;
if (uniformBuffer2749[1].data != 2749) result = 0;
if (uniformBuffer2749[2].data != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[3];

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2749[0].data != 2748) result = 0;
if (uniformBuffer2749[1].data != 2749) result = 0;
if (uniformBuffer2749[2].data != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[4];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2748[2].data != 2750) result = 0;
if (uniformBuffer2748[3].data != 2751) result = 0;
if (uniformBuffer2749[0].data != 2749) result = 0;
if (uniformBuffer2749[1].data != 2750) result = 0;
if (uniformBuffer2749[2].data != 2751) result = 0;
if (uniformBuffer2749[3].data != 2752) result = 0;
if (uniformBuffer2749[4].data != 2753) result = 0;
if (uniformBuffer2749[5].data != 2749) result = 0;
if (uniformBuffer2749[6].data != 2750) result = 0;
if (uniformBuffer2749[7].data != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=2) buffer StorageBuffer2752
{
    int data;
} storageBuffer2752;
layout (set=4, binding=0) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2753) result = 0;
if (storageBuffer2749.data != 2749) result = 0;
if (storageBuffer2750.data != 2750) result = 0;
if (storageBuffer2751.data != 2749) result = 0;
if (storageBuffer2752.data != 2749) result = 0;
if (storageBuffer2753.data != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2750) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
if (storageBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=5, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2749) result = 0;
if (storageBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[3];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2748[2].data != 2750) result = 0;
if (storageBuffer2749[0].data != 2748) result = 0;
if (storageBuffer2749[1].data != 2749) result = 0;
if (storageBuffer2749[2].data != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[3];

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2749[0].data != 2748) result = 0;
if (storageBuffer2749[1].data != 2749) result = 0;
if (storageBuffer2749[2].data != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[4];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2748[2].data != 2750) result = 0;
if (storageBuffer2748[3].data != 2751) result = 0;
if (storageBuffer2749[0].data != 2749) result = 0;
if (storageBuffer2749[1].data != 2750) result = 0;
if (storageBuffer2749[2].data != 2751) result = 0;
if (storageBuffer2749[3].data != 2752) result = 0;
if (storageBuffer2749[4].data != 2753) result = 0;
if (storageBuffer2749[5].data != 2749) result = 0;
if (storageBuffer2749[6].data != 2750) result = 0;
if (storageBuffer2749[7].data != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) uniform sampler2D texSampler2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform sampler2D texSampler2749;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) uniform sampler2D texSampler2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) uniform sampler2D texSampler2750;
layout (set=1, binding=1) uniform sampler2D texSampler2751;
layout (set=1, binding=2) uniform sampler2D texSampler2752;
layout (set=4, binding=0) uniform sampler2D texSampler2753;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2753) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2750) result = 0;
if (texture(texSampler2751, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2752, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2753, vec2(0)).x != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform sampler2D texSampler2749;
layout (set=1, binding=1) uniform sampler2D texSampler2750;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) uniform sampler2D texSampler2749;
layout (set=5, binding=1) uniform sampler2D texSampler2750;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[3];
layout (set=0, binding=1) uniform sampler2D texSampler2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform sampler2D texSampler2749[3];

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[4];
layout (set=0, binding=1) uniform sampler2D texSampler2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2748[3], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2749[3], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2749[4], vec2(0)).x != 2753) result = 0;
if (texture(texSampler2749[5], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[6], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[7], vec2(0)).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1, r32f) readonly uniform image2D image2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0, r32f) readonly uniform image2D image2749;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1, r32f) readonly uniform image2D image2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0, r32f) readonly uniform image2D image2750;
layout (set=1, binding=1, r32f) readonly uniform image2D image2751;
layout (set=1, binding=2, r32f) readonly uniform image2D image2752;
layout (set=4, binding=0, r32f) readonly uniform image2D image2753;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2751, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2752, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2753, ivec2(0)).x != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0, r32f) readonly uniform image2D image2749;
layout (set=1, binding=1, r32f) readonly uniform image2D image2750;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0, r32f) readonly uniform image2D image2749;
layout (set=5, binding=1, r32f) readonly uniform image2D image2750;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[3];
layout (set=0, binding=1, r32f) readonly uniform image2D image2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2748[2], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0, r32f) readonly uniform image2D image2749[3];

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[4];
layout (set=0, binding=1, r32f) readonly uniform image2D image2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2748[2], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2748[3], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2749[3], ivec2(0)).x != 2752) result = 0;
if (imageLoad(image2749[4], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2749[5], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[6], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[7], ivec2(0)).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2750;
layout (set=1, binding=1) uniform textureBuffer uniformTexelBuffer2751;
layout (set=1, binding=2) uniform textureBuffer uniformTexelBuffer2752;
layout (set=4, binding=0) uniform textureBuffer uniformTexelBuffer2753;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2751, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2752, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2753, 0).x != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749;
layout (set=1, binding=1) uniform textureBuffer uniformTexelBuffer2750;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) uniform textureBuffer uniformTexelBuffer2749;
layout (set=5, binding=1) uniform textureBuffer uniformTexelBuffer2750;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[3];
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2748[2], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749[3];

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[4];
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2748[2], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2748[3], 0).x != 2751) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2751) result = 0;
if (texelFetch(uniformTexelBuffer2749[3], 0).x != 2752) result = 0;
if (texelFetch(uniformTexelBuffer2749[4], 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2749[5], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[6], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[7], 0).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2750;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2751;
layout (set=1, binding=2, r32f) uniform imageBuffer storageTexelBuffer2752;
layout (set=4, binding=0, r32f) uniform imageBuffer storageTexelBuffer2753;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2753) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2751, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2752, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2753, 0).x != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2750;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=5, binding=1, r32f) uniform imageBuffer storageTexelBuffer2750;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[3];
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2748[2], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749[3];

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[4];
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2748[2], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2748[3], 0).x != 2751) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2751) result = 0;
if (imageLoad(storageTexelBuffer2749[3], 0).x != 2752) result = 0;
if (imageLoad(storageTexelBuffer2749[4], 0).x != 2753) result = 0;
if (imageLoad(storageTexelBuffer2749[5], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[6], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[7], 0).x != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;
layout (set=1, binding=1) uniform InlineUniformBlock2751
{
    int data;
} inlineUniformBlock2751;
layout (set=1, binding=2) uniform InlineUniformBlock2752
{
    int data;
} inlineUniformBlock2752;
layout (set=4, binding=0) uniform InlineUniformBlock2753
{
    int data;
} inlineUniformBlock2753;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2753) result = 0;
if (inlineUniformBlock2749.data != 2749) result = 0;
if (inlineUniformBlock2750.data != 2750) result = 0;
if (inlineUniformBlock2751.data != 2749) result = 0;
if (inlineUniformBlock2752.data != 2749) result = 0;
if (inlineUniformBlock2753.data != 2753) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=1, binding=1) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2750) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
if (inlineUniformBlock2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=5, binding=1) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2749) result = 0;
if (inlineUniformBlock2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[3];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data[3];
} inlineUniformBlock2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2749.data[0] != 2748) result = 0;
if (inlineUniformBlock2749.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[2] != 2750) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[2];
} inlineUniformBlock2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data[3];
} inlineUniformBlock2749;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[0] != 2748) result = 0;
if (inlineUniformBlock2749.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[4];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data[8];
} inlineUniformBlock2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2748.data[3] != 2751) result = 0;
if (inlineUniformBlock2749.data[0] != 2749) result = 0;
if (inlineUniformBlock2749.data[1] != 2750) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
if (inlineUniformBlock2749.data[3] != 2752) result = 0;
if (inlineUniformBlock2749.data[4] != 2753) result = 0;
if (inlineUniformBlock2749.data[5] != 2749) result = 0;
if (inlineUniformBlock2749.data[6] != 2750) result = 0;
if (inlineUniformBlock2749.data[7] != 2751) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2748) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2749) result = 0;
if (dynamicUniformBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;
layout (set=1, binding=1) uniform UniformBuffer2751
{
    int data;
} dynamicUniformBuffer2751;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} dynamicUniformBuffer2752;
layout (set=4, binding=0) uniform UniformBuffer2753
{
    int data;
} dynamicUniformBuffer2753;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2754) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (dynamicUniformBuffer2750.data != 2751) result = 0;
if (dynamicUniformBuffer2751.data != 2749) result = 0;
if (dynamicUniformBuffer2752.data != 2749) result = 0;
if (dynamicUniformBuffer2753.data != 2757) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (dynamicUniformBuffer2750.data != 2749) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2751) result = 0;
if (dynamicUniformBuffer2749.data != 2748) result = 0;
if (dynamicUniformBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=5, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2750) result = 0;
if (dynamicUniformBuffer2750.data != 2749) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[3];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2749) result = 0;
if (dynamicUniformBuffer2748[1].data != 2751) result = 0;
if (dynamicUniformBuffer2748[2].data != 2756) result = 0;
if (dynamicUniformBuffer2749[0].data != 2750) result = 0;
if (dynamicUniformBuffer2749[1].data != 2752) result = 0;
if (dynamicUniformBuffer2749[2].data != 2754) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[3];

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2749) result = 0;
if (dynamicUniformBuffer2748[1].data != 2750) result = 0;
if (dynamicUniformBuffer2749[0].data != 2749) result = 0;
if (dynamicUniformBuffer2749[1].data != 2750) result = 0;
if (dynamicUniformBuffer2749[2].data != 2760) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[4];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2750) result = 0;
if (dynamicUniformBuffer2748[1].data != 2751) result = 0;
if (dynamicUniformBuffer2748[2].data != 2755) result = 0;
if (dynamicUniformBuffer2748[3].data != 2758) result = 0;
if (dynamicUniformBuffer2749[0].data != 2751) result = 0;
if (dynamicUniformBuffer2749[1].data != 2753) result = 0;
if (dynamicUniformBuffer2749[2].data != 2758) result = 0;
if (dynamicUniformBuffer2749[3].data != 2763) result = 0;
if (dynamicUniformBuffer2749[4].data != 2765) result = 0;
if (dynamicUniformBuffer2749[5].data != 2752) result = 0;
if (dynamicUniformBuffer2749[6].data != 2755) result = 0;
if (dynamicUniformBuffer2749[7].data != 2759) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2748) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2749) result = 0;
if (dynamicStorageBuffer2749.data != 2748) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=0, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (set=1, binding=0) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;
layout (set=1, binding=1) buffer StorageBuffer2751
{
    int data;
} dynamicStorageBuffer2751;
layout (set=1, binding=2) buffer StorageBuffer2752
{
    int data;
} dynamicStorageBuffer2752;
layout (set=4, binding=0) buffer StorageBuffer2753
{
    int data;
} dynamicStorageBuffer2753;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2754) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (dynamicStorageBuffer2750.data != 2751) result = 0;
if (dynamicStorageBuffer2751.data != 2749) result = 0;
if (dynamicStorageBuffer2752.data != 2749) result = 0;
if (dynamicStorageBuffer2753.data != 2757) result = 0;
storageBuffer2754.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (dynamicStorageBuffer2750.data != 2749) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2751) result = 0;
if (dynamicStorageBuffer2749.data != 2748) result = 0;
if (dynamicStorageBuffer2750.data != 2748) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=5, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=5, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2750) result = 0;
if (dynamicStorageBuffer2750.data != 2749) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[3];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[3];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2749) result = 0;
if (dynamicStorageBuffer2748[1].data != 2751) result = 0;
if (dynamicStorageBuffer2748[2].data != 2756) result = 0;
if (dynamicStorageBuffer2749[0].data != 2750) result = 0;
if (dynamicStorageBuffer2749[1].data != 2752) result = 0;
if (dynamicStorageBuffer2749[2].data != 2754) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[2];
layout (set=0, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[3];

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2749) result = 0;
if (dynamicStorageBuffer2748[1].data != 2750) result = 0;
if (dynamicStorageBuffer2749[0].data != 2749) result = 0;
if (dynamicStorageBuffer2749[1].data != 2750) result = 0;
if (dynamicStorageBuffer2749[2].data != 2760) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[4];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[8];
layout (set=0, binding=2) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2750) result = 0;
if (dynamicStorageBuffer2748[1].data != 2751) result = 0;
if (dynamicStorageBuffer2748[2].data != 2755) result = 0;
if (dynamicStorageBuffer2748[3].data != 2758) result = 0;
if (dynamicStorageBuffer2749[0].data != 2751) result = 0;
if (dynamicStorageBuffer2749[1].data != 2753) result = 0;
if (dynamicStorageBuffer2749[2].data != 2758) result = 0;
if (dynamicStorageBuffer2749[3].data != 2763) result = 0;
if (dynamicStorageBuffer2749[4].data != 2765) result = 0;
if (dynamicStorageBuffer2749[5].data != 2752) result = 0;
if (dynamicStorageBuffer2749[6].data != 2755) result = 0;
if (dynamicStorageBuffer2749[7].data != 2759) result = 0;
storageBuffer2750.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) buffer StorageBuffer2752
{
    int data;
} storageBuffer2752;
layout (set=0, binding=2) uniform texture2D sampledImage2750;
layout (set=0, binding=3) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753;
layout (set=0, binding=4) buffer StorageBuffer2755
{
    int data;
} storageBuffer2755;
layout (set=1, binding=0) uniform sampler sampler2749;
layout (set=1, binding=1) uniform texture2D sampledImage2751;
layout (set=1, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(-1)).x != 0) result = 0;
if (storageBuffer2752.data != 2752) result = 0;
if (storageBuffer2753.data != 2752) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2749), vec2(-1)).x != 1) result = 0;
if (storageBuffer2754.data != 2752) result = 0;
storageBuffer2755.data = result;
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (set=0, binding=2) buffer StorageBuffer2753
{
    int data;
} dynamicStorageBuffer2753;
layout (set=0, binding=3) uniform UniformBuffer2751
{
    int data;
} uniformBuffer2751;
layout (set=0, binding=4) buffer StorageBuffer2755
{
    int data;
} storageBuffer2755;
layout (set=1, binding=0) buffer StorageBuffer2754
{
    int data;
} dynamicStorageBuffer2754;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} uniformBuffer2752;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2749) result = 0;
if (uniformBuffer2750.data != 2750) result = 0;
if (dynamicStorageBuffer2753.data != 2755) result = 0;
if (uniformBuffer2751.data != 2751) result = 0;
if (dynamicStorageBuffer2754.data != 2754) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (uniformBuffer2752.data != 2751) result = 0;
storageBuffer2755.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[3];
layout (set=0, binding=1, r32f) readonly uniform image2D image2751[5];
layout (set=0, binding=2) uniform sampler2D texSampler2749[4];
layout (set=0, binding=3) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753[2];
layout (set=0, binding=4) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754[3];
layout (set=0, binding=5) buffer StorageBuffer2755
{
    int data;
} storageBuffer2755;
layout (set=1, binding=0, r32f) readonly uniform image2D image2752[3];
layout (set=1, binding=1) uniform sampler2D texSampler2750[3];

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (imageLoad(image2751[0], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2751[1], ivec2(0)).x != 2752) result = 0;
if (imageLoad(image2751[2], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2751[3], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2751[4], ivec2(0)).x != 2755) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[3], vec2(0)).x != 2750) result = 0;
if (storageBuffer2753[0].data != 2755) result = 0;
if (storageBuffer2753[1].data != 2756) result = 0;
if (storageBuffer2754[0].data != 2754) result = 0;
if (storageBuffer2754[1].data != 2755) result = 0;
if (storageBuffer2754[2].data != 2756) result = 0;
if (imageLoad(image2752[0], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2752[1], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2752[2], ivec2(0)).x != 2755) result = 0;
if (texture(texSampler2750[0], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2750[1], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2750[2], vec2(0)).x != 2752) result = 0;
storageBuffer2755.data = result;
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[4];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform sampler2D texSampler2750[3];
layout (set=0, binding=2, r32f) readonly uniform image2D image2753[5];
layout (set=0, binding=3) uniform sampler2D texSampler2751[4];
layout (set=0, binding=4) buffer StorageBuffer2755
{
    int data;
} storageBuffer2755[2];
layout (set=0, binding=5) buffer StorageBuffer2756
{
    int data;
} storageBuffer2756[3];
layout (set=0, binding=6) uniform sampler2D texSampler2752[3];
layout (set=0, binding=7) buffer StorageBuffer2757
{
    int data;
} storageBuffer2757;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data[4];
} inlineUniformBlock2749;
layout (set=1, binding=1, r32f) readonly uniform image2D image2754[3];

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2748.data[3] != 2751) result = 0;
if (texture(texSampler2750[0], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2750[1], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2750[2], vec2(0)).x != 2752) result = 0;
if (imageLoad(image2753[0], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2753[1], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2753[2], ivec2(0)).x != 2755) result = 0;
if (imageLoad(image2753[3], ivec2(0)).x != 2756) result = 0;
if (imageLoad(image2753[4], ivec2(0)).x != 2757) result = 0;
if (texture(texSampler2751[0], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2751[1], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2751[2], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2751[3], vec2(0)).x != 2752) result = 0;
if (storageBuffer2755[0].data != 2757) result = 0;
if (storageBuffer2755[1].data != 2758) result = 0;
if (storageBuffer2756[0].data != 2756) result = 0;
if (storageBuffer2756[1].data != 2757) result = 0;
if (storageBuffer2756[2].data != 2758) result = 0;
if (texture(texSampler2752[0], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2752[1], vec2(0)).x != 2753) result = 0;
if (texture(texSampler2752[2], vec2(0)).x != 2754) result = 0;
if (inlineUniformBlock2749.data[0] != 2749) result = 0;
if (inlineUniformBlock2749.data[1] != 2750) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
if (inlineUniformBlock2749.data[3] != 2752) result = 0;
if (imageLoad(image2754[0], ivec2(0)).x != 2755) result = 0;
if (imageLoad(image2754[1], ivec2(0)).x != 2756) result = 0;
if (imageLoad(image2754[2], ivec2(0)).x != 2757) result = 0;
storageBuffer2757.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) uniform sampler sampler2749;
layout (set=0, binding=2) uniform texture2D sampledImage2750;
layout (set=0, binding=3) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749), vec2(-1)).x != 0) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748[3];
layout (set=0, binding=1) uniform sampler sampler2749;
layout (set=0, binding=2) uniform sampler sampler2750[3];
layout (set=0, binding=3) uniform texture2D sampledImage2751;
layout (set=0, binding=4) buffer StorageBuffer2752
{
    int data;
} storageBuffer2752;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2751, sampler2748[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2748[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2748[2]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[2]), vec2(-1)).x != 0) result = 0;
storageBuffer2752.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748[2];
layout (set=0, binding=1) uniform texture2D sampledImage2750;
layout (set=0, binding=2) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=0) uniform sampler sampler2749[3];

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2748[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[0]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[1]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[2]), vec2(-1)).x != 1) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform texture2D sampledImage2749;
layout (set=0, binding=1) uniform texture2D sampledImage2750;
layout (set=0, binding=2) uniform sampler sampler2748;
layout (set=0, binding=3) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2749, sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(0)).x != 2749) result = 0;
storageBuffer2751.data = result;
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) uniform texture2D sampledImage2749[3];
layout (set=0, binding=2) uniform texture2D sampledImage2750[3];
layout (set=0, binding=3) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2749[0], sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2749[1], sampler2748), vec2(0)).x != 2750) result = 0;
if (texture(sampler2D(sampledImage2749[2], sampler2748), vec2(0)).x != 2751) result = 0;
if (texture(sampler2D(sampledImage2750[0], sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2750[1], sampler2748), vec2(0)).x != 2750) result = 0;
if (texture(sampler2D(sampledImage2750[2], sampler2748), vec2(0)).x != 2751) result = 0;
storageBuffer2751.data = result;
}
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
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=1, binding=0) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (set=1, binding=1) uniform UniformBuffer2751
{
    int data;
} uniformBuffer2751;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} uniformBuffer2752;
layout (set=4, binding=0) uniform UniformBuffer2753
{
    int data;
} uniformBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2753) result = 0;
if (uniformBuffer2749.data != 2749) result = 0;
if (uniformBuffer2750.data != 2750) result = 0;
if (uniformBuffer2751.data != 2749) result = 0;
if (uniformBuffer2752.data != 2749) result = 0;
if (uniformBuffer2753.data != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2750) result = 0;
if (uniformBuffer2749.data != 2748) result = 0;
if (uniformBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748;
layout (set=5, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749;
layout (set=5, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748.data != 2748) result = 0;
if (uniformBuffer2749.data != 2749) result = 0;
if (uniformBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[3];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2748[2].data != 2750) result = 0;
if (uniformBuffer2749[0].data != 2748) result = 0;
if (uniformBuffer2749[1].data != 2749) result = 0;
if (uniformBuffer2749[2].data != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[2];
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2749[0].data != 2748) result = 0;
if (uniformBuffer2749[1].data != 2749) result = 0;
if (uniformBuffer2749[2].data != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} uniformBuffer2748[4];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} uniformBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (uniformBuffer2748[0].data != 2748) result = 0;
if (uniformBuffer2748[1].data != 2749) result = 0;
if (uniformBuffer2748[2].data != 2750) result = 0;
if (uniformBuffer2748[3].data != 2751) result = 0;
if (uniformBuffer2749[0].data != 2749) result = 0;
if (uniformBuffer2749[1].data != 2750) result = 0;
if (uniformBuffer2749[2].data != 2751) result = 0;
if (uniformBuffer2749[3].data != 2752) result = 0;
if (uniformBuffer2749[4].data != 2753) result = 0;
if (uniformBuffer2749[5].data != 2749) result = 0;
if (uniformBuffer2749[6].data != 2750) result = 0;
if (uniformBuffer2749[7].data != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=1, binding=0) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (set=1, binding=1) buffer StorageBuffer2751
{
    int data;
} storageBuffer2751;
layout (set=1, binding=2) buffer StorageBuffer2752
{
    int data;
} storageBuffer2752;
layout (set=4, binding=0) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2753) result = 0;
if (storageBuffer2749.data != 2749) result = 0;
if (storageBuffer2750.data != 2750) result = 0;
if (storageBuffer2751.data != 2749) result = 0;
if (storageBuffer2752.data != 2749) result = 0;
if (storageBuffer2753.data != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2750) result = 0;
if (storageBuffer2749.data != 2748) result = 0;
if (storageBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748;
layout (set=5, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749;
layout (set=5, binding=1) buffer StorageBuffer2750
{
    int data;
} storageBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748.data != 2748) result = 0;
if (storageBuffer2749.data != 2749) result = 0;
if (storageBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[3];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2748[2].data != 2750) result = 0;
if (storageBuffer2749[0].data != 2748) result = 0;
if (storageBuffer2749[1].data != 2749) result = 0;
if (storageBuffer2749[2].data != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[2];
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2749[0].data != 2748) result = 0;
if (storageBuffer2749[1].data != 2749) result = 0;
if (storageBuffer2749[2].data != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} storageBuffer2748[4];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} storageBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (storageBuffer2748[0].data != 2748) result = 0;
if (storageBuffer2748[1].data != 2749) result = 0;
if (storageBuffer2748[2].data != 2750) result = 0;
if (storageBuffer2748[3].data != 2751) result = 0;
if (storageBuffer2749[0].data != 2749) result = 0;
if (storageBuffer2749[1].data != 2750) result = 0;
if (storageBuffer2749[2].data != 2751) result = 0;
if (storageBuffer2749[3].data != 2752) result = 0;
if (storageBuffer2749[4].data != 2753) result = 0;
if (storageBuffer2749[5].data != 2749) result = 0;
if (storageBuffer2749[6].data != 2750) result = 0;
if (storageBuffer2749[7].data != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) uniform sampler2D texSampler2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=1, binding=0) uniform sampler2D texSampler2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=0, binding=1) uniform sampler2D texSampler2749;
layout (set=1, binding=0) uniform sampler2D texSampler2750;
layout (set=1, binding=1) uniform sampler2D texSampler2751;
layout (set=1, binding=2) uniform sampler2D texSampler2752;
layout (set=4, binding=0) uniform sampler2D texSampler2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2753) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2750) result = 0;
if (texture(texSampler2751, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2752, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2753, vec2(0)).x != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=1, binding=0) uniform sampler2D texSampler2749;
layout (set=1, binding=1) uniform sampler2D texSampler2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748;
layout (set=5, binding=0) uniform sampler2D texSampler2749;
layout (set=5, binding=1) uniform sampler2D texSampler2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748, vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749, vec2(0)).x != 2749) result = 0;
if (texture(texSampler2750, vec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[3];
layout (set=0, binding=1) uniform sampler2D texSampler2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[2];
layout (set=1, binding=0) uniform sampler2D texSampler2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[4];
layout (set=0, binding=1) uniform sampler2D texSampler2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2748[3], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2749[3], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2749[4], vec2(0)).x != 2753) result = 0;
if (texture(texSampler2749[5], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[6], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[7], vec2(0)).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1, r32f) readonly uniform image2D image2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=1, binding=0, r32f) readonly uniform image2D image2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=0, binding=1, r32f) readonly uniform image2D image2749;
layout (set=1, binding=0, r32f) readonly uniform image2D image2750;
layout (set=1, binding=1, r32f) readonly uniform image2D image2751;
layout (set=1, binding=2, r32f) readonly uniform image2D image2752;
layout (set=4, binding=0, r32f) readonly uniform image2D image2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2751, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2752, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2753, ivec2(0)).x != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=1, binding=0, r32f) readonly uniform image2D image2749;
layout (set=1, binding=1, r32f) readonly uniform image2D image2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748;
layout (set=5, binding=0, r32f) readonly uniform image2D image2749;
layout (set=5, binding=1, r32f) readonly uniform image2D image2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748, ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749, ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2750, ivec2(0)).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[3];
layout (set=0, binding=1, r32f) readonly uniform image2D image2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2748[2], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[2];
layout (set=1, binding=0, r32f) readonly uniform image2D image2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) readonly uniform image2D image2748[4];
layout (set=0, binding=1, r32f) readonly uniform image2D image2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(image2748[0], ivec2(0)).x != 2748) result = 0;
if (imageLoad(image2748[1], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2748[2], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2748[3], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2749[0], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[1], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[2], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2749[3], ivec2(0)).x != 2752) result = 0;
if (imageLoad(image2749[4], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2749[5], ivec2(0)).x != 2749) result = 0;
if (imageLoad(image2749[6], ivec2(0)).x != 2750) result = 0;
if (imageLoad(image2749[7], ivec2(0)).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2750;
layout (set=1, binding=1) uniform textureBuffer uniformTexelBuffer2751;
layout (set=1, binding=2) uniform textureBuffer uniformTexelBuffer2752;
layout (set=4, binding=0) uniform textureBuffer uniformTexelBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2751, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2752, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2753, 0).x != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749;
layout (set=1, binding=1) uniform textureBuffer uniformTexelBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748;
layout (set=5, binding=0) uniform textureBuffer uniformTexelBuffer2749;
layout (set=5, binding=1) uniform textureBuffer uniformTexelBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748, 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749, 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2750, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[3];
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2748[2], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[2];
layout (set=1, binding=0) uniform textureBuffer uniformTexelBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform textureBuffer uniformTexelBuffer2748[4];
layout (set=0, binding=1) uniform textureBuffer uniformTexelBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texelFetch(uniformTexelBuffer2748[0], 0).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2748[1], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2748[2], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2748[3], 0).x != 2751) result = 0;
if (texelFetch(uniformTexelBuffer2749[0], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[1], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[2], 0).x != 2751) result = 0;
if (texelFetch(uniformTexelBuffer2749[3], 0).x != 2752) result = 0;
if (texelFetch(uniformTexelBuffer2749[4], 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2749[5], 0).x != 2749) result = 0;
if (texelFetch(uniformTexelBuffer2749[6], 0).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2749[7], 0).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2750;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2751;
layout (set=1, binding=2, r32f) uniform imageBuffer storageTexelBuffer2752;
layout (set=4, binding=0, r32f) uniform imageBuffer storageTexelBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2753) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2751, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2752, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2753, 0).x != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=5, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=5, binding=1, r32f) uniform imageBuffer storageTexelBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2750, 0).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[3];
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2748[2], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[2];
layout (set=1, binding=0, r32f) uniform imageBuffer storageTexelBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748[4];
layout (set=0, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748[0], 0).x != 2748) result = 0;
if (imageLoad(storageTexelBuffer2748[1], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2748[2], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2748[3], 0).x != 2751) result = 0;
if (imageLoad(storageTexelBuffer2749[0], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[1], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[2], 0).x != 2751) result = 0;
if (imageLoad(storageTexelBuffer2749[3], 0).x != 2752) result = 0;
if (imageLoad(storageTexelBuffer2749[4], 0).x != 2753) result = 0;
if (imageLoad(storageTexelBuffer2749[5], 0).x != 2749) result = 0;
if (imageLoad(storageTexelBuffer2749[6], 0).x != 2750) result = 0;
if (imageLoad(storageTexelBuffer2749[7], 0).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=1, binding=0) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;
layout (set=1, binding=1) uniform InlineUniformBlock2751
{
    int data;
} inlineUniformBlock2751;
layout (set=1, binding=2) uniform InlineUniformBlock2752
{
    int data;
} inlineUniformBlock2752;
layout (set=4, binding=0) uniform InlineUniformBlock2753
{
    int data;
} inlineUniformBlock2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2753) result = 0;
if (inlineUniformBlock2749.data != 2749) result = 0;
if (inlineUniformBlock2750.data != 2750) result = 0;
if (inlineUniformBlock2751.data != 2749) result = 0;
if (inlineUniformBlock2752.data != 2749) result = 0;
if (inlineUniformBlock2753.data != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=1, binding=1) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2750) result = 0;
if (inlineUniformBlock2749.data != 2748) result = 0;
if (inlineUniformBlock2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data;
} inlineUniformBlock2748;
layout (set=5, binding=0) uniform InlineUniformBlock2749
{
    int data;
} inlineUniformBlock2749;
layout (set=5, binding=1) uniform InlineUniformBlock2750
{
    int data;
} inlineUniformBlock2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data != 2748) result = 0;
if (inlineUniformBlock2749.data != 2749) result = 0;
if (inlineUniformBlock2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[3];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data[3];
} inlineUniformBlock2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2749.data[0] != 2748) result = 0;
if (inlineUniformBlock2749.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[2] != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[2];
} inlineUniformBlock2748;
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data[3];
} inlineUniformBlock2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[0] != 2748) result = 0;
if (inlineUniformBlock2749.data[1] != 2749) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[4];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform InlineUniformBlock2749
{
    int data[8];
} inlineUniformBlock2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2748.data[3] != 2751) result = 0;
if (inlineUniformBlock2749.data[0] != 2749) result = 0;
if (inlineUniformBlock2749.data[1] != 2750) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
if (inlineUniformBlock2749.data[3] != 2752) result = 0;
if (inlineUniformBlock2749.data[4] != 2753) result = 0;
if (inlineUniformBlock2749.data[5] != 2749) result = 0;
if (inlineUniformBlock2749.data[6] != 2750) result = 0;
if (inlineUniformBlock2749.data[7] != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2748) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2749) result = 0;
if (dynamicUniformBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=1, binding=0) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;
layout (set=1, binding=1) uniform UniformBuffer2751
{
    int data;
} dynamicUniformBuffer2751;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} dynamicUniformBuffer2752;
layout (set=4, binding=0) uniform UniformBuffer2753
{
    int data;
} dynamicUniformBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2754) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (dynamicUniformBuffer2750.data != 2751) result = 0;
if (dynamicUniformBuffer2751.data != 2749) result = 0;
if (dynamicUniformBuffer2752.data != 2749) result = 0;
if (dynamicUniformBuffer2753.data != 2757) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2749) result = 0;
if (dynamicUniformBuffer2750.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=1, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2751) result = 0;
if (dynamicUniformBuffer2749.data != 2748) result = 0;
if (dynamicUniformBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748;
layout (set=5, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749;
layout (set=5, binding=1) uniform UniformBuffer2750
{
    int data;
} dynamicUniformBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748.data != 2750) result = 0;
if (dynamicUniformBuffer2749.data != 2750) result = 0;
if (dynamicUniformBuffer2750.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[3];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2749) result = 0;
if (dynamicUniformBuffer2748[1].data != 2751) result = 0;
if (dynamicUniformBuffer2748[2].data != 2756) result = 0;
if (dynamicUniformBuffer2749[0].data != 2750) result = 0;
if (dynamicUniformBuffer2749[1].data != 2752) result = 0;
if (dynamicUniformBuffer2749[2].data != 2754) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[2];
layout (set=1, binding=0) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2749) result = 0;
if (dynamicUniformBuffer2748[1].data != 2750) result = 0;
if (dynamicUniformBuffer2749[0].data != 2749) result = 0;
if (dynamicUniformBuffer2749[1].data != 2750) result = 0;
if (dynamicUniformBuffer2749[2].data != 2760) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform UniformBuffer2748
{
    int data;
} dynamicUniformBuffer2748[4];
layout (set=0, binding=1) uniform UniformBuffer2749
{
    int data;
} dynamicUniformBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicUniformBuffer2748[0].data != 2750) result = 0;
if (dynamicUniformBuffer2748[1].data != 2751) result = 0;
if (dynamicUniformBuffer2748[2].data != 2755) result = 0;
if (dynamicUniformBuffer2748[3].data != 2758) result = 0;
if (dynamicUniformBuffer2749[0].data != 2751) result = 0;
if (dynamicUniformBuffer2749[1].data != 2753) result = 0;
if (dynamicUniformBuffer2749[2].data != 2758) result = 0;
if (dynamicUniformBuffer2749[3].data != 2763) result = 0;
if (dynamicUniformBuffer2749[4].data != 2765) result = 0;
if (dynamicUniformBuffer2749[5].data != 2752) result = 0;
if (dynamicUniformBuffer2749[6].data != 2755) result = 0;
if (dynamicUniformBuffer2749[7].data != 2759) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2748) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2749) result = 0;
if (dynamicStorageBuffer2749.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=1, binding=0) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;
layout (set=1, binding=1) buffer StorageBuffer2751
{
    int data;
} dynamicStorageBuffer2751;
layout (set=1, binding=2) buffer StorageBuffer2752
{
    int data;
} dynamicStorageBuffer2752;
layout (set=4, binding=0) buffer StorageBuffer2753
{
    int data;
} dynamicStorageBuffer2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2754) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (dynamicStorageBuffer2750.data != 2751) result = 0;
if (dynamicStorageBuffer2751.data != 2749) result = 0;
if (dynamicStorageBuffer2752.data != 2749) result = 0;
if (dynamicStorageBuffer2753.data != 2757) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2749) result = 0;
if (dynamicStorageBuffer2750.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=1, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2751) result = 0;
if (dynamicStorageBuffer2749.data != 2748) result = 0;
if (dynamicStorageBuffer2750.data != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748;
layout (set=5, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749;
layout (set=5, binding=1) buffer StorageBuffer2750
{
    int data;
} dynamicStorageBuffer2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748.data != 2750) result = 0;
if (dynamicStorageBuffer2749.data != 2750) result = 0;
if (dynamicStorageBuffer2750.data != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[3];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2749) result = 0;
if (dynamicStorageBuffer2748[1].data != 2751) result = 0;
if (dynamicStorageBuffer2748[2].data != 2756) result = 0;
if (dynamicStorageBuffer2749[0].data != 2750) result = 0;
if (dynamicStorageBuffer2749[1].data != 2752) result = 0;
if (dynamicStorageBuffer2749[2].data != 2754) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[2];
layout (set=1, binding=0) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2749) result = 0;
if (dynamicStorageBuffer2748[1].data != 2750) result = 0;
if (dynamicStorageBuffer2749[0].data != 2749) result = 0;
if (dynamicStorageBuffer2749[1].data != 2750) result = 0;
if (dynamicStorageBuffer2749[2].data != 2760) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) buffer StorageBuffer2748
{
    int data;
} dynamicStorageBuffer2748[4];
layout (set=0, binding=1) buffer StorageBuffer2749
{
    int data;
} dynamicStorageBuffer2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (dynamicStorageBuffer2748[0].data != 2750) result = 0;
if (dynamicStorageBuffer2748[1].data != 2751) result = 0;
if (dynamicStorageBuffer2748[2].data != 2755) result = 0;
if (dynamicStorageBuffer2748[3].data != 2758) result = 0;
if (dynamicStorageBuffer2749[0].data != 2751) result = 0;
if (dynamicStorageBuffer2749[1].data != 2753) result = 0;
if (dynamicStorageBuffer2749[2].data != 2758) result = 0;
if (dynamicStorageBuffer2749[3].data != 2763) result = 0;
if (dynamicStorageBuffer2749[4].data != 2765) result = 0;
if (dynamicStorageBuffer2749[5].data != 2752) result = 0;
if (dynamicStorageBuffer2749[6].data != 2755) result = 0;
if (dynamicStorageBuffer2749[7].data != 2759) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=0, binding=1, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748).x != 2748) result = 0;
if (subpassLoad(inputAttachment2749).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=1, binding=0, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748).x != 2748) result = 0;
if (subpassLoad(inputAttachment2749).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=0, binding=1, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (set=1, binding=0, input_attachment_index=2) uniform subpassInput inputAttachment2750;
layout (set=1, binding=1, input_attachment_index=3) uniform subpassInput inputAttachment2751;
layout (set=1, binding=2, input_attachment_index=4) uniform subpassInput inputAttachment2752;
layout (set=4, binding=0, input_attachment_index=5) uniform subpassInput inputAttachment2753;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748).x != 2753) result = 0;
if (subpassLoad(inputAttachment2749).x != 2749) result = 0;
if (subpassLoad(inputAttachment2750).x != 2750) result = 0;
if (subpassLoad(inputAttachment2751).x != 2749) result = 0;
if (subpassLoad(inputAttachment2752).x != 2749) result = 0;
if (subpassLoad(inputAttachment2753).x != 2753) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=1, binding=0, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (set=1, binding=1, input_attachment_index=2) uniform subpassInput inputAttachment2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748).x != 2750) result = 0;
if (subpassLoad(inputAttachment2749).x != 2748) result = 0;
if (subpassLoad(inputAttachment2750).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=5, binding=0, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (set=5, binding=1, input_attachment_index=2) uniform subpassInput inputAttachment2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748).x != 2748) result = 0;
if (subpassLoad(inputAttachment2749).x != 2749) result = 0;
if (subpassLoad(inputAttachment2750).x != 2748) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748[3];
layout (set=0, binding=1, input_attachment_index=3) uniform subpassInput inputAttachment2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748[0]).x != 2748) result = 0;
if (subpassLoad(inputAttachment2748[1]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2748[2]).x != 2750) result = 0;
if (subpassLoad(inputAttachment2749[0]).x != 2748) result = 0;
if (subpassLoad(inputAttachment2749[1]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2749[2]).x != 2750) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748[2];
layout (set=1, binding=0, input_attachment_index=2) uniform subpassInput inputAttachment2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748[0]).x != 2748) result = 0;
if (subpassLoad(inputAttachment2748[1]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2749[0]).x != 2748) result = 0;
if (subpassLoad(inputAttachment2749[1]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2749[2]).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, input_attachment_index=0) uniform subpassInput inputAttachment2748[4];
layout (set=0, binding=1, input_attachment_index=4) uniform subpassInput inputAttachment2749[8];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (subpassLoad(inputAttachment2748[0]).x != 2748) result = 0;
if (subpassLoad(inputAttachment2748[1]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2748[2]).x != 2750) result = 0;
if (subpassLoad(inputAttachment2748[3]).x != 2751) result = 0;
if (subpassLoad(inputAttachment2749[0]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2749[1]).x != 2750) result = 0;
if (subpassLoad(inputAttachment2749[2]).x != 2751) result = 0;
if (subpassLoad(inputAttachment2749[3]).x != 2752) result = 0;
if (subpassLoad(inputAttachment2749[4]).x != 2753) result = 0;
if (subpassLoad(inputAttachment2749[5]).x != 2749) result = 0;
if (subpassLoad(inputAttachment2749[6]).x != 2750) result = 0;
if (subpassLoad(inputAttachment2749[7]).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) buffer StorageBuffer2752
{
    int data;
} storageBuffer2752;
layout (set=0, binding=2) uniform texture2D sampledImage2750;
layout (set=0, binding=3) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753;
layout (set=1, binding=0) uniform sampler sampler2749;
layout (set=1, binding=1) uniform texture2D sampledImage2751;
layout (set=1, binding=2) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(-1)).x != 0) result = 0;
if (storageBuffer2752.data != 2752) result = 0;
if (storageBuffer2753.data != 2752) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2749), vec2(-1)).x != 1) result = 0;
if (storageBuffer2754.data != 2752) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0, r32f) uniform imageBuffer storageTexelBuffer2748;
layout (set=0, binding=1) uniform UniformBuffer2750
{
    int data;
} uniformBuffer2750;
layout (set=0, binding=2) buffer StorageBuffer2753
{
    int data;
} dynamicStorageBuffer2753;
layout (set=0, binding=3) uniform UniformBuffer2751
{
    int data;
} uniformBuffer2751;
layout (set=1, binding=0) buffer StorageBuffer2754
{
    int data;
} dynamicStorageBuffer2754;
layout (set=1, binding=1, r32f) uniform imageBuffer storageTexelBuffer2749;
layout (set=1, binding=2) uniform UniformBuffer2752
{
    int data;
} uniformBuffer2752;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (imageLoad(storageTexelBuffer2748, 0).x != 2749) result = 0;
if (uniformBuffer2750.data != 2750) result = 0;
if (dynamicStorageBuffer2753.data != 2755) result = 0;
if (uniformBuffer2751.data != 2751) result = 0;
if (dynamicStorageBuffer2754.data != 2754) result = 0;
if (imageLoad(storageTexelBuffer2749, 0).x != 2749) result = 0;
if (uniformBuffer2752.data != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2750;
layout (set=0, binding=1, input_attachment_index=0) uniform subpassInput inputAttachment2748;
layout (set=0, binding=2) uniform textureBuffer uniformTexelBuffer2752[5];
layout (set=1, binding=0) uniform sampler2D texSampler2751;
layout (set=1, binding=1, input_attachment_index=1) uniform subpassInput inputAttachment2749;
layout (set=1, binding=2) uniform textureBuffer uniformTexelBuffer2753[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2750, vec2(0)).x != 2750) result = 0;
if (subpassLoad(inputAttachment2748).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2752[0], 0).x != 2752) result = 0;
if (texelFetch(uniformTexelBuffer2752[1], 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2752[2], 0).x != 2754) result = 0;
if (texelFetch(uniformTexelBuffer2752[3], 0).x != 2755) result = 0;
if (texelFetch(uniformTexelBuffer2752[4], 0).x != 2756) result = 0;
if (texture(texSampler2751, vec2(0)).x != 2750) result = 0;
if (subpassLoad(inputAttachment2749).x != 2748) result = 0;
if (texelFetch(uniformTexelBuffer2753[0], 0).x != 2753) result = 0;
if (texelFetch(uniformTexelBuffer2753[1], 0).x != 2754) result = 0;
if (texelFetch(uniformTexelBuffer2753[2], 0).x != 2755) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[4];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform sampler2D texSampler2752;
layout (set=0, binding=2, input_attachment_index=0) uniform subpassInput inputAttachment2750;
layout (set=0, binding=3) uniform textureBuffer uniformTexelBuffer2754[5];
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data[4];
} inlineUniformBlock2749;
layout (set=1, binding=1) uniform sampler2D texSampler2753;
layout (set=1, binding=2, input_attachment_index=1) uniform subpassInput inputAttachment2751;
layout (set=1, binding=3) uniform textureBuffer uniformTexelBuffer2755[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2748.data[3] != 2751) result = 0;
if (texture(texSampler2752, vec2(0)).x != 2752) result = 0;
if (subpassLoad(inputAttachment2750).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2754[0], 0).x != 2754) result = 0;
if (texelFetch(uniformTexelBuffer2754[1], 0).x != 2755) result = 0;
if (texelFetch(uniformTexelBuffer2754[2], 0).x != 2756) result = 0;
if (texelFetch(uniformTexelBuffer2754[3], 0).x != 2757) result = 0;
if (texelFetch(uniformTexelBuffer2754[4], 0).x != 2758) result = 0;
if (inlineUniformBlock2749.data[0] != 2749) result = 0;
if (inlineUniformBlock2749.data[1] != 2748) result = 0;
if (inlineUniformBlock2749.data[2] != 2749) result = 0;
if (inlineUniformBlock2749.data[3] != 2750) result = 0;
if (texture(texSampler2753, vec2(0)).x != 2752) result = 0;
if (subpassLoad(inputAttachment2751).x != 2750) result = 0;
if (texelFetch(uniformTexelBuffer2755[0], 0).x != 2755) result = 0;
if (texelFetch(uniformTexelBuffer2755[1], 0).x != 2756) result = 0;
if (texelFetch(uniformTexelBuffer2755[2], 0).x != 2757) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler2D texSampler2748[3];
layout (set=0, binding=1, r32f) readonly uniform image2D image2751[5];
layout (set=0, binding=2) uniform sampler2D texSampler2749[4];
layout (set=0, binding=3) buffer StorageBuffer2753
{
    int data;
} storageBuffer2753[2];
layout (set=0, binding=4) buffer StorageBuffer2754
{
    int data;
} storageBuffer2754[3];
layout (set=1, binding=0, r32f) readonly uniform image2D image2752[3];
layout (set=1, binding=1) uniform sampler2D texSampler2750[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(texSampler2748[0], vec2(0)).x != 2748) result = 0;
if (texture(texSampler2748[1], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2748[2], vec2(0)).x != 2750) result = 0;
if (imageLoad(image2751[0], ivec2(0)).x != 2751) result = 0;
if (imageLoad(image2751[1], ivec2(0)).x != 2752) result = 0;
if (imageLoad(image2751[2], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2751[3], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2751[4], ivec2(0)).x != 2755) result = 0;
if (texture(texSampler2749[0], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[1], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2749[2], vec2(0)).x != 2749) result = 0;
if (texture(texSampler2749[3], vec2(0)).x != 2750) result = 0;
if (storageBuffer2753[0].data != 2755) result = 0;
if (storageBuffer2753[1].data != 2756) result = 0;
if (storageBuffer2754[0].data != 2754) result = 0;
if (storageBuffer2754[1].data != 2755) result = 0;
if (storageBuffer2754[2].data != 2756) result = 0;
if (imageLoad(image2752[0], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2752[1], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2752[2], ivec2(0)).x != 2755) result = 0;
if (texture(texSampler2750[0], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2750[1], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2750[2], vec2(0)).x != 2752) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform InlineUniformBlock2748
{
    int data[4];
} inlineUniformBlock2748;
layout (set=0, binding=1) uniform sampler2D texSampler2750[3];
layout (set=0, binding=2, r32f) readonly uniform image2D image2753[5];
layout (set=0, binding=3) uniform sampler2D texSampler2751[4];
layout (set=0, binding=4) buffer StorageBuffer2755
{
    int data;
} storageBuffer2755[2];
layout (set=0, binding=5) buffer StorageBuffer2756
{
    int data;
} storageBuffer2756[3];
layout (set=0, binding=6) uniform sampler2D texSampler2752[3];
layout (set=1, binding=0) uniform InlineUniformBlock2749
{
    int data[4];
} inlineUniformBlock2749;
layout (set=1, binding=1, r32f) readonly uniform image2D image2754[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (inlineUniformBlock2748.data[0] != 2748) result = 0;
if (inlineUniformBlock2748.data[1] != 2749) result = 0;
if (inlineUniformBlock2748.data[2] != 2750) result = 0;
if (inlineUniformBlock2748.data[3] != 2751) result = 0;
if (texture(texSampler2750[0], vec2(0)).x != 2750) result = 0;
if (texture(texSampler2750[1], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2750[2], vec2(0)).x != 2752) result = 0;
if (imageLoad(image2753[0], ivec2(0)).x != 2753) result = 0;
if (imageLoad(image2753[1], ivec2(0)).x != 2754) result = 0;
if (imageLoad(image2753[2], ivec2(0)).x != 2755) result = 0;
if (imageLoad(image2753[3], ivec2(0)).x != 2756) result = 0;
if (imageLoad(image2753[4], ivec2(0)).x != 2757) result = 0;
if (texture(texSampler2751[0], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2751[1], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2751[2], vec2(0)).x != 2751) result = 0;
if (texture(texSampler2751[3], vec2(0)).x != 2752) result = 0;
if (storageBuffer2755[0].data != 2757) result = 0;
if (storageBuffer2755[1].data != 2758) result = 0;
if (storageBuffer2756[0].data != 2756) result = 0;
if (storageBuffer2756[1].data != 2757) result = 0;
if (storageBuffer2756[2].data != 2758) result = 0;
if (texture(texSampler2752[0], vec2(0)).x != 2752) result = 0;
if (texture(texSampler2752[1], vec2(0)).x != 2753) result = 0;
if (texture(texSampler2752[2], vec2(0)).x != 2754) result = 0;
if (inlineUniformBlock2749.data[0] != 2749) result = 0;
if (inlineUniformBlock2749.data[1] != 2750) result = 0;
if (inlineUniformBlock2749.data[2] != 2751) result = 0;
if (inlineUniformBlock2749.data[3] != 2752) result = 0;
if (imageLoad(image2754[0], ivec2(0)).x != 2755) result = 0;
if (imageLoad(image2754[1], ivec2(0)).x != 2756) result = 0;
if (imageLoad(image2754[2], ivec2(0)).x != 2757) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) uniform sampler sampler2749;
layout (set=0, binding=2) uniform texture2D sampledImage2750;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749), vec2(-1)).x != 0) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748[3];
layout (set=0, binding=1) uniform sampler sampler2749;
layout (set=0, binding=2) uniform sampler sampler2750[3];
layout (set=0, binding=3) uniform texture2D sampledImage2751;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2751, sampler2748[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2748[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2748[2]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2751, sampler2750[2]), vec2(-1)).x != 0) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748[2];
layout (set=0, binding=1) uniform texture2D sampledImage2750;
layout (set=1, binding=0) uniform sampler sampler2749[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2750, sampler2748[0]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2748[1]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[0]), vec2(-1)).x != 1) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[1]), vec2(-1)).x != 0) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2749[2]), vec2(-1)).x != 1) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform texture2D sampledImage2749;
layout (set=0, binding=1) uniform texture2D sampledImage2750;
layout (set=0, binding=2) uniform sampler sampler2748;
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2749, sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2750, sampler2748), vec2(0)).x != 2749) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 430

layout (set=0, binding=0) uniform sampler sampler2748;
layout (set=0, binding=1) uniform texture2D sampledImage2749[3];
layout (set=0, binding=2) uniform texture2D sampledImage2750[3];
layout (location = 0) out vec4 outColor;

void main()
{
int result = 1;
if (texture(sampler2D(sampledImage2749[0], sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2749[1], sampler2748), vec2(0)).x != 2750) result = 0;
if (texture(sampler2D(sampledImage2749[2], sampler2748), vec2(0)).x != 2751) result = 0;
if (texture(sampler2D(sampledImage2750[0], sampler2748), vec2(0)).x != 2749) result = 0;
if (texture(sampler2D(sampledImage2750[1], sampler2748), vec2(0)).x != 2750) result = 0;
if (texture(sampler2D(sampledImage2750[2], sampler2748), vec2(0)).x != 2751) result = 0;
if (result == 1) outColor = vec4(0, 1, 0, 1);
else outColor = vec4(1, 0, 1, 0);
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out flat int quadrant;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    quadrant = 0;
}
#version 460
layout (location=0) in flat int quadrant;
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D inSampler0;
layout (set=0, binding=1) readonly buffer BufferBlock { float red; } inBuffer;
void main(void) {
    vec4 sampledColor = vec4(0.0);
    sampledColor = texture(inSampler0, vec2(0.0));
    sampledColor.r = inBuffer.red;
    outColor = sampledColor;
}
#version 460
layout (location=0) in flat int quadrant;
layout (location=0) out vec4 outColor;
layout (set=0, binding=1) uniform sampler2D inSampler0;
layout (set=0, binding=0) readonly buffer BufferBlock { float red; } inBuffer;
void main(void) {
    vec4 sampledColor = vec4(0.0);
    sampledColor = texture(inSampler0, vec2(0.0));
    sampledColor.r = inBuffer.red;
    outColor = sampledColor;
}
#version 460
layout (location=0) in vec4 inPos;
layout (location=0) out flat int quadrant;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
    if (inPos.x < 0.0) {
        if (inPos.y < 0.0) {
            quadrant = 0;
        } else {
            quadrant = 1;
        }
    } else {
        if (inPos.y < 0.0) {
            quadrant = 2;
        } else {
            quadrant = 3;
        }
    }
}
#version 460
layout (location=0) in flat int quadrant;
layout (location=0) out vec4 outColor;
layout (set=0, binding=0) uniform sampler2D inSampler0;
layout (set=0, binding=1) uniform sampler2D inSampler1;
layout (set=0, binding=2) uniform sampler2D inSampler2;
layout (set=0, binding=3) uniform sampler2D inSampler3;
layout (set=0, binding=4) readonly buffer BufferBlock { float red; } inBuffer;
void main(void) {
    vec4 sampledColor = vec4(0.0);
    if (quadrant == 0) {
        sampledColor = texture(inSampler0, vec2(0.0));
    } else if (quadrant == 1) {
        sampledColor = texture(inSampler1, vec2(0.0));
    } else if (quadrant == 2) {
        sampledColor = texture(inSampler2, vec2(0.0));
    } else if (quadrant == 3) {
        sampledColor = texture(inSampler3, vec2(0.0));
    }
    sampledColor.r = inBuffer.red;
    outColor = sampledColor;
}
#version 460
layout (location=0) in flat int quadrant;
layout (location=0) out vec4 outColor;
layout (set=0, binding=1) uniform sampler2D inSampler0;
layout (set=0, binding=2) uniform sampler2D inSampler1;
layout (set=0, binding=3) uniform sampler2D inSampler2;
layout (set=0, binding=4) uniform sampler2D inSampler3;
layout (set=0, binding=0) readonly buffer BufferBlock { float red; } inBuffer;
void main(void) {
    vec4 sampledColor = vec4(0.0);
    if (quadrant == 0) {
        sampledColor = texture(inSampler0, vec2(0.0));
    } else if (quadrant == 1) {
        sampledColor = texture(inSampler1, vec2(0.0));
    } else if (quadrant == 2) {
        sampledColor = texture(inSampler2, vec2(0.0));
    } else if (quadrant == 3) {
        sampledColor = texture(inSampler3, vec2(0.0));
    }
    sampledColor.r = inBuffer.red;
    outColor = sampledColor;
}
