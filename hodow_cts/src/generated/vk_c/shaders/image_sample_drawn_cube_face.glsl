#version 450
layout(location = 0) in vec4 a_position;
void main (void) {
    gl_Position = a_position;
}
#version 450
layout(location = 0) in highp vec4 a_position;
layout(location = 1) in vec2 inTexCoord;
layout(location = 1) out vec2 fragTexCoord;
void main (void) {
    gl_Position = a_position;
    fragTexCoord = inTexCoord;
}
#version 450
layout(location = 0) out vec4 outColor;
layout(push_constant) uniform constants {
     int pass;
} pc;
void main() {
   if (pc.pass == 1) {
      outColor = vec4(0., 1., 1., 1.);
    } else {
      outColor = vec4(1., 0., 1., 1.);
    }
}
#version 450
layout(location = 0) out vec4 outColor;
layout(location = 1) in vec2 fragTexCoord;
layout(binding = 0) uniform samplerCube texSampler;
void main() {
     outColor = texture(texSampler, vec3(fragTexCoord.x, 1.0, fragTexCoord.y));
     outColor += texture(texSampler, vec3(fragTexCoord.x, -1.0, fragTexCoord.y));
     outColor += texture(texSampler, vec3(fragTexCoord.x, fragTexCoord.y, 1.0));
     outColor += texture(texSampler, vec3(fragTexCoord.x, fragTexCoord.y, -1.0));
     outColor /= 4.;
}
