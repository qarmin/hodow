#version 430
layout(std430, binding = 0) buffer BufferPos {
vec4 p[100];
} pos;
out gl_PerVertex{
vec4 gl_Position;
};
void main() {
gl_Position = pos.p[gl_VertexIndex];
}
#version 430
layout(location = 0) out vec4 my_FragColor;
layout (push_constant) uniform AreaSelect {
    ivec4 number;
} Area;
void main() {
    if((gl_FragCoord.y < 64) && (Area.number.x != 0)) discard;
    if((gl_FragCoord.y >= 64) && (gl_FragCoord.y < 128) && (Area.number.x != 1)) discard;
    if((gl_FragCoord.y >= 128) && (gl_FragCoord.y < 192) && (Area.number.x != 2)) discard;
    if((gl_FragCoord.y >= 192) && (Area.number.x != 3)) discard;
    my_FragColor = vec4(0,1,0,1);
}
#version 430
layout(std430, binding = 0) buffer Predicate {
uint p;
} predicate;
out gl_PerVertex{
vec4 gl_Position;
};
void main() {
atomicMin(predicate.p, 0);
gl_Position = vec4(1.0);
}
#version 430
layout(location = 0) out vec4 my_FragColor;
void main() {
    discard;
}
#version 430
layout(location = 0) out vec4 my_FragColor;
void main() {
    my_FragColor = vec4(0,1,0,1);
}
#version 430
layout(std430, binding = 0) buffer Predicate {
uint p;
} predicate;
out gl_PerVertex{
vec4 gl_Position;
};
void main() {
atomicMax(predicate.p, 1);
gl_Position = vec4(1.0);
}
