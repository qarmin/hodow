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
