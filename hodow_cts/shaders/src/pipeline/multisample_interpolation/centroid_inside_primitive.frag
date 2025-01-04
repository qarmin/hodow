#version 440
layout(location = 0) centroid in vec3 fs_in_barCoord;

layout(location = 0) out vec4 fs_out_color;

void main (void)
{
    if( all(greaterThanEqual(fs_in_barCoord, vec3(0.0))) && all(lessThanEqual(fs_in_barCoord, vec3(1.0))) )
            fs_out_color = vec4(0.0, 1.0, 0.0, 1.0);
    else
            fs_out_color = vec4(1.0, 0.0, 0.0, 1.0);
}
