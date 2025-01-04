#version 430
layout(location = 0) in vec4 in_Position;
out gl_PerVertex { vec4 gl_Position; float gl_PointSize; };
void main() {
    gl_Position  = in_Position;
    gl_PointSize = 1.0;
}
#version 400
layout(location = 0) out vec4 out_FragColor;
void main()
{
    out_FragColor = vec4(0.07, 0.48, 0.75, 1.0);
    if ((int(gl_FragCoord.x) % 2) == (int(gl_FragCoord.y) % 2))
        discard;
}
