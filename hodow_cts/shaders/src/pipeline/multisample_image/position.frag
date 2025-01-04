#version 450

layout(location = 0) out uint o_status;

layout(set = 0, binding = 0) uniform sampler2DMS colorTexture;

void main(void)
{
    uint result = 0;
    vec4 a, b;

#if ${samples} > 0
    a = texelFetch(colorTexture, ivec2(0,0), 0);
    b = vec4(0, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 1
    a = texelFetch(colorTexture, ivec2(0,0), 1);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 2
    a = texelFetch(colorTexture, ivec2(0,0), 2);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 3
    a = texelFetch(colorTexture, ivec2(0,0), 3);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 4
    a = texelFetch(colorTexture, ivec2(0,0), 4);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 5
    a = texelFetch(colorTexture, ivec2(0,0), 5);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 6
    a = texelFetch(colorTexture, ivec2(0,0), 6);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 7
    a = texelFetch(colorTexture, ivec2(0,0), 7);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 8
    a = texelFetch(colorTexture, ivec2(0,0), 8);
    b = vec4(0.5, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 9
    a = texelFetch(colorTexture, ivec2(0,0), 9);
    b = vec4(1, 0, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 10
    a = texelFetch(colorTexture, ivec2(0,0), 10);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 11
    a = texelFetch(colorTexture, ivec2(0,0), 11);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 12
    a = texelFetch(colorTexture, ivec2(0,0), 12);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 13
    a = texelFetch(colorTexture, ivec2(0,0), 13);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 14
    a = texelFetch(colorTexture, ivec2(0,0), 14);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 15
    a = texelFetch(colorTexture, ivec2(0,0), 15);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 16
    a = texelFetch(colorTexture, ivec2(0,0), 16);
    b = vec4(0, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 17
    a = texelFetch(colorTexture, ivec2(0,0), 17);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 18
    a = texelFetch(colorTexture, ivec2(0,0), 18);
    b = vec4(0, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 19
    a = texelFetch(colorTexture, ivec2(0,0), 19);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 20
    a = texelFetch(colorTexture, ivec2(0,0), 20);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 21
    a = texelFetch(colorTexture, ivec2(0,0), 21);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 22
    a = texelFetch(colorTexture, ivec2(0,0), 22);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 23
    a = texelFetch(colorTexture, ivec2(0,0), 23);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 24
    a = texelFetch(colorTexture, ivec2(0,0), 24);
    b = vec4(0.5, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 25
    a = texelFetch(colorTexture, ivec2(0,0), 25);
    b = vec4(1, 0.5, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 26
    a = texelFetch(colorTexture, ivec2(0,0), 26);
    b = vec4(0.5, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 27
    a = texelFetch(colorTexture, ivec2(0,0), 27);
    b = vec4(1, 1, 0, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 28
    a = texelFetch(colorTexture, ivec2(0,0), 28);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 29
    a = texelFetch(colorTexture, ivec2(0,0), 29);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 30
    a = texelFetch(colorTexture, ivec2(0,0), 30);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 31
    a = texelFetch(colorTexture, ivec2(0,0), 31);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 32
    a = texelFetch(colorTexture, ivec2(0,0), 32);
    b = vec4(0, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 33
    a = texelFetch(colorTexture, ivec2(0,0), 33);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 34
    a = texelFetch(colorTexture, ivec2(0,0), 34);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 35
    a = texelFetch(colorTexture, ivec2(0,0), 35);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 36
    a = texelFetch(colorTexture, ivec2(0,0), 36);
    b = vec4(0, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 37
    a = texelFetch(colorTexture, ivec2(0,0), 37);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 38
    a = texelFetch(colorTexture, ivec2(0,0), 38);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 39
    a = texelFetch(colorTexture, ivec2(0,0), 39);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 40
    a = texelFetch(colorTexture, ivec2(0,0), 40);
    b = vec4(0.5, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 41
    a = texelFetch(colorTexture, ivec2(0,0), 41);
    b = vec4(1, 0, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 42
    a = texelFetch(colorTexture, ivec2(0,0), 42);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 43
    a = texelFetch(colorTexture, ivec2(0,0), 43);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 44
    a = texelFetch(colorTexture, ivec2(0,0), 44);
    b = vec4(0.5, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 45
    a = texelFetch(colorTexture, ivec2(0,0), 45);
    b = vec4(1, 0, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 46
    a = texelFetch(colorTexture, ivec2(0,0), 46);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 47
    a = texelFetch(colorTexture, ivec2(0,0), 47);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 48
    a = texelFetch(colorTexture, ivec2(0,0), 48);
    b = vec4(0, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 49
    a = texelFetch(colorTexture, ivec2(0,0), 49);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 50
    a = texelFetch(colorTexture, ivec2(0,0), 50);
    b = vec4(0, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 51
    a = texelFetch(colorTexture, ivec2(0,0), 51);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 52
    a = texelFetch(colorTexture, ivec2(0,0), 52);
    b = vec4(0, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 53
    a = texelFetch(colorTexture, ivec2(0,0), 53);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 54
    a = texelFetch(colorTexture, ivec2(0,0), 54);
    b = vec4(0, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 55
    a = texelFetch(colorTexture, ivec2(0,0), 55);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 56
    a = texelFetch(colorTexture, ivec2(0,0), 56);
    b = vec4(0.5, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 57
    a = texelFetch(colorTexture, ivec2(0,0), 57);
    b = vec4(1, 0.5, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 58
    a = texelFetch(colorTexture, ivec2(0,0), 58);
    b = vec4(0.5, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 59
    a = texelFetch(colorTexture, ivec2(0,0), 59);
    b = vec4(1, 1, 0.5, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 60
    a = texelFetch(colorTexture, ivec2(0,0), 60);
    b = vec4(0.5, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 61
    a = texelFetch(colorTexture, ivec2(0,0), 61);
    b = vec4(1, 0.5, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 62
    a = texelFetch(colorTexture, ivec2(0,0), 62);
    b = vec4(0.5, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif
#if ${samples} > 63
    a = texelFetch(colorTexture, ivec2(0,0), 63);
    b = vec4(1, 1, 1, 1.0);
    if (abs(a.x - b.x) > 0.1 || abs(a.y - b.y) > 0.1 || abs(a.z - b.z) > 0.1) result++;
#endif

    o_status = result;
}
