#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
vec2 positions[3] = vec2[](
    vec2(-1.0, -1.0),
    vec2( 3.0, -1.0),
    vec2(-1.0,  3.0)
);
void main (void) {
    gl_Position = vec4(positions[gl_VertexIndex % 3], 0.0, 1.0);
    gl_PointSize = 1.0;
}
#version 460
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform sampler2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rg8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r16) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba8) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform usampler2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            uvec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32ui) uniform uimage2D res;
layout (set=0, binding=1) buffer OutBlock { uvec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    uvec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = texelFetch(res, ivec2(col, row), 0);
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0) uniform isampler2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = texelFetch(res, ivec2(col, row), 0);
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            ivec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32i) uniform iimage2D res;
layout (set=0, binding=1) buffer OutBlock { ivec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ivec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, r32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 1;
    const uint height = 1;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 4;
    const uint height = 4;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 53;
    const uint height = 92;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (local_size_x=64, local_size_y=1, local_size_z=1) in;
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    // One row per WG.
    const uint width = 512;
    const uint height = 512;
    const uint wgSize = gl_WorkGroupSize.x;
    const uint pixelsPerInv = (width + (wgSize - 1u)) / wgSize;
    for (uint i = 0; i < pixelsPerInv; ++i) {
        const uint col = i * wgSize + gl_LocalInvocationIndex;
        const uint row = gl_WorkGroupID.x;
        if (col < width && row < height) {
            vec4 color = imageLoad(res, ivec2(col, row));
            const uint outIndex = row * width + col;
            ssbo.pixels[outIndex] = color;
        }
    }
}
#version 460
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 1;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 4;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 53;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (set=0, binding=0, rgba32f) uniform image2D res;
layout (set=0, binding=1) buffer OutBlock { vec4 pixels[]; } ssbo;
void main(void) {
    const uint width = 512;
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    vec4 color = imageLoad(res, ivec2(col, row));
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
