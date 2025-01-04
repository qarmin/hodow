#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 vtxColor;
layout(location = 0) out highp vec4 fragColor;

void main (void)
{
    fragColor = vtxColor;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) uniform Block1
{
    vec4 color;
} inputData1;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) uniform Block2
{
    vec4 color;
} inputData2;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
    vtxColor.rgb += inputData2.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) readonly buffer Block1
{
    vec4 color;
} inputData1;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) readonly buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) readonly buffer Block2
{
    vec4 color;
} inputData2;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
    vtxColor.rgb += inputData2.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputData1;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) uniform Block2
{
    vec4 color;
} inputData2;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
    vtxColor.rgb += inputData2.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) readonly buffer Block1
{
    vec4 color;
} inputData1;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) readonly buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) readonly buffer Block2
{
    vec4 color;
} inputData2;

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputData0.color.rgb;
    vtxColor.rgb += inputData1.color.rgb;
    vtxColor.rgb += inputData2.color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputDataNonDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[2];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataDyn[1].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) uniform Block2
{
    vec4 color;
} inputDataNonDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataDyn[1].color.rgb;
    vtxColor.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputDataDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) readonly buffer Block1
{
    vec4 color;
} inputDataNonDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputDataDyn[2];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataDyn[1].color.rgb;
}
#version 450
layout(location = 0) in highp vec4 position;
layout(location = 1) in highp vec4 color;
layout(location = 0) out highp vec4 vtxColor;
layout(set = 0, binding = 0) readonly buffer Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) readonly buffer Block2
{
    vec4 color;
} inputDataNonDyn[1];

out gl_PerVertex { vec4 gl_Position; };

void main()
{
    gl_Position = position;
    vtxColor = vec4(0, 0, 0, 1);
    vtxColor.rgb += inputDataDyn[0].color.rgb;
    vtxColor.rgb += inputDataDyn[1].color.rgb;
    vtxColor.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) uniform Block2
{
    vec4 color;
} inputData2;
layout(set = 0, binding = 3) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
    outData.color.rgb += inputData2.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 0, binding = 1) buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 0, binding = 2) buffer Block2
{
    vec4 color;
} inputData2;
layout(set = 0, binding = 3) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
    outData.color.rgb += inputData2.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) uniform Block2
{
    vec4 color;
} inputData2;
layout(set = 3, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
    outData.color.rgb += inputData2.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputData0;
layout(set = 1, binding = 0) buffer Block1
{
    vec4 color;
} inputData1;
layout(set = 2, binding = 0) buffer Block2
{
    vec4 color;
} inputData2;
layout(set = 3, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputData0.color.rgb;
    outData.color.rgb += inputData1.color.rgb;
    outData.color.rgb += inputData2.color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) uniform Block1
{
    vec4 color;
} inputDataNonDyn[1];
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataDyn[1].color.rgb;
}
#version 450
layout(set = 0, binding = 0) uniform Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) uniform Block2
{
    vec4 color;
} inputDataNonDyn[1];
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataDyn[1].color.rgb;
    outData.color.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputDataDyn[1];
layout(set = 1, binding = 0) buffer Block1
{
    vec4 color;
} inputDataNonDyn[1];
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataDyn[1].color.rgb;
}
#version 450
layout(set = 0, binding = 0) buffer Block0
{
    vec4 color;
} inputDataDyn[2];
layout(set = 1, binding = 0) buffer Block2
{
    vec4 color;
} inputDataNonDyn[1];
layout(set = 2, binding = 0) writeonly buffer Output
{
    vec4 color;
} outData;

void main()
{
    outData.color = vec4(0, 0, 0, 1);
    outData.color.rgb += inputDataDyn[0].color.rgb;
    outData.color.rgb += inputDataDyn[1].color.rgb;
    outData.color.rgb += inputDataNonDyn[0].color.rgb;
}
#version 450

layout(set = 0, binding = 0) uniform uboVertexData
{
    vec4 position;
} inputPosData;

layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec4 inColor;
layout(location = 0) out vec4 outColor;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = inPosition + inputPosData.position;
    outColor = inColor;
}
#version 450

layout(set = 0, binding = 1) uniform uboSharedData
{
    vec4 color;
} inputData0;

layout(set = 0, binding = 3) uniform uboFragOnly
{
    mat4 color;
} inputData1;

layout(location = 0) in vec4 inColor;
layout(location = 0) out vec4 outColor;

void main (void)
{
    outColor = inColor + inputData0.color;
    outColor.b = inputData1.color[3][3];
}
#version 450

layout(set = 0, binding = 1) uniform uboSharedData
{
    vec4 color;
} inputData;

layout(set = 0, binding = 2) writeonly buffer ssboOutput
{
    vec4 color;
} outData;

layout(set = 0, binding = 4) readonly buffer ssboInput
{
    mat4 color;
} readData;

void main (void)
{
    outData.color = inputData.color;
    outData.color.g = readData.color[3][1];
    outData.color.b = readData.color[3][2];
}
#version 450

layout(set = 0, binding = 4) uniform uboVertexData
{
    vec4 position;
} inputPosData;

layout(location = 0) in vec4 inPosition;
layout(location = 1) in vec4 inColor;
layout(location = 0) out vec4 outColor;

out gl_PerVertex
{
    vec4 gl_Position;
};

void main (void)
{
    gl_Position = inPosition + inputPosData.position;
    outColor = inColor;
}
#version 450

layout(set = 0, binding = 3) uniform uboSharedData
{
    vec4 color;
} inputData0;

layout(set = 0, binding = 1) uniform uboFragOnly
{
    mat4 color;
} inputData1;

layout(location = 0) in vec4 inColor;
layout(location = 0) out vec4 outColor;

void main (void)
{
    outColor = inColor + inputData0.color;
    outColor.b = inputData1.color[3][3];
}
#version 450

layout(set = 0, binding = 3) uniform uboSharedData
{
    vec4 color;
} inputData;

layout(set = 0, binding = 2) writeonly buffer ssboOutput
{
    vec4 color;
} outData;

layout(set = 0, binding = 0) readonly buffer ssboInput
{
    mat4 color;
} readData;

void main (void)
{
    outData.color = inputData.color;
    outData.color.g = readData.color[3][1];
    outData.color.b = readData.color[3][2];
}
