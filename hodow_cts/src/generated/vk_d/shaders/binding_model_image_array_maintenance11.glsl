#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 0)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 1)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 2)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 0)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 1)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 2)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 0)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 1)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(textureSize(img, 2)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image1D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage1D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage1D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uint(imageSize(img)), 1, 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const int coords = int(invCol);
        const float normCoords = ((float(coords) + float(0.5)) / float(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image1DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage1DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(4096, 1, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, 0);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 0)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 1)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(textureSize(img, 2)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage2D img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage2D img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec2(imageSize(img)), 1);
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec2 coords = ivec2(invCol, invRow);
        const vec2 normCoords = ((vec2(coords) + vec2(0.5)) / vec2(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 0)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 1)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 2)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 0)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 1)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 2)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 0)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 0);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 1)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 1);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(textureSize(img, 2)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = textureLod(img, normCoords, 2);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba16i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2DArray img;
layout (set=0, binding=1) buffer BufferBlock { vec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32ui) uniform uimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { uvec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        ssbo.values[globalInvocationIndex] = imageLoad(img, coords);
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32i) uniform iimage2DArray img;
layout (set=0, binding=1) buffer BufferBlock { ivec4 values[]; } ssbo;
void main (void) {
    const uvec3 imageSize = uvec3(uvec3(imageSize(img)));
    const bool sizeOK = (imageSize == uvec3(64, 64, 1));
    const uint pixelCount = imageSize.x * imageSize.y;
    const uint globalInvocationIndex = gl_WorkGroupID.x * gl_WorkGroupSize.x + gl_LocalInvocationIndex;
    if (sizeOK && globalInvocationIndex < pixelCount) {
        const uint invRow = globalInvocationIndex / imageSize.x;
        const uint invCol = globalInvocationIndex % imageSize.x;
        const ivec3 coords = ivec3(invCol, invRow, 0);
        const vec3 normCoords = ((vec3(coords) + vec3(0.5)) / vec3(imageSize));
        imageStore(img, coords, ssbo.values[globalInvocationIndex]);
    }
}
