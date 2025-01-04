#version 450
layout(location = 0) in highp vec4 a_position;
out gl_PerVertex {
    vec4 gl_Position;
};
void main (void)
{
    gl_Position = a_position;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdx(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdx(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdx(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdxFine(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdxFine(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdxFine(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdxCoarse(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdxCoarse(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdxCoarse(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdy(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdy(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdy(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdyFine(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdyFine(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdyFine(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = dFdyCoarse(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = dFdyCoarse(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = dFdyCoarse(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = fwidth(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = fwidth(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = fwidth(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = fwidthFine(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = fwidthFine(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = fwidthFine(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec2 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec2 u_bias; }; 
void main (void)
{
    highp vec2 res = fwidthCoarse(vec2(-0.0, 2.7)) * u_scale + u_bias;
    o_color = vec4(res, 0.0, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec3 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec3 u_bias; }; 
void main (void)
{
    highp vec3 res = fwidthCoarse(vec3(1e2, 8.0, 0.01)) * u_scale + u_bias;
    o_color = vec4(res, 1.0);
}
#version 450
layout(location = 0) out mediump vec4 o_color;
layout(binding = 0, std140) uniform Scale { highp vec4 u_scale; };
layout(binding = 1, std140) uniform Bias { highp vec4 u_bias; }; 
void main (void)
{
    highp vec4 res = fwidthCoarse(vec4(1.0, 7.2, -1e5, 0.0)) * u_scale + u_bias;
    o_color = res;
}
