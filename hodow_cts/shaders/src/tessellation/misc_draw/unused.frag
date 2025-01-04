#version 460
layout (location=0, component=0) in  float fsA;
layout (location=0, component=1) in  float fsB;
layout (location=0, component=2) in  vec2  fsCD;
layout (location=1)              in  vec4  fsEFGH;
layout (location=0) out vec4 outColor;
void main() {
    const float eps = 0.01;
    bool ok = abs(fsA - 0.125) < eps
           && abs(fsB - 0.375) < eps
           && abs(fsCD.x - 0.625) < eps && abs(fsCD.y - 0.875) < eps
           && abs(fsEFGH.x - 0.1) < eps && abs(fsEFGH.y - 0.2) < eps
           && abs(fsEFGH.z - 0.3) < eps && abs(fsEFGH.w - 0.4) < eps;
    outColor = ok ? vec4(0.0, 1.0, 0.0, 1.0) : vec4(1.0, 0.0, 0.0, 1.0);
}
