#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 0) out vec2 var0;

void main()
{
    vec2 in0 = vec2(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec2 var0;
layout(location = 0) out vec2 dEQP_FragColor;

void main()
{
    vec2 out0 = var0;
    out0 /= vec2(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 1, component = 3) in float in0_3;
layout(location = 0) out vec2 var0;

void main()
{
    vec2 in0 = vec2(in0_0, in0_1);
    var0 = in0_3 * in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 1, component = 2) in float in0_2;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec3 var0;
layout(location = 0) out vec3 dEQP_FragColor;

void main()
{
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 1, component = 2) in float in0_2;
layout(location = 1, component = 3) in float in0_3;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1, in0_2);
    var0 = in0_3 * in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in vec2 in0_1;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in vec2 in0_1;
layout(location = 1, component = 3) in float in0_3;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1);
    var0 = in0_3 * in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in vec2 in0_0;
layout(location = 1, component = 2) in float in0_1;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in vec2 in0_0;
layout(location = 1, component = 2) in float in0_1;
layout(location = 1, component = 3) in float in0_3;
layout(location = 0) out vec3 var0;

void main()
{
    vec3 in0 = vec3(in0_0, in0_1);
    var0 = in0_3 * in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 1, component = 2) in float in0_2;
layout(location = 1, component = 3) in float in0_3;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1, in0_2, in0_3);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in float in0_1;
layout(location = 1, component = 2) in vec2 in0_2;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in vec2 in0_1;
layout(location = 1, component = 3) in float in0_2;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in float in0_0;
layout(location = 1, component = 1) in vec3 in0_1;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in vec2 in0_0;
layout(location = 1, component = 2) in float in0_1;
layout(location = 1, component = 3) in float in0_2;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in vec2 in0_0;
layout(location = 1, component = 2) in vec2 in0_1;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in vec3 in0_0;
layout(location = 1, component = 3) in float in0_1;
layout(location = 0) out vec4 var0;

