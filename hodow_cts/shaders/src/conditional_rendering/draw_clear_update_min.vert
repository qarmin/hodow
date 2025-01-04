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
