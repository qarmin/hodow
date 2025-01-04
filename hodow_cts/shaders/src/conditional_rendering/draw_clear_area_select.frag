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