void main()
{
    vec4 in0 = vec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in int in0_1;
layout(location = 0) out ivec2 var0;

void main()
{
    ivec2 in0 = ivec2(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec2 var0;
layout(location = 0) out ivec2 dEQP_FragColor;

void main()
{
    ivec2 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in int in0_1;
layout(location = 1, component = 3) in int in0_3;
layout(location = 0) out ivec2 var0;

void main()
{
    ivec2 in0 = ivec2(in0_0, in0_1);
    var0 = in0_3 * in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in int in0_1;
layout(location = 1, component = 2) in int in0_2;
layout(location = 1, component = 3) in int in0_3;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1, in0_2, in0_3);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in int in0_1;
layout(location = 1, component = 2) in ivec2 in0_2;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in ivec2 in0_1;
layout(location = 1, component = 3) in int in0_2;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in int in0_0;
layout(location = 1, component = 1) in ivec3 in0_1;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in ivec2 in0_0;
layout(location = 1, component = 2) in int in0_1;
layout(location = 1, component = 3) in int in0_2;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1, in0_2);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in ivec2 in0_0;
layout(location = 1, component = 2) in ivec2 in0_1;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1, component = 0) in ivec3 in0_0;
layout(location = 1, component = 3) in int in0_1;
layout(location = 0) out ivec4 var0;

void main()
{
    ivec4 in0 = ivec4(in0_0, in0_1);
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out float var0_1;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in float var0_1;
layout(location = 0) out vec2 dEQP_FragColor;

void main()
{
    vec2 var0 = vec2(var0_0, var0_1);
    vec2 out0 = var0;
    out0 /= vec2(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out float var0_1;
layout(location = 0, component = 2) out float var0_2;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    var0_2 = in0.z + in0.z;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in float var0_1;
layout(location = 0, component = 2) in float var0_2;
layout(location = 0) out vec3 dEQP_FragColor;

void main()
{
    vec3 var0 = vec3(var0_0, var0_1, var0_2);
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out vec2 var0_1;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.yz + in0.yz;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in vec2 var0_1;
layout(location = 0) out vec3 dEQP_FragColor;

void main()
{
    vec3 var0 = vec3(var0_0, var0_1);
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0, component = 0) out vec2 var0_0;
layout(location = 0, component = 2) out float var0_1;

void main()
{
    var0_0 = in0.xy + in0.xy;
    var0_1 = in0.z + in0.z;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in vec2 var0_0;
layout(location = 0, component = 2) in float var0_1;
layout(location = 0) out vec3 dEQP_FragColor;

void main()
{
    vec3 var0 = vec3(var0_0, var0_1);
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out float var0_1;
layout(location = 0, component = 2) out float var0_2;
layout(location = 0, component = 3) out float var0_3;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    var0_2 = in0.z + in0.z;
    var0_3 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in float var0_1;
layout(location = 0, component = 2) in float var0_2;
layout(location = 0, component = 3) in float var0_3;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1, var0_2, var0_3);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out float var0_1;
layout(location = 0, component = 2) out vec2 var0_2;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    var0_2 = in0.zw + in0.zw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in float var0_1;
layout(location = 0, component = 2) in vec2 var0_2;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1, var0_2);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out vec2 var0_1;
layout(location = 0, component = 3) out float var0_2;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.yz + in0.yz;
    var0_2 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in vec2 var0_1;
layout(location = 0, component = 3) in float var0_2;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1, var0_2);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out float var0_0;
layout(location = 0, component = 1) out vec3 var0_1;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.yzw + in0.yzw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in float var0_0;
layout(location = 0, component = 1) in vec3 var0_1;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out vec2 var0_0;
layout(location = 0, component = 2) out float var0_1;
layout(location = 0, component = 3) out float var0_2;

void main()
{
    var0_0 = in0.xy + in0.xy;
    var0_1 = in0.z + in0.z;
    var0_2 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in vec2 var0_0;
layout(location = 0, component = 2) in float var0_1;
layout(location = 0, component = 3) in float var0_2;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1, var0_2);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out vec2 var0_0;
layout(location = 0, component = 2) out vec2 var0_1;

void main()
{
    var0_0 = in0.xy + in0.xy;
    var0_1 = in0.zw + in0.zw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in vec2 var0_0;
layout(location = 0, component = 2) in vec2 var0_1;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0, component = 0) out vec3 var0_0;
layout(location = 0, component = 3) out float var0_1;

void main()
{
    var0_0 = in0.xyz + in0.xyz;
    var0_1 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) in vec3 var0_0;
layout(location = 0, component = 3) in float var0_1;
layout(location = 0) out vec4 dEQP_FragColor;

void main()
{
    vec4 var0 = vec4(var0_0, var0_1);
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0, component = 0) out int var0_0;
layout(location = 0, component = 1) out int var0_1;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in int var0_0;
layout(location = 0, component = 1) flat in int var0_1;
layout(location = 0) out ivec2 dEQP_FragColor;

void main()
{
    ivec2 var0 = ivec2(var0_0, var0_1);
    ivec2 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out int var0_0;
layout(location = 0, component = 1) out int var0_1;
layout(location = 0, component = 2) out int var0_2;
layout(location = 0, component = 3) out int var0_3;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    var0_2 = in0.z + in0.z;
    var0_3 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in int var0_0;
layout(location = 0, component = 1) flat in int var0_1;
layout(location = 0, component = 2) flat in int var0_2;
layout(location = 0, component = 3) flat in int var0_3;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1, var0_2, var0_3);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out int var0_0;
layout(location = 0, component = 1) out int var0_1;
layout(location = 0, component = 2) out ivec2 var0_2;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.y + in0.y;
    var0_2 = in0.zw + in0.zw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in int var0_0;
layout(location = 0, component = 1) flat in int var0_1;
layout(location = 0, component = 2) flat in ivec2 var0_2;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1, var0_2);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out int var0_0;
layout(location = 0, component = 1) out ivec2 var0_1;
layout(location = 0, component = 3) out int var0_2;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.yz + in0.yz;
    var0_2 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in int var0_0;
layout(location = 0, component = 1) flat in ivec2 var0_1;
layout(location = 0, component = 3) flat in int var0_2;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1, var0_2);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out int var0_0;
layout(location = 0, component = 1) out ivec3 var0_1;

void main()
{
    var0_0 = in0.x + in0.x;
    var0_1 = in0.yzw + in0.yzw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in int var0_0;
layout(location = 0, component = 1) flat in ivec3 var0_1;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out ivec2 var0_0;
layout(location = 0, component = 2) out int var0_1;
layout(location = 0, component = 3) out int var0_2;

void main()
{
    var0_0 = in0.xy + in0.xy;
    var0_1 = in0.z + in0.z;
    var0_2 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in ivec2 var0_0;
layout(location = 0, component = 2) flat in int var0_1;
layout(location = 0, component = 3) flat in int var0_2;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1, var0_2);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out ivec2 var0_0;
layout(location = 0, component = 2) out ivec2 var0_1;

void main()
{
    var0_0 = in0.xy + in0.xy;
    var0_1 = in0.zw + in0.zw;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in ivec2 var0_0;
layout(location = 0, component = 2) flat in ivec2 var0_1;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0, component = 0) out ivec3 var0_0;
layout(location = 0, component = 3) out int var0_1;

void main()
{
    var0_0 = in0.xyz + in0.xyz;
    var0_1 = in0.w + in0.w;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0, component = 0) flat in ivec3 var0_0;
layout(location = 0, component = 3) flat in int var0_1;
layout(location = 0) out ivec4 dEQP_FragColor;

void main()
{
    ivec4 var0 = ivec4(var0_0, var0_1);
    ivec4 out0 = var0;
    dEQP_FragColor = out0;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec2 in0;
layout(location = 0) out vec2 var0;

void main()
{
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec2 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out float dEQP_FragColor_1;

void main()
{
    vec2 out0 = var0;
    out0 /= vec2(255.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec3 in0;
layout(location = 0) out vec3 var0;

void main()
{
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec3 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out float dEQP_FragColor_1;
layout(location = 0, component = 2) out float dEQP_FragColor_2;

void main()
{
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
    dEQP_FragColor_2 = out0.z;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec3 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out vec2 dEQP_FragColor_1;

void main()
{
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.yz;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec3 var0;
layout(location = 0, component = 0) out vec2 dEQP_FragColor_0;
layout(location = 0, component = 2) out float dEQP_FragColor_1;

void main()
{
    vec3 out0 = var0;
    out0 /= vec3(31.0, 63.0, 31.0);
    dEQP_FragColor_0 = out0.xy;
    dEQP_FragColor_1 = out0.z;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) out vec4 var0;
layout(location = 1) out vec4 var1;

void main()
{
    var0 = in0 + in0;
    var1 = in0 + in0 + in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out float dEQP_FragColor_0_0;
layout(location = 0, component = 1) out vec3  dEQP_FragColor_0_1[2];
layout(location = 1, component = 0) out float dEQP_FragColor_1_0;
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0 = out0.x;
    dEQP_FragColor_0_1[0] = out0.yzw;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_1_0 = out1.x;
    dEQP_FragColor_0_1[1] = out1.yzw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out vec3  dEQP_FragColor_0_0[2];
layout(location = 0, component = 3) out float dEQP_FragColor_0_3;
layout(location = 1, component = 3) out float dEQP_FragColor_1_3;
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0[0] = out0.xyz;
    dEQP_FragColor_0_3 = out0.w;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_0_0[1] = out1.xyz;
    dEQP_FragColor_1_3 = out1.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out vec2 dEQP_FragColor_0_0;
layout(location = 0, component = 2) out vec2 dEQP_FragColor_0_2[2];
layout(location = 1, component = 0) out vec2 dEQP_FragColor_1_0;
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0 = out0.xy;
    dEQP_FragColor_0_2[0] = out0.zw;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_1_0 = out1.xy;
    dEQP_FragColor_0_2[1] = out1.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out vec2 dEQP_FragColor_0_0[2];
layout(location = 0, component = 2) out vec2 dEQP_FragColor_0_2;
layout(location = 1, component = 2) out vec2 dEQP_FragColor_1_2;
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0[0] = out0.xy;
    dEQP_FragColor_0_2 = out0.zw;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_0_0[1] = out1.xy;
    dEQP_FragColor_1_2 = out1.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out float dEQP_FragColor_0_0;
layout(location = 0, component = 1) out float dEQP_FragColor_0_1[2];
layout(location = 0, component = 2) out vec2  dEQP_FragColor_0_2[2];
layout(location = 1, component = 0) out float dEQP_FragColor_1_0;
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0 = out0.x;
    dEQP_FragColor_0_1[0] = out0.y;
    dEQP_FragColor_0_2[0] = out0.zw;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_1_0 = out1.x;
    dEQP_FragColor_0_1[1] = out1.y;
    dEQP_FragColor_0_2[1] = out1.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 1) in vec4 var1;
layout(location = 0, component = 0) out float dEQP_FragColor_0_0[2];
layout(location = 0, component = 1) out float dEQP_FragColor_0_1[2];
layout(location = 0, component = 2) out float dEQP_FragColor_0_2[2];
layout(location = 0, component = 3) out float dEQP_FragColor_0_3[2];
void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0_0[0] = out0.x;
    dEQP_FragColor_0_1[0] = out0.y;
    dEQP_FragColor_0_2[0] = out0.z;
    dEQP_FragColor_0_3[0] = out0.w;

    vec4 out1 = var1;
    out1 /= vec4(255.0);
    dEQP_FragColor_0_0[1] = out1.x;
    dEQP_FragColor_0_1[1] = out1.y;
    dEQP_FragColor_0_2[1] = out1.z;
    dEQP_FragColor_0_3[1] = out1.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in vec4 in0;
layout(location = 0) out vec4 var0;

void main()
{
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out float dEQP_FragColor_1;
layout(location = 0, component = 2) out float dEQP_FragColor_2;
layout(location = 0, component = 3) out float dEQP_FragColor_3;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
    dEQP_FragColor_2 = out0.z;
    dEQP_FragColor_3 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out float dEQP_FragColor_1;
layout(location = 0, component = 2) out vec2 dEQP_FragColor_2;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
    dEQP_FragColor_2 = out0.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out vec2 dEQP_FragColor_1;
layout(location = 0, component = 3) out float dEQP_FragColor_2;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.yz;
    dEQP_FragColor_2 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out float dEQP_FragColor_0;
layout(location = 0, component = 1) out vec3 dEQP_FragColor_1;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.yzw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out vec2 dEQP_FragColor_0;
layout(location = 0, component = 2) out float dEQP_FragColor_1;
layout(location = 0, component = 3) out float dEQP_FragColor_2;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.xy;
    dEQP_FragColor_1 = out0.z;
    dEQP_FragColor_2 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out vec2 dEQP_FragColor_0;
layout(location = 0, component = 2) out vec2 dEQP_FragColor_1;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.xy;
    dEQP_FragColor_1 = out0.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 var0;
layout(location = 0, component = 0) out vec3 dEQP_FragColor_0;
layout(location = 0, component = 3) out float dEQP_FragColor_1;

void main()
{
    vec4 out0 = var0;
    out0 /= vec4(255.0);
    dEQP_FragColor_0 = out0.xyz;
    dEQP_FragColor_1 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec2 in0;
layout(location = 0) out ivec2 var0;

void main()
{
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec2 var0;
layout(location = 0, component = 0) out int dEQP_FragColor_0;
layout(location = 0, component = 1) out int dEQP_FragColor_1;

void main()
{
    ivec2 out0 = var0;
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) in vec4 dEQP_Position;
layout(location = 1) in ivec4 in0;
layout(location = 0) out ivec4 var0;

void main()
{
    var0 = in0 + in0;
    gl_Position = dEQP_Position;

}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out int dEQP_FragColor_0;
layout(location = 0, component = 1) out int dEQP_FragColor_1;
layout(location = 0, component = 2) out int dEQP_FragColor_2;
layout(location = 0, component = 3) out int dEQP_FragColor_3;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
    dEQP_FragColor_2 = out0.z;
    dEQP_FragColor_3 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out int dEQP_FragColor_0;
layout(location = 0, component = 1) out int dEQP_FragColor_1;
layout(location = 0, component = 2) out ivec2 dEQP_FragColor_2;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.y;
    dEQP_FragColor_2 = out0.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out int dEQP_FragColor_0;
layout(location = 0, component = 1) out ivec2 dEQP_FragColor_1;
layout(location = 0, component = 3) out int dEQP_FragColor_2;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.yz;
    dEQP_FragColor_2 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out int dEQP_FragColor_0;
layout(location = 0, component = 1) out ivec3 dEQP_FragColor_1;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.x;
    dEQP_FragColor_1 = out0.yzw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out ivec2 dEQP_FragColor_0;
layout(location = 0, component = 2) out int dEQP_FragColor_1;
layout(location = 0, component = 3) out int dEQP_FragColor_2;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.xy;
    dEQP_FragColor_1 = out0.z;
    dEQP_FragColor_2 = out0.w;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out ivec2 dEQP_FragColor_0;
layout(location = 0, component = 2) out ivec2 dEQP_FragColor_1;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.xy;
    dEQP_FragColor_1 = out0.zw;
}
#version 440 core
precision highp float;
precision highp int;
layout(location = 0) flat in ivec4 var0;
layout(location = 0, component = 0) out ivec3 dEQP_FragColor_0;
layout(location = 0, component = 3) out int dEQP_FragColor_1;

void main()
{
    ivec4 out0 = var0;
    dEQP_FragColor_0 = out0.xyz;
    dEQP_FragColor_1 = out0.w;
}
