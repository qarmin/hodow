#version 430

vec4 positions[3] = vec4[](
    vec4(0.5f, 0.5f, 1.0f, 1.0f),
    vec4(-0.3f, 0.3f, 1.0f, 1.0f),
    vec4(-1.0f, 1.0f, 1.0f, 1.0f)
);

vec4 colors[3] = vec4[](
    vec4(0.0f, 0.0f, 1.0f, 1.0f), // blue
    vec4(0.0f, 1.0f, 0.0f, 1.0f), // green
    vec4(0.0f, 0.0f, 0.0f, 1.0f)  // black
);

layout(location = 0) out vec4 out_color;

out gl_PerVertex {
    vec4 gl_Position;
	float gl_PointSize;
};

void main() {
	gl_Position = positions[gl_VertexIndex];
	gl_PointSize = 1.0f;
	out_color = colors[gl_VertexIndex];
}#version 430

layout(location = 0) in vec4 in_color;
layout(location = 0) out vec4 out_color;
layout (set=0, binding=0, std430) buffer StorageBlock
{
  uint counter;
} ssbo;

void main()
{
  out_color = in_color;
  atomicAdd(ssbo.counter, 1);
}#version 460
layout (location=0) in vec4 inPos;
void main(void) {
    gl_Position = inPos;
    gl_PointSize = 1.0;
}
#version 460
layout (location=0) out vec4 outColor;
void main(void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
}
