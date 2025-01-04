#version 450
out gl_PerVertex {
	vec4 gl_Position;
};
highp float;
void main (void) {
	gl_Position = vec4(((gl_VertexIndex + 2) / 3) % 2 == 0 ? -1.0 : 1.0,
	                   ((gl_VertexIndex + 1) / 3) % 2 == 0 ? -1.0 : 1.0, 0.0, 1.0);
}
#version 450
highp float;

layout(triangles) in;
layout(triangle_strip, max_vertices = 18) out;

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
};

void main (void) {
    for (int layerNdx = 0; layerNdx < 3; ++layerNdx) {
        for(int vertexNdx = 0; vertexNdx < gl_in.length(); vertexNdx++) {
            gl_Position = gl_in[vertexNdx].gl_Position;
            gl_Layer    = layerNdx;
            EmitVertex();
        };
        EndPrimitive();
    };
}
#version 450
precision highp float;
precision highp int;
void main (void)
{
  float sampleIndex = float(gl_SampleID);
  float valueIndex = round(mod(sampleIndex, 4.0));
  float value = valueIndex + 2.0;
  value = round(exp2(value));
  bool condition = (int(value) == 8);
  value = round(value - float(condition) * 6.0);
  gl_FragDepth = value / 100.0;
}
#version 450
precision highp float;
precision highp int;
layout(push_constant) uniform PushConstant {
  highp int sampleID;
} pushConstants;
void main (void)
{
  if(gl_SampleID != pushConstants.sampleID)
    discard;
  gl_FragDepth = 0.5;
}
#version 450
precision highp float;
precision highp int;
void main (void)
{
  gl_FragDepth = 0.5;
}
#version 450
void main (void)
{
  const float x = (-1.0+2.0*((gl_VertexIndex & 2)>>1));
  const float y = ( 1.0-2.0* (gl_VertexIndex % 2));
  gl_Position = vec4(x, y, 0.6, 1.0);
}
#version 450
void main (void)
{
}
