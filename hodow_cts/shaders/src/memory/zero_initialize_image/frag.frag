#version 460
${descriptors}void main(void) {
    const uint width = ${width};
    const uint col = uint(gl_FragCoord.x);
    const uint row = uint(gl_FragCoord.y);
    ${pixel_type} color = ${read_op}(res, ivec2(col, row)${lod_arg});
    const uint outIndex = row * width + col;
    ssbo.pixels[outIndex] = color;
}
