#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp vec3 var[2][2];
};

void main (void)
{
	var[0][0] = vec3(-89.0f, 30.0f, -70.0f);
	var[0][1] = vec3(-60.0f, 72.0f, -102.0f);
	var[1][0] = vec3(-100.0f, 84.0f, -31.0f);
	var[1][1] = vec3(68.0f, 104.0f, 14.0f);
}
#version 450

void main (void)
{
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp vec3 var[2][2];
};

void main (void)
{
	var[0][0] = vec3(-89.0f, 30.0f, -70.0f);
	var[0][1] = vec3(-60.0f, 72.0f, -102.0f);
	var[1][0] = vec3(-100.0f, 84.0f, -31.0f);
	var[1][1] = vec3(68.0f, 104.0f, 14.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	highp vec4 var[2][2];
};

void main (void)
{
	var[0][0] = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	var[0][1] = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	var[1][0] = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	var[1][1] = vec4(83.0f, -117.0f, 75.0f, 12.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	highp vec4 var[2][2];
};

void main (void)
{
	var[0][0] = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	var[0][1] = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	var[1][0] = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	var[1][1] = vec4(83.0f, -117.0f, 75.0f, 12.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	highp ivec2 var[2][2];
};

void main (void)
{
	var[0][0] = ivec2(-89, 30);
	var[0][1] = ivec2(-70, -60);
	var[1][0] = ivec2(72, -102);
	var[1][1] = ivec2(-100, 84);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	highp ivec2 var[2][2];
};

void main (void)
{
	var[0][0] = ivec2(-89, 30);
	var[0][1] = ivec2(-70, -60);
	var[1][0] = ivec2(72, -102);
	var[1][1] = ivec2(-100, 84);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp ivec3 var[2][2];
};

void main (void)
{
	var[0][0] = ivec3(-89, 30, -70);
	var[0][1] = ivec3(-60, 72, -102);
	var[1][0] = ivec3(-100, 84, -31);
	var[1][1] = ivec3(68, 104, 14);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp ivec3 var[2][2];
};

void main (void)
{
	var[0][0] = ivec3(-89, 30, -70);
	var[0][1] = ivec3(-60, 72, -102);
	var[1][0] = ivec3(-100, 84, -31);
	var[1][1] = ivec3(68, 104, 14);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	highp uvec2 var[2][2];
};

void main (void)
{
	var[0][0] = uvec2(89u, 30u);
	var[0][1] = uvec2(70u, 60u);
	var[1][0] = uvec2(72u, 102u);
	var[1][1] = uvec2(100u, 84u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp mat2 var[2][2];
};

void main (void)
{
	var[0][0] = mat2(-89.0, 30.0, -70.0, -60.0);
	var[0][1] = mat2(72.0, -102.0, -100.0, 84.0);
	var[1][0] = mat2(-31.0, 68.0, 104.0, 14.0);
	var[1][1] = mat2(83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=144 sizeInLocations=12
{
	highp mat3 var[2][2];
};

void main (void)
{
	var[0][0] = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][1] = mat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[1][0] = mat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[1][1] = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	highp mat4 var[2][2];
};

void main (void)
{
	var[0][0] = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1] = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0] = mat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1] = mat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	highp mat2x3 var[2][2];
};

void main (void)
{
	var[0][0] = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[0][1] = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1][0] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[1][1] = mat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	highp mat2x4 var[2][2];
};

void main (void)
{
	var[0][0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1][0] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][1] = mat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	highp mat2x4 var[2][2];
};

void main (void)
{
	var[0][0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1][0] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][1] = mat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=12
{
	highp mat3x4 var[2][2];
};

void main (void)
{
	var[0][0] = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1] = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0] = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1] = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=16
{
	highp mat4x3 var[2][2];
};

void main (void)
{
	var[0][0] = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1] = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0] = mat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1] = mat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	double var[2][2];
};

void main (void)
{
	var[0][0] = -89.0;
	var[0][1] = 30.0;
	var[1][0] = -70.0;
	var[1][1] = -60.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	dvec2 var[2][2];
};

void main (void)
{
	var[0][0] = dvec2(-89.0, 30.0);
	var[0][1] = dvec2(-70.0, -60.0);
	var[1][0] = dvec2(72.0, -102.0);
	var[1][1] = dvec2(-100.0, 84.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	dvec2 var[2][2];
};

void main (void)
{
	var[0][0] = dvec2(-89.0, 30.0);
	var[0][1] = dvec2(-70.0, -60.0);
	var[1][0] = dvec2(72.0, -102.0);
	var[1][1] = dvec2(-100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	dvec3 var[2][2];
};

void main (void)
{
	var[0][0] = dvec3(-89.0, 30.0, -70.0);
	var[0][1] = dvec3(-60.0, 72.0, -102.0);
	var[1][0] = dvec3(-100.0, 84.0, -31.0);
	var[1][1] = dvec3(68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	dmat2 var[2][2];
};

void main (void)
{
	var[0][0] = dmat2(-89.0, 30.0, -70.0, -60.0);
	var[0][1] = dmat2(72.0, -102.0, -100.0, 84.0);
	var[1][0] = dmat2(-31.0, 68.0, 104.0, 14.0);
	var[1][1] = dmat2(83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	dmat2 var[2][2];
};

void main (void)
{
	var[0][0] = dmat2(-89.0, 30.0, -70.0, -60.0);
	var[0][1] = dmat2(72.0, -102.0, -100.0, 84.0);
	var[1][0] = dmat2(-31.0, 68.0, 104.0, 14.0);
	var[1][1] = dmat2(83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=16
{
	dmat2x3 var[2][2];
};

void main (void)
{
	var[0][0] = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[0][1] = dmat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1][0] = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[1][1] = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	dmat2x4 var[2][2];
};

void main (void)
{
	var[0][0] = dmat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][1] = dmat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1][0] = dmat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][1] = dmat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	dmat2x4 var[2][2];
};

void main (void)
{
	var[0][0] = dmat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][1] = dmat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1][0] = dmat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][1] = dmat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=24
{
	dmat3 var[2][2];
};

void main (void)
{
	var[0][0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[1][0] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[1][1] = dmat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=24
{
	dmat3 var[2][2];
};

void main (void)
{
	var[0][0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[1][0] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[1][1] = dmat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=32
{
	dmat4x3 var[2][2];
};

void main (void)
{
	var[0][0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1] = dmat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=512 sizeInLocations=32
{
	dmat4 var[2][2];
};

void main (void)
{
	var[0][0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1] = dmat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=512 sizeInLocations=32
{
	dmat4 var[2][2];
};

void main (void)
{
	var[0][0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1] = dmat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=8
{
	highp float var[2][2][2];
};

void main (void)
{
	var[0][0][0] = -89.0f;
	var[0][0][1] = 30.0f;
	var[0][1][0] = -70.0f;
	var[0][1][1] = -60.0f;
	var[1][0][0] = 72.0f;
	var[1][0][1] = -102.0f;
	var[1][1][0] = -100.0f;
	var[1][1][1] = 84.0f;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=8
{
	highp float var[2][2][2];
};

void main (void)
{
	var[0][0][0] = -89.0f;
	var[0][0][1] = 30.0f;
	var[0][1][0] = -70.0f;
	var[0][1][1] = -60.0f;
	var[1][0][0] = 72.0f;
	var[1][0][1] = -102.0f;
	var[1][1][0] = -100.0f;
	var[1][1][1] = 84.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp vec2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = vec2(-89.0f, 30.0f);
	var[0][0][1] = vec2(-70.0f, -60.0f);
	var[0][1][0] = vec2(72.0f, -102.0f);
	var[0][1][1] = vec2(-100.0f, 84.0f);
	var[1][0][0] = vec2(-31.0f, 68.0f);
	var[1][0][1] = vec2(104.0f, 14.0f);
	var[1][1][0] = vec2(83.0f, -117.0f);
	var[1][1][1] = vec2(75.0f, 12.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp vec2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = vec2(-89.0f, 30.0f);
	var[0][0][1] = vec2(-70.0f, -60.0f);
	var[0][1][0] = vec2(72.0f, -102.0f);
	var[0][1][1] = vec2(-100.0f, 84.0f);
	var[1][0][0] = vec2(-31.0f, 68.0f);
	var[1][0][1] = vec2(104.0f, 14.0f);
	var[1][1][0] = vec2(83.0f, -117.0f);
	var[1][1][1] = vec2(75.0f, 12.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	highp vec3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = vec3(-89.0f, 30.0f, -70.0f);
	var[0][0][1] = vec3(-60.0f, 72.0f, -102.0f);
	var[0][1][0] = vec3(-100.0f, 84.0f, -31.0f);
	var[0][1][1] = vec3(68.0f, 104.0f, 14.0f);
	var[1][0][0] = vec3(83.0f, -117.0f, 75.0f);
	var[1][0][1] = vec3(12.0f, -18.0f, -101.0f);
	var[1][1][0] = vec3(100.0f, -34.0f, -35.0f);
	var[1][1][1] = vec3(-43.0f, 48.0f, 4.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	highp vec4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	var[0][0][1] = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	var[0][1][0] = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	var[0][1][1] = vec4(83.0f, -117.0f, 75.0f, 12.0f);
	var[1][0][0] = vec4(-18.0f, -101.0f, 100.0f, -34.0f);
	var[1][0][1] = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	var[1][1][0] = vec4(-60.0f, 37.0f, 52.0f, 98.0f);
	var[1][1][1] = vec4(-80.0f, -62.0f, -54.0f, -79.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=8
{
	highp int var[2][2][2];
};

void main (void)
{
	var[0][0][0] = -89;
	var[0][0][1] = 30;
	var[0][1][0] = -70;
	var[0][1][1] = -60;
	var[1][0][0] = 72;
	var[1][0][1] = -102;
	var[1][1][0] = -100;
	var[1][1][1] = 84;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp ivec2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = ivec2(-89, 30);
	var[0][0][1] = ivec2(-70, -60);
	var[0][1][0] = ivec2(72, -102);
	var[0][1][1] = ivec2(-100, 84);
	var[1][0][0] = ivec2(-31, 68);
	var[1][0][1] = ivec2(104, 14);
	var[1][1][0] = ivec2(83, -117);
	var[1][1][1] = ivec2(75, 12);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	highp ivec3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = ivec3(-89, 30, -70);
	var[0][0][1] = ivec3(-60, 72, -102);
	var[0][1][0] = ivec3(-100, 84, -31);
	var[0][1][1] = ivec3(68, 104, 14);
	var[1][0][0] = ivec3(83, -117, 75);
	var[1][0][1] = ivec3(12, -18, -101);
	var[1][1][0] = ivec3(100, -34, -35);
	var[1][1][1] = ivec3(-43, 48, 4);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	highp ivec4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = ivec4(-89, 30, -70, -60);
	var[0][0][1] = ivec4(72, -102, -100, 84);
	var[0][1][0] = ivec4(-31, 68, 104, 14);
	var[0][1][1] = ivec4(83, -117, 75, 12);
	var[1][0][0] = ivec4(-18, -101, 100, -34);
	var[1][0][1] = ivec4(-35, -43, 48, 4);
	var[1][1][0] = ivec4(-60, 37, 52, 98);
	var[1][1][1] = ivec4(-80, -62, -54, -79);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=8
{
	highp uint var[2][2][2];
};

void main (void)
{
	var[0][0][0] = 89u;
	var[0][0][1] = 30u;
	var[0][1][0] = 70u;
	var[0][1][1] = 60u;
	var[1][0][0] = 72u;
	var[1][0][1] = 102u;
	var[1][1][0] = 100u;
	var[1][1][1] = 84u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp uvec2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = uvec2(89u, 30u);
	var[0][0][1] = uvec2(70u, 60u);
	var[0][1][0] = uvec2(72u, 102u);
	var[0][1][1] = uvec2(100u, 84u);
	var[1][0][0] = uvec2(31u, 68u);
	var[1][0][1] = uvec2(104u, 14u);
	var[1][1][0] = uvec2(83u, 117u);
	var[1][1][1] = uvec2(75u, 12u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	highp uvec2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = uvec2(89u, 30u);
	var[0][0][1] = uvec2(70u, 60u);
	var[0][1][0] = uvec2(72u, 102u);
	var[0][1][1] = uvec2(100u, 84u);
	var[1][0][0] = uvec2(31u, 68u);
	var[1][0][1] = uvec2(104u, 14u);
	var[1][1][0] = uvec2(83u, 117u);
	var[1][1][1] = uvec2(75u, 12u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	highp uvec3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = uvec3(89u, 30u, 70u);
	var[0][0][1] = uvec3(60u, 72u, 102u);
	var[0][1][0] = uvec3(100u, 84u, 31u);
	var[0][1][1] = uvec3(68u, 104u, 14u);
	var[1][0][0] = uvec3(83u, 117u, 75u);
	var[1][0][1] = uvec3(12u, 18u, 101u);
	var[1][1][0] = uvec3(100u, 34u, 35u);
	var[1][1][1] = uvec3(43u, 48u, 4u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	highp uvec3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = uvec3(89u, 30u, 70u);
	var[0][0][1] = uvec3(60u, 72u, 102u);
	var[0][1][0] = uvec3(100u, 84u, 31u);
	var[0][1][1] = uvec3(68u, 104u, 14u);
	var[1][0][0] = uvec3(83u, 117u, 75u);
	var[1][0][1] = uvec3(12u, 18u, 101u);
	var[1][1][0] = uvec3(100u, 34u, 35u);
	var[1][1][1] = uvec3(43u, 48u, 4u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=24
{
	highp mat3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][0][1] = mat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][0] = mat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[0][1][1] = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][0][0] = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	var[1][0][1] = mat3(32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	var[1][1][0] = mat3(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0);
	var[1][1][1] = mat3(-60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=512 sizeInLocations=32
{
	highp mat4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][0][1] = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[0][1][0] = mat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[0][1][1] = mat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	var[1][0][0] = mat4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	var[1][0][1] = mat4(-49.0, -6.0, 98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
	var[1][1][0] = mat4(44.0, 56.0, -33.0, 109.0, -119.0, 34.0, -102.0, 104.0, 33.0, 127.0, 121.0, 42.0, -34.0, -92.0, 75.0, -68.0);
	var[1][1][1] = mat4(84.0, -4.0, 38.0, 119.0, -79.0, 39.0, -7.0, 119.0, -75.0, 19.0, -79.0, -31.0, 50.0, 79.0, -21.0, -5.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=16
{
	highp mat2x3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[0][0][1] = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1][0] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][1] = mat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0][0] = mat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	var[1][0][1] = mat2x3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1][0] = mat2x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	var[1][1][1] = mat2x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=16
{
	highp mat2x3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[0][0][1] = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1][0] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][1] = mat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0][0] = mat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	var[1][0][1] = mat2x3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1][0] = mat2x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	var[1][1][1] = mat2x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	highp mat2x4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][0][1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1][0] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][1] = mat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0][0] = mat2x4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	var[1][0][1] = mat2x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1][0] = mat2x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	var[1][1][1] = mat2x4(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	highp mat2x4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][0][1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1][0] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][1] = mat2x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0][0] = mat2x4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	var[1][0][1] = mat2x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1][0] = mat2x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	var[1][1][1] = mat2x4(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=24
{
	highp mat3x4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][0][1] = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][0] = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[0][1][1] = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][0][0] = mat3x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	var[1][0][1] = mat3x4(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	var[1][1][0] = mat3x4(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	var[1][1][1] = mat3x4(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=24
{
	highp mat3x4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][0][1] = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][0] = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[0][1][1] = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][0][0] = mat3x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	var[1][0][1] = mat3x4(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	var[1][1][0] = mat3x4(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	var[1][1][1] = mat3x4(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=32
{
	highp mat4x2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][0][1] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1][0] = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][1] = mat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0][0] = mat4x2(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	var[1][0][1] = mat4x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1][0] = mat4x2(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	var[1][1][1] = mat4x2(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=8
{
	double var[2][2][2];
};

void main (void)
{
	var[0][0][0] = -89.0;
	var[0][0][1] = 30.0;
	var[0][1][0] = -70.0;
	var[0][1][1] = -60.0;
	var[1][0][0] = 72.0;
	var[1][0][1] = -102.0;
	var[1][1][0] = -100.0;
	var[1][1][1] = 84.0;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=16
{
	dvec3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dvec3(-89.0, 30.0, -70.0);
	var[0][0][1] = dvec3(-60.0, 72.0, -102.0);
	var[0][1][0] = dvec3(-100.0, 84.0, -31.0);
	var[0][1][1] = dvec3(68.0, 104.0, 14.0);
	var[1][0][0] = dvec3(83.0, -117.0, 75.0);
	var[1][0][1] = dvec3(12.0, -18.0, -101.0);
	var[1][1][0] = dvec3(100.0, -34.0, -35.0);
	var[1][1][1] = dvec3(-43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	dvec4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dvec4(-89.0, 30.0, -70.0, -60.0);
	var[0][0][1] = dvec4(72.0, -102.0, -100.0, 84.0);
	var[0][1][0] = dvec4(-31.0, 68.0, 104.0, 14.0);
	var[0][1][1] = dvec4(83.0, -117.0, 75.0, 12.0);
	var[1][0][0] = dvec4(-18.0, -101.0, 100.0, -34.0);
	var[1][0][1] = dvec4(-35.0, -43.0, 48.0, 4.0);
	var[1][1][0] = dvec4(-60.0, 37.0, 52.0, 98.0);
	var[1][1][1] = dvec4(-80.0, -62.0, -54.0, -79.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=256 sizeInLocations=16
{
	dvec4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dvec4(-89.0, 30.0, -70.0, -60.0);
	var[0][0][1] = dvec4(72.0, -102.0, -100.0, 84.0);
	var[0][1][0] = dvec4(-31.0, 68.0, 104.0, 14.0);
	var[0][1][1] = dvec4(83.0, -117.0, 75.0, 12.0);
	var[1][0][0] = dvec4(-18.0, -101.0, 100.0, -34.0);
	var[1][0][1] = dvec4(-35.0, -43.0, 48.0, 4.0);
	var[1][1][0] = dvec4(-60.0, 37.0, 52.0, 98.0);
	var[1][1][1] = dvec4(-80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=24
{
	dmat3x2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[0][0][1] = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][1][0] = dmat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][1] = dmat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[1][0][0] = dmat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	var[1][0][1] = dmat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][1][0] = dmat3x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	var[1][1][1] = dmat3x2(114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=576 sizeInLocations=48
{
	dmat3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][0][1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][0] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[0][1][1] = dmat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][0][0] = dmat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	var[1][0][1] = dmat3(32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	var[1][1][0] = dmat3(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0);
	var[1][1][1] = dmat3(-60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=576 sizeInLocations=48
{
	dmat3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[0][0][1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[0][1][0] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	var[0][1][1] = dmat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[1][0][0] = dmat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	var[1][0][1] = dmat3(32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	var[1][1][0] = dmat3(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0);
	var[1][1][1] = dmat3(-60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=512 sizeInLocations=32
{
	dmat4x2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][0][1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1][0] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][1] = dmat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0][0] = dmat4x2(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	var[1][0][1] = dmat4x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1][0] = dmat4x2(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	var[1][1][1] = dmat4x2(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=512 sizeInLocations=32
{
	dmat4x2 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[0][0][1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][1][0] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][1] = dmat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[1][0][0] = dmat4x2(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	var[1][0][1] = dmat4x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][1][0] = dmat4x2(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	var[1][1][1] = dmat4x2(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=768 sizeInLocations=64
{
	dmat4x3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][0][1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][0] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[0][1][1] = dmat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][0][0] = dmat4x3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	var[1][0][1] = dmat4x3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	var[1][1][0] = dmat4x3(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	var[1][1][1] = dmat4x3(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=768 sizeInLocations=64
{
	dmat4x3 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[0][0][1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[0][1][0] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	var[0][1][1] = dmat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[1][0][0] = dmat4x3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	var[1][0][1] = dmat4x3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	var[1][1][0] = dmat4x3(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	var[1][1][1] = dmat4x3(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=1024 sizeInLocations=64
{
	dmat4 var[2][2][2];
};

void main (void)
{
	var[0][0][0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[0][0][1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[0][1][0] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	var[0][1][1] = dmat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	var[1][0][0] = dmat4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	var[1][0][1] = dmat4(-49.0, -6.0, 98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
	var[1][1][0] = dmat4(44.0, 56.0, -33.0, 109.0, -119.0, 34.0, -102.0, 104.0, 33.0, 127.0, 121.0, 42.0, -34.0, -92.0, 75.0, -68.0);
	var[1][1][1] = dmat4(84.0, -4.0, 38.0, 119.0, -79.0, 39.0, -7.0, 119.0, -75.0, 19.0, -79.0, -31.0, 50.0, 79.0, -21.0, -5.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp uvec3 a; // unassigned
	mediump mat2 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=124 sizeInLocations=14
{
	mediump int u;
	S s[2][2];
	mediump vec2 v;
};

void main (void)
{
	u = -89;
	s[0][0].b = mat2(30.0, -70.0, -60.0, 72.0);
	s[0][1].b = mat2(-102.0, -100.0, 84.0, -31.0);
	s[1][0].b = mat2(68.0, 104.0, 14.0, 83.0);
	s[1][1].b = mat2(-117.0, 75.0, 12.0, -18.0);
	v = vec2(-101.0f, 100.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp uvec3 a; // unassigned
	mediump mat2 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=124 sizeInLocations=14
{
	mediump int u;
	S s[2][2];
	mediump vec2 v;
};

void main (void)
{
	u = -89;
	s[0][0].b = mat2(30.0, -70.0, -60.0, 72.0);
	s[0][1].b = mat2(-102.0, -100.0, 84.0, -31.0);
	s[1][0].b = mat2(68.0, 104.0, 14.0, 83.0);
	s[1][1].b = mat2(-117.0, 75.0, 12.0, -18.0);
	v = vec2(-101.0f, 100.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp uvec3 a; // unassigned
	mediump mat2 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 124) out Block // sizeInBytes=124 sizeInLocations=14
{
	mediump int u;
	S s[2][2];
	mediump vec2 v;
} block[2];

void main (void)
{
	block[0].u = -89;
	block[0].s[0][0].b = mat2(30.0, -70.0, -60.0, 72.0);
	block[0].s[0][1].b = mat2(-102.0, -100.0, 84.0, -31.0);
	block[0].s[1][0].b = mat2(68.0, 104.0, 14.0, 83.0);
	block[0].s[1][1].b = mat2(-117.0, 75.0, 12.0, -18.0);
	block[0].v = vec2(-101.0f, 100.0f);
	block[1].u = -34;
	block[1].s[0][0].b = mat2(-35.0, -43.0, 48.0, 4.0);
	block[1].s[0][1].b = mat2(-60.0, 37.0, 52.0, 98.0);
	block[1].s[1][0].b = mat2(-80.0, -62.0, -54.0, -79.0);
	block[1].s[1][1].b = mat2(3.0, -97.0, -118.0, -108.0);
	block[1].v = vec2(-120.0f, 48.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	double var;
};

void main (void)
{
	var = -89.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	dvec2 var;
};

void main (void)
{
	var = dvec2(-89.0, 30.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	dvec4 var;
};

void main (void)
{
	var = dvec4(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	dmat2 var;
};

void main (void)
{
	var = dmat2(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 var;
};

void main (void)
{
	var = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	dmat2x4 var;
};

void main (void)
{
	var = dmat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 var;
};

void main (void)
{
	var = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 var;
};

void main (void)
{
	var = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=6
{
	dmat3 var;
};

void main (void)
{
	var = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 var;
};

void main (void)
{
	var = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 var;
};

void main (void)
{
	var = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	dmat4 var;
};

void main (void)
{
	var = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=128 sizeInLocations=8
{
	dmat4 var;
};

void main (void)
{
	var = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 var;
};

void main (void)
{
	var = vec2(-89.0f, 30.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	lowp vec3 var;
};

void main (void)
{
	var = vec3(-89.0f, 30.0f, -70.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 var;
};

void main (void)
{
	var = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	lowp ivec2 var;
};

void main (void)
{
	var = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	lowp ivec3 var;
};

void main (void)
{
	var = ivec3(-89, 30, -70);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 var;
};

void main (void)
{
	var = ivec4(-89, 30, -70, -60);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=4 sizeInLocations=1
{
	lowp uint var;
};

void main (void)
{
	var = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	lowp uvec2 var;
};

void main (void)
{
	var = uvec2(89u, 30u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 var;
};

void main (void)
{
	var = uvec3(89u, 30u, 70u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 var;
};

void main (void)
{
	var = uvec3(89u, 30u, 70u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	lowp uvec4 var;
};

void main (void)
{
	var = uvec4(89u, 30u, 70u, 60u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 var;
};

void main (void)
{
	var = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	lowp mat4 var;
};

void main (void)
{
	var = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	lowp mat4 var;
};

void main (void)
{
	var = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	lowp mat2x4 var;
};

void main (void)
{
	var = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	lowp mat2x4 var;
};

void main (void)
{
	var = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 var;
};

void main (void)
{
	var = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 var;
};

void main (void)
{
	var = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	lowp mat3x4 var;
};

void main (void)
{
	var = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	lowp mat4x2 var;
};

void main (void)
{
	var = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	lowp mat4x2 var;
};

void main (void)
{
	var = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	lowp mat4x3 var;
};

void main (void)
{
	var = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	mediump vec2 var;
};

void main (void)
{
	var = vec2(-89.0f, 30.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	mediump vec2 var;
};

void main (void)
{
	var = vec2(-89.0f, 30.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	mediump vec3 var;
};

void main (void)
{
	var = vec3(-89.0f, 30.0f, -70.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	mediump vec3 var;
};

void main (void)
{
	var = vec3(-89.0f, 30.0f, -70.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=4 sizeInLocations=1
{
	mediump int var;
};

void main (void)
{
	var = -89;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=4 sizeInLocations=1
{
	mediump int var;
};

void main (void)
{
	var = -89;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	mediump ivec2 var;
};

void main (void)
{
	var = ivec2(-89, 30);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 var;
};

void main (void)
{
	var = ivec3(-89, 30, -70);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 var;
};

void main (void)
{
	var = ivec3(-89, 30, -70);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	mediump ivec4 var;
};

void main (void)
{
	var = ivec4(-89, 30, -70, -60);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=4 sizeInLocations=1
{
	mediump uint var;
};

void main (void)
{
	var = 89u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 var;
};

void main (void)
{
	var = uvec4(89u, 30u, 70u, 60u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 var;
};

void main (void)
{
	var = uvec4(89u, 30u, 70u, 60u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 var;
};

void main (void)
{
	var = mat2(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 var;
};

void main (void)
{
	var = mat2(-89.0, 30.0, -70.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=64 sizeInLocations=4
{
	mediump mat4 var;
};

void main (void)
{
	var = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=2
{
	mediump mat2x3 var;
};

void main (void)
{
	var = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=2
{
	mediump mat2x3 var;
};

void main (void)
{
	var = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	mediump mat2x4 var;
};

void main (void)
{
	var = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 var;
};

void main (void)
{
	var = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 var;
};

void main (void)
{
	var = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	mediump mat3x4 var;
};

void main (void)
{
	var = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	mediump mat4x2 var;
};

void main (void)
{
	var = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	mediump mat4x2 var;
};

void main (void)
{
	var = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 var;
};

void main (void)
{
	var = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp vec2 var;
};

void main (void)
{
	var = vec2(-89.0f, 30.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp vec2 var;
};

void main (void)
{
	var = vec2(-89.0f, 30.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=1
{
	highp vec4 var;
};

void main (void)
{
	var = vec4(-89.0f, 30.0f, -70.0f, -60.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp ivec2 var;
};

void main (void)
{
	var = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp uint var;
};

void main (void)
{
	var = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 var;
};

void main (void)
{
	var = uvec2(89u, 30u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 var;
};

void main (void)
{
	var = uvec2(89u, 30u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=1
{
	highp uvec3 var;
};

void main (void)
{
	var = uvec3(89u, 30u, 70u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 var;
};

void main (void)
{
	var = mat2(-89.0, 30.0, -70.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp mat3 var;
};

void main (void)
{
	var = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp mat3 var;
};

void main (void)
{
	var = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=2
{
	highp mat2x3 var;
};

void main (void)
{
	var = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=2
{
	highp mat2x4 var;
};

void main (void)
{
	var = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	highp mat3x2 var;
};

void main (void)
{
	var = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	highp mat3x4 var;
};

void main (void)
{
	var = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 var;
};

void main (void)
{
	var = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp mat4x3 var;
};

void main (void)
{
	var = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp vec3 var[3];
};

void main (void)
{
	var[0] = vec3(-89.0f, 30.0f, -70.0f);
	var[1] = vec3(-60.0f, 72.0f, -102.0f);
	var[2] = vec3(-100.0f, 84.0f, -31.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp vec3 var[3];
};

void main (void)
{
	var[0] = vec3(-89.0f, 30.0f, -70.0f);
	var[1] = vec3(-60.0f, 72.0f, -102.0f);
	var[2] = vec3(-100.0f, 84.0f, -31.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp ivec3 var[3];
};

void main (void)
{
	var[0] = ivec3(-89, 30, -70);
	var[1] = ivec3(-60, 72, -102);
	var[2] = ivec3(-100, 84, -31);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	highp ivec4 var[3];
};

void main (void)
{
	var[0] = ivec4(-89, 30, -70, -60);
	var[1] = ivec4(72, -102, -100, 84);
	var[2] = ivec4(-31, 68, 104, 14);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=12 sizeInLocations=3
{
	highp uint var[3];
};

void main (void)
{
	var[0] = 89u;
	var[1] = 30u;
	var[2] = 70u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	highp uvec2 var[3];
};

void main (void)
{
	var[0] = uvec2(89u, 30u);
	var[1] = uvec2(70u, 60u);
	var[2] = uvec2(72u, 102u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	highp uvec2 var[3];
};

void main (void)
{
	var[0] = uvec2(89u, 30u);
	var[1] = uvec2(70u, 60u);
	var[2] = uvec2(72u, 102u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp uvec3 var[3];
};

void main (void)
{
	var[0] = uvec3(89u, 30u, 70u);
	var[1] = uvec3(60u, 72u, 102u);
	var[2] = uvec3(100u, 84u, 31u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp uvec3 var[3];
};

void main (void)
{
	var[0] = uvec3(89u, 30u, 70u);
	var[1] = uvec3(60u, 72u, 102u);
	var[2] = uvec3(100u, 84u, 31u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=108 sizeInLocations=9
{
	highp mat3 var[3];
};

void main (void)
{
	var[0] = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[1] = mat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[2] = mat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=12
{
	highp mat4 var[3];
};

void main (void)
{
	var[0] = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1] = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[2] = mat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=6
{
	highp mat2x3 var[3];
};

void main (void)
{
	var[0] = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[1] = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[2] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=6
{
	highp mat2x3 var[3];
};

void main (void)
{
	var[0] = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[1] = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[2] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=6
{
	highp mat2x4 var[3];
};

void main (void)
{
	var[0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=6
{
	highp mat2x4 var[3];
};

void main (void)
{
	var[0] = mat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = mat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = mat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=9
{
	highp mat3x2 var[3];
};

void main (void)
{
	var[0] = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[1] = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[2] = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=9
{
	highp mat3x2 var[3];
};

void main (void)
{
	var[0] = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[1] = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[2] = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=12
{
	highp mat4x2 var[3];
};

void main (void)
{
	var[0] = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=12
{
	highp mat4x2 var[3];
};

void main (void)
{
	var[0] = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=144 sizeInLocations=12
{
	highp mat4x3 var[3];
};

void main (void)
{
	var[0] = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1] = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[2] = mat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=144 sizeInLocations=12
{
	highp mat4x3 var[3];
};

void main (void)
{
	var[0] = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1] = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[2] = mat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=24 sizeInLocations=3
{
	double var[3];
};

void main (void)
{
	var[0] = -89.0;
	var[1] = 30.0;
	var[2] = -70.0;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=48 sizeInLocations=3
{
	dvec2 var[3];
};

void main (void)
{
	var[0] = dvec2(-89.0, 30.0);
	var[1] = dvec2(-70.0, -60.0);
	var[2] = dvec2(72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=96 sizeInLocations=6
{
	dvec4 var[3];
};

void main (void)
{
	var[0] = dvec4(-89.0, 30.0, -70.0, -60.0);
	var[1] = dvec4(72.0, -102.0, -100.0, 84.0);
	var[2] = dvec4(-31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=12
{
	dmat2x4 var[3];
};

void main (void)
{
	var[0] = dmat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = dmat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = dmat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=144 sizeInLocations=9
{
	dmat3x2 var[3];
};

void main (void)
{
	var[0] = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	var[1] = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[2] = dmat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=216 sizeInLocations=18
{
	dmat3 var[3];
};

void main (void)
{
	var[0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[2] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=216 sizeInLocations=18
{
	dmat3 var[3];
};

void main (void)
{
	var[0] = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	var[1] = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	var[2] = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=18
{
	dmat3x4 var[3];
};

void main (void)
{
	var[0] = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1] = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[2] = dmat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=18
{
	dmat3x4 var[3];
};

void main (void)
{
	var[0] = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1] = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[2] = dmat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=12
{
	dmat4x2 var[3];
};

void main (void)
{
	var[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=192 sizeInLocations=12
{
	dmat4x2 var[3];
};

void main (void)
{
	var[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	var[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=288 sizeInLocations=24
{
	dmat4x3 var[3];
};

void main (void)
{
	var[0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	var[1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	var[2] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=24
{
	dmat4 var[3];
};

void main (void)
{
	var[0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[2] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=384 sizeInLocations=24
{
	dmat4 var[3];
};

void main (void)
{
	var[0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	var[1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	var[2] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp ivec3 a; // unassigned
	highp vec3 b[2];
	mediump mat3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=6
{
	S s;
};

void main (void)
{
	s.b[0] = vec3(-89.0f, 30.0f, -70.0f);
	s.b[1] = vec3(-60.0f, 72.0f, -102.0f);
	s.c = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a; // unassigned
	highp vec3 b[2];
	mediump mat3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=72 sizeInLocations=6
{
	S s;
};

void main (void)
{
	s.b[0] = vec3(-89.0f, 30.0f, -70.0f);
	s.b[1] = vec3(-60.0f, 72.0f, -102.0f);
	s.c = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp ivec3 a; // unassigned
	highp vec3 b[2];
	mediump mat3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out Block // sizeInBytes=72 sizeInLocations=6
{
	S s;
} block[3];

void main (void)
{
	block[0].s.b[0] = vec3(-89.0f, 30.0f, -70.0f);
	block[0].s.b[1] = vec3(-60.0f, 72.0f, -102.0f);
	block[0].s.c = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	block[1].s.b[0] = vec3(12.0f, -18.0f, -101.0f);
	block[1].s.b[1] = vec3(100.0f, -34.0f, -35.0f);
	block[1].s.c = mat3(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	block[2].s.b[0] = vec3(-54.0f, -79.0f, 3.0f);
	block[2].s.b[1] = vec3(-97.0f, -118.0f, -108.0f);
	block[2].s.c = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a; // unassigned
	highp vec3 b[2];
	mediump mat3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out Block // sizeInBytes=72 sizeInLocations=6
{
	S s;
} block[3];

void main (void)
{
	block[0].s.b[0] = vec3(-89.0f, 30.0f, -70.0f);
	block[0].s.b[1] = vec3(-60.0f, 72.0f, -102.0f);
	block[0].s.c = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	block[1].s.b[0] = vec3(12.0f, -18.0f, -101.0f);
	block[1].s.b[1] = vec3(100.0f, -34.0f, -35.0f);
	block[1].s.c = mat3(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	block[2].s.b[0] = vec3(-54.0f, -79.0f, 3.0f);
	block[2].s.b[1] = vec3(-97.0f, -118.0f, -108.0f);
	block[2].s.c = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a; // unassigned
	mediump mat2 b[2];
	highp float c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=116 sizeInLocations=14
{
	lowp uint u;
	S s[2];
	mediump vec4 v;
};

void main (void)
{
	u = 89u;
	s[0].b[0] = mat2(30.0, -70.0, -60.0, 72.0);
	s[0].b[1] = mat2(-102.0, -100.0, 84.0, -31.0);
	s[0].c = 68.0f;
	s[1].b[0] = mat2(104.0, 14.0, 83.0, -117.0);
	s[1].b[1] = mat2(75.0, 12.0, -18.0, -101.0);
	s[1].c = 100.0f;
	v = vec4(-34.0f, -35.0f, -43.0f, 48.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a; // unassigned
	mediump mat2 b[2];
	highp float c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 116) out Block // sizeInBytes=116 sizeInLocations=14
{
	lowp uint u;
	S s[2];
	mediump vec4 v;
} block[2];

void main (void)
{
	block[0].u = 89u;
	block[0].s[0].b[0] = mat2(30.0, -70.0, -60.0, 72.0);
	block[0].s[0].b[1] = mat2(-102.0, -100.0, 84.0, -31.0);
	block[0].s[0].c = 68.0f;
	block[0].s[1].b[0] = mat2(104.0, 14.0, 83.0, -117.0);
	block[0].s[1].b[1] = mat2(75.0, 12.0, -18.0, -101.0);
	block[0].s[1].c = 100.0f;
	block[0].v = vec4(-34.0f, -35.0f, -43.0f, 48.0f);
	block[1].u = 4u;
	block[1].s[0].b[0] = mat2(-60.0, 37.0, 52.0, 98.0);
	block[1].s[0].b[1] = mat2(-80.0, -62.0, -54.0, -79.0);
	block[1].s[0].c = 3.0f;
	block[1].s[1].b[0] = mat2(-97.0, -118.0, -108.0, -120.0);
	block[1].s[1].b[1] = mat2(48.0, -71.0, -59.0, -40.0);
	block[1].s[1].c = -62.0f;
	block[1].v = vec4(114.0f, -109.0f, -51.0f, 32.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a;
	mediump mat2 b[2];
	highp float c; // unassigned
};
struct T
{
	mediump vec3 a;
	S b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=120 sizeInLocations=15
{
	S s;
	lowp uint v; // unassigned
	T t;
	highp vec2 u;
};

void main (void)
{
	s.a = ivec3(-89, 30, -70);
	s.b[0] = mat2(-60.0, 72.0, -102.0, -100.0);
	s.b[1] = mat2(84.0, -31.0, 68.0, 104.0);
	t.a = vec3(14.0f, 83.0f, -117.0f);
	t.b.a = ivec3(75, 12, -18);
	t.b.b[0] = mat2(-101.0, 100.0, -34.0, -35.0);
	t.b.b[1] = mat2(-43.0, 48.0, 4.0, -60.0);
	u = vec2(37.0f, 52.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp ivec3 a;
	mediump mat2 b[2];
	highp float c; // unassigned
};
struct T
{
	mediump vec3 a;
	S b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out Block // sizeInBytes=120 sizeInLocations=15
{
	S s;
	lowp uint v; // unassigned
	T t;
	highp vec2 u;
} block[2];

void main (void)
{
	block[0].s.a = ivec3(-89, 30, -70);
	block[0].s.b[0] = mat2(-60.0, 72.0, -102.0, -100.0);
	block[0].s.b[1] = mat2(84.0, -31.0, 68.0, 104.0);
	block[0].t.a = vec3(14.0f, 83.0f, -117.0f);
	block[0].t.b.a = ivec3(75, 12, -18);
	block[0].t.b.b[0] = mat2(-101.0, 100.0, -34.0, -35.0);
	block[0].t.b.b[1] = mat2(-43.0, 48.0, 4.0, -60.0);
	block[0].u = vec2(37.0f, 52.0f);
	block[1].s.a = ivec3(98, -80, -62);
	block[1].s.b[0] = mat2(-54.0, -79.0, 3.0, -97.0);
	block[1].s.b[1] = mat2(-118.0, -108.0, -120.0, 48.0);
	block[1].t.a = vec3(-71.0f, -59.0f, -40.0f);
	block[1].t.b.a = ivec3(-62, 114, -109);
	block[1].t.b.b[0] = mat2(-51.0, 32.0, 113.0, -44.0);
	block[1].t.b.b[1] = mat2(-77.0, -11.0, 66.0, -11.0);
	block[1].u = vec2(87.0f, -87.0f);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp ivec3 a;
	mediump mat2 b[2];
	highp float c; // unassigned
};
struct T
{
	mediump vec3 a;
	S b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out Block // sizeInBytes=120 sizeInLocations=15
{
	S s;
	lowp uint v; // unassigned
	T t;
	highp vec2 u;
} block[2];

void main (void)
{
	block[0].s.a = ivec3(-89, 30, -70);
	block[0].s.b[0] = mat2(-60.0, 72.0, -102.0, -100.0);
	block[0].s.b[1] = mat2(84.0, -31.0, 68.0, 104.0);
	block[0].t.a = vec3(14.0f, 83.0f, -117.0f);
	block[0].t.b.a = ivec3(75, 12, -18);
	block[0].t.b.b[0] = mat2(-101.0, 100.0, -34.0, -35.0);
	block[0].t.b.b[1] = mat2(-43.0, 48.0, 4.0, -60.0);
	block[0].u = vec2(37.0f, 52.0f);
	block[1].s.a = ivec3(98, -80, -62);
	block[1].s.b[0] = mat2(-54.0, -79.0, 3.0, -97.0);
	block[1].s.b[1] = mat2(-118.0, -108.0, -120.0, 48.0);
	block[1].t.a = vec3(-71.0f, -59.0f, -40.0f);
	block[1].t.b.a = ivec3(-62, 114, -109);
	block[1].t.b.b[0] = mat2(-51.0, 32.0, 113.0, -44.0);
	block[1].t.b.b[1] = mat2(-77.0, -11.0, 66.0, -11.0);
	block[1].u = vec2(87.0f, -87.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp float a[2];
};
struct T
{
	mediump mat2 a;
	S b[2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out Block // sizeInBytes=84 sizeInLocations=16
{
	S s;
	lowp vec2 v; // unassigned
	T t[2];
	highp uint u;
};

void main (void)
{
	s.a[0] = -89.0f;
	s.a[1] = 30.0f;
	t[0].a = mat2(-70.0, -60.0, 72.0, -102.0);
	t[0].b[0].a[0] = -100.0f;
	t[0].b[0].a[1] = 84.0f;
	t[0].b[1].a[0] = -31.0f;
	t[0].b[1].a[1] = 68.0f;
	t[1].a = mat2(104.0, 14.0, 83.0, -117.0);
	t[1].b[0].a[0] = 75.0f;
	t[1].b[0].a[1] = 12.0f;
	t[1].b[1].a[0] = -18.0f;
	t[1].b[1].a[1] = -101.0f;
	u = 100u;

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	highp float a[2];
};
struct T
{
	mediump mat2 a;
	S b[2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 84) out Block // sizeInBytes=84 sizeInLocations=16
{
	S s;
	lowp vec2 v; // unassigned
	T t[2];
	highp uint u;
} block[2];

void main (void)
{
	block[0].s.a[0] = -89.0f;
	block[0].s.a[1] = 30.0f;
	block[0].t[0].a = mat2(-70.0, -60.0, 72.0, -102.0);
	block[0].t[0].b[0].a[0] = -100.0f;
	block[0].t[0].b[0].a[1] = 84.0f;
	block[0].t[0].b[1].a[0] = -31.0f;
	block[0].t[0].b[1].a[1] = 68.0f;
	block[0].t[1].a = mat2(104.0, 14.0, 83.0, -117.0);
	block[0].t[1].b[0].a[0] = 75.0f;
	block[0].t[1].b[0].a[1] = 12.0f;
	block[0].t[1].b[1].a[0] = -18.0f;
	block[0].t[1].b[1].a[1] = -101.0f;
	block[0].u = 100u;
	block[1].s.a[0] = -34.0f;
	block[1].s.a[1] = -35.0f;
	block[1].t[0].a = mat2(-43.0, 48.0, 4.0, -60.0);
	block[1].t[0].b[0].a[0] = 37.0f;
	block[1].t[0].b[0].a[1] = 52.0f;
	block[1].t[0].b[1].a[0] = 98.0f;
	block[1].t[0].b[1].a[1] = -80.0f;
	block[1].t[1].a = mat2(-62.0, -54.0, -79.0, 3.0);
	block[1].t[1].b[0].a[0] = -97.0f;
	block[1].t[1].b[0].a[1] = -118.0f;
	block[1].t[1].b[1].a[0] = -108.0f;
	block[1].t[1].b[1].a[1] = -120.0f;
	block[1].u = 48u;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	highp float a[2];
};
struct T
{
	mediump mat2 a;
	S b[2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 84) out Block // sizeInBytes=84 sizeInLocations=16
{
	S s;
	lowp vec2 v; // unassigned
	T t[2];
	highp uint u;
} block[2];

void main (void)
{
	block[0].s.a[0] = -89.0f;
	block[0].s.a[1] = 30.0f;
	block[0].t[0].a = mat2(-70.0, -60.0, 72.0, -102.0);
	block[0].t[0].b[0].a[0] = -100.0f;
	block[0].t[0].b[0].a[1] = 84.0f;
	block[0].t[0].b[1].a[0] = -31.0f;
	block[0].t[0].b[1].a[1] = 68.0f;
	block[0].t[1].a = mat2(104.0, 14.0, 83.0, -117.0);
	block[0].t[1].b[0].a[0] = 75.0f;
	block[0].t[1].b[0].a[1] = 12.0f;
	block[0].t[1].b[1].a[0] = -18.0f;
	block[0].t[1].b[1].a[1] = -101.0f;
	block[0].u = 100u;
	block[1].s.a[0] = -34.0f;
	block[1].s.a[1] = -35.0f;
	block[1].t[0].a = mat2(-43.0, 48.0, 4.0, -60.0);
	block[1].t[0].b[0].a[0] = 37.0f;
	block[1].t[0].b[0].a[1] = 52.0f;
	block[1].t[0].b[1].a[0] = 98.0f;
	block[1].t[0].b[1].a[1] = -80.0f;
	block[1].t[1].a = mat2(-62.0, -54.0, -79.0, 3.0);
	block[1].t[1].b[0].a[0] = -97.0f;
	block[1].t[1].b[0].a[1] = -118.0f;
	block[1].t[1].b[1].a[0] = -108.0f;
	block[1].t[1].b[1].a[1] = -120.0f;
	block[1].u = 48u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp float var;
} block[3];

void main (void)
{
	block[0].var = -89.0f;
	block[1].var = 30.0f;
	block[2].var = -70.0f;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp float var;
} block[3];

void main (void)
{
	block[0].var = -89.0f;
	block[1].var = 30.0f;
	block[2].var = -70.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp int var;
} block[3];

void main (void)
{
	block[0].var = -89;
	block[1].var = 30;
	block[2].var = -70;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp int var;
} block[3];

void main (void)
{
	block[0].var = -89;
	block[1].var = 30;
	block[2].var = -70;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp ivec2 var;
} block[3];

void main (void)
{
	block[0].var = ivec2(-89, 30);
	block[1].var = ivec2(-70, -60);
	block[2].var = ivec2(72, -102);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16) out Block // sizeInBytes=16 sizeInLocations=1
{
	highp ivec4 var;
} block[3];

void main (void)
{
	block[0].var = ivec4(-89, 30, -70, -60);
	block[1].var = ivec4(72, -102, -100, 84);
	block[2].var = ivec4(-31, 68, 104, 14);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 4) out Block // sizeInBytes=4 sizeInLocations=1
{
	highp uint var;
} block[3];

void main (void)
{
	block[0].var = 89u;
	block[1].var = 30u;
	block[2].var = 70u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 var;
} block[3];

void main (void)
{
	block[0].var = uvec2(89u, 30u);
	block[1].var = uvec2(70u, 60u);
	block[2].var = uvec2(72u, 102u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out Block // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 var;
} block[3];

void main (void)
{
	block[0].var = uvec2(89u, 30u);
	block[1].var = uvec2(70u, 60u);
	block[2].var = uvec2(72u, 102u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 12) out Block // sizeInBytes=12 sizeInLocations=1
{
	highp uvec3 var;
} block[3];

void main (void)
{
	block[0].var = uvec3(89u, 30u, 70u);
	block[1].var = uvec3(60u, 72u, 102u);
	block[2].var = uvec3(100u, 84u, 31u);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 36) out Block // sizeInBytes=36 sizeInLocations=3
{
	highp mat3 var;
} block[3];

void main (void)
{
	block[0].var = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	block[1].var = mat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	block[2].var = mat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 64) out Block // sizeInBytes=64 sizeInLocations=4
{
	highp mat4 var;
} block[3];

void main (void)
{
	block[0].var = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	block[1].var = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	block[2].var = mat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 24) out Block // sizeInBytes=24 sizeInLocations=2
{
	highp mat2x3 var;
} block[3];

void main (void)
{
	block[0].var = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	block[1].var = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	block[2].var = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 48) out Block // sizeInBytes=48 sizeInLocations=3
{
	highp mat3x4 var;
} block[3];

void main (void)
{
	block[0].var = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	block[1].var = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	block[2].var = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 48) out Block // sizeInBytes=48 sizeInLocations=4
{
	highp mat4x3 var;
} block[3];

void main (void)
{
	block[0].var = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	block[1].var = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	block[2].var = mat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out Block // sizeInBytes=8 sizeInLocations=1
{
	double var;
} block[3];

void main (void)
{
	block[0].var = -89.0;
	block[1].var = 30.0;
	block[2].var = -70.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16) out Block // sizeInBytes=16 sizeInLocations=1
{
	dvec2 var;
} block[3];

void main (void)
{
	block[0].var = dvec2(-89.0, 30.0);
	block[1].var = dvec2(-70.0, -60.0);
	block[2].var = dvec2(72.0, -102.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16) out Block // sizeInBytes=16 sizeInLocations=1
{
	dvec2 var;
} block[3];

void main (void)
{
	block[0].var = dvec2(-89.0, 30.0);
	block[1].var = dvec2(-70.0, -60.0);
	block[2].var = dvec2(72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 24) out Block // sizeInBytes=24 sizeInLocations=2
{
	dvec3 var;
} block[3];

void main (void)
{
	block[0].var = dvec3(-89.0, 30.0, -70.0);
	block[1].var = dvec3(-60.0, 72.0, -102.0);
	block[2].var = dvec3(-100.0, 84.0, -31.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 24) out Block // sizeInBytes=24 sizeInLocations=2
{
	dvec3 var;
} block[3];

void main (void)
{
	block[0].var = dvec3(-89.0, 30.0, -70.0);
	block[1].var = dvec3(-60.0, 72.0, -102.0);
	block[2].var = dvec3(-100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 32) out Block // sizeInBytes=32 sizeInLocations=2
{
	dmat2 var;
} block[3];

void main (void)
{
	block[0].var = dmat2(-89.0, 30.0, -70.0, -60.0);
	block[1].var = dmat2(72.0, -102.0, -100.0, 84.0);
	block[2].var = dmat2(-31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 32) out Block // sizeInBytes=32 sizeInLocations=2
{
	dmat2 var;
} block[3];

void main (void)
{
	block[0].var = dmat2(-89.0, 30.0, -70.0, -60.0);
	block[1].var = dmat2(72.0, -102.0, -100.0, 84.0);
	block[2].var = dmat2(-31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 48) out Block // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 var;
} block[3];

void main (void)
{
	block[0].var = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	block[1].var = dmat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	block[2].var = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 64) out Block // sizeInBytes=64 sizeInLocations=4
{
	dmat2x4 var;
} block[3];

void main (void)
{
	block[0].var = dmat2x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	block[1].var = dmat2x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	block[2].var = dmat2x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 64) out Block // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 var;
} block[3];

void main (void)
{
	block[0].var = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	block[1].var = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	block[2].var = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 96) out Block // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 var;
} block[3];

void main (void)
{
	block[0].var = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	block[1].var = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	block[2].var = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockA // sizeInBytes=32 sizeInLocations=4
{
	highp float a;
	lowp uvec3 b; // unassigned
	mediump mat2 c;
} blockA;
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unassigned
	int d;
} blockB;

void main (void)
{
	blockA.a = -89.0f;
	blockA.c = mat2(30.0, -70.0, -60.0, 72.0);
	blockB.a = mat3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB.b = ivec2(75, 12);
	blockB.d = -18;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 96) out BlockA // sizeInBytes=32 sizeInLocations=4
{
	highp float a;
	lowp uvec3 b; // unassigned
	mediump mat2 c;
} blockA[2];
layout(location = 8, xfb_buffer = 0, xfb_offset = 32, xfb_stride = 96) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	mediump mat3 a;
	lowp ivec2 b;
	highp vec4 c; // unassigned
	int d;
} blockB[2];

void main (void)
{
	blockA[0].a = -89.0f;
	blockA[0].c = mat2(30.0, -70.0, -60.0, 72.0);
	blockA[1].a = -102.0f;
	blockA[1].c = mat2(-100.0, 84.0, -31.0, 68.0);
	blockB[0].a = mat3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockB[0].b = ivec2(-34, -35);
	blockB[0].d = -43;
	blockB[1].a = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	blockB[1].b = ivec2(-79, 3);
	blockB[1].d = -97;
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp mat2 a;
	mediump ivec2 b[2];
};
struct T
{
	mediump uint a; // unassigned
	S b;
	uvec3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockA // sizeInBytes=40 sizeInLocations=6
{
	highp float a;
	S b;
	lowp uint c; // unassigned
} blockA;
layout(location = 6, xfb_buffer = 0, xfb_offset = 40) out BlockB // sizeInBytes=68 sizeInLocations=9
{
	mediump mat2 a;
	T b;
	int c;
} blockB;

void main (void)
{
	blockA.a = -89.0f;
	blockA.b.a = mat2(30.0, -70.0, -60.0, 72.0);
	blockA.b.b[0] = ivec2(-102, -100);
	blockA.b.b[1] = ivec2(84, -31);
	blockB.a = mat2(68.0, 104.0, 14.0, 83.0);
	blockB.b.b.a = mat2(-117.0, 75.0, 12.0, -18.0);
	blockB.b.b.b[0] = ivec2(-101, 100);
	blockB.b.b.b[1] = ivec2(-34, -35);
	blockB.b.c = uvec3(43u, 48u, 4u);
	blockB.c = -60;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp mat2 a;
	mediump ivec2 b[2];
};
struct T
{
	mediump uint a; // unassigned
	S b;
	uvec3 c;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 108) out BlockA // sizeInBytes=40 sizeInLocations=6
{
	highp float a;
	S b;
	lowp uint c; // unassigned
} blockA[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 40, xfb_stride = 108) out BlockB // sizeInBytes=68 sizeInLocations=9
{
	mediump mat2 a;
	T b;
	int c;
} blockB[2];

void main (void)
{
	blockA[0].a = -89.0f;
	blockA[0].b.a = mat2(30.0, -70.0, -60.0, 72.0);
	blockA[0].b.b[0] = ivec2(-102, -100);
	blockA[0].b.b[1] = ivec2(84, -31);
	blockA[1].a = 68.0f;
	blockA[1].b.a = mat2(104.0, 14.0, 83.0, -117.0);
	blockA[1].b.b[0] = ivec2(75, 12);
	blockA[1].b.b[1] = ivec2(-18, -101);
	blockB[0].a = mat2(100.0, -34.0, -35.0, -43.0);
	blockB[0].b.b.a = mat2(48.0, 4.0, -60.0, 37.0);
	blockB[0].b.b.b[0] = ivec2(52, 98);
	blockB[0].b.b.b[1] = ivec2(-80, -62);
	blockB[0].b.c = uvec3(54u, 79u, 3u);
	blockB[0].c = -97;
	blockB[1].a = mat2(-118.0, -108.0, -120.0, 48.0);
	blockB[1].b.b.a = mat2(-71.0, -59.0, -40.0, -62.0);
	blockB[1].b.b.b[0] = ivec2(114, -109);
	blockB[1].b.b.b[1] = ivec2(-51, 32);
	blockB[1].b.c = uvec3(113u, 44u, 77u);
	blockB[1].c = -11;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA;
layout(location = 8, xfb_buffer = 0, xfb_offset = 60) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA.a = -89;
	blockA.b.a[0] = 30.0f;
	blockA.b.a[1] = -70.0f;
	blockA.b.a[2] = -60.0f;
	blockA.b.b[0] = vec2(72.0f, -102.0f);
	blockA.b.b[1] = vec2(-100.0f, 84.0f);
	blockA.b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockB.a = mat2(83.0, -117.0, 75.0, 12.0);
	blockB.b.b = ivec3(-18, -101, 100);
	blockB.d = -34;
	blockC.a = 35u;
	blockC.b = mat2(-43.0, 48.0, 4.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 132) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 16, xfb_buffer = 0, xfb_offset = 60, xfb_stride = 132) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 28, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -89;
	blockA[0].b.a[0] = 30.0f;
	blockA[0].b.a[1] = -70.0f;
	blockA[0].b.a[2] = -60.0f;
	blockA[0].b.b[0] = vec2(72.0f, -102.0f);
	blockA[0].b.b[1] = vec2(-100.0f, 84.0f);
	blockA[0].b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockA[1].a = 83;
	blockA[1].b.a[0] = -117.0f;
	blockA[1].b.a[1] = 75.0f;
	blockA[1].b.a[2] = 12.0f;
	blockA[1].b.b[0] = vec2(-18.0f, -101.0f);
	blockA[1].b.b[1] = vec2(100.0f, -34.0f);
	blockA[1].b.c = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	blockB[0].a = mat2(-60.0, 37.0, 52.0, 98.0);
	blockB[0].b.b = ivec3(-80, -62, -54);
	blockB[0].d = -79;
	blockB[1].a = mat2(3.0, -97.0, -118.0, -108.0);
	blockB[1].b.b = ivec3(-120, 48, -71);
	blockB[1].d = -59;
	blockC.a = 40u;
	blockC.b = mat2(-62.0, 114.0, -109.0, -51.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA;
layout(location = 11, xfb_buffer = 1, xfb_offset = 0) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 60) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA.a = -89;
	blockA.b.a[0] = 30.0f;
	blockA.b.a[1] = -70.0f;
	blockA.b.a[2] = -60.0f;
	blockA.b.b[0] = vec2(72.0f, -102.0f);
	blockA.b.b[1] = vec2(-100.0f, 84.0f);
	blockA.b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockB.a = mat2(-101.0, 100.0, -34.0, -35.0);
	blockB.b.b = ivec3(-43, 48, 4);
	blockB.d = -60;
	blockC.a = 83u;
	blockC.b = mat2(-117.0, 75.0, 12.0, -18.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA;
layout(location = 11, xfb_buffer = 1, xfb_offset = 0) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 60) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA.a = -89;
	blockA.b.a[0] = 30.0f;
	blockA.b.a[1] = -70.0f;
	blockA.b.a[2] = -60.0f;
	blockA.b.b[0] = vec2(72.0f, -102.0f);
	blockA.b.b[1] = vec2(-100.0f, 84.0f);
	blockA.b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockB.a = mat2(-101.0, 100.0, -34.0, -35.0);
	blockB.b.b = ivec3(-43, 48, 4);
	blockB.d = -60;
	blockC.a = 83u;
	blockC.b = mat2(-117.0, 75.0, 12.0, -18.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 112) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 19, xfb_buffer = 1, xfb_offset = 60, xfb_stride = 112) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 16, xfb_buffer = 0, xfb_offset = 60) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -89;
	blockA[0].b.a[0] = 30.0f;
	blockA[0].b.a[1] = -70.0f;
	blockA[0].b.a[2] = -60.0f;
	blockA[0].b.b[0] = vec2(72.0f, -102.0f);
	blockA[0].b.b[1] = vec2(-100.0f, 84.0f);
	blockA[0].b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockA[1].a = 83;
	blockA[1].b.a[0] = -117.0f;
	blockA[1].b.a[1] = 75.0f;
	blockA[1].b.a[2] = 12.0f;
	blockA[1].b.b[0] = vec2(-18.0f, -101.0f);
	blockA[1].b.b[1] = vec2(100.0f, -34.0f);
	blockA[1].b.c = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	blockB[0].a = mat2(-62.0, -54.0, -79.0, 3.0);
	blockB[0].b.b = ivec3(-97, -118, -108);
	blockB[0].d = -120;
	blockB[1].a = mat2(48.0, -71.0, -59.0, -40.0);
	blockB[1].b.b = ivec3(-62, 114, -109);
	blockB[1].d = -51;
	blockC.a = 60u;
	blockC.b = mat2(37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 112) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 19, xfb_buffer = 1, xfb_offset = 60, xfb_stride = 112) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 16, xfb_buffer = 0, xfb_offset = 60) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -89;
	blockA[0].b.a[0] = 30.0f;
	blockA[0].b.a[1] = -70.0f;
	blockA[0].b.a[2] = -60.0f;
	blockA[0].b.b[0] = vec2(72.0f, -102.0f);
	blockA[0].b.b[1] = vec2(-100.0f, 84.0f);
	blockA[0].b.c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockA[1].a = 83;
	blockA[1].b.a[0] = -117.0f;
	blockA[1].b.a[1] = 75.0f;
	blockA[1].b.a[2] = 12.0f;
	blockA[1].b.b[0] = vec2(-18.0f, -101.0f);
	blockA[1].b.b[1] = vec2(100.0f, -34.0f);
	blockA[1].b.c = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	blockB[0].a = mat2(-62.0, -54.0, -79.0, 3.0);
	blockB[0].b.b = ivec3(-97, -118, -108);
	blockB[0].d = -120;
	blockB[1].a = mat2(48.0, -71.0, -59.0, -40.0);
	blockB[1].b.b = ivec3(-62, 114, -109);
	blockB[1].d = -51;
	blockC.a = 60u;
	blockC.b = mat2(37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 15, xfb_buffer = 1, xfb_offset = 52, xfb_stride = 112) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 112) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 52) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -43;
	blockA[0].b.a[0] = 48.0f;
	blockA[0].b.a[1] = 4.0f;
	blockA[0].b.a[2] = -60.0f;
	blockA[0].b.b[0] = vec2(37.0f, 52.0f);
	blockA[0].b.b[1] = vec2(98.0f, -80.0f);
	blockA[0].b.c = vec4(-62.0f, -54.0f, -79.0f, 3.0f);
	blockA[1].a = -97;
	blockA[1].b.a[0] = -118.0f;
	blockA[1].b.a[1] = -108.0f;
	blockA[1].b.a[2] = -120.0f;
	blockA[1].b.b[0] = vec2(48.0f, -71.0f);
	blockA[1].b.b[1] = vec2(-59.0f, -40.0f);
	blockA[1].b.c = vec4(-62.0f, 114.0f, -109.0f, -51.0f);
	blockB[0].a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b.b = ivec3(72, -102, -100);
	blockB[0].d = 84;
	blockB[1].a = mat2(-31.0, 68.0, 104.0, 14.0);
	blockB[1].b.b = ivec3(83, -117, 75);
	blockB[1].d = 12;
	blockC.a = 18u;
	blockC.b = mat2(-101.0, 100.0, -34.0, -35.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 3, xfb_buffer = 1, xfb_offset = 0) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA;
layout(location = 11, xfb_buffer = 1, xfb_offset = 60) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB;
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA.a = -102;
	blockA.b.a[0] = -100.0f;
	blockA.b.a[1] = 84.0f;
	blockA.b.a[2] = -31.0f;
	blockA.b.b[0] = vec2(68.0f, 104.0f);
	blockA.b.b[1] = vec2(14.0f, 83.0f);
	blockA.b.c = vec4(-117.0f, 75.0f, 12.0f, -18.0f);
	blockB.a = mat2(-101.0, 100.0, -34.0, -35.0);
	blockB.b.b = ivec3(-43, 48, 4);
	blockB.d = -60;
	blockC.a = 89u;
	blockC.b = mat2(30.0, -70.0, -60.0, 72.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 3, xfb_buffer = 1, xfb_offset = 0) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA;
layout(location = 11, xfb_buffer = 1, xfb_offset = 60) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB;
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA.a = -102;
	blockA.b.a[0] = -100.0f;
	blockA.b.a[1] = 84.0f;
	blockA.b.a[2] = -31.0f;
	blockA.b.b[0] = vec2(68.0f, 104.0f);
	blockA.b.b[1] = vec2(14.0f, 83.0f);
	blockA.b.c = vec4(-117.0f, 75.0f, 12.0f, -18.0f);
	blockB.a = mat2(-101.0, 100.0, -34.0, -35.0);
	blockB.b.b = ivec3(-43, 48, 4);
	blockB.d = -60;
	blockC.a = 89u;
	blockC.b = mat2(30.0, -70.0, -60.0, 72.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 112) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 19, xfb_buffer = 1, xfb_offset = 60, xfb_stride = 112) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -102;
	blockA[0].b.a[0] = -100.0f;
	blockA[0].b.a[1] = 84.0f;
	blockA[0].b.a[2] = -31.0f;
	blockA[0].b.b[0] = vec2(68.0f, 104.0f);
	blockA[0].b.b[1] = vec2(14.0f, 83.0f);
	blockA[0].b.c = vec4(-117.0f, 75.0f, 12.0f, -18.0f);
	blockA[1].a = -101;
	blockA[1].b.a[0] = 100.0f;
	blockA[1].b.a[1] = -34.0f;
	blockA[1].b.a[2] = -35.0f;
	blockA[1].b.b[0] = vec2(-43.0f, 48.0f);
	blockA[1].b.b[1] = vec2(4.0f, -60.0f);
	blockA[1].b.c = vec4(37.0f, 52.0f, 98.0f, -80.0f);
	blockB[0].a = mat2(-62.0, -54.0, -79.0, 3.0);
	blockB[0].b.b = ivec3(-97, -118, -108);
	blockB[0].d = -120;
	blockB[1].a = mat2(48.0, -71.0, -59.0, -40.0);
	blockB[1].b.b = ivec3(-62, 114, -109);
	blockB[1].d = -51;
	blockC.a = 89u;
	blockC.b = mat2(30.0, -70.0, -60.0, 72.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct S
{
	lowp float a[3];
	mediump vec2 b[2];
	highp vec4 c;
};
struct T
{
	mediump uint a; // unassigned
	ivec3 b;
};
layout(location = 3, xfb_buffer = 1, xfb_offset = 0, xfb_stride = 112) out BlockA // sizeInBytes=60 sizeInLocations=8
{
	highp int a;
	S b;
	lowp uvec3 c; // unassigned
} blockA[2];
layout(location = 19, xfb_buffer = 1, xfb_offset = 60, xfb_stride = 112) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	mediump mat2 a;
	T b;
	ivec4 c; // unassigned
	int d;
} blockB[2];
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	highp uint a;
	highp mat2 b;
} blockC;

void main (void)
{
	blockA[0].a = -102;
	blockA[0].b.a[0] = -100.0f;
	blockA[0].b.a[1] = 84.0f;
	blockA[0].b.a[2] = -31.0f;
	blockA[0].b.b[0] = vec2(68.0f, 104.0f);
	blockA[0].b.b[1] = vec2(14.0f, 83.0f);
	blockA[0].b.c = vec4(-117.0f, 75.0f, 12.0f, -18.0f);
	blockA[1].a = -101;
	blockA[1].b.a[0] = 100.0f;
	blockA[1].b.a[1] = -34.0f;
	blockA[1].b.a[2] = -35.0f;
	blockA[1].b.b[0] = vec2(-43.0f, 48.0f);
	blockA[1].b.b[1] = vec2(4.0f, -60.0f);
	blockA[1].b.c = vec4(37.0f, 52.0f, 98.0f, -80.0f);
	blockB[0].a = mat2(-62.0, -54.0, -79.0, 3.0);
	blockB[0].b.b = ivec3(-97, -118, -108);
	blockB[0].d = -120;
	blockB[1].a = mat2(48.0, -71.0, -59.0, -40.0);
	blockB[1].b.b = ivec3(-62, 114, -109);
	blockB[1].d = -51;
	blockC.a = 89u;
	blockC.b = mat2(30.0, -70.0, -60.0, 72.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp int a;
	mediump uint b; // unassigned
	mediump uint c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	lowp uint d;
	highp int e;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	lowp float f;
	lowp float g;
	lowp uint h;
} blockD;

void main (void)
{
	blockB.a = -89;
	blockB.c = 30u;
	d = 70u;
	e = -60;
	blockD.f = 72.0f;
	blockD.g = -102.0f;
	blockD.h = 100u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	lowp int a;
	highp float b;
	mediump int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	mediump float d;
	highp int e;
	mediump int f;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 24) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp int g;
} blockD;

void main (void)
{
	blockB.a = -89;
	blockB.b = 30.0f;
	blockB.c = -70;
	d = -60.0f;
	e = 72;
	f = -102;
	blockD.g = -100;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	highp int a;
	lowp uint b; // unassigned
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	mediump int c;
};

void main (void)
{
	a = -89;
	c = 30;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	highp float b;
	mediump int c;
	mediump uint d;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	lowp float e;
	mediump float f; // unassigned
	mediump float g;
} blockD;

void main (void)
{
	a = -89;
	blockC.b = 30.0f;
	blockC.c = -70;
	blockC.d = 60u;
	blockD.e = 72.0f;
	blockD.g = -102.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	highp float b; // unassigned
	highp uint c;
	mediump int d;
} blockC;

void main (void)
{
	a = 89u;
	blockC.c = 30u;
	blockC.d = -70;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};

void main (void)
{
	a = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	lowp float a; // unassigned
	mediump int b;
	mediump float c;
} blockB;

void main (void)
{
	blockB.b = -89;
	blockB.c = 30.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump uint a;
	lowp uint b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	lowp int c;
	mediump float d;
	mediump int e;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	highp int f;
	lowp int g;
} blockD;

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30u;
	c = -70;
	d = -60.0f;
	e = 72;
	blockD.f = -102;
	blockD.g = -100;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp float a;
} blockB;

void main (void)
{
	blockB.a = -89.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp float a;
	lowp float b;
	mediump float c;
};

void main (void)
{
	a = -89.0f;
	b = 30.0f;
	c = -70.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	lowp uint a;
	mediump int b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	mediump int c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	highp float d; // unassigned
	highp int e;
};

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30;
	c = -70;
	e = -60;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump int a;
	lowp float b;
} blockB;

void main (void)
{
	blockB.a = -89;
	blockB.b = 30.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	mediump int a;
	mediump int b;
	highp int c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	mediump int d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	highp uint e;
	lowp uint f;
	highp float g;
} blockD;

void main (void)
{
	a = -89;
	b = 30;
	c = -70;
	d = -60;
	blockD.e = 72u;
	blockD.f = 102u;
	blockD.g = -100.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};

void main (void)
{
	a = -89;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp uint a;
	lowp int b;
	lowp uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump int d;
	mediump int e;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp float f;
};

void main (void)
{
	a = 89u;
	b = 30;
	c = 70u;
	d = -60;
	e = 72;
	f = -102.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp uint b;
} blockC;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	lowp uint c;
} blockD;

void main (void)
{
	a = -89;
	blockC.b = 30u;
	blockD.c = 70u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	highp float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	mediump uint b;
	mediump float c; // unassigned
	mediump uint d;
};

void main (void)
{
	blockB.a = -89.0f;
	b = 30u;
	d = 70u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp uint a;
	highp int b;
	lowp float c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	lowp float d;
	highp int e;
	highp int f;
};

void main (void)
{
	a = 89u;
	b = 30;
	c = -70.0f;
	d = -60.0f;
	e = 72;
	f = -102;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump float a;
	mediump int b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	highp int c;
	mediump uint d;
	mediump int e; // unassigned
} blockC;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30;
	blockC.c = -70;
	blockC.d = 60u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp float a;
	mediump int b;
	highp int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump uint d;
	lowp float e;
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	lowp int f;
	lowp float g;
};

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30;
	blockB.c = -70;
	blockC.d = 60u;
	blockC.e = 72.0f;
	f = -102;
	g = -100.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	lowp int a; // unassigned
	mediump float b;
};

void main (void)
{
	b = -89.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump uint a;
	lowp float b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp uint c;
} blockC;

void main (void)
{
	a = 89u;
	b = 30.0f;
	blockC.c = 70u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	mediump int a;
	mediump int b;
	highp int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp int d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	highp float e; // unassigned
	lowp uint f;
	mediump uint g;
} blockD;

void main (void)
{
	blockB.a = -89;
	blockB.b = 30;
	blockB.c = -70;
	d = -60;
	blockD.f = 72u;
	blockD.g = 102u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp ivec3 a;
	lowp int b;
	mediump ivec2 c;
};

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = -60;
	c = ivec2(72, -102);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	highp ivec4 a;
	highp ivec2 b;
	mediump uvec2 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	highp vec4 d;
	lowp ivec2 e;
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockD // sizeInBytes=28 sizeInLocations=3
{
	lowp vec4 f;
	highp int g;
	lowp vec2 h;
};

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b = ivec2(72, -102);
	blockB.c = uvec2(100u, 84u);
	blockC.d = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockC.e = ivec2(83, -117);
	f = vec4(75.0f, 12.0f, -18.0f, -101.0f);
	g = 100;
	h = vec2(-34.0f, -35.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump uint a; // unassigned
	highp int b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	mediump vec2 c;
};

void main (void)
{
	blockB.b = -89;
	c = vec2(30.0f, -70.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	highp float a;
	highp ivec2 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp float d;
};

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = ivec2(30, -70);
	blockC.c = ivec4(-60, 72, -102, -100);
	d = 84.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	mediump vec3 a;
	highp uint b;
};

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = 60u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=28 sizeInLocations=2
{
	highp ivec4 b;
	mediump vec3 c; // unassigned
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=28 sizeInLocations=3
{
	mediump uint d;
	highp vec4 e;
	lowp uvec2 f;
};

void main (void)
{
	blockB.a = -89.0f;
	b = ivec4(30, -70, -60, 72);
	d = 102u;
	e = vec4(-100.0f, 84.0f, -31.0f, 68.0f);
	f = uvec2(104u, 14u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	lowp uvec4 a; // unassigned
	highp uint b;
};

void main (void)
{
	b = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	mediump int a;
	mediump ivec4 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 20) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	mediump uvec4 c;
	highp uvec4 d; // unassigned
	lowp uvec4 e;
} blockC;

void main (void)
{
	blockB.a = -89;
	blockB.b = ivec4(30, -70, -60, 72);
	blockC.c = uvec4(102u, 100u, 84u, 31u);
	blockC.e = uvec4(68u, 104u, 14u, 83u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=3
{
	highp vec2 a;
	lowp int b;
	lowp uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=20 sizeInLocations=2
{
	highp uvec2 e; // unassigned
	highp ivec3 f;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = -70;
	c = 60u;
	d = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	f = ivec3(-31, 68, 104);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	lowp uvec2 a;
	highp int b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	mediump uvec3 c;
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = -70;
	c = uvec3(60u, 72u, 102u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	highp uvec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	mediump ivec3 b;
	lowp vec3 c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	lowp vec2 d;
	highp vec4 e; // unassigned
};

void main (void)
{
	a = uvec4(89u, 30u, 70u, 60u);
	blockC.b = ivec3(72, -102, -100);
	blockC.c = vec3(84.0f, -31.0f, 68.0f);
	d = vec2(104.0f, 14.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump uvec3 b;
	mediump uint c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 d;
};

void main (void)
{
	a = -89;
	blockC.b = uvec3(30u, 70u, 60u);
	blockC.c = 72u;
	d = uvec4(102u, 100u, 84u, 31u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	highp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=16 sizeInLocations=3
{
	highp int b;
	highp uint c;
	mediump vec2 d;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp uvec3 e;
};

void main (void)
{
	a = -89;
	blockC.b = 30;
	blockC.c = 70u;
	blockC.d = vec2(-60.0f, 72.0f);
	e = uvec3(102u, 100u, 84u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	mediump int a;
	lowp ivec4 b;
	mediump ivec2 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	mediump vec2 d;
};

void main (void)
{
	blockB.a = -89;
	blockB.b = ivec4(30, -70, -60, 72);
	blockB.c = ivec2(-102, -100);
	d = vec2(84.0f, -31.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	mediump uvec4 a;
	mediump ivec2 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	mediump ivec3 c;
	mediump ivec3 d;
	highp ivec4 e; // unassigned
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 f;
};

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = ivec2(72, -102);
	blockC.c = ivec3(-100, 84, -31);
	blockC.d = ivec3(68, 104, 14);
	f = vec4(83.0f, -117.0f, 75.0f, 12.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	highp ivec2 a;
	lowp int b;
	lowp vec3 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump uint d;
	highp uvec3 e; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	mediump ivec2 f;
	mediump ivec4 g;
};

void main (void)
{
	a = ivec2(-89, 30);
	b = -70;
	c = vec3(-60.0f, 72.0f, -102.0f);
	d = 100u;
	f = ivec2(84, -31);
	g = ivec4(68, 104, 14, 83);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp vec3 a;
	lowp float b;
	mediump vec2 c;
} blockB;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = -60.0f;
	blockB.c = vec2(72.0f, -102.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	lowp ivec4 a;
	lowp vec4 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	highp vec4 c;
};

void main (void)
{
	a = ivec4(-89, 30, -70, -60);
	b = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=28 sizeInLocations=3
{
	highp vec3 b;
	highp ivec2 c;
	highp vec2 d;
};

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	b = vec3(-60.0f, 72.0f, -102.0f);
	c = ivec2(-100, 84);
	d = vec2(-31.0f, 68.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	highp ivec4 b;
	highp vec3 c;
	highp uvec2 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 44) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 e;
} blockD;

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = ivec4(-70, -60, 72, -102);
	c = vec3(-100.0f, 84.0f, -31.0f);
	d = uvec2(68u, 104u);
	blockD.e = vec3(14.0f, 83.0f, -117.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	highp ivec4 a;
	highp uvec4 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	mediump uvec2 c;
	highp int d;
	mediump ivec2 e;
};

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b = uvec4(72u, 102u, 100u, 84u);
	c = uvec2(31u, 68u);
	d = 104;
	e = ivec2(14, 83);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	lowp ivec4 a;
	highp vec2 b;
} blockB;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b = vec2(72.0f, -102.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	highp uvec3 a;
	lowp uvec3 b;
	lowp uvec4 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp float d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 44) out BlockD // sizeInBytes=28 sizeInLocations=2
{
	highp uvec3 e;
	highp ivec4 f;
};

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b = uvec3(60u, 72u, 102u);
	c = uvec4(100u, 84u, 31u, 68u);
	d = 104.0f;
	e = uvec3(14u, 83u, 117u);
	f = ivec4(75, 12, -18, -101);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=5
{
	dvec2 a;
	mediump mat3x2 b; // unassigned
	mediump vec2 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	c = vec2(-70.0f, -60.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
} blockB;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	lowp float a;
	mediump uvec2 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	dmat4 c;
};

void main (void)
{
	a = -89.0f;
	b = uvec2(30u, 70u);
	c = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec2 a; // unassigned
	dvec2 b;
} blockB;

void main (void)
{
	blockB.b = dvec2(-89.0, 30.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dvec4 a;
	lowp mat3 b; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 c;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	highp ivec4 d;
};

void main (void)
{
	a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockC.c = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	d = ivec4(-18, -101, 100, -34);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	dmat3x4 a;
	highp uvec2 b;
} blockB;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = uvec2(83u, 117u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=9
{
	double a;
	dmat3 b;
	dmat2 c;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	dmat3 d;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 184) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 e;
};

void main (void)
{
	blockB.a = -89.0;
	blockB.b = dmat3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockB.c = dmat2(104.0, 14.0, 83.0, -117.0);
	blockC.d = dmat3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = dmat3x2(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	lowp uint a;
	highp vec4 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 20) out BlockC // sizeInBytes=36 sizeInLocations=4
{
	highp uvec3 c;
	mediump mat3x2 d; // unassigned
};

void main (void)
{
	a = 89u;
	b = vec4(30.0f, -70.0f, -60.0f, 72.0f);
	c = uvec3(102u, 100u, 84u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	highp mat2x3 a;
} blockB;

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=5
{
	lowp mat3x4 a; // unassigned
	mediump ivec4 b;
	dvec2 c;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	mediump mat2 d;
	dvec4 e;
	mediump vec2 f;
} blockC;

void main (void)
{
	b = ivec4(-89, 30, -70, -60);
	c = dvec2(72.0, -102.0);
	blockC.d = mat2(-100.0, 84.0, -31.0, 68.0);
	blockC.e = dvec4(104.0, 14.0, 83.0, -117.0);
	blockC.f = vec2(75.0f, 12.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump ivec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=92 sizeInLocations=6
{
	lowp vec4 b;
	highp mat4 c;
	highp uvec3 d;
} blockC;

void main (void)
{
	a = ivec2(-89, 30);
	blockC.b = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
	blockC.c = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = uvec3(48u, 4u, 60u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	lowp mat2x3 a;
	dmat3x2 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=12 sizeInLocations=2
{
	mediump float c;
	mediump ivec2 d;
};

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = 83.0f;
	d = ivec2(-117, 75);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=15
{
	dmat4x3 a;
	dmat2x3 b; // unassigned
	highp mat3x4 c;
} blockB;
layout(location = 15, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	lowp mat4 d;
	mediump mat4 e;
} blockC;
layout(location = 23, xfb_buffer = 0, xfb_offset = 320) out BlockD // sizeInBytes=56 sizeInLocations=5
{
	highp uvec4 f;
	lowp mat3x2 g; // unassigned
	mediump ivec4 h;
} blockD;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.c = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.d = mat4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC.e = mat4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	blockD.f = uvec4(46u, 122u, 97u, 108u);
	blockD.h = ivec4(-127, -10, 113, -60);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	dvec2 b;
	dvec3 c;
} blockC;

void main (void)
{
	a = 89u;
	blockC.b = dvec2(30.0, -70.0);
	blockC.c = dvec3(-60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=52 sizeInLocations=4
{
	mediump mat3x4 b;
	highp uint c;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 d;
} blockD;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = 100u;
	blockD.d = dmat3x4(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=7
{
	dmat2x3 a;
	mediump mat3x2 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 c;
} blockC;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	highp vec2 a;
	highp uvec4 b;
} blockB;

void main (void)
{
	blockB.a = vec2(-89.0f, 30.0f);
	blockB.b = uvec4(70u, 60u, 72u, 102u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat2 a;
	highp uvec4 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=232 sizeInLocations=17
{
	lowp uint c; // unassigned
	dmat4x3 d;
	dmat4 e;
};
layout(location = 20, xfb_buffer = 0, xfb_offset = 280) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	lowp int f;
	mediump uint g; // unassigned
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = uvec4(72u, 102u, 100u, 84u);
	d = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	e = dmat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	f = -120;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 b;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	highp vec4 c;
	highp mat3x4 d; // unassigned
} blockD;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockC.b = dvec4(-60.0, 72.0, -102.0, -100.0);
	blockD.c = vec4(84.0f, -31.0f, 68.0f, 104.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	mediump vec3 a;
	dmat2x3 b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=200 sizeInLocations=15
{
	dmat4 c;
	lowp mat3 d;
	mediump mat4x2 e;
};
layout(location = 20, xfb_buffer = 0, xfb_offset = 264) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 f;
} blockD;

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = dmat2x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	c = dmat4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	d = mat3(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	e = mat4x2(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockD.f = dmat4x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=60 sizeInLocations=4
{
	lowp ivec3 b;
	highp mat3x4 c; // unassigned
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	lowp mat2x3 d[4];
} blockD;

void main (void)
{
	a = 89u;
	blockC.b = ivec3(30, -70, -60);
	blockD.d[0] = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockD.d[1] = mat2x3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockD.d[2] = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.d[3] = mat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	lowp mat2 a; // unassigned
	mediump ivec3 b;
	lowp uint c;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	highp vec4 d;
	dvec2 e;
} blockC;

void main (void)
{
	blockB.b = ivec3(-89, 30, -70);
	blockB.c = 60u;
	blockC.d = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	blockC.e = dvec2(-31.0, 68.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	highp int a;
	dmat3x4 b;
	lowp ivec3 c;
} blockB;

void main (void)
{
	blockB.a = -89;
	blockB.b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.c = ivec3(-117, 75, 12);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=320 sizeInLocations=26
{
	highp vec4 a; // unassigned
	dmat4x3 b[3];
	mediump ivec4 c;
};

void main (void)
{
	b[0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[2] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	c = ivec4(-120, 48, -71, -59);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=88 sizeInLocations=6
{
	highp uvec2 b;
	dmat4x2 c;
	highp ivec3 d[1];
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=52 sizeInLocations=6
{
	lowp mat4x2 e;
	mediump uint f;
	lowp ivec4 g;
} blockD;

void main (void)
{
	blockB.a = -89.0f;
	b = uvec2(30u, 70u);
	c = dmat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	d[0] = ivec3(14, 83, -117);
	blockD.e = mat4x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.f = 48u;
	blockD.g = ivec4(4, -60, 37, 52);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	dvec3 a;
	highp mat4x2 b;
};

void main (void)
{
	a = dvec3(-89.0, 30.0, -70.0);
	b = mat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=17
{
	dvec2 a;
	dmat4 b;
	dmat4x3 c[1];
} blockB;

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB.c[0] = dmat4x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	dvec2 a;
	lowp ivec2 b;
	highp ivec4 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = ivec2(-70, -60);
	c = ivec4(72, -102, -100, 84);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	lowp mat3x2 a;
	dmat4x2 b[1];
	dmat2x3 c;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 d;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	highp vec4 e;
} blockD;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b[0] = dmat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB.c = dmat2x3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.d = mat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.e = vec4(-80.0f, -62.0f, -54.0f, -79.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	dmat3x4 a;
	dvec3 b;
} blockB;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dvec3(83.0, -117.0, 75.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 b;
} blockC;

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b = mat2(68.0, 104.0, 14.0, 83.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	highp mat4x3 a;
	mediump int b;
	dvec4 c;
} blockB;

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = 83;
	blockB.c = dvec4(-117.0, 75.0, 12.0, -18.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=184 sizeInLocations=12
{
	dvec3 a;
	dmat4x2 b;
	dmat3x4 c; // unassigned
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockB.b = dmat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	mediump ivec2 a;
	mediump vec2 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=216 sizeInLocations=18
{
	dmat3 c[2];
	lowp mat3x4 d;
	highp mat3x2 e;
} blockC;

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = vec2(-70.0f, -60.0f);
	blockC.c[0] = dmat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockC.c[1] = dmat3(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = mat3x4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	blockC.e = mat3x2(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	mediump vec4 a; // unassigned
	highp vec3 b;
	highp uint c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	dvec4 d;
	mediump mat4 e;
	highp mat4x3 f;
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 176) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	lowp mat3 g;
	mediump uvec3 h; // unassigned
} blockD;

void main (void)
{
	blockB.b = vec3(-89.0f, 30.0f, -70.0f);
	blockB.c = 60u;
	d = dvec4(72.0, -102.0, -100.0, 84.0);
	e = mat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	f = mat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD.g = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	dmat4x3 a;
	lowp vec2 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	dvec4 c; // unassigned
	dmat3x2 d;
} blockC;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = vec2(83.0f, -117.0f);
	blockC.d = dmat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	dmat2x3 b;
	double c;
	lowp float d; // unassigned
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = 100.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	mediump mat4x3 a;
	mediump uvec2 b;
	double c;
};

void main (void)
{
	a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = uvec2(83u, 117u);
	c = 75.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=7
{
	highp mat4x2 a;
	double b;
	dmat2 c;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	mediump mat4 d;
	mediump vec4 e;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	mediump uvec4 f;
	highp uvec4 g; // unassigned
	mediump float h;
} blockD;

void main (void)
{
	blockB.a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = -31.0;
	blockB.c = dmat2(68.0, 104.0, 14.0, 83.0);
	d = mat4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	e = vec4(-62.0f, -54.0f, -79.0f, 3.0f);
	blockD.f = uvec4(97u, 118u, 108u, 120u);
	blockD.h = 48.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	dvec2 a; // unassigned
	mediump uint b;
	mediump uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	dmat4 d;
};

void main (void)
{
	b = 89u;
	c = 30u;
	d = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat2x3 a;
	highp mat4x3 b; // unassigned
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	lowp uvec4 c;
	highp vec3 d;
	dvec4 e;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=104 sizeInLocations=7
{
	dvec3 f;
	dmat4x2 g;
	mediump ivec4 h;
} blockD;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = uvec4(100u, 84u, 31u, 68u);
	d = vec3(104.0f, 14.0f, 83.0f);
	e = dvec4(-117.0, 75.0, 12.0, -18.0);
	blockD.f = dvec3(-101.0, 100.0, -34.0);
	blockD.g = dmat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.h = ivec4(-80, -62, -54, -79);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=212 sizeInLocations=14
{
	mediump int a[1];
	lowp mat3x4 b[4];
	lowp vec4 c;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 216) out BlockC // sizeInBytes=128 sizeInLocations=9
{
	highp vec4 d;
	highp uvec3 e[4];
	dmat4x2 f;
};

void main (void)
{
	blockB.a[0] = -89;
	blockB.b[0] = mat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.b[1] = mat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockB.b[2] = mat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockB.b[3] = mat3x4(48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0);
	blockB.c = vec4(-11.0f, 66.0f, -11.0f, 87.0f);
	d = vec4(-87.0f, 87.0f, 95.0f, -46.0f);
	e[0] = uvec3(122u, 97u, 108u);
	e[1] = uvec3(127u, 10u, 113u);
	e[2] = uvec3(60u, 58u, 109u);
	e[3] = uvec3(38u, 103u, 63u);
	f = dmat4x2(-6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dmat2 a;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	lowp mat2x3 a;
};

void main (void)
{
	a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	dvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	lowp mat4 b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=24 sizeInLocations=3
{
	highp mat3x2 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = mat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	mediump vec4 b;
	mediump uvec2 c; // unassigned
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = vec4(72.0f, -102.0f, -100.0f, 84.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	lowp uvec2 a;
	dmat4x2 b;
} blockB;

void main (void)
{
	blockB.a = uvec2(89u, 30u);
	blockB.b = dmat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 b;
};

void main (void)
{
	blockB[0].a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 a;
} blockB;

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	dmat4 a;
	dvec2 b;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	mediump mat3x4 c;
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b = dvec2(-18.0, -101.0);
	c = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	dvec4 a;
	lowp mat3 b;
	dmat2 c;
};

void main (void)
{
	a = dvec4(-89.0, 30.0, -70.0, -60.0);
	b = mat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c = dmat2(-117.0, 75.0, 12.0, -18.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 a;
} blockB;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 104) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	lowp vec3 a;
	dmat2 b;
	mediump uvec3 c;
} blockB[2];
layout(location = 8, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=40 sizeInLocations=4
{
	mediump ivec4 d;
	lowp mat3x2 e;
};

void main (void)
{
	blockB[0].a = vec3(-89.0f, 30.0f, -70.0f);
	blockB[0].b = dmat2(-60.0, 72.0, -102.0, -100.0);
	blockB[0].c = uvec3(84u, 31u, 68u);
	blockB[1].a = vec3(104.0f, 14.0f, 83.0f);
	blockB[1].b = dmat2(-117.0, 75.0, 12.0, -18.0);
	blockB[1].c = uvec3(101u, 100u, 34u);
	d = ivec4(-35, -43, 48, 4);
	e = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	lowp mat3 a;
	dmat2 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 c;
} blockC;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = dmat2(68.0, 104.0, 14.0, 83.0);
	blockC.c = ivec4(-117, 75, 12, -18);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp uvec3 a;
} blockB;

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
};

void main (void)
{
	a = dvec3(-89.0, 30.0, -70.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	lowp uint a;
	dmat3x4 b;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=64 sizeInLocations=5
{
	lowp mat2 c;
	mediump mat3x4 d;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=64 sizeInLocations=5
{
	lowp mat2 e;
	dmat2 f;
	dvec2 g; // unassigned
} blockD;

void main (void)
{
	a = 89u;
	b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockC.c = mat2(-117.0, 75.0, 12.0, -18.0);
	blockC.d = mat3x4(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockD.e = mat2(-62.0, -54.0, -79.0, 3.0);
	blockD.f = dmat2(-97.0, -118.0, -108.0, -120.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	double a;
	dmat3x2 b; // unassigned
} blockB[3];

void main (void)
{
	blockB[0].a = -89.0;
	blockB[1].a = 30.0;
	blockB[2].a = -70.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16, xfb_stride = 224) out BlockC // sizeInBytes=208 sizeInLocations=13
{
	dmat4x2 b; // unassigned
	dmat3x4 c;
	mediump mat3x4 d;
} blockC[2];

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockC[0].c = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].d = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC[1].c = dmat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC[1].d = mat3x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 24) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump ivec2 a;
} blockB[2];
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 b;
} blockC;

void main (void)
{
	blockB[0].a = ivec2(-89, 30);
	blockB[1].a = ivec2(-70, -60);
	blockC.b = vec4(72.0f, -102.0f, -100.0f, 84.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	highp ivec4 a;
	mediump uvec4 b;
} blockB[1];
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=76 sizeInLocations=5
{
	mediump ivec3 c;
	highp mat4 d; // unassigned
} blockC;

void main (void)
{
	blockB[0].a = ivec4(-89, 30, -70, -60);
	blockB[0].b = uvec4(72u, 102u, 100u, 84u);
	blockC.c = ivec3(-31, 68, 104);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	mediump ivec2 a;
	dmat2x3 b;
};

void main (void)
{
	a = ivec2(-89, 30);
	b = dmat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	lowp uvec3 a;
	highp vec4 b;
	dmat3 c;
} blockB[1];
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=52 sizeInLocations=6
{
	mediump uint d;
	highp mat3x2 e;
	lowp mat2x3 f;
} blockC[1];

void main (void)
{
	blockB[0].a = uvec3(89u, 30u, 70u);
	blockB[0].b = vec4(-60.0f, 72.0f, -102.0f, -100.0f);
	blockB[0].c = dmat3(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].d = 18u;
	blockC[0].e = mat3x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC[0].f = mat2x3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 36) out BlockC // sizeInBytes=36 sizeInLocations=5
{
	highp int b;
	mediump mat4x2 c;
} blockC;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b = 68;
	blockC.c = mat4x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	dmat4x3 a;
	dvec4 b;
	lowp uint c;
} blockB;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dvec4(83.0, -117.0, 75.0, 12.0);
	blockB.c = 18u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 128) out BlockB // sizeInBytes=128 sizeInLocations=12
{
	highp mat4x2 a;
	dmat4x3 b;
} blockB[3];

void main (void)
{
	blockB[0].a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[0].b = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB[1].a = mat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB[1].b = dmat4x3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockB[2].a = mat4x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockB[2].b = dmat4x3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=12
{
	dmat3x4 a;
	highp mat3x4 b;
	mediump mat3x4 c;
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	highp mat2 a;
	highp mat2x3 b;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 b;
} blockC;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b = dmat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=5
{
	lowp int a;
	mediump mat4 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dvec3 c;
	mediump uvec3 d; // unassigned
	lowp vec3 e;
} blockC;

void main (void)
{
	blockB.a = -89;
	blockB.b = mat4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.c = dvec3(-101.0, 100.0, -34.0);
	blockC.e = vec3(-35.0f, -43.0f, 48.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 200) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	double a;
	lowp ivec2 b;
} blockB[2];
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=136 sizeInLocations=10
{
	highp mat3x4 c; // unassigned
	lowp ivec3 d;
	dmat3 e;
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 f;
} blockD;

void main (void)
{
	blockB[0].a = -89.0;
	blockB[0].b = ivec2(30, -70);
	blockB[1].a = -60.0;
	blockB[1].b = ivec2(72, -102);
	d = ivec3(-100, 84, -31);
	e = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockD.f = mat4x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	dvec3 a;
	lowp uint b;
	mediump ivec4 c;
} blockB[1];
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	dvec2 d;
	mediump mat3 e;
	lowp float f;
} blockC;

void main (void)
{
	blockB[0].a = dvec3(-89.0, 30.0, -70.0);
	blockB[0].b = 60u;
	blockB[0].c = ivec4(72, -102, -100, 84);
	blockC.d = dvec2(-31.0, 68.0);
	blockC.e = mat3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockC.f = -34.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	lowp mat2 a; // unassigned
	mediump uint b;
	dmat3x2 c; // unassigned
};

void main (void)
{
	b = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=14
{
	dmat4 a;
	dvec3 b;
	mediump mat4x3 c;
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b = dvec3(-18.0, -101.0, 100.0);
	c = mat4x3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	dmat2 a;
	lowp ivec2 b;
	lowp mat3x2 c;
} blockB;

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = ivec2(72, -102);
	blockB.c = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	mediump vec3 a; // unassigned
	mediump vec4 b;
	mediump float c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	double d;
	dvec4 e; // unassigned
	lowp uvec2 f; // unassigned
};

void main (void)
{
	blockB.b = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockB.c = 72.0f;
	d = -102.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	dmat4x2 a;
	mediump mat4 b;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 c;
};

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = mat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = dmat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	mediump mat3x2 a;
	highp mat3x4 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 c;
} blockC;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = mat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC.c = dvec3(100.0, -34.0, -35.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB;

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	highp vec3 a;
	mediump uvec4 b;
	dmat2x3 c;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	dvec2 d; // unassigned
	mediump mat4 e;
} blockC;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = uvec4(60u, 72u, 102u, 100u);
	blockB.c = dmat2x3(84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockC.e = mat4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	lowp float a;
	highp mat2x3 b;
	highp uint c;
} blockB;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockB.c = 84u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat3 a;
	lowp uint b;
	highp uvec4 c;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	lowp uvec3 d;
	mediump float e;
} blockC;

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = 68u;
	blockB.c = uvec4(104u, 14u, 83u, 117u);
	blockC.d = uvec3(75u, 12u, 18u);
	blockC.e = -101.0f;
}
#version 450

struct sA
{
	mediump float mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 b;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=20 sizeInLocations=3
{
	mediump mat2 c;
	sA d;
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockC.b = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockD.c = mat2(104.0, 14.0, 83.0, -117.0);
	blockD.d.mA = 75.0f;
}
#version 450

struct sA
{
	dvec4 mA;
	dmat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=11
{
	sA a;
	highp mat4x2 b;
	dvec2 c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	mediump mat2x3 d;
} blockC;
layout(location = 13, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=88 sizeInLocations=8
{
	lowp vec3 e;
	dmat2x3 f;
	highp mat3x2 g; // unassigned
};

void main (void)
{
	a.mA = dvec4(-89.0, 30.0, -70.0, -60.0);
	a.mB = dmat4x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	c = dvec2(-35.0, -43.0);
	blockC.d = mat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	e = vec3(-80.0f, -62.0f, -54.0f);
	f = dmat2x3(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
}
#version 450

struct sA
{
	mediump uint mA;
};
struct sB
{
	sA mA;
	lowp mat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	sB a;
	highp int b;
};

void main (void)
{
	a.mA.mA = 89u;
	a.mB = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	b = 84;
}
#version 450

struct sA
{
	lowp ivec3 mA; // unassigned
	highp int mB;
	dvec4 mC;
};
struct sB
{
	sA mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	sB a;
	mediump uint b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dmat2 c;
} blockC;

void main (void)
{
	blockB.a.mA.mB = -89;
	blockB.a.mA.mC = dvec4(30.0, -70.0, -60.0, 72.0);
	blockB.b = 102u;
	blockC.c = dmat2(-100.0, 84.0, -31.0, 68.0);
}
#version 450

struct sA
{
	mediump mat4x3 mA;
	highp uint mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=10
{
	dmat2 a;
	dmat3x2 b;
	sA c;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=56 sizeInLocations=7
{
	highp mat4x2 d; // unassigned
	mediump mat3x2 e;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	c.mA = mat4x3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	c.mB = 48u;
	e = mat3x2(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

struct sA
{
	lowp mat4x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	dmat2x3 a;
	lowp ivec2 b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=112 sizeInLocations=10
{
	lowp mat2 c; // unassigned
	lowp mat4 d;
	sA e;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 f;
};

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = ivec2(-100, 84);
	blockC.d = mat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.e.mA = mat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	f = dmat4x2(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=136 sizeInLocations=11
{
	lowp int b;
	dmat2 c; // unassigned
	dmat4x3 d; // unassigned
};

void main (void)
{
	a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	b = 68;
}
#version 450

struct sA
{
	dvec3 mA;
	highp float mB[3];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	dvec4 a;
	lowp vec2 b;
	mediump mat4 c;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=56 sizeInLocations=6
{
	mediump uvec4 d;
	sA e;
} blockC;

void main (void)
{
	a = dvec4(-89.0, 30.0, -70.0, -60.0);
	b = vec2(72.0f, -102.0f);
	c = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = uvec4(48u, 4u, 60u, 37u);
	blockC.e.mA = dvec3(52.0, 98.0, -80.0);
	blockC.e.mB[0] = -62.0f;
	blockC.e.mB[1] = -54.0f;
	blockC.e.mB[2] = -79.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	mediump int a;
	lowp ivec2 b;
};

void main (void)
{
	a = -89;
	b = ivec2(30, -70);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump uvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=152 sizeInLocations=10
{
	mediump float b; // unassigned
	dmat4 c;
	mediump vec3 d; // unassigned
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 e;
};

void main (void)
{
	a = uvec2(89u, 30u);
	blockC.c = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	e = dmat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=10
{
	highp mat4x3 a;
	dmat3 b;
} blockB;

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dmat3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=11
{
	lowp mat2 a;
	dmat4x3 b; // unassigned
	lowp ivec4 c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=56 sizeInLocations=4
{
	mediump vec2 d; // unassigned
	dmat3x2 e;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	c = ivec4(72, -102, -100, 84);
	e = dmat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

struct sA
{
	mediump vec2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	dmat3x2 a;
	dmat4x2 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	sA c;
	highp vec2 d;
	highp ivec2 e;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 136) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	mediump ivec4 f;
};

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dmat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	c.mA = vec2(75.0f, 12.0f);
	d = vec2(-18.0f, -101.0f);
	e = ivec2(100, -34);
	f = ivec4(-35, -43, 48, 4);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	mediump uvec3 a;
} blockB;

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
}
#version 450

struct sA
{
	highp int mA;
	mediump mat4x3 mB;
};
struct sB
{
	mediump vec3 mA;
};
struct sC
{
	lowp mat3 mA;
};
struct sD
{
	sB mA;
	dmat4x2 mB;
	sC mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=12
{
	lowp mat4x3 a;
	dmat4 b;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=232 sizeInLocations=16
{
	dmat4 c;
	dmat2 d;
	dmat3 e; // unassigned
} blockC;
layout(location = 28, xfb_buffer = 0, xfb_offset = 408) out BlockD // sizeInBytes=184 sizeInLocations=14
{
	sA f;
	mediump ivec3 g; // unassigned
	sD h;
} blockD;

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dmat4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC.c = dmat4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockC.d = dmat2(-51.0, 32.0, 113.0, -44.0);
	blockD.f.mA = -77;
	blockD.f.mB = mat4x3(-11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0);
	blockD.h.mA.mA = vec3(-10.0f, 113.0f, -60.0f);
	blockD.h.mB = dmat4x2(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	blockD.h.mC.mA = mat3(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0);
}
#version 450

struct sA
{
	mediump uvec2 mA;
	lowp mat4x3 mB;
};
struct sB
{
	dmat2 mA;
};
struct sC
{
	dmat2x3 mA;
};
struct sD
{
	sC mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	sA a; // unassigned
	sB b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	sD c;
	dmat3x4 d[1];
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 232) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	dmat2 e;
	lowp ivec4 f;
	highp uvec2 g;
};

void main (void)
{
	blockB.b.mA = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC.c.mA.mA = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.d[0] = dmat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = dmat2(48.0, 4.0, -60.0, 37.0);
	f = ivec4(52, 98, -80, -62);
	g = uvec2(54u, 79u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=4
{
	lowp int a;
	lowp mat3x2 b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 c;
} blockC;

void main (void)
{
	blockB.a = -89;
	blockB.b = mat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockC.c = mat3(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=10
{
	dmat3 a; // unassigned
	highp mat4x3 b;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 c;
} blockC;

void main (void)
{
	b = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	mediump mat4x2 a;
	mediump uvec3 b;
	highp uvec3 c;
} blockB;

void main (void)
{
	blockB.a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = uvec3(31u, 68u, 104u);
	blockB.c = uvec3(14u, 83u, 117u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	dmat4 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	highp mat4 b;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	mediump uint c;
} blockD;

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockD.c = 3u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=13
{
	dmat4x2 a[3];
	mediump int b;
} blockB;
layout(location = 13, xfb_buffer = 0, xfb_offset = 200) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 c;
} blockC;
layout(location = 16, xfb_buffer = 0, xfb_offset = 224) out BlockD // sizeInBytes=80 sizeInLocations=5
{
	dmat2 d[1];
	lowp mat3x4 e;
};

void main (void)
{
	blockB.a[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB.b = -60;
	blockC.c = mat3x2(37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	d[0] = dmat2(-79.0, 3.0, -97.0, -118.0);
	e = mat3x4(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	lowp ivec2 a; // unassigned
	dmat2x3 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 c;
};

void main (void)
{
	blockB.b = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = mat4x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	dmat2x3 a;
	highp ivec2 b;
	dvec4 c;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dmat2 d;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=168 sizeInLocations=14
{
	dvec3 e;
	mediump mat3 f[4];
} blockD;

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = ivec2(-100, 84);
	c = dvec4(-31.0, 68.0, 104.0, 14.0);
	d = dmat2(83.0, -117.0, 75.0, 12.0);
	blockD.e = dvec3(-18.0, -101.0, 100.0);
	blockD.f[0] = mat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.f[1] = mat3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.f[2] = mat3(48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	blockD.f[3] = mat3(113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0);
}
#version 450

struct sA
{
	mediump mat3 mA; // unassigned
	mediump mat3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	lowp ivec3 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=200 sizeInLocations=14
{
	sA b;
	dmat4 c;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	highp mat3 d;
} blockD;

void main (void)
{
	a = ivec3(-89, 30, -70);
	blockC.b.mB = mat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = dmat4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.d = mat3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
}
#version 450

struct sA
{
	dmat3x4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=10
{
	highp ivec4 a[2];
	sA b;
	dmat2 c;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=200 sizeInLocations=15
{
	dvec3 d[4];
	lowp mat3 e;
	dmat2 f[2];
};
layout(location = 25, xfb_buffer = 0, xfb_offset = 360) out BlockD // sizeInBytes=56 sizeInLocations=6
{
	mediump uvec2 g;
	mediump mat4x2 h; // unassigned
	dvec2 i;
};

void main (void)
{
	blockB.a[0] = ivec4(-89, 30, -70, -60);
	blockB.a[1] = ivec4(72, -102, -100, 84);
	blockB.b.mA = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.c = dmat2(-35.0, -43.0, 48.0, 4.0);
	d[0] = dvec3(-60.0, 37.0, 52.0);
	d[1] = dvec3(98.0, -80.0, -62.0);
	d[2] = dvec3(-54.0, -79.0, 3.0);
	d[3] = dvec3(-97.0, -118.0, -108.0);
	e = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	f[0] = dmat2(32.0, 113.0, -44.0, -77.0);
	f[1] = dmat2(-11.0, 66.0, -11.0, 87.0);
	g = uvec2(87u, 87u);
	i = dvec2(95.0, -46.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat3x2 a;
	mediump uint b;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = 100u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	highp mat2x3 a;
	dvec4 b;
	mediump uint c;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 d;
} blockC;

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dvec4(-100.0, 84.0, -31.0, 68.0);
	blockB.c = 104u;
	blockC.d = dvec4(14.0, 83.0, -117.0, 75.0);
}
#version 450

struct sA
{
	dvec3 mA;
	lowp mat3x4 mB[2];
};
struct sB
{
	mediump uvec4 mA;
};
struct sC
{
	dmat4x3 mA[4];
	dmat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	sA a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=464 sizeInLocations=38
{
	sB b; // unassigned
	double c[2];
	sC d;
} blockC;
layout(location = 46, xfb_buffer = 0, xfb_offset = 584) out BlockD // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 e;
};

void main (void)
{
	blockB.a.mA = dvec3(-89.0, 30.0, -70.0);
	blockB.a.mB[0] = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.a.mB[1] = mat3x4(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockC.c[0] = 98.0;
	blockC.c[1] = -80.0;
	blockC.d.mA[0] = dmat4x3(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
	blockC.d.mA[1] = dmat4x3(-62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0);
	blockC.d.mA[2] = dmat4x3(-87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0);
	blockC.d.mA[3] = dmat4x3(-109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0);
	blockC.d.mB = dmat3x2(54.0, -50.0, -84.0, -49.0, -6.0, 98.0);
	e = mat3x2(-34.0, -69.0, -57.0, -8.0, -89.0, 91.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dmat3x2 a;
	dvec3 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	mediump mat4 c;
};

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dvec3(-100.0, 84.0, -31.0);
	c = mat4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
}
#version 450

struct sA
{
	lowp uvec2 mA; // unassigned
};
struct sB
{
	mediump uint mA;
	highp vec4 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=84 sizeInLocations=7
{
	lowp mat3 a;
	lowp mat4x3 b; // unassigned
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=128 sizeInLocations=11
{
	sA c;
	dmat4x3 d; // unassigned
	sB e;
};

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	e.mA = 68u;
	e.mB = vec4(104.0f, 14.0f, 83.0f, -117.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	highp uint a;
	highp mat2 b;
	mediump mat3 c;
} blockB[2];

void main (void)
{
	blockB[0].a = 89u;
	blockB[0].b = mat2(30.0, -70.0, -60.0, 72.0);
	blockB[0].c = mat3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB[1].a = 75u;
	blockB[1].b = mat2(12.0, -18.0, -101.0, 100.0);
	blockB[1].c = mat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
}
#version 450

struct sA
{
	highp ivec4 mA;
	dmat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	mediump uvec2 a;
	highp uvec3 b;
	sA c;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=12 sizeInLocations=2
{
	lowp uvec2 d;
	highp int e;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=64 sizeInLocations=5
{
	highp int f;
	dvec2 g;
	highp mat3 h;
};

void main (void)
{
	blockB.a = uvec2(89u, 30u);
	blockB.b = uvec3(70u, 60u, 72u);
	blockB.c.mA = ivec4(-102, -100, 84, -31);
	blockB.c.mB = dmat4x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = uvec2(101u, 100u);
	blockC.e = -34;
	f = -35;
	g = dvec2(-43.0, 48.0);
	h = mat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
}
#version 450

struct sA
{
	mediump mat2 mA;
	highp ivec2 mB;
	highp vec2 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	sA a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=128 sizeInLocations=10
{
	dmat3 b;
	highp uint c;
	lowp mat3x4 d;
};

void main (void)
{
	a.mA = mat2(-89.0, 30.0, -70.0, -60.0);
	a.mB = ivec2(72, -102);
	b = dmat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	c = 12u;
	d = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	highp mat4 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 b;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=44 sizeInLocations=4
{
	highp mat2 c; // unassigned
	mediump ivec4 d;
	lowp ivec3 e;
};

void main (void)
{
	a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b = dvec4(-18.0, -101.0, 100.0, -34.0);
	d = ivec4(-35, -43, 48, 4);
	e = ivec3(-60, 37, 52);
}
#version 450

struct sA
{
	highp mat3 mA;
	lowp mat2x3 mB;
	double mC;
};
struct sB
{
	highp mat4x3 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=12
{
	dmat4x3 a;
	lowp mat4x2 b;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=224 sizeInLocations=17
{
	lowp mat4 c;
	sB d;
	highp mat3 e;
} blockC;
layout(location = 29, xfb_buffer = 0, xfb_offset = 352) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	mediump int f; // unassigned
	highp int g;
};

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.c = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockC.d.mA = mat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC.d.mB.mA = mat3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0);
	blockC.d.mB.mB = mat2x3(-122.0, -97.0, 108.0, -127.0, -10.0, 113.0);
	blockC.d.mB.mC = -60.0;
	blockC.e = mat3(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0);
	g = -40;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	lowp uvec4 a; // unassigned
	mediump uint b;
} blockB[1];

void main (void)
{
	blockB[0].b = 89u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out BlockB // sizeInBytes=88 sizeInLocations=8
{
	lowp uvec2 a;
	dmat3 b;
	mediump vec2 c;
} blockB[3];
layout(location = 24, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 d;
} blockC[1];

void main (void)
{
	blockB[0].a = uvec2(89u, 30u);
	blockB[0].b = dmat3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockB[0].c = vec2(14.0f, 83.0f);
	blockB[1].a = uvec2(117u, 75u);
	blockB[1].b = dmat3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[1].c = vec2(-60.0f, 37.0f);
	blockB[2].a = uvec2(52u, 98u);
	blockB[2].b = dmat3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockB[2].c = vec2(48.0f, -71.0f);
	blockC[0].d = mat4x2(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 b;
} blockC;

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.b = mat4x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

struct sA
{
	lowp mat4x3 mA; // unassigned
	highp mat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 128) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	highp vec4 a;
} blockB[2];
layout(location = 2, xfb_buffer = 0, xfb_offset = 16, xfb_stride = 128) out BlockC // sizeInBytes=112 sizeInLocations=9
{
	sA b; // unassigned
	mediump vec4 c;
} blockC[2];

void main (void)
{
	blockB[0].a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockB[1].a = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	blockC[0].c = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockC[1].c = vec4(83.0f, -117.0f, 75.0f, 12.0f);
}
#version 450

struct sA
{
	mediump float mA;
	lowp mat3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=5
{
	sA a;
	lowp ivec2 b;
} blockB;

void main (void)
{
	blockB.a.mA = -89.0f;
	blockB.a.mB = mat3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockB.b = ivec2(104, 14);
}
#version 450

struct sA
{
	mediump vec2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=4
{
	lowp mat2x3 a;
	sA b;
	lowp vec3 c;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=120 sizeInLocations=8
{
	dmat3x4 d;
	lowp mat2x3 e;
};

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b.mA = vec2(-100.0f, 84.0f);
	blockB.c = vec3(-31.0f, 68.0f, 104.0f);
	d = dmat3x4(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = mat2x3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp vec2 a;
	mediump vec2 b;
	highp vec2 c;
} blockB;

void main (void)
{
	blockB.a = vec2(-89.0f, 30.0f);
	blockB.b = vec2(-70.0f, -60.0f);
	blockB.c = vec2(72.0f, -102.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=56 sizeInLocations=7
{
	lowp mat3x2 a;
	lowp uvec2 b;
	lowp mat3x2 c;
} blockB[2];

void main (void)
{
	blockB[0].a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b = uvec2(100u, 84u);
	blockB[0].c = mat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB[1].a = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB[1].b = uvec2(35u, 43u);
	blockB[1].c = mat3x2(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=6
{
	lowp mat4x2 a;
	lowp mat2 b;
};

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat2(-31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	dmat2x3 a;
	mediump int b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=56 sizeInLocations=4
{
	mediump uvec4 c;
	dmat2 d;
	lowp ivec2 e;
} blockC;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = -100;
	blockC.c = uvec4(84u, 31u, 68u, 104u);
	blockC.d = dmat2(14.0, 83.0, -117.0, 75.0);
	blockC.e = ivec2(12, -18);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp uvec3 b;
	highp vec2 c;
	highp float d;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=136 sizeInLocations=10
{
	highp mat4 e;
	dmat3 f;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = uvec3(72u, 102u, 100u);
	c = vec2(84.0f, -31.0f);
	d = 68.0f;
	e = mat4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	f = dmat3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
}
#version 450

struct sA
{
	dmat2x3 mA;
	lowp vec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 152) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	sA a;
	highp vec4 b;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=76 sizeInLocations=5
{
	mediump mat4 c;
	lowp uvec3 d;
};

void main (void)
{
	blockB[0].a.mA = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].a.mB = vec2(-100.0f, 84.0f);
	blockB[0].b = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockB[1].a.mA = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].a.mB = vec2(100.0f, -34.0f);
	blockB[1].b = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	c = mat4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	d = uvec3(40u, 62u, 114u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=160 sizeInLocations=12
{
	dmat2 b;
	dmat3x4 c;
	lowp mat4x2 d;
} blockC;

void main (void)
{
	blockB[0].a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.b = dmat2(-100.0, 84.0, -31.0, 68.0);
	blockC.c = dmat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = mat4x2(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	dvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = mat3x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	mediump mat4x2 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32, xfb_stride = 36) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp int b;
} blockC[3];

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC[0].b = -31;
	blockC[1].b = 68;
	blockC[2].b = 104;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=56 sizeInLocations=6
{
	lowp vec3 b; // unassigned
	lowp mat4x2 c;
	lowp vec3 d;
};

void main (void)
{
	a = uvec2(89u, 30u);
	c = mat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	d = vec3(104.0f, 14.0f, 83.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	highp vec4 a;
	mediump float b;
	dvec2 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 d;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 e;
} blockD;

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = 72.0f;
	c = dvec2(-102.0, -100.0);
	d = dvec3(84.0, -31.0, 68.0);
	blockD.e = ivec3(104, 14, 83);
}
#version 450

struct sA
{
	dmat2x3 mA;
	mediump mat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec4 a;
} blockB[2];
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=72 sizeInLocations=7
{
	sA b;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 c;
} blockD;

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[1].a = dvec4(72.0, -102.0, -100.0, 84.0);
	blockC.b.mA = dmat2x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.b.mB = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockD.c = uvec3(35u, 43u, 48u);
}
#version 450

struct sA
{
	dvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=11
{
	sA a;
	dmat4 b;
	highp uvec3 c;
} blockB[1];

void main (void)
{
	blockB[0].a.mA = dvec3(-89.0, 30.0, -70.0);
	blockB[0].b = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockB[0].c = uvec3(34u, 35u, 43u);
}
#version 450

struct sA
{
	lowp mat3x2 mA;
	dmat2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	dvec4 a;
	dmat4x3 b;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	sA c;
} blockC;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB.b = dmat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c.mA = mat3x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.c.mB = dmat2(48.0, 4.0, -60.0, 37.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec4 a;
} blockB;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
}
#version 450

struct sA
{
	dmat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat3x2 a;
	highp uvec2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=160 sizeInLocations=13
{
	mediump mat4x3 c;
	mediump vec4 d;
	dmat4x3 e;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=144 sizeInLocations=11
{
	highp mat4 f;
	mediump mat4x2 g;
	sA h;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = uvec2(100u, 84u);
	c = mat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	d = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	e = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	f = mat4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	g = mat4x2(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	h.mA = dmat3x2(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	double a;
	dvec4 b;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=60 sizeInLocations=4
{
	lowp mat3x4 c;
	highp ivec3 d;
} blockC;

void main (void)
{
	blockB[0].a = -89.0;
	blockB[0].b = dvec4(30.0, -70.0, -60.0, 72.0);
	blockC.c = mat3x4(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = ivec3(-101, 100, -34);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=32 sizeInLocations=3
{
	dvec3 b;
	highp int c; // unassigned
};

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = dvec3(-31.0, 68.0, 104.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec2 a;
	dvec2 b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = dvec2(-70.0, -60.0);
}
#version 450

struct sA
{
	highp vec2 mA;
	dmat2 mB;
	mediump float mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=14
{
	dmat2x3 a;
	dmat4 b;
	dmat2 c;
} blockB[1];
layout(location = 14, xfb_buffer = 0, xfb_offset = 208, xfb_stride = 408) out BlockC // sizeInBytes=176 sizeInLocations=12
{
	dmat3x4 d;
	sA e; // unassigned
	dmat2 f;
} blockC[3];
layout(location = 50, xfb_buffer = 0, xfb_offset = 384) out BlockD // sizeInBytes=24 sizeInLocations=3
{
	highp vec2 g;
	lowp vec3 h;
	mediump float i; // unassigned
};

void main (void)
{
	blockB[0].a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b = dmat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockB[0].c = dmat2(48.0, 4.0, -60.0, 37.0);
	blockC[0].d = dmat3x4(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockC[0].f = dmat2(-71.0, -59.0, -40.0, -62.0);
	blockC[1].d = dmat3x4(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockC[1].f = dmat2(87.0, 95.0, -46.0, -122.0);
	blockC[2].d = dmat3x4(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0);
	blockC[2].f = dmat2(37.0, -112.0, 88.0, -40.0);
	g = vec2(-22.0f, 40.0f);
	h = vec3(-17.0f, 54.0f, -50.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp uint a;
	highp uint b;
	mediump vec4 c;
} blockB;

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30u;
	blockB.c = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	double a;
	lowp mat3x4 b; // unassigned
	lowp ivec4 c; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=80 sizeInLocations=6
{
	dmat2x3 d;
	dmat2 e; // unassigned
} blockC;

void main (void)
{
	a = -89.0;
	blockC.d = dmat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
}
#version 450

struct sA
{
	dmat4 mA;
	lowp uint mB;
	lowp uvec2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=11
{
	sA a; // unassigned
	dvec2 b;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 c;
} blockC;

void main (void)
{
	blockB.b = dvec2(-89.0, 30.0);
	blockC.c = vec2(-70.0f, -60.0f);
}
#version 450

struct sA
{
	dmat3x2 mA;
	dvec4 mB[1];
	dmat3x4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=232 sizeInLocations=16
{
	mediump uint a;
	lowp mat4x3 b;
	sA c;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 232) out BlockC // sizeInBytes=56 sizeInLocations=6
{
	highp mat3x2 d[1];
	lowp mat2 e;
	dvec2 f;
} blockC;

void main (void)
{
	a = 89u;
	b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c.mA = dmat3x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	c.mB[0] = dvec4(-34.0, -35.0, -43.0, 48.0);
	c.mC = dmat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockC.d[0] = mat3x2(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
	blockC.e = mat2(-62.0, 114.0, -109.0, -51.0);
	blockC.f = dvec2(32.0, 113.0);
}
#version 450

struct sA
{
	highp ivec2 mA;
	double mB; // unassigned
	mediump int mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	dmat4x2 a;
	sA b; // unassigned
	lowp vec3 c;
} blockB[1];

void main (void)
{
	blockB[0].a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[0].c = vec3(-31.0f, 68.0f, 104.0f);
}
#version 450

struct sA
{
	dmat3x4 mA[4];
	highp uint mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=6
{
	mediump mat4 a;
	double b; // unassigned
	lowp ivec3 c;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=408 sizeInLocations=26
{
	lowp ivec4 d;
	sA e;
};

void main (void)
{
	blockB.a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.c = ivec3(-18, -101, 100);
	d = ivec4(-34, -35, -43, 48);
	e.mA[0] = dmat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	e.mA[1] = dmat3x4(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	e.mA[2] = dmat3x4(-44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0);
	e.mA[3] = dmat3x4(108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0);
	e.mB = 112u;
}
#version 450

struct sA
{
	lowp vec3 mA;
	highp mat3x2 mB;
	dmat4x2 mC;
};
struct sB
{
	lowp mat3 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=12
{
	sB a;
	highp int b;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockC // sizeInBytes=128 sizeInLocations=12
{
	dmat4x3 c;
	lowp mat3x2 d;
	highp int e;
} blockC;

void main (void)
{
	blockB.a.mA = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.a.mB.mA = vec3(68.0f, 104.0f, 14.0f);
	blockB.a.mB.mB = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB.a.mB.mC = dmat4x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockB.b = 52;
	blockC.c = dmat4x3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockC.d = mat3x2(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	blockC.e = 32;
}
#version 450

struct sA
{
	mediump float mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 104) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	sA a;
	dmat3x2 b;
	mediump mat3x4 c; // unassigned
} blockB[3];

void main (void)
{
	blockB[0].a.mA = -89.0f;
	blockB[0].b = dmat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockB[1].a.mA = 84.0f;
	blockB[1].b = dmat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB[2].a.mA = 75.0f;
	blockB[2].b = dmat3x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
}
#version 450

struct sA
{
	dmat2 mA;
	lowp mat2 mB;
	double mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp vec3 a;
	mediump uint b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	highp uvec4 c;
	highp vec4 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockD // sizeInBytes=120 sizeInLocations=9
{
	sA e;
	mediump mat4 f;
} blockD;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = 60u;
	c = uvec4(72u, 102u, 100u, 84u);
	d = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockD.e.mA = dmat2(83.0, -117.0, 75.0, 12.0);
	blockD.e.mB = mat2(-18.0, -101.0, 100.0, -34.0);
	blockD.e.mC = -35.0;
	blockD.f = mat4(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 a;
} blockB;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	dmat2 a; // unassigned
	dvec3 b[1];
	lowp int c;
} blockB;

void main (void)
{
	blockB.b[0] = dvec3(-89.0, 30.0, -70.0);
	blockB.c = -60;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	dmat4x3 a;
	mediump uvec4 b;
	lowp vec3 c;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 128, xfb_stride = 232) out BlockC // sizeInBytes=104 sizeInLocations=8
{
	highp vec4 d;
	dmat3 e;
	highp uvec3 f;
} blockC[2];

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = uvec4(83u, 117u, 75u, 12u);
	c = vec3(-18.0f, -101.0f, 100.0f);
	blockC[0].d = vec4(-34.0f, -35.0f, -43.0f, 48.0f);
	blockC[0].e = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC[0].f = uvec3(3u, 97u, 118u);
	blockC[1].d = vec4(-108.0f, -120.0f, 48.0f, -71.0f);
	blockC[1].e = dmat3(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC[1].f = uvec3(77u, 11u, 66u);
}
#version 450

struct sA
{
	dvec2 mA;
	dvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	sA a;
	dmat4x2 b;
};

void main (void)
{
	a.mA = dvec2(-89.0, 30.0);
	a.mB = dvec3(-70.0, -60.0, 72.0);
	b = dmat4x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 20) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	mediump int a;
} blockB[3];
layout(location = 3, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 b;
};

void main (void)
{
	blockB[0].a = -89;
	blockB[1].a = 30;
	blockB[2].a = -70;
	b = mat2(-60.0, 72.0, -102.0, -100.0);
}
#version 450

struct sA
{
	lowp mat2x3 mA;
};
struct sB
{
	sA mA;
	highp ivec4 mB;
	double mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	sB a;
} blockB;

void main (void)
{
	blockB.a.mA.mA = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.a.mB = ivec4(-100, 84, -31, 68);
	blockB.a.mC = 104.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat2 a; // unassigned
	highp ivec4 b[1];
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=272 sizeInLocations=22
{
	mediump mat4x3 c[4]; // unassigned
	dmat2 d;
	dmat2x3 e;
};

void main (void)
{
	b[0] = ivec4(-89, 30, -70, -60);
	d = dmat2(72.0, -102.0, -100.0, 84.0);
	e = dmat2x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

struct sA
{
	highp int mA;
	dmat4 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	dmat4 a; // unassigned
	highp vec3 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=152 sizeInLocations=10
{
	dmat4 c;
	lowp mat2x3 d; // unassigned
};
layout(location = 19, xfb_buffer = 0, xfb_offset = 296, xfb_stride = 592) out BlockD // sizeInBytes=296 sizeInLocations=21
{
	sA e[2];
	mediump mat3x2 f;
} blockD[3];

void main (void)
{
	blockB.b = vec3(-89.0f, 30.0f, -70.0f);
	c = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD[0].e[0].mA = -34;
	blockD[0].e[0].mB = dmat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD[0].e[1].mA = -120;
	blockD[0].e[1].mB = dmat4(48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0);
	blockD[0].f = mat3x2(-87.0, 87.0, 95.0, -46.0, -122.0, -97.0);
	blockD[1].e[0].mA = 108;
	blockD[1].e[0].mB = dmat4(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	blockD[1].e[1].mA = -17;
	blockD[1].e[1].mB = dmat4(54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0);
	blockD[1].f = mat3x2(-112.0, -35.0, -127.0, 44.0, 56.0, -33.0);
	blockD[2].e[0].mA = 109;
	blockD[2].e[0].mB = dmat4(-119.0, 34.0, -102.0, 104.0, 33.0, 127.0, 121.0, 42.0, -34.0, -92.0, 75.0, -68.0, 84.0, -4.0, 38.0, 119.0);
	blockD[2].e[1].mA = -79;
	blockD[2].e[1].mB = dmat4(39.0, -7.0, 119.0, -75.0, 19.0, -79.0, -31.0, 50.0, 79.0, -21.0, -5.0, -88.0, -104.0, -84.0, -36.0, 61.0);
	blockD[2].f = mat3x2(-37.0, 15.0, 107.0, 112.0, -16.0, 5.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=4
{
	highp ivec3 a;
	mediump vec4 b;
	lowp uvec2 c[2];
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 44, xfb_stride = 92) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	mediump mat3x4 d;
} blockC[2];

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = vec4(-60.0f, 72.0f, -102.0f, -100.0f);
	c[0] = uvec2(84u, 31u);
	c[1] = uvec2(68u, 104u);
	blockC[0].d = mat3x4(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC[1].d = mat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=7
{
	highp mat2 a;
	lowp uint b;
	dmat2x3 c;
} blockB;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = 72u;
	blockB.c = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	lowp vec4 a; // unassigned
	dvec2 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=44 sizeInLocations=6
{
	lowp vec2 c;
	highp mat4x2 d;
	mediump uint e;
} blockC;

void main (void)
{
	b = dvec2(-89.0, 30.0);
	blockC.c = vec2(-70.0f, -60.0f);
	blockC.d = mat4x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.e = 83u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	mediump mat3x2 a;
	dvec2 b;
} blockB;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dvec2(-100.0, 84.0);
}
#version 450

struct sA
{
	mediump int mA;
	dmat3x4 mB; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=100 sizeInLocations=8
{
	lowp uint a;
	highp mat4x3 b;
	mediump mat3x4 c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=112 sizeInLocations=8
{
	lowp int d;
	sA e; // unassigned
} blockC[1];
layout(location = 16, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=88 sizeInLocations=7
{
	dmat3 f;
	mediump uvec3 g;
} blockD[1];

void main (void)
{
	a = 89u;
	b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c = mat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockC[0].d = 37;
	blockD[0].f = dmat3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD[0].g = uvec3(108u, 120u, 48u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	dmat3x2 a;
	dmat3x2 b;
	lowp ivec3 c;
} blockB;

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.c = ivec3(83, -117, 75);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=112 sizeInLocations=7
{
	dmat3x4 b;
	lowp uvec3 c;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 160, xfb_stride = 176) out BlockD // sizeInBytes=16 sizeInLocations=2
{
	mediump vec2 d[1];
	double e;
} blockD[2];

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = uvec3(100u, 34u, 35u);
	blockD[0].d[0] = vec2(-43.0f, 48.0f);
	blockD[0].e = 4.0;
	blockD[1].d[0] = vec2(-60.0f, 37.0f);
	blockD[1].e = 52.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=128 sizeInLocations=11
{
	mediump ivec3 b[4];
	highp int c;
	dmat3 d[1];
};

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	b[0] = ivec3(-60, 72, -102);
	b[1] = ivec3(-100, 84, -31);
	b[2] = ivec3(68, 104, 14);
	b[3] = ivec3(83, -117, 75);
	c = 12;
	d[0] = dmat3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=18
{
	dmat3x4 a;
	dmat2x3 b[3];
} blockB[1];

void main (void)
{
	blockB[0].a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[0].b[0] = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[0].b[1] = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[0].b[2] = dmat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	mediump uvec3 a;
	dmat3x2 b; // unassigned
	lowp uint c;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72, xfb_stride = 264) out BlockC // sizeInBytes=144 sizeInLocations=9
{
	dmat3x4 d;
	lowp mat3x4 e;
} blockC[3];
layout(location = 32, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	dmat2 f; // unassigned
	mediump ivec2 g; // unassigned
	double h;
} blockD[1];

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.c = 60u;
	blockC[0].d = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].e = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC[1].d = dmat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC[1].e = mat3x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	blockC[2].d = dmat3x4(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	blockC[2].e = mat3x4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	blockD[0].h = -17.0;
}
#version 450

struct sA
{
	lowp mat3x2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	highp vec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 140) out BlockB // sizeInBytes=36 sizeInLocations=4
{
	sB a;
	sC b[1];
} blockB[3];
layout(location = 12, xfb_buffer = 0, xfb_offset = 36) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 c;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=68 sizeInLocations=5
{
	mediump mat3x4 d;
	highp vec4 e; // unassigned
	mediump int f;
};

void main (void)
{
	blockB[0].a.mA.mA = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b[0].mA = vec3(-100.0f, 84.0f, -31.0f);
	blockB[1].a.mA.mA = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB[1].b[0].mA = vec3(12.0f, -18.0f, -101.0f);
	blockB[2].a.mA.mA = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[2].b[0].mA = vec3(-60.0f, 37.0f, 52.0f);
	blockC.c = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	d = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	f = -77;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=14
{
	lowp mat3 a;
	mediump mat3x2 b;
	dmat4x3 c;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=176 sizeInLocations=11
{
	lowp vec4 d;
	dmat3x4 e;
	dmat4x2 f;
};

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.c = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	d = vec4(98.0f, -80.0f, -62.0f, -54.0f);
	e = dmat3x4(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
	f = dmat4x2(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
}
#version 450

struct sA
{
	highp ivec4 mA;
	mediump mat2 mB;
	dmat2x3 mC;
};
struct sB
{
	lowp mat3x2 mA;
	mediump mat4x2 mB;
};
struct sC
{
	sA mA;
	sB mB;
	highp uint mC;
};
struct sD
{
	dmat3 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 304) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dmat4x2 a;
	mediump uvec2 b;
} blockB[3];
layout(location = 15, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=232 sizeInLocations=22
{
	lowp uvec4 c;
	sC d; // unassigned
	sD e; // unassigned
} blockC;

void main (void)
{
	blockB[0].a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[0].b = uvec2(31u, 68u);
	blockB[1].a = dmat4x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].b = uvec2(100u, 34u);
	blockB[2].a = dmat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB[2].b = uvec2(80u, 62u);
	blockC.c = uvec4(54u, 79u, 3u, 97u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dvec2 a;
	lowp uvec4 b;
	highp vec4 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	mediump uint d;
	lowp mat2 e;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	mediump mat2 f;
	dmat4x2 g;
} blockD[1];

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = uvec4(70u, 60u, 72u, 102u);
	blockB.c = vec4(-100.0f, 84.0f, -31.0f, 68.0f);
	blockC.d = 104u;
	blockC.e = mat2(14.0, 83.0, -117.0, 75.0);
	blockD[0].f = mat2(12.0, -18.0, -101.0, 100.0);
	blockD[0].g = dmat4x2(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

struct sA
{
	mediump mat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	mediump int a;
	mediump mat3 b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 c;
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockD // sizeInBytes=160 sizeInLocations=11
{
	highp uvec2 d;
	dmat4 e;
	sA f;
};

void main (void)
{
	blockB.a = -89;
	blockB.b = mat3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = ivec4(104, 14, 83, -117);
	d = uvec2(75u, 12u);
	e = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	f.mA = mat2x3(3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
}
#version 450

struct sA
{
	lowp ivec4 mA;
	highp uvec4 mB;
	mediump int mC; // unassigned
};
struct sB
{
	sA mA;
	highp vec4 mB;
	dmat3x2 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	highp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	sB b;
	lowp mat3 c; // unassigned
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 d;
} blockD;

void main (void)
{
	a = 89u;
	blockC.b.mA.mA = ivec4(30, -70, -60, 72);
	blockC.b.mA.mB = uvec4(102u, 100u, 84u, 31u);
	blockC.b.mB = vec4(68.0f, 104.0f, 14.0f, 83.0f);
	blockD.d = dmat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat3 a;
	mediump int b; // unassigned
	lowp ivec4 c;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=160 sizeInLocations=10
{
	dmat3x4 d;
	highp mat3x4 e;
	lowp uvec3 f; // unassigned
};

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.c = ivec4(68, 104, 14, 83);
	d = dmat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	e = mat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 b[1];
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	lowp mat2x3 c;
	lowp vec2 d;
	dvec2 e;
} blockD;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0] = dvec4(83.0, -117.0, 75.0, 12.0);
	blockD.c = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.d = vec2(48.0f, 4.0f);
	blockD.e = dvec2(-60.0, 37.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=400 sizeInLocations=33
{
	dvec2 a;
	dmat4x3 b[4];
};
layout(location = 33, xfb_buffer = 0, xfb_offset = 400, xfb_stride = 488) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 c;
} blockC[3];
layout(location = 39, xfb_buffer = 0, xfb_offset = 432) out BlockD // sizeInBytes=56 sizeInLocations=5
{
	lowp mat4x3 d;
	lowp ivec2 e;
} blockD;

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b[0] = dmat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	b[1] = dmat4x3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	b[2] = dmat4x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	b[3] = dmat4x3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0);
	blockC[0].c = dvec4(66.0, -11.0, 87.0, -87.0);
	blockC[1].c = dvec4(87.0, 95.0, -46.0, -122.0);
	blockC[2].c = dvec4(-97.0, 108.0, -127.0, -10.0);
	blockD.d = mat4x3(113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0);
	blockD.e = ivec2(-22, 40);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=19
{
	highp mat4x2 a[3]; // unassigned
	dmat3 b; // unassigned
	lowp float c;
} blockB;
layout(location = 19, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=40 sizeInLocations=4
{
	highp uvec2 d[3];
	dvec2 e;
};

void main (void)
{
	blockB.c = -89.0f;
	d[0] = uvec2(30u, 70u);
	d[1] = uvec2(60u, 72u);
	d[2] = uvec2(102u, 100u);
	e = dvec2(84.0, -31.0);
}
#version 450

struct sA
{
	dmat3x4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dmat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32, xfb_stride = 208) out BlockC // sizeInBytes=176 sizeInLocations=13
{
	lowp mat3x4 b;
	lowp mat4x2 c;
	sA d; // unassigned
} blockC[3];

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC[0].b = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].c = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC[1].b = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockC[1].c = mat4x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockC[2].b = mat3x4(-51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	blockC[2].c = mat4x2(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	double a[2];
};

void main (void)
{
	a[0] = -89.0;
	a[1] = 30.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	dvec2 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp float b;
} blockC;

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockC.b = -70.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
} blockB[3];

void main (void)
{
	blockB[0].a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB[1].a = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[2].a = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 224) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dvec4 a;
	mediump mat4 b;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 96, xfb_stride = 224) out BlockC // sizeInBytes=112 sizeInLocations=7
{
	dmat3x2 c;
	dmat4x2 d; // unassigned
} blockC[2];
layout(location = 26, xfb_buffer = 0, xfb_offset = 208) out BlockD // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 e;
} blockD;

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = mat4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB[1].a = dvec4(-35.0, -43.0, 48.0, 4.0);
	blockB[1].b = mat4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC[0].c = dmat3x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	blockC[1].c = dmat3x2(113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	blockD.e = mat2(87.0, -87.0, 87.0, 95.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	lowp ivec2 a;
	highp uvec2 b;
	mediump vec3 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=200 sizeInLocations=13
{
	dmat3x4 e; // unassigned
	highp ivec2 f;
	dmat3x4 g;
} blockD;

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = uvec2(70u, 60u);
	blockB.c = vec3(72.0f, -102.0f, -100.0f);
	d = uvec3(84u, 31u, 68u);
	blockD.f = ivec2(104, 14);
	blockD.g = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 80) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	dvec4 a;
	lowp mat4x3 b;
} blockB[3];

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = mat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB[1].a = dvec4(-18.0, -101.0, 100.0, -34.0);
	blockB[1].b = mat4x3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB[2].a = dvec4(3.0, -97.0, -118.0, -108.0);
	blockB[2].b = mat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	lowp vec2 a;
	dmat3x4 b;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = dmat3x4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=7
{
	lowp int a;
	lowp mat4x3 b;
	lowp mat2 c;
};

void main (void)
{
	a = -89;
	b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c = mat2(-117.0, 75.0, 12.0, -18.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
};

void main (void)
{
	a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	mediump ivec3 a[4]; // unassigned
	dvec4 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	lowp ivec2 c;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 d;
} blockD;

void main (void)
{
	blockB.b = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockC.c = ivec2(72, -102);
	blockD.d = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
}
#version 450

struct sA
{
	mediump vec2 mA;
};
struct sB
{
	mediump mat3 mA;
	sA mB;
};
struct sC
{
	dmat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	dmat2 a;
	dmat2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	dvec3 c;
	sB d;
	highp mat3 e;
} blockC;
layout(location = 13, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dvec4 f;
	sC g; // unassigned
	dvec2 h;
} blockD[1];

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat2(72.0, -102.0, -100.0, 84.0);
	blockC.c = dvec3(-31.0, 68.0, 104.0);
	blockC.d.mA = mat3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.d.mB.mA = vec2(-35.0f, -43.0f);
	blockC.e = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	blockD[0].f = dvec4(-79.0, 3.0, -97.0, -118.0);
	blockD[0].h = dvec2(-108.0, -120.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=52 sizeInLocations=5
{
	highp float a; // unassigned
	mediump vec3 b;
	mediump mat3 c;
};

void main (void)
{
	b = vec3(-89.0f, 30.0f, -70.0f);
	c = mat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=92 sizeInLocations=10
{
	mediump mat3x4 b;
	highp mat4x2 c;
	mediump int d[3];
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=72 sizeInLocations=6
{
	dvec3 e; // unassigned
	dmat2x3 f;
} blockD[1];

void main (void)
{
	blockB[0].a = ivec3(-89, 30, -70);
	b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	c = mat4x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d[0] = 4;
	d[1] = -60;
	d[2] = 37;
	blockD[0].f = dmat2x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
}
#version 450

struct sA
{
	dmat3x2 mA;
	dvec3 mB[4]; // unassigned
};
struct sB
{
	sA mA;
	mediump mat2 mB;
	mediump mat3x4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=16
{
	sB a;
};

void main (void)
{
	a.mA.mA = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	a.mB = mat2(-100.0, 84.0, -31.0, 68.0);
	a.mC = mat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat3x2 a;
	highp uint b;
} blockB;

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = 100u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	highp float a;
	lowp uint b;
	mediump mat4x3 c;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	lowp mat3x2 d;
	dmat2 e;
	lowp int f;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	double g;
	dvec2 h;
} blockD;

void main (void)
{
	a = -89.0f;
	b = 30u;
	c = mat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.d = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.e = dmat2(-35.0, -43.0, 48.0, 4.0);
	blockC.f = -60;
	blockD.g = 37.0;
	blockD.h = dvec2(52.0, 98.0);
}
#version 450

struct sA
{
	highp ivec4 mA;
	dmat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	double a;
	sA b;
} blockB[3];

void main (void)
{
	blockB[0].a = -89.0;
	blockB[0].b.mA = ivec4(30, -70, -60, 72);
	blockB[0].b.mB = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockB[1].a = 14.0;
	blockB[1].b.mA = ivec4(83, -117, 75, 12);
	blockB[1].b.mB = dmat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockB[2].a = 48.0;
	blockB[2].b.mA = ivec4(4, -60, 37, 52);
	blockB[2].b.mB = dmat2x3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 264) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	highp mat3x2 a;
	dvec4 b;
	lowp uvec2 c;
} blockB[3];
layout(location = 18, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=168 sizeInLocations=14
{
	dmat3 d;
	dmat4x3 e;
} blockC;
layout(location = 32, xfb_buffer = 0, xfb_offset = 232) out BlockD // sizeInBytes=32 sizeInLocations=2
{
	dvec4 f;
};

void main (void)
{
	blockB[0].a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b = dvec4(-100.0, 84.0, -31.0, 68.0);
	blockB[0].c = uvec2(104u, 14u);
	blockB[1].a = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].b = dvec4(100.0, -34.0, -35.0, -43.0);
	blockB[1].c = uvec2(48u, 4u);
	blockB[2].a = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockB[2].b = dvec4(-54.0, -79.0, 3.0, -97.0);
	blockB[2].c = uvec2(118u, 108u);
	blockC.d = dmat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	blockC.e = dmat4x3(32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0);
	f = dvec4(-122.0, -97.0, 108.0, -127.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dvec3 a;
	highp uvec4 b; // unassigned
	dmat2 c;
} blockB[2];

void main (void)
{
	blockB[0].a = dvec3(-89.0, 30.0, -70.0);
	blockB[0].c = dmat2(-60.0, 72.0, -102.0, -100.0);
	blockB[1].a = dvec3(84.0, -31.0, 68.0);
	blockB[1].c = dmat2(104.0, 14.0, 83.0, -117.0);
}
#version 450

struct sA
{
	double mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp int a;
	highp ivec3 b[1];
	sA c;
} blockB[3];
layout(location = 9, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=20 sizeInLocations=2
{
	mediump float d;
	highp ivec4 e;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 44) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 f;
};

void main (void)
{
	blockB[0].a = -89;
	blockB[0].b[0] = ivec3(30, -70, -60);
	blockB[0].c.mA = 72.0;
	blockB[1].a = -102;
	blockB[1].b[0] = ivec3(-100, 84, -31);
	blockB[1].c.mA = 68.0;
	blockB[2].a = 104;
	blockB[2].b[0] = ivec3(14, 83, -117);
	blockB[2].c.mA = 75.0;
	d = 12.0f;
	e = ivec4(-18, -101, 100, -34);
	f = ivec3(-35, -43, 48);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB[1];
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=256 sizeInLocations=16
{
	dvec4 b;
	dmat4 c;
	dmat3x4 d[1];
};
layout(location = 18, xfb_buffer = 0, xfb_offset = 280) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	lowp mat2x3 e;
};

void main (void)
{
	blockB[0].a = dvec3(-89.0, 30.0, -70.0);
	b = dvec4(-60.0, 72.0, -102.0, -100.0);
	c = dmat4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d[0] = dmat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	e = mat2x3(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=14
{
	dmat2 a;
	dmat3 b; // unassigned
	mediump vec3 c[2][3];
} blockB;

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB.c[0][0] = vec3(72.0f, -102.0f, -100.0f);
	blockB.c[0][1] = vec3(84.0f, -31.0f, 68.0f);
	blockB.c[0][2] = vec3(104.0f, 14.0f, 83.0f);
	blockB.c[1][0] = vec3(-117.0f, 75.0f, 12.0f);
	blockB.c[1][1] = vec3(-18.0f, -101.0f, 100.0f);
	blockB.c[1][2] = vec3(-34.0f, -35.0f, -43.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=7
{
	mediump mat3x4 a;
	dmat2x3 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 96, xfb_stride = 208) out BlockC // sizeInBytes=112 sizeInLocations=10
{
	lowp mat3x2 c;
	dmat3 d;
	highp vec3 e;
} blockC[3];

void main (void)
{
	blockB.a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC[0].c = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC[0].d = dmat3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[0].e = vec3(-97.0f, -118.0f, -108.0f);
	blockC[1].c = mat3x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockC[1].d = dmat3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockC[1].e = vec3(-11.0f, 87.0f, -87.0f);
	blockC[2].c = mat3x2(87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	blockC[2].d = dmat3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0);
	blockC[2].e = vec3(-6.0f, 37.0f, -112.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 0) highp mat4x2 a;
} blockB[1];
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=128 sizeInLocations=12
{
	layout(xfb_offset = 88) dmat3 d; // unassigned
	layout(xfb_offset = 32) mediump mat4x2 b;
	layout(xfb_offset = 64) highp mat2x3 c;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 160) mediump uvec2 e;
} blockD;

void main (void)
{
	blockB[0].a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.e = uvec2(48u, 4u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 8) dmat4x2 b;
	layout(xfb_offset = 0) mediump ivec2 a;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 120) highp ivec2 d;
	layout(xfb_offset = 72) mediump mat3x4 c;
} blockC;

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = dmat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = mat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = ivec2(48, 4);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 24) double b;
	layout(xfb_offset = 0) lowp mat3x2 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 32) lowp mat3x4 c;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 88) dmat3 e;
	layout(xfb_offset = 80) double d;
} blockD;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = -100.0;
	blockC.c = mat3x4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD.d = -34.0;
	blockD.e = dmat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

struct sA
{
	dmat3x4 mA;
	highp mat2 mB;
	mediump mat2x3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=424 sizeInLocations=32
{
	layout(xfb_offset = 416) lowp uint c;
	layout(xfb_offset = 0) sA a[3];
	layout(xfb_offset = 408) double b;
} blockB[1];
layout(location = 32, xfb_buffer = 0, xfb_offset = 424) out BlockC // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 424) dmat4x3 d;
};
layout(location = 40, xfb_buffer = 0, xfb_offset = 520) out BlockD // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 520) highp ivec2 e[4];
};

void main (void)
{
	blockB[0].a[0].mA = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[0].a[0].mB = mat2(83.0, -117.0, 75.0, 12.0);
	blockB[0].a[0].mC = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockB[0].a[1].mA = dmat3x4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	blockB[0].a[1].mB = mat2(-118.0, -108.0, -120.0, 48.0);
	blockB[0].a[1].mC = mat2x3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockB[0].a[2].mA = dmat3x4(-51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	blockB[0].a[2].mB = mat2(-46.0, -122.0, -97.0, 108.0);
	blockB[0].a[2].mC = mat2x3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0);
	blockB[0].b = -38.0;
	blockB[0].c = 103u;
	d = dmat4x3(-63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	e[0] = ivec2(-49, -6);
	e[1] = ivec2(98, -34);
	e[2] = ivec2(-69, -57);
	e[3] = ivec2(-8, -89);
}
#version 450

struct sA
{
	dmat3x4 mA;
	dmat2 mB;
	lowp ivec4 mC[4];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 48) dmat4x2 b;
	layout(xfb_offset = 0) lowp mat3x4 a;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 144) mediump uint e;
	layout(xfb_offset = 112) lowp ivec4 c;
	layout(xfb_offset = 128) lowp ivec4 d;
} blockC;
layout(location = 10, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=192 sizeInLocations=12
{
	layout(xfb_offset = 152) sA f;
} blockD;

void main (void)
{
	blockB.a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.c = ivec4(-35, -43, 48, 4);
	blockC.d = ivec4(-60, 37, 52, 98);
	blockC.e = 80u;
	blockD.f.mA = dmat3x4(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
	blockD.f.mB = dmat2(-62.0, 114.0, -109.0, -51.0);
	blockD.f.mC[0] = ivec4(32, 113, -44, -77);
	blockD.f.mC[1] = ivec4(-11, 66, -11, 87);
	blockD.f.mC[2] = ivec4(-87, 87, 95, -46);
	blockD.f.mC[3] = ivec4(-122, -97, 108, -127);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) double a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8, xfb_stride = 136) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 8) dmat4 b;
} blockC[3];

void main (void)
{
	blockB.a = -89.0;
	blockC[0].b = dmat4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC[1].b = dmat4(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[2].b = dmat4(-97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0);
}
#version 450

struct sA
{
	highp vec4 mA;
};
struct sB
{
	dmat2 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 32) dmat3 c;
	layout(xfb_offset = 0) lowp mat2 a;
	layout(xfb_offset = 16) highp uvec4 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=96 sizeInLocations=7
{
	layout(xfb_offset = 152) lowp mat3x4 e;
	layout(xfb_offset = 104) dmat2x3 d;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 200) out BlockD // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 200) sB f[3];
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = uvec4(72u, 102u, 100u, 84u);
	blockB.c = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	d = dmat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = mat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD.f[0].mA = dmat2(-108.0, -120.0, 48.0, -71.0);
	blockD.f[0].mB.mA = vec4(-59.0f, -40.0f, -62.0f, 114.0f);
	blockD.f[1].mA = dmat2(-109.0, -51.0, 32.0, 113.0);
	blockD.f[1].mB.mA = vec4(-44.0f, -77.0f, -11.0f, 66.0f);
	blockD.f[2].mA = dmat2(-11.0, 87.0, -87.0, 87.0);
	blockD.f[2].mB.mA = vec4(95.0f, -46.0f, -122.0f, -97.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=296 sizeInLocations=21
{
	layout(xfb_offset = 104) dmat4x2 c[3];
	layout(xfb_offset = 0) highp float a;
	layout(xfb_offset = 8) dmat4x3 b;
};

void main (void)
{
	a = -89.0f;
	b = dmat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c[0] = dmat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	c[1] = dmat4x2(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	c[2] = dmat4x2(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	layout(xfb_offset = 48) mediump int b[1];
	layout(xfb_offset = 0) dmat2x3 a;
} blockB;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b[0] = -100;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=7
{
	layout(xfb_offset = 60) highp mat3 c;
	layout(xfb_offset = 0) mediump uvec3 a;
	layout(xfb_offset = 12) mediump mat3x4 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 120) dmat3 e[1][1];
	layout(xfb_offset = 96) highp mat2x3 d;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.c = mat3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = mat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	e[0][0] = dmat3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
}
#version 450

struct sA
{
	mediump uint mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 8) dvec2 b;
	layout(xfb_offset = 0) sA a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 24) mediump uvec3 c;
} blockC;

void main (void)
{
	blockB.a.mA = 89u;
	blockB.b = dvec2(30.0, -70.0);
	blockC.c = uvec3(60u, 72u, 102u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 52) lowp uvec4 c;
	layout(xfb_offset = 0) dmat2x3 a;
	layout(xfb_offset = 48) highp uint b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 72, xfb_stride = 144) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 72) dmat3 d;
} blockC[2];

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = 100u;
	c = uvec4(84u, 31u, 68u, 104u);
	blockC[0].d = dmat3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC[1].d = dmat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 280) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat3 a;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	layout(xfb_offset = 88) dmat4 d;
	layout(xfb_offset = 72) double b;
	layout(xfb_offset = 80) double c;
} blockC;
layout(location = 22, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 216) dmat4x2 e;
} blockD;

void main (void)
{
	blockB[0].a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB[1].a = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC.b = 100.0;
	blockC.c = -34.0;
	blockC.d = dmat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD.e = dmat4x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp ivec4 a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 56) highp ivec4 d[4];
	layout(xfb_offset = 16) mediump mat2x3 b;
	layout(xfb_offset = 40) mediump ivec4 c;
} blockC;

void main (void)
{
	blockB[0].a = ivec4(-89, 30, -70, -60);
	blockC.b = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = ivec4(104, 14, 83, -117);
	blockC.d[0] = ivec4(75, 12, -18, -101);
	blockC.d[1] = ivec4(100, -34, -35, -43);
	blockC.d[2] = ivec4(48, 4, -60, 37);
	blockC.d[3] = ivec4(52, 98, -80, -62);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3 a;
} blockB;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
}
#version 450

struct sA
{
	highp uvec4 mA[2];
	dmat3x4 mB;
};
struct sB
{
	mediump mat2x3 mA; // unassigned
	sA mB;
	dvec2 mC;
};
struct sC
{
	lowp mat3 mA;
	dmat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=11
{
	layout(xfb_offset = 0) sB a;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 168) lowp vec4 b;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 184) out BlockD // sizeInBytes=152 sizeInLocations=13
{
	layout(xfb_offset = 200) sC e;
	layout(xfb_offset = 184) mediump ivec2 c; // unassigned
	layout(xfb_offset = 192) lowp uint d;
};

void main (void)
{
	blockB.a.mB.mA[0] = uvec4(89u, 30u, 70u, 60u);
	blockB.a.mB.mA[1] = uvec4(72u, 102u, 100u, 84u);
	blockB.a.mB.mB = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.a.mC = dvec2(-35.0, -43.0);
	blockC.b = vec4(48.0f, 4.0f, -60.0f, 37.0f);
	d = 52u;
	e.mA = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	e.mB = dmat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=136 sizeInLocations=9
{
	layout(xfb_offset = 16) dmat4 c; // unassigned
	layout(xfb_offset = 8) double b;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 144) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 144) lowp mat3x4 d;
} blockD;

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = -70.0;
	blockD.d = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3x2 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 24) dmat3x2 b;
};

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 40) dmat4x2 b;
	layout(xfb_offset = 0) lowp mat3 a; // unassigned
} blockB[1];

void main (void)
{
	blockB[0].b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

struct sA
{
	lowp uvec2 mA;
};
struct sB
{
	highp ivec4 mA;
	sA mB; // unassigned
	mediump uvec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=12
{
	layout(xfb_offset = 0) mediump mat4x2 a[3];
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 200) highp vec2 d;
	layout(xfb_offset = 96) dmat3 b;
	layout(xfb_offset = 168) dvec4 c;
};
layout(location = 21, xfb_buffer = 0, xfb_offset = 208) out BlockD // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 248) dmat2 f;
	layout(xfb_offset = 208) sB e;
} blockD[1];

void main (void)
{
	blockB.a[0] = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b = dmat3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	c = dvec4(-97.0, -118.0, -108.0, -120.0);
	d = vec2(48.0f, -71.0f);
	blockD[0].e.mA = ivec4(-59, -40, -62, 114);
	blockD[0].e.mC = uvec4(109u, 51u, 32u, 113u);
	blockD[0].f = dmat2(-44.0, -77.0, -11.0, 66.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=5
{
	layout(xfb_offset = 12) mediump mat4x2 b;
	layout(xfb_offset = 0) lowp ivec3 a; // unassigned
} blockB;

void main (void)
{
	blockB.b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

struct sA
{
	mediump uint mA;
	highp int mB;
	dmat3x4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 224) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uvec2 a[1];
} blockB[3];
layout(location = 3, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=168 sizeInLocations=12
{
	layout(xfb_offset = 112) lowp mat4 c;
	layout(xfb_offset = 8) sA b;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 176, xfb_stride = 224) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 176) dmat3x2 d;
} blockD[3];

void main (void)
{
	blockB[0].a[0] = uvec2(89u, 30u);
	blockB[1].a[0] = uvec2(70u, 60u);
	blockB[2].a[0] = uvec2(72u, 102u);
	blockC.b.mA = 100u;
	blockC.b.mB = 84;
	blockC.b.mC = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.c = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD[0].d = dmat3x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockD[1].d = dmat3x2(114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockD[2].d = dmat3x2(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=7
{
	layout(xfb_offset = 32) highp mat3 b;
	layout(xfb_offset = 0) lowp mat4x2 a;
};

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
}
#version 450

struct sA
{
	lowp mat3x4 mA;
	dvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	layout(xfb_offset = 16) highp mat2x3 c;
	layout(xfb_offset = 0) lowp uvec2 a;
	layout(xfb_offset = 8) double b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 40) lowp ivec3 d;
} blockC[1];
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockD // sizeInBytes=160 sizeInLocations=12
{
	layout(xfb_offset = 144) dmat3 g;
	layout(xfb_offset = 56) dvec2 e;
	layout(xfb_offset = 72) sA f;
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = -70.0;
	c = mat2x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC[0].d = ivec3(68, 104, 14);
	e = dvec2(83.0, -117.0);
	f.mA = mat3x4(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	f.mB = dvec3(52.0, 98.0, -80.0);
	g = dmat3(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
}
#version 450

struct sA
{
	dmat3x4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 200) out BlockB // sizeInBytes=200 sizeInLocations=13
{
	layout(xfb_offset = 104) dmat3x4 c;
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 96) lowp vec2 b;
} blockB[2];

void main (void)
{
	blockB[0].a.mA = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[0].b = vec2(83.0f, -117.0f);
	blockB[0].c = dmat3x4(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockB[1].a.mA = dmat3x4(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockB[1].b = vec2(-71.0f, -59.0f);
	blockB[1].c = dmat3x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp vec2 a;
} blockB[2];

void main (void)
{
	blockB[0].a = vec2(-89.0f, 30.0f);
	blockB[1].a = vec2(-70.0f, -60.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=7
{
	layout(xfb_offset = 16) dmat3x2 b;
	layout(xfb_offset = 0) highp float a[4];
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 64) dmat2 c;
} blockC;

void main (void)
{
	a[0] = -89.0f;
	a[1] = 30.0f;
	a[2] = -70.0f;
	a[3] = -60.0f;
	b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = dmat2(104.0, 14.0, 83.0, -117.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	layout(xfb_offset = 112) highp vec4 c;
	layout(xfb_offset = 0) mediump mat4x3 a[2];
	layout(xfb_offset = 96) dvec2 b; // unassigned
};

void main (void)
{
	a[0] = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	a[1] = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = vec4(-60.0f, 37.0f, 52.0f, 98.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 40) lowp uvec3 c;
	layout(xfb_offset = 0) double a; // unassigned
	layout(xfb_offset = 8) dmat2 b;
};

void main (void)
{
	b = dmat2(-89.0, 30.0, -70.0, -60.0);
	c = uvec3(72u, 102u, 100u);
}
#version 450

struct sA
{
	dmat4x2 mA;
	mediump ivec2 mB;
	dmat3x2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	layout(xfb_offset = 0) sA a;
};

void main (void)
{
	a.mA = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	a.mB = ivec2(-31, 68);
	a.mC = dmat3x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

struct sA
{
	mediump uint mA;
	dmat3x4 mB;
	mediump mat2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=13
{
	layout(xfb_offset = 32) sA b;
	layout(xfb_offset = 0) lowp mat4x2 a; // unassigned
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 152) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 200) mediump ivec4 d;
	layout(xfb_offset = 152) dmat3x2 c;
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=48 sizeInLocations=5
{
	layout(xfb_offset = 248) dvec2 g; // unassigned
	layout(xfb_offset = 216) double e[3]; // unassigned
	layout(xfb_offset = 240) lowp vec2 f;
} blockD;

void main (void)
{
	b.mA = 89u;
	b.mB = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	b.mC = mat2(-117.0, 75.0, 12.0, -18.0);
	blockC.c = dmat3x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.d = ivec4(4, -60, 37, 52);
	blockD.f = vec2(98.0f, -80.0f);
}
#version 450

struct sA
{
	dmat3 mA;
	mediump mat3 mB;
	lowp int mC; // unassigned
};
struct sB
{
	dmat2x3 mA;
};
struct sC
{
	sB mA; // unassigned
	highp mat3x4 mB[3];
	lowp vec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=10
{
	layout(xfb_offset = 0) sA a;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 112, xfb_stride = 1152) out BlockC // sizeInBytes=1024 sizeInLocations=68
{
	layout(xfb_offset = 1072) dmat4x2 d;
	layout(xfb_offset = 112) sC b[4];
	layout(xfb_offset = 944) dmat4 c[1];
} blockC[2];
layout(location = 146, xfb_buffer = 0, xfb_offset = 1136) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 1136) highp ivec4 e;
};

void main (void)
{
	blockB.a.mA = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.a.mB = mat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC[0].b[0].mB[0] = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockC[0].b[0].mB[1] = mat3x4(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockC[0].b[0].mB[2] = mat3x4(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockC[0].b[0].mC = vec4(87.0f, 95.0f, -46.0f, -122.0f);
	blockC[0].b[1].mB[0] = mat3x4(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0);
	blockC[0].b[1].mB[1] = mat3x4(37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0);
	blockC[0].b[1].mB[2] = mat3x4(98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0);
	blockC[0].b[1].mC = vec4(-35.0f, -127.0f, 44.0f, 56.0f);
	blockC[0].b[2].mB[0] = mat3x4(-33.0, 109.0, -119.0, 34.0, -102.0, 104.0, 33.0, 127.0, 121.0, 42.0, -34.0, -92.0);
	blockC[0].b[2].mB[1] = mat3x4(75.0, -68.0, 84.0, -4.0, 38.0, 119.0, -79.0, 39.0, -7.0, 119.0, -75.0, 19.0);
	blockC[0].b[2].mB[2] = mat3x4(-79.0, -31.0, 50.0, 79.0, -21.0, -5.0, -88.0, -104.0, -84.0, -36.0, 61.0, -37.0);
	blockC[0].b[2].mC = vec4(15.0f, 107.0f, 112.0f, -16.0f);
	blockC[0].b[3].mB[0] = mat3x4(5.0, -11.0, -98.0, 29.0, -61.0, 34.0, -108.0, -21.0, -40.0, -116.0, 108.0, -100.0);
	blockC[0].b[3].mB[1] = mat3x4(77.0, -56.0, 89.0, -73.0, 115.0, -14.0, 9.0, -74.0, 41.0, -5.0, -16.0, 34.0);
	blockC[0].b[3].mB[2] = mat3x4(-126.0, 30.0, -78.0, -110.0, 96.0, -102.0, -59.0, 117.0, 66.0, 90.0, -125.0, -33.0);
	blockC[0].b[3].mC = vec4(-51.0f, -57.0f, -47.0f, 39.0f);
	blockC[0].c[0] = dmat4(-78.0, 76.0, -11.0, 50.0, -121.0, 44.0, -112.0, -109.0, 26.0, -98.0, -98.0, 60.0, -95.0, -72.0, 95.0, -74.0);
	blockC[0].d = dmat4x2(89.0, 90.0, 65.0, 19.0, -28.0, 38.0, 100.0, -100.0);
	blockC[1].b[0].mB[0] = mat3x4(7.0, -79.0, 67.0, 14.0, -75.0, -26.0, 19.0, 111.0, -46.0, 122.0, -62.0, 23.0);
	blockC[1].b[0].mB[1] = mat3x4(-77.0, -93.0, -99.0, -64.0, 23.0, -19.0, -87.0, -74.0, 112.0, 122.0, -119.0, -34.0);
	blockC[1].b[0].mB[2] = mat3x4(-85.0, 12.0, -61.0, 89.0, 79.0, 25.0, 18.0, 107.0, 88.0, 38.0, -127.0, 92.0);
	blockC[1].b[0].mC = vec4(92.0f, 15.0f, -34.0f, -92.0f);
	blockC[1].b[1].mB[0] = mat3x4(-71.0, -43.0, 109.0, 68.0, 124.0, 114.0, 11.0, 40.0, -65.0, 56.0, -86.0, -31.0);
	blockC[1].b[1].mB[1] = mat3x4(-49.0, -21.0, -27.0, -42.0, 90.0, -61.0, 5.0, 40.0, -72.0, 63.0, -121.0, 126.0);
	blockC[1].b[1].mB[2] = mat3x4(-51.0, -23.0, 70.0, -95.0, 56.0, -66.0, 42.0, -36.0, -120.0, -25.0, -59.0, 25.0);
	blockC[1].b[1].mC = vec4(-118.0f, 93.0f, -87.0f, 15.0f);
	blockC[1].b[2].mB[0] = mat3x4(108.0, 6.0, -94.0, 25.0, -51.0, 84.0, -119.0, -2.0, 61.0, -68.0, -27.0, -80.0);
	blockC[1].b[2].mB[1] = mat3x4(29.0, -10.0, -105.0, 92.0, -74.0, -88.0, -118.0, -61.0, 74.0, 46.0, 29.0, 116.0);
	blockC[1].b[2].mB[2] = mat3x4(3.0, 96.0, -15.0, -7.0, 106.0, 90.0, 50.0, 101.0, 85.0, 98.0, 112.0, 26.0);
	blockC[1].b[2].mC = vec4(-72.0f, -61.0f, 42.0f, -48.0f);
	blockC[1].b[3].mB[0] = mat3x4(99.0, -116.0, 120.0, -107.0, 53.0, -102.0, -8.0, 22.0, 106.0, 22.0, 58.0, -69.0);
	blockC[1].b[3].mB[1] = mat3x4(31.0, -21.0, -52.0, 9.0, -4.0, 1.0, 74.0, -111.0, -112.0, -77.0, 23.0, -102.0);
	blockC[1].b[3].mB[2] = mat3x4(-39.0, 39.0, -115.0, 13.0, 125.0, -115.0, -117.0, 104.0, -109.0, 32.0, -101.0, -5.0);
	blockC[1].b[3].mC = vec4(25.0f, -91.0f, -119.0f, -20.0f);
	blockC[1].c[0] = dmat4(-82.0, -26.0, -26.0, -105.0, 88.0, -33.0, -74.0, -66.0, 32.0, 113.0, -104.0, 119.0, 77.0, -112.0, 125.0, 69.0);
	blockC[1].d = dmat4x2(-64.0, 92.0, -15.0, 99.0, -118.0, -62.0, -86.0, -76.0);
	e = ivec4(121, 88, -2, -109);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 144) out BlockB // sizeInBytes=40 sizeInLocations=5
{
	layout(xfb_offset = 8) mediump mat4x2 b;
	layout(xfb_offset = 0) highp uvec2 a; // unassigned
} blockB[2];
layout(location = 10, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 104) highp mat3 e;
	layout(xfb_offset = 40) dvec2 c[2];
	layout(xfb_offset = 72) dmat2 d; // unassigned
} blockC;

void main (void)
{
	blockB[0].b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[1].b = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c[0] = dvec2(-18.0, -101.0);
	blockC.c[1] = dvec2(100.0, -34.0);
	blockC.e = mat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

struct sA
{
	dmat3x2 mA;
	dmat3x4 mB;
};
struct sB
{
	sA mA;
	mediump mat2x3 mB;
	dmat3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) lowp mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40, xfb_stride = 344) out BlockC // sizeInBytes=280 sizeInLocations=21
{
	layout(xfb_offset = 304) lowp vec4 d;
	layout(xfb_offset = 40) highp mat3x2 b;
	layout(xfb_offset = 64) sB c;
} blockC[3];
layout(location = 66, xfb_buffer = 0, xfb_offset = 320) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 320) dvec3 e;
} blockD;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC[0].b = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC[0].c.mA.mA = dmat3x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockC[0].c.mA.mB = dmat3x4(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[0].c.mB = mat2x3(-97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockC[0].c.mC = dmat3(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC[0].d = vec4(-77.0f, -11.0f, 66.0f, -11.0f);
	blockC[1].b = mat3x2(87.0, -87.0, 87.0, 95.0, -46.0, -122.0);
	blockC[1].c.mA.mA = dmat3x2(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	blockC[1].c.mA.mB = dmat3x4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	blockC[1].c.mB = mat2x3(-17.0, 54.0, -50.0, -84.0, -49.0, -6.0);
	blockC[1].c.mC = dmat3(98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0);
	blockC[1].d = vec4(-110.0f, 28.0f, -112.0f, -35.0f);
	blockC[2].b = mat3x2(-127.0, 44.0, 56.0, -33.0, 109.0, -119.0);
	blockC[2].c.mA.mA = dmat3x2(34.0, -102.0, 104.0, 33.0, 127.0, 121.0);
	blockC[2].c.mA.mB = dmat3x4(42.0, -34.0, -92.0, 75.0, -68.0, 84.0, -4.0, 38.0, 119.0, -79.0, 39.0, -7.0);
	blockC[2].c.mB = mat2x3(119.0, -75.0, 19.0, -79.0, -31.0, 50.0);
	blockC[2].c.mC = dmat3(79.0, -21.0, -5.0, -88.0, -104.0, -84.0, -36.0, 61.0, -37.0);
	blockC[2].d = vec4(15.0f, 107.0f, 112.0f, -16.0f);
	blockD.e = dvec3(5.0, -11.0, -98.0);
}
#version 450

struct sA
{
	mediump uvec3 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 144) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 16) lowp vec2 b;
	layout(xfb_offset = 0) mediump mat2 a;
} blockB[3];
layout(location = 9, xfb_buffer = 0, xfb_offset = 24, xfb_stride = 144) out BlockC // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 96) dvec3 d;
	layout(xfb_offset = 24) dmat3 c;
} blockC[2];
layout(location = 25, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 132) lowp ivec2 f;
	layout(xfb_offset = 120) sA e;
};

void main (void)
{
	blockB[0].a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = vec2(72.0f, -102.0f);
	blockB[1].a = mat2(-100.0, 84.0, -31.0, 68.0);
	blockB[1].b = vec2(104.0f, 14.0f);
	blockB[2].a = mat2(83.0, -117.0, 75.0, 12.0);
	blockB[2].b = vec2(-18.0f, -101.0f);
	blockC[0].c = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockC[0].d = dvec3(98.0, -80.0, -62.0);
	blockC[1].c = dmat3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockC[1].d = dvec3(-59.0, -40.0, -62.0);
	f = ivec2(114, -109);
}
#version 450

struct sA
{
	mediump mat3x4 mA;
};
struct sB
{
	dmat4x3 mA;
	dmat4x2 mB;
	dmat4x3 mC;
};
struct sC
{
	sA mA;
	sB mB;
	mediump vec4 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=11
{
	layout(xfb_offset = 48) dmat2 b[4];
	layout(xfb_offset = 0) lowp mat3x4 a;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=328 sizeInLocations=25
{
	layout(xfb_offset = 184) sC d;
	layout(xfb_offset = 176) mediump ivec2 c;
};
layout(location = 36, xfb_buffer = 0, xfb_offset = 504) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 528) highp uvec3 f;
	layout(xfb_offset = 504) lowp mat2x3 e;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0] = dmat2(83.0, -117.0, 75.0, 12.0);
	b[1] = dmat2(-18.0, -101.0, 100.0, -34.0);
	b[2] = dmat2(-35.0, -43.0, 48.0, 4.0);
	b[3] = dmat2(-60.0, 37.0, 52.0, 98.0);
	c = ivec2(-80, -62);
	d.mA.mA = mat3x4(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	d.mB.mA = dmat4x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	d.mB.mB = dmat4x2(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0);
	d.mB.mC = dmat4x3(113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0);
	e = mat2x3(-22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	f = uvec3(49u, 6u, 98u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 56) mediump mat2x3 c; // unassigned
	layout(xfb_offset = 0) highp mat3x4 a;
	layout(xfb_offset = 48) mediump vec2 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 80) lowp uvec4 d;
} blockC;

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = vec2(83.0f, -117.0f);
	blockC.d = uvec4(75u, 12u, 18u, 101u);
}
#version 450

struct sA
{
	mediump uvec2 mA;
	lowp int mB;
	highp ivec2 mC;
};
struct sB
{
	dmat2x3 mA;
	double mB;
	dmat2x3 mC;
};
struct sC
{
	sB mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=12
{
	layout(xfb_offset = 24) sC b;
	layout(xfb_offset = 0) sA a;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 184) dmat2 e;
	layout(xfb_offset = 128) highp mat3x2 c;
	layout(xfb_offset = 152) dmat2 d;
};
layout(location = 19, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 248) dmat2 g;
	layout(xfb_offset = 216) dvec4 f;
} blockD[1];

void main (void)
{
	a.mA = uvec2(89u, 30u);
	a.mB = -70;
	a.mC = ivec2(-60, 72);
	b.mA.mA = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	b.mA.mB = 14.0;
	b.mA.mC = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = dmat2(-60.0, 37.0, 52.0, 98.0);
	e = dmat2(-80.0, -62.0, -54.0, -79.0);
	blockD[0].f = dvec4(3.0, -97.0, -118.0, -108.0);
	blockD[0].g = dmat2(-120.0, 48.0, -71.0, -59.0);
}
#version 450

struct sA
{
	dmat4x3 mA;
	dvec2 mB;
};
struct sB
{
	dmat2x3 mA;
	double mB; // unassigned
	highp ivec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump vec2 a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=184 sizeInLocations=15
{
	layout(xfb_offset = 120) sB c;
	layout(xfb_offset = 8) sA b; // unassigned
} blockC;
layout(location = 16, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=176 sizeInLocations=11
{
	layout(xfb_offset = 320) lowp mat3x4 e;
	layout(xfb_offset = 192) dmat4 d;
} blockD;

void main (void)
{
	blockB[0].a = vec2(-89.0f, 30.0f);
	blockC.c.mA = dmat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC.c.mC = ivec4(-31, 68, 104, 14);
	blockD.d = dmat4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.e = mat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
}
#version 450

struct sA
{
	mediump ivec2 mA;
};
struct sB
{
	mediump vec4 mA;
	lowp int mB;
	highp ivec4 mC[1][3];
};
struct sC
{
	sB mA;
	dmat3x4 mB;
	highp mat4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=16
{
	layout(xfb_offset = 8) sC b;
	layout(xfb_offset = 0) sA a;
} blockB;
layout(location = 16, xfb_buffer = 0, xfb_offset = 240, xfb_stride = 256) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 240) highp ivec4 c;
} blockC[2];

void main (void)
{
	blockB.a.mA = ivec2(-89, 30);
	blockB.b.mA.mA = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
	blockB.b.mA.mB = -100;
	blockB.b.mA.mC[0][0] = ivec4(84, -31, 68, 104);
	blockB.b.mA.mC[0][1] = ivec4(14, 83, -117, 75);
	blockB.b.mA.mC[0][2] = ivec4(12, -18, -101, 100);
	blockB.b.mB = dmat3x4(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	blockB.b.mC = mat4(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	blockC[0].c = ivec4(-44, -77, -11, 66);
	blockC[1].c = ivec4(-11, 87, -87, 87);
}
#version 450

struct sA
{
	lowp mat4x2 mA;
	lowp mat2 mB; // unassigned
	lowp float mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 192) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump vec3 a;
} blockB[2];
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 12) lowp mat4 b;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=112 sizeInLocations=12
{
	layout(xfb_offset = 184) lowp ivec2 e;
	layout(xfb_offset = 80) sA c;
	layout(xfb_offset = 136) dmat2x3 d;
} blockD;

void main (void)
{
	blockB[0].a = vec3(-89.0f, 30.0f, -70.0f);
	blockB[1].a = vec3(-60.0f, 72.0f, -102.0f);
	blockC.b = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.c.mA = mat4x2(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockD.c.mC = -54.0f;
	blockD.d = dmat2x3(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.e = ivec2(48, -71);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uvec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 16) dmat3x4 b;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	b = dmat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 176) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4 a;
} blockB[3];
layout(location = 24, xfb_buffer = 0, xfb_offset = 128, xfb_stride = 176) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 128) dvec4 b;
} blockC[2];
layout(location = 28, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 160) mediump vec4 c;
} blockD;

void main (void)
{
	blockB[0].a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB[1].a = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB[2].a = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC[0].b = dvec4(-77.0, -11.0, 66.0, -11.0);
	blockC[1].b = dvec4(87.0, -87.0, 87.0, 95.0);
	blockD.c = vec4(-46.0f, -122.0f, -97.0f, 108.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 16) dvec4 b;
} blockC;

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.b = dvec4(72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) highp mat3x4 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 88) mediump mat4 d;
	layout(xfb_offset = 48) mediump mat4x2 b;
	layout(xfb_offset = 80) lowp uvec2 c;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 192) double g;
	layout(xfb_offset = 152) lowp mat2x3 e;
	layout(xfb_offset = 176) mediump uvec3 f;
} blockD;

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	c = uvec2(35u, 43u);
	d = mat4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockD.e = mat2x3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockD.f = uvec3(51u, 32u, 113u);
	blockD.g = -44.0;
}
#version 450

struct sA
{
	lowp mat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 40) highp mat3x2 c;
	layout(xfb_offset = 0) dvec2 a;
	layout(xfb_offset = 16) sA b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b.mA = mat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c = mat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

struct sA
{
	lowp mat4x2 mA;
	dmat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump float a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 4, xfb_stride = 432) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 4) mediump uint b;
} blockC[2];
layout(location = 3, xfb_buffer = 0, xfb_offset = 8) out BlockD // sizeInBytes=424 sizeInLocations=33
{
	layout(xfb_offset = 424) mediump int e;
	layout(xfb_offset = 8) dmat4 c;
	layout(xfb_offset = 136) sA d[3];
} blockD;

void main (void)
{
	blockB[0].a = -89.0f;
	blockC[0].b = 30u;
	blockC[1].b = 70u;
	blockD.c = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD.d[0].mA = mat4x2(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockD.d[0].mB = dmat4x2(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD.d[1].mA = mat4x2(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
	blockD.d[1].mB = dmat4x2(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockD.d[2].mA = mat4x2(-11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0);
	blockD.d[2].mB = dmat4x2(108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0);
	blockD.e = -103;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=256 sizeInLocations=16
{
	layout(xfb_offset = 8) dmat4x2 b[4];
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 264) out BlockD // sizeInBytes=48 sizeInLocations=5
{
	layout(xfb_offset = 264) mediump float c;
	layout(xfb_offset = 272) dmat2 d;
	layout(xfb_offset = 304) highp int e[2];
} blockD;

void main (void)
{
	a = 89u;
	blockC.b[0] = dmat4x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b[1] = dmat4x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.b[2] = dmat4x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockC.b[3] = dmat4x2(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockD.c = -97.0f;
	blockD.d = dmat2(-118.0, -108.0, -120.0, 48.0);
	blockD.e[0] = -71;
	blockD.e[1] = -59;
}
#version 450

struct sA
{
	mediump mat4x2 mA;
	dmat4x2 mB[1]; // unassigned
	dmat3 mC;
};
struct sB
{
	dvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=14
{
	layout(xfb_offset = 0) sA a;
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 168) dvec2 b;
	// layout(xfb_offset = 184) sB c; // missing field
} blockC;

void main (void)
{
	a.mA = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	a.mC = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.b = dvec2(-101.0, 100.0);
}
#version 450

struct sA
{
	lowp mat4 mA; // unassigned
	mediump uvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=8
{
	layout(xfb_offset = 0) lowp mat4x2 a; // unassigned
	layout(xfb_offset = 32) highp mat2x3 b;
	layout(xfb_offset = 56) lowp mat2 c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=92 sizeInLocations=6
{
	layout(xfb_offset = 72) mediump uvec4 d[1];
	layout(xfb_offset = 88) sA e;
} blockC;

void main (void)
{
	b = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = mat2(-100.0, 84.0, -31.0, 68.0);
	blockC.d[0] = uvec4(104u, 14u, 83u, 117u);
	blockC.e.mB = uvec3(75u, 12u, 18u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=60 sizeInLocations=5
{
	layout(xfb_offset = 0) lowp ivec3 a;
	layout(xfb_offset = 12) mediump mat4x3 b;
};

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = mat4x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
}
#version 450

struct sA
{
	mediump vec4 mA;
	mediump int mB;
};
struct sB
{
	mediump mat3 mA;
	lowp mat3x4 mB;
	lowp mat3 mC; // unassigned
};
struct sC
{
	lowp vec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump uvec3 a;
	layout(xfb_offset = 12) sA b; // unassigned
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=148 sizeInLocations=11
{
	layout(xfb_offset = 32) sB c;
	layout(xfb_offset = 152) mediump ivec4 d;
	layout(xfb_offset = 168) sC e;
};

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	c.mA = mat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c.mB = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = ivec4(-60, 37, 52, 98);
	e.mA = vec3(-80.0f, -62.0f, -54.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4x3 a;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=368 sizeInLocations=25
{
	layout(xfb_offset = 96) lowp mat3x4 b[3][2];
	layout(xfb_offset = 384) lowp int c;
	layout(xfb_offset = 392) dmat3 d;
};

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0][0] = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[0][1] = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	b[1][0] = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	b[1][1] = mat3x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	b[2][0] = mat3x4(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	b[2][1] = mat3x4(88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	c = -69;
	d = dmat3(-57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat3x4 a;
	layout(xfb_offset = 96) dvec4 b; // unassigned
} blockB;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

struct sA
{
	dmat2 mA;
};
struct sB
{
	sA mA[1][1];
	dmat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 16) dmat3x2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 64) highp float c;
	layout(xfb_offset = 72) sB d;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	c = 104.0f;
	d.mA[0][0].mA = dmat2(14.0, 83.0, -117.0, 75.0);
	d.mB = dmat2x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) highp uvec4 a;
	layout(xfb_offset = 16) highp ivec4 b;
	layout(xfb_offset = 32) dmat2 c;
};

void main (void)
{
	a = uvec4(89u, 30u, 70u, 60u);
	b = ivec4(72, -102, -100, 84);
	c = dmat2(-31.0, 68.0, 104.0, 14.0);
}
#version 450

struct sA
{
	lowp mat2x3 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) highp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 4) lowp ivec3 b; // unassigned
	layout(xfb_offset = 16) sA c;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 40) lowp vec4 d;
} blockD;

void main (void)
{
	a = 89u;
	blockD.d = vec4(30.0f, -70.0f, -60.0f, 72.0f);
}
#version 450

struct sA
{
	highp mat3 mA;
	highp uint mB;
	highp mat4 mC;
};
struct sB
{
	dmat3x4 mA;
};
struct sC
{
	dmat3 mA[4];
	sB mB;
	highp ivec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=11
{
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 104) highp mat2x3 b;
	layout(xfb_offset = 128) highp uvec4 c[1]; // unassigned
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=400 sizeInLocations=31
{
	layout(xfb_offset = 144) sC d;
} blockC;

void main (void)
{
	a.mA = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	a.mB = 68u;
	a.mC = mat4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	b = mat2x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC.d.mA[0] = dmat3(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
	blockC.d.mA[1] = dmat3(-62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0);
	blockC.d.mA[2] = dmat3(66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0);
	blockC.d.mA[3] = dmat3(108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0);
	blockC.d.mB.mA = dmat3x4(-63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	blockC.d.mC = ivec4(-49, -6, 98, -34);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) lowp mat3x4 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=56 sizeInLocations=6
{
	layout(xfb_offset = 48) dvec3 b;
	layout(xfb_offset = 72) highp mat4x2 c;
};

void main (void)
{
	blockB.a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = dvec3(83.0, -117.0, 75.0);
	c = mat4x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
}
#version 450

struct sA
{
	highp mat2x3 mA;
	double mB;
	lowp int mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump vec4 a;
	layout(xfb_offset = 16) highp mat2 b;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 32) lowp mat4x2 c[1];
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=48 sizeInLocations=5
{
	layout(xfb_offset = 64) highp int d;
	layout(xfb_offset = 72) sA e;
} blockD;

void main (void)
{
	blockB.a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockB.b = mat2(72.0, -102.0, -100.0, 84.0);
	c[0] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockD.d = -18;
	blockD.e.mA = mat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockD.e.mB = 4.0;
	blockD.e.mC = -60;
}
#version 450

struct sA
{
	mediump uvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 0) dmat2 a;
	layout(xfb_offset = 32) dmat4x3 b;
	layout(xfb_offset = 128) double c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 136) lowp ivec3 d;
	layout(xfb_offset = 148) highp ivec4 e;
	layout(xfb_offset = 164) sA f;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = -18.0;
	d = ivec3(-101, 100, -34);
	e = ivec4(-35, -43, 48, 4);
	f.mA = uvec3(60u, 37u, 52u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) highp mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=96 sizeInLocations=9
{
	layout(xfb_offset = 40) dmat3 b; // unassigned
	// layout(xfb_offset = 112) mediump mat2 c; // missing field
	layout(xfb_offset = 128) lowp ivec2 d;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 136) out BlockD // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 136) mediump vec2 e;
	layout(xfb_offset = 144) dvec3 f;
};

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.d = ivec2(68, 104);
	e = vec2(14.0f, 83.0f);
	f = dvec3(-117.0, 75.0, 12.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 0) lowp mat2x3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 24) lowp ivec3 b; // unassigned
	layout(xfb_offset = 36) lowp uvec4 c;
	layout(xfb_offset = 52) mediump mat3 d;
};

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = uvec4(100u, 84u, 31u, 68u);
	d = mat3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
}
#version 450

struct sA
{
	highp vec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	// layout(xfb_offset = 0) lowp uint a; // missing field
	layout(xfb_offset = 4) sA b;
};

void main (void)
{
	b.mA = vec3(-89.0f, 30.0f, -70.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	// layout(xfb_offset = 0) highp uint a; // missing field
	layout(xfb_offset = 4) mediump ivec2 b;
} blockB;

void main (void)
{
	blockB.b = ivec2(-89, 30);
}
#version 450

struct sA
{
	mediump mat2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	layout(xfb_offset = 0) sA a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=256 sizeInLocations=19
{
	layout(xfb_offset = 16) highp mat3 b[4];
	layout(xfb_offset = 160) dvec4 c[3];
	// layout(xfb_offset = 256) highp uvec3 d; // missing field
};

void main (void)
{
	a.mA = mat2(-89.0, 30.0, -70.0, -60.0);
	b[0] = mat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	b[1] = mat3(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	b[2] = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	b[3] = mat3(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	c[0] = dvec4(-40.0, -62.0, 114.0, -109.0);
	c[1] = dvec4(-51.0, 32.0, 113.0, -44.0);
	c[2] = dvec4(-77.0, -11.0, 66.0, -11.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=10
{
	layout(xfb_offset = 0) lowp uvec3 a;
	layout(xfb_offset = 12) mediump uvec2 b;
	layout(xfb_offset = 24) dmat4x3 c; // unassigned
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=76 sizeInLocations=7
{
	layout(xfb_offset = 120) highp mat3x2 d;
	// layout(xfb_offset = 144) mediump mat3 e; // missing field
	layout(xfb_offset = 180) lowp uvec4 f;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.b = uvec2(60u, 72u);
	d = mat3x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	f = uvec4(14u, 83u, 117u, 75u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 0) highp uvec3 a; // unassigned
	// layout(xfb_offset = 16) dmat4x2 b; // missing field
	layout(xfb_offset = 80) dmat4x2 c;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 144) mediump ivec3 d[4];
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	// layout(xfb_offset = 192) lowp mat2 e[1]; // missing field
	layout(xfb_offset = 208) mediump mat4 f;
} blockD;

void main (void)
{
	blockB.c = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	d[0] = ivec3(-31, 68, 104);
	d[1] = ivec3(14, 83, -117);
	d[2] = ivec3(75, 12, -18);
	d[3] = ivec3(-101, 100, -34);
	blockD.f = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

struct sA
{
	dmat2 mA;
};
struct sB
{
	highp ivec2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 0) highp uvec3 a;
	layout(xfb_offset = 16) sA b;
	// layout(xfb_offset = 48) sB c[2]; // missing field
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 64) highp ivec2 d;
} blockC;

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b.mA = dmat2(-60.0, 72.0, -102.0, -100.0);
	blockC.d = ivec2(84, -31);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp uint a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 8) dmat2 b;
	layout(xfb_offset = 40) lowp uvec3 c;
	// layout(xfb_offset = 52) highp uvec2 d; // missing field
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=56 sizeInLocations=6
{
	layout(xfb_offset = 64) highp uvec2 e[4];
	layout(xfb_offset = 96) dvec2 f;
	layout(xfb_offset = 112) mediump int g;
} blockD;

void main (void)
{
	blockB.a = 89u;
	b = dmat2(30.0, -70.0, -60.0, 72.0);
	c = uvec3(102u, 100u, 84u);
	blockD.e[0] = uvec2(31u, 68u);
	blockD.e[1] = uvec2(104u, 14u);
	blockD.e[2] = uvec2(83u, 117u);
	blockD.e[3] = uvec2(75u, 12u);
	blockD.f = dvec2(-18.0, -101.0);
	blockD.g = 100;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	// layout(xfb_offset = 0) lowp ivec4 a; // missing field
	layout(xfb_offset = 16) dvec2 b;
	layout(xfb_offset = 32) double c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 40) lowp uvec3 d;
} blockC;

void main (void)
{
	blockB.b = dvec2(-89.0, 30.0);
	blockB.c = -70.0;
	blockC.d = uvec3(60u, 72u, 102u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=6
{
	layout(xfb_offset = 0) mediump mat3x2 a;
	layout(xfb_offset = 24) lowp uint b[2];
	layout(xfb_offset = 32) mediump ivec3 c;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 48) mediump float d;
	layout(xfb_offset = 56) dvec2 e; // unassigned
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 72) highp vec2 f;
	// layout(xfb_offset = 80) lowp mat4 g; // missing field
} blockD;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b[0] = 100u;
	b[1] = 84u;
	c = ivec3(-31, 68, 104);
	blockC.d = 14.0f;
	blockD.f = vec2(83.0f, -117.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 0) highp vec2 a;
	layout(xfb_offset = 8) lowp uvec4 b; // unassigned
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 24) dvec3 c;
} blockC;

void main (void)
{
	blockB.a = vec2(-89.0f, 30.0f);
	blockC.c = dvec3(-70.0, -60.0, 72.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 0) dmat4 a;
	layout(xfb_offset = 128) lowp mat3x4 b;
	// layout(xfb_offset = 176) dvec4 c; // missing field
} blockB;
layout(location = 13, xfb_buffer = 0, xfb_offset = 208) out BlockC // sizeInBytes=36 sizeInLocations=5
{
	layout(xfb_offset = 208) mediump mat4x2 d;
	layout(xfb_offset = 240) mediump uint e;
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 248) out BlockD // sizeInBytes=200 sizeInLocations=16
{
	layout(xfb_offset = 248) mediump int f;
	layout(xfb_offset = 256) dmat3 g[2];
	layout(xfb_offset = 400) mediump mat3x4 h;
};

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.b = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC.d = mat4x2(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockC.e = 120u;
	f = 48;
	g[0] = dmat3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	g[1] = dmat3(-44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	h = mat3x4(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=12
{
	layout(xfb_offset = 0) dmat4x2 a[3];
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 192) dmat4x2 b;
} blockC;

void main (void)
{
	blockB.a[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.b = dmat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
}
#version 450

struct sA
{
	mediump mat4 mA;
	lowp ivec2 mB;
	highp uint mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 0) lowp vec3 a;
	layout(xfb_offset = 12) lowp uvec2 b;
	layout(xfb_offset = 24) dvec4 c;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=104 sizeInLocations=8
{
	// layout(xfb_offset = 56) sA d; // missing field
	layout(xfb_offset = 132) lowp uvec3 e;
	// layout(xfb_offset = 144) dvec2 f; // missing field
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=264 sizeInLocations=18
{
	layout(xfb_offset = 160) dmat4x2 g;
	layout(xfb_offset = 224) dmat3 h;
	layout(xfb_offset = 296) dmat4 i;
} blockD;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = uvec2(60u, 72u);
	blockB.c = dvec4(-102.0, -100.0, 84.0, -31.0);
	blockC.e = uvec3(68u, 104u, 14u);
	blockD.g = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockD.h = dmat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockD.i = dmat4(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=14
{
	layout(xfb_offset = 0) lowp mat4x2 a;
	layout(xfb_offset = 32) dmat4x3 b;
	layout(xfb_offset = 128) lowp mat2 c;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 144) dmat4 d;
};

void main (void)
{
	blockB.a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.c = mat2(-35.0, -43.0, 48.0, 4.0);
	d = dmat4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
}
#version 450

struct sA
{
	highp mat3x4 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=304 sizeInLocations=19
{
	layout(xfb_offset = 0) highp uvec4 a; // unassigned
	layout(xfb_offset = 16) dmat3x4 b;
	layout(xfb_offset = 112) sA c[4];
} blockB;

void main (void)
{
	blockB.b = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=232 sizeInLocations=15
{
	layout(xfb_offset = 0) dmat3x4 a;
	layout(xfb_offset = 96) dmat4 b; // unassigned
	layout(xfb_offset = 224) highp float c;
};
layout(location = 15, xfb_buffer = 0, xfb_offset = 232) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	// layout(xfb_offset = 232) highp ivec3 d; // missing field
	layout(xfb_offset = 248) dmat4x2 e;
} blockC;
layout(location = 20, xfb_buffer = 0, xfb_offset = 312) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	// layout(xfb_offset = 312) dmat4x2 f; // missing field
	layout(xfb_offset = 376) highp mat2 g;
} blockD;

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = 83.0f;
	blockC.e = dmat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockD.g = mat2(-43.0, 48.0, 4.0, -60.0);
}
#version 450

struct sA
{
	lowp vec4 mA;
};
struct sB
{
	sA mA;
	lowp float mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 0) sB a;
};

void main (void)
{
	a.mA.mA = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	a.mB = 72.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 0) lowp ivec4 a;
	layout(xfb_offset = 16) dmat2 b[3];
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 112) dmat3x4 c;
	layout(xfb_offset = 208) dmat2 d;
};

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b[0] = dmat2(72.0, -102.0, -100.0, 84.0);
	blockB.b[1] = dmat2(-31.0, 68.0, 104.0, 14.0);
	blockB.b[2] = dmat2(83.0, -117.0, 75.0, 12.0);
	c = dmat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	d = dmat2(-80.0, -62.0, -54.0, -79.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=12
{
	layout(xfb_offset = 0) highp uvec3 a;
	layout(xfb_offset = 12) mediump mat3x4 b;
	layout(xfb_offset = 64) dmat4x3 c;
};

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	c = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

struct sA
{
	mediump mat4x2 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 0) highp mat2x3 a;
	// layout(xfb_offset = 24) dmat2 b; // missing field
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=44 sizeInLocations=5
{
	// layout(xfb_offset = 56) mediump ivec3 c; // missing field
	layout(xfb_offset = 68) sA d;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 100) out BlockD // sizeInBytes=80 sizeInLocations=7
{
	// layout(xfb_offset = 100) lowp mat3x4 e; // missing field
	layout(xfb_offset = 148) lowp mat4x2 f;
} blockD;

void main (void)
{
	a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockD.f = mat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 0) lowp mat4x3 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 48) highp mat4 b; // unassigned
	layout(xfb_offset = 112) mediump vec2 c;
	layout(xfb_offset = 120) mediump uvec4 d;
};

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = vec2(83.0f, -117.0f);
	d = uvec4(75u, 12u, 18u, 101u);
}
#version 450

struct sA
{
	highp vec3 mA;
	dmat2x3 mB;
};
struct sB
{
	dmat4x3 mA;
	lowp int mB;
};
struct sC
{
	dmat3 mA;
	sB mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=128 sizeInLocations=10
{
	layout(xfb_offset = 128) dmat2x3 b[2]; // unassigned
	layout(xfb_offset = 224) dvec4 c;
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 256) out BlockD // sizeInBytes=320 sizeInLocations=26
{
	// layout(xfb_offset = 256) sA d[2]; // missing field
	layout(xfb_offset = 384) mediump ivec3 e;
	layout(xfb_offset = 400) sC f;
};

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c = dvec4(-18.0, -101.0, 100.0, -34.0);
	e = ivec3(-35, -43, 48);
	f.mA = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	f.mB.mA = dmat4x3(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	f.mB.mB = -51;
}
#version 450

struct sA
{
	dmat4 mA[4];
	highp mat2x3 mB;
	highp int mC[3];
};
struct sB
{
	lowp mat4 mA[4];
};
struct sC
{
	double mA;
	sB mB;
	mediump float mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=576 sizeInLocations=39
{
	layout(xfb_offset = 0) lowp vec4 a;
	layout(xfb_offset = 16) sA b; // unassigned
	layout(xfb_offset = 568) lowp int c;
} blockB;
layout(location = 39, xfb_buffer = 0, xfb_offset = 576) out BlockC // sizeInBytes=288 sizeInLocations=19
{
	layout(xfb_offset = 576) sC d;
	layout(xfb_offset = 848) highp ivec4 e;
} blockC;
layout(location = 58, xfb_buffer = 0, xfb_offset = 864) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 864) highp mat4x3 f;
};

void main (void)
{
	blockB.a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockB.c = 72;
	blockC.d.mA = -102.0;
	blockC.d.mB.mA[0] = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d.mB.mA[1] = mat4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockC.d.mB.mA[2] = mat4(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockC.d.mB.mA[3] = mat4(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0);
	blockC.e = ivec4(37, -112, 88, -40);
	f = mat4x3(-22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0, -69.0, -57.0);
}
#version 450

struct sA
{
	highp vec3 mA;
	mediump vec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 0) dmat2 a;
	layout(xfb_offset = 32) sA b;
	layout(xfb_offset = 56) dmat3x2 c;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 104) highp uvec3 d;
	layout(xfb_offset = 116) mediump mat4x3 e;
	layout(xfb_offset = 164) lowp float f;
};

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b.mA = vec3(72.0f, -102.0f, -100.0f);
	blockB.b.mB = vec3(84.0f, -31.0f, 68.0f);
	blockB.c = dmat3x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	d = uvec3(18u, 101u, 100u);
	e = mat4x3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	f = -79.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	layout(xfb_offset = 0) lowp float a;
	layout(xfb_offset = 4) lowp float b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 8) lowp mat4x2 c;
	layout(xfb_offset = 40) mediump mat3x4 d;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 88) highp uvec2 e;
};

void main (void)
{
	a = -89.0f;
	b = 30.0f;
	c = mat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	d = mat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = uvec2(48u, 4u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	layout(xfb_offset = 16) dmat3x2 b;
	layout(xfb_offset = 64) lowp int c;
	// layout(xfb_offset = 68) lowp int d; // missing field
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 72) highp vec4 e;
	layout(xfb_offset = 88) dmat4x3 f;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = 104;
	e = vec4(14.0f, 83.0f, -117.0f, 75.0f);
	f = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=84 sizeInLocations=9
{
	layout(xfb_offset = 0) mediump mat4x3 a;
	layout(xfb_offset = 48) lowp mat4x2 b;
	layout(xfb_offset = 80) highp float c;
} blockB;

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.c = -35.0f;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=15
{
	layout(xfb_offset = 0) mediump uint a;
	layout(xfb_offset = 8) dmat3x4 b;
	layout(xfb_offset = 104) highp mat4x2 c[2];
};
layout(location = 15, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 168) dmat4x2 d;
} blockC;
layout(location = 19, xfb_buffer = 0, xfb_offset = 232) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 232) dmat2x3 e;
} blockD;

void main (void)
{
	a = 89u;
	b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c[0] = mat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	c[1] = mat4x2(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockC.d = dmat4x2(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.e = dmat2x3(48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat3 a;
	layout(xfb_offset = 72) dvec3 b;
} blockB;

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = dvec3(68.0, 104.0, 14.0);
}
#version 450

struct sA
{
	mediump mat2 mA; // unassigned
	lowp mat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 0) lowp vec3 a[1];
	// layout(xfb_offset = 16) dmat3x2 b; // missing field
	layout(xfb_offset = 64) sA c;
} blockB;

void main (void)
{
	blockB.a[0] = vec3(-89.0f, 30.0f, -70.0f);
	blockB.c.mB = mat3x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
}
#version 450

struct sA
{
	lowp mat3x2 mA;
	lowp uvec3 mB;
};
struct sB
{
	mediump mat4x2 mA;
	mediump int mB;
	sA mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=11
{
	layout(xfb_offset = 0) dvec4 a[1];
	layout(xfb_offset = 32) sB b;
} blockB;

void main (void)
{
	blockB.a[0] = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB.b.mA = mat4x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b.mB = 83;
	blockB.b.mC.mA = mat3x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockB.b.mC.mB = uvec3(34u, 35u, 43u);
}
#version 450

struct sA
{
	double mA;
	dvec2 mB;
	highp mat3x4 mC; // unassigned
};
struct sB
{
	lowp mat2 mA;
	dvec4 mB;
	mediump ivec2 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=14
{
	layout(xfb_offset = 0) sA a; // unassigned
	layout(xfb_offset = 72) sB b; // unassigned
	layout(xfb_offset = 128) dmat2x3 c;
};

void main (void)
{
	c = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 0) lowp vec2 a;
	layout(xfb_offset = 8) dmat3 b;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=128 sizeInLocations=10
{
	// layout(xfb_offset = 80) dmat3x4 c; // missing field
	layout(xfb_offset = 176) highp mat4x2 d;
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 208) out BlockD // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 208) highp ivec2 e;
	layout(xfb_offset = 216) mediump mat2x3 f;
} blockD;

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = dmat3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockC.d = mat4x2(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD.e = ivec2(-34, -35);
	blockD.f = mat2x3(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
}
#version 450

struct sA
{
	dmat4 mA;
	highp ivec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 0) sA a;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 144) dmat3 b[1];
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 216) lowp uvec3 c;
} blockD;

void main (void)
{
	a.mA = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	a.mB = ivec3(-18, -101, 100);
	blockC.b[0] = dmat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.c = uvec3(80u, 62u, 54u);
}
#version 450

struct sA
{
	highp mat3 mA;
	highp ivec4 mB;
	highp uvec4 mC;
};
struct sB
{
	double mA;
	mediump ivec3 mB;
	sA mC[2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=184 sizeInLocations=12
{
	layout(xfb_offset = 0) double a;
	layout(xfb_offset = 8) dmat3x2 b;
	layout(xfb_offset = 56) dmat4 c;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 184) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 184) dmat3 d;
};
layout(location = 18, xfb_buffer = 0, xfb_offset = 256) out BlockD // sizeInBytes=208 sizeInLocations=16
{
	layout(xfb_offset = 256) sB e;
	layout(xfb_offset = 416) dmat2x3 f;
} blockD;

void main (void)
{
	a = -89.0;
	b = dmat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	c = dmat4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockD.e.mA = 3.0;
	blockD.e.mB = ivec3(-97, -118, -108);
	blockD.e.mC[0].mA = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	blockD.e.mC[0].mB = ivec4(32, 113, -44, -77);
	blockD.e.mC[0].mC = uvec4(11u, 66u, 11u, 87u);
	blockD.e.mC[1].mA = mat3(-87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0);
	blockD.e.mC[1].mB = ivec4(113, -60, 58, -109);
	blockD.e.mC[1].mC = uvec4(38u, 103u, 63u, 6u);
	blockD.f = dmat2x3(37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 0) dmat4x3 a;
	layout(xfb_offset = 96) highp float b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 104) dmat4 c;
	layout(xfb_offset = 232) mediump vec3 d;
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 248) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 248) mediump uvec3 e;
} blockD;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = 83.0f;
	blockC.c = dmat4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockC.d = vec3(-62.0f, -54.0f, -79.0f);
	blockD.e = uvec3(3u, 97u, 118u);
}
#version 450

struct sA
{
	lowp uint mA;
	dmat2 mB;
};
struct sB
{
	dmat2x3 mA;
	sA mB;
	dvec3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 0) highp mat4x2 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 32) highp mat4 b;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=280 sizeInLocations=23
{
	layout(xfb_offset = 96) dmat4x3 c;
	// layout(xfb_offset = 192) sB d; // missing field
	layout(xfb_offset = 304) dmat3 e; // unassigned
} blockD;

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC.b = mat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockD.c = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
}
#version 450

struct sA
{
	dmat3 mA;
	mediump mat4x3 mB;
	mediump mat3x2 mC[1];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=15
{
	layout(xfb_offset = 0) highp uvec2 a;
	layout(xfb_offset = 8) highp int b;
	layout(xfb_offset = 16) sA c;
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = -70;
	c.mA = dmat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c.mB = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c.mC[0] = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

struct sA
{
	mediump mat4 mA;
	dmat4x2 mB;
	dvec3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=10
{
	layout(xfb_offset = 0) sA a;
};

void main (void)
{
	a.mA = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	a.mB = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	a.mC = dvec3(-60.0, 37.0, 52.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	layout(xfb_offset = 0) highp vec2 a;
	layout(xfb_offset = 8) dmat3x4 b;
	layout(xfb_offset = 104) lowp ivec4 c;
} blockB;

void main (void)
{
	blockB.a = vec2(-89.0f, 30.0f);
	blockB.b = dmat3x4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB.c = ivec4(75, 12, -18, -101);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 0) mediump uvec2 a[4];
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 32) dmat4 b;
};

void main (void)
{
	blockB.a[0] = uvec2(89u, 30u);
	blockB.a[1] = uvec2(70u, 60u);
	blockB.a[2] = uvec2(72u, 102u);
	blockB.a[3] = uvec2(100u, 84u);
	b = dmat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

struct sA
{
	highp mat3x4 mA;
	highp mat3x4 mB;
};
struct sB
{
	lowp ivec4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 208) sB d;
	layout(xfb_offset = 16) sA b;
	layout(xfb_offset = 112) dvec4 c[3];
} blockC;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockC.b.mA = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b.mB = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC.c[0] = dvec4(-80.0, -62.0, -54.0, -79.0);
	blockC.c[1] = dvec4(3.0, -97.0, -118.0, -108.0);
	blockC.c[2] = dvec4(-120.0, 48.0, -71.0, -59.0);
	blockC.d.mA = ivec4(-40, -62, 114, -109);
}
#version 450

struct sA
{
	lowp mat2x3 mA; // unassigned
	mediump int mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=12
{
	// layout(xfb_offset = 112) sA c; // missing field
	layout(xfb_offset = 0) mediump mat3 a;
	// layout(xfb_offset = 40) dmat3 b; // missing field
};

void main (void)
{
	a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 128) mediump ivec2 b;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 136) out BlockD // sizeInBytes=144 sizeInLocations=10
{
	// layout(xfb_offset = 232) highp mat3x4 e; // missing field
	layout(xfb_offset = 136) dmat2x3 c;
	layout(xfb_offset = 184) dmat3x2 d;
} blockD;

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b = ivec2(-18, -101);
	blockD.c = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockD.d = dmat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

struct sA
{
	dvec3 mA;
	double mB;
	mediump vec4 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 4) lowp mat2x3 b;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 80) lowp vec4 d;
	layout(xfb_offset = 32) sA c;
} blockD;

void main (void)
{
	a = 89u;
	blockC.b = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockD.c.mA = dvec3(84.0, -31.0, 68.0);
	blockD.c.mB = 104.0;
	blockD.d = vec4(14.0f, 83.0f, -117.0f, 75.0f);
}
#version 450

struct sA
{
	dmat4x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 72) double c;
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 64) lowp uint b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 80) lowp int d;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 84) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 92) mediump mat3x4 f; // unassigned
	layout(xfb_offset = 84) mediump vec2 e;
};

void main (void)
{
	a.mA = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = 31u;
	c = 68.0;
	blockC.d = 104;
	e = vec2(14.0f, 83.0f);
}
#version 450

struct sA
{
	dmat2x3 mA;
	lowp ivec3 mB; // unassigned
};
struct sB
{
	lowp mat3x2 mA[1];
	lowp mat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	layout(xfb_offset = 64) mediump mat3 b;
	layout(xfb_offset = 0) sA a;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=488 sizeInLocations=41
{
	layout(xfb_offset = 584) highp uvec2 e;
	// layout(xfb_offset = 104) sB c[4]; // missing field
	// layout(xfb_offset = 392) dmat3x2 d[4]; // missing field
} blockC;

void main (void)
{
	a.mA = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC.e = uvec2(12u, 18u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=288 sizeInLocations=18
{
	layout(xfb_offset = 256) dvec4 b;
	// layout(xfb_offset = 0) highp mat4 a[2][2]; // missing field
} blockB;

void main (void)
{
	blockB.b = dvec4(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp uvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 8) dmat2 b;
} blockC;

void main (void)
{
	a = uvec2(89u, 30u);
	blockC.b = dmat2(-70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) highp int a[1];
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 4) lowp mat4x3 b;
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 52) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 52) lowp uvec4 c;
} blockD;

void main (void)
{
	a[0] = -89;
	blockC.b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockD.c = uvec4(117u, 75u, 12u, 18u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 16) mediump float b;
	// layout(xfb_offset = 0) highp vec4 a; // missing field
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 24) double c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 32) dvec3 d[2];
};

void main (void)
{
	b = -89.0f;
	blockC.c = 30.0;
	d[0] = dvec3(-70.0, -60.0, 72.0);
	d[1] = dvec3(-102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 24) dmat4x2 b;
	// layout(xfb_offset = 0) mediump mat2x3 a; // missing field
};

void main (void)
{
	b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp ivec2 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 8) dmat3 b;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 80) highp uint c;
};

void main (void)
{
	blockB.a = ivec2(-89, 30);
	b = dmat3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	c = 14u;
}
#version 450

struct sA
{
	lowp uvec3 mA;
	lowp float mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=6
{
	layout(xfb_offset = 16) highp ivec2 c[4];
	// layout(xfb_offset = 0) mediump ivec3 a; // missing field
	layout(xfb_offset = 12) highp int b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 48) dvec2 d;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=28 sizeInLocations=4
{
	layout(xfb_offset = 84) lowp ivec2 g;
	layout(xfb_offset = 64) highp uint e;
	layout(xfb_offset = 68) sA f;
} blockD;

void main (void)
{
	b = -89;
	c[0] = ivec2(30, -70);
	c[1] = ivec2(-60, 72);
	c[2] = ivec2(-102, -100);
	c[3] = ivec2(84, -31);
	d = dvec2(68.0, 104.0);
	blockD.e = 14u;
	blockD.f.mA = uvec3(83u, 117u, 75u);
	blockD.f.mB = 12.0f;
	blockD.g = ivec2(-18, -101);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) dmat4x2 a[1];
};

void main (void)
{
	a[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) dvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 32) double c;
	layout(xfb_offset = 16) highp vec3 b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = vec3(-70.0f, -60.0f, 72.0f);
	c = -102.0;
}
#version 450

struct sA
{
	dmat3x2 mA;
	dmat3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=552 sizeInLocations=41
{
	layout(xfb_offset = 456) dmat3x4 c;
	layout(xfb_offset = 0) dmat4x3 a; // unassigned
	layout(xfb_offset = 96) sA b[3];
} blockB;
layout(location = 41, xfb_buffer = 0, xfb_offset = 552) out BlockC // sizeInBytes=52 sizeInLocations=4
{
	layout(xfb_offset = 600) highp uint e;
	layout(xfb_offset = 552) highp mat3x4 d; // unassigned
} blockC;

void main (void)
{
	blockB.b[0].mA = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b[0].mB = dmat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.b[1].mA = dmat3x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockB.b[1].mB = dmat3(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockB.b[2].mA = dmat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockB.b[2].mB = dmat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	blockB.c = dmat3x4(32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0);
	blockC.e = 122u;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 0) dmat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 32) dmat3 b;
} blockC;

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC.b = dmat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=8
{
	layout(xfb_offset = 32) highp mat4x2 b;
	layout(xfb_offset = 0) mediump mat4x2 a;
};

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

struct sA
{
	lowp mat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=132 sizeInLocations=11
{
	layout(xfb_offset = 96) highp mat3 b;
	// layout(xfb_offset = 0) highp mat4x3 a[2]; // missing field
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 132) out BlockC // sizeInBytes=100 sizeInLocations=8
{
	layout(xfb_offset = 220) mediump ivec3 e;
	// layout(xfb_offset = 132) sA c; // missing field
	layout(xfb_offset = 156) highp vec4 d[4]; // unassigned
};

void main (void)
{
	b = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	e = ivec3(68, 104, 14);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) lowp mat3x4 a;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp ivec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=36 sizeInLocations=4
{
	layout(xfb_offset = 36) lowp uvec3 c;
	layout(xfb_offset = 12) highp mat3x2 b;
};

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	b = mat3x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	c = uvec3(68u, 104u, 14u);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=12
{
	layout(xfb_offset = 136) dvec3 c;
	layout(xfb_offset = 0) dmat4x2 a;
	layout(xfb_offset = 64) dmat3 b; // unassigned
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 160) dmat4x2 d;
} blockC;
layout(location = 16, xfb_buffer = 0, xfb_offset = 224) out BlockD // sizeInBytes=28 sizeInLocations=2
{
	layout(xfb_offset = 236) highp uvec4 f;
	layout(xfb_offset = 224) mediump ivec3 e;
};

void main (void)
{
	a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c = dvec3(-31.0, 68.0, 104.0);
	blockC.d = dmat4x2(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	e = ivec3(-34, -35, -43);
	f = uvec4(48u, 4u, 60u, 37u);
}
#version 450

struct sA
{
	dvec4 mA;
};
struct sB
{
	dvec3 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=9
{
	layout(xfb_offset = 72) dmat4x2 c;
	layout(xfb_offset = 0) highp uint a;
	layout(xfb_offset = 8) dmat4x2 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=128 sizeInLocations=11
{
	layout(xfb_offset = 256) highp ivec2 f;
	layout(xfb_offset = 136) dmat2x3 d;
	layout(xfb_offset = 184) dmat3 e;
} blockC;
layout(location = 20, xfb_buffer = 0, xfb_offset = 264) out BlockD // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 296) sB h;
	layout(xfb_offset = 264) dmat2 g;
};

void main (void)
{
	blockB.a = 89u;
	blockB.b = dmat4x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.c = dmat4x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = dmat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.e = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC.f = ivec2(3, -97);
	g = dmat2(-118.0, -108.0, -120.0, 48.0);
	h.mA = dvec3(-71.0, -59.0, -40.0);
	h.mB.mA = dvec4(-62.0, 114.0, -109.0, -51.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4x3 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 96) highp int b;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=112 sizeInLocations=7
{
	// layout(xfb_offset = 200) dvec2 d; // missing field
	layout(xfb_offset = 104) dmat3x4 c;
};

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = 83;
	c = dmat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) dmat3x2 a;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=12
{
	layout(xfb_offset = 0) lowp mat4x2 a[3];
} blockB;

void main (void)
{
	blockB.a[0] = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

struct sA
{
	mediump float mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 8) sA b;
} blockC;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 16) dmat2 c;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	c = dmat2(-70.0, -60.0, 72.0, -102.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 12) mediump uvec2 b;
	layout(xfb_offset = 0) highp ivec3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 56) dvec2 e;
	// layout(xfb_offset = 24) lowp uvec4 c; // missing field
	layout(xfb_offset = 40) lowp ivec4 d; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 136) lowp mat3x4 g;
	layout(xfb_offset = 72) highp uvec4 f[4]; // unassigned
} blockD;

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	blockB.b = uvec2(60u, 72u);
	e = dvec2(-102.0, -100.0);
	blockD.g = mat3x4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	layout(xfb_offset = 56) dmat3x2 c;
	layout(xfb_offset = 0) mediump mat2 a;
	layout(xfb_offset = 16) mediump mat3 b;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=112 sizeInLocations=9
{
	// layout(xfb_offset = 208) highp ivec2 f; // missing field
	layout(xfb_offset = 104) dmat3 d;
	layout(xfb_offset = 176) dvec4 e;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 216) highp vec4 g;
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = mat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.c = dmat3x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	d = dmat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	e = dvec4(-80.0, -62.0, -54.0, -79.0);
	blockD.g = vec4(3.0f, -97.0f, -118.0f, -108.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=17
{
	layout(xfb_offset = 112) dmat4x3 c; // unassigned
	// layout(xfb_offset = 0) mediump vec3 a; // missing field
	layout(xfb_offset = 16) dmat4x3 b;
};

void main (void)
{
	b = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
}
#version 450

struct sA
{
	highp uvec2 mA; // unassigned
	mediump mat2 mB;
	lowp int mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) dmat4x2 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=176 sizeInLocations=13
{
	layout(xfb_offset = 208) sA d;
	layout(xfb_offset = 64) dmat4 b;
	layout(xfb_offset = 192) highp uvec4 c;
} blockC;

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC.b = dmat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.c = uvec4(60u, 37u, 52u, 98u);
	blockC.d.mB = mat2(-80.0, -62.0, -54.0, -79.0);
	blockC.d.mC = 3;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 24) double b;
	layout(xfb_offset = 0) mediump mat3x2 a;
};

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = -100.0;
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 8) dmat3x2 b;
	layout(xfb_offset = 0) lowp float a; // unassigned
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 84) mediump vec3 e;
	layout(xfb_offset = 56) mediump vec4 c; // unassigned
	layout(xfb_offset = 72) lowp ivec3 d;
};

void main (void)
{
	b = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	d = ivec3(-100, 84, -31);
	e = vec3(68.0f, 104.0f, 14.0f);
}
#version 450

struct sA
{
	lowp uint mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=52 sizeInLocations=6
{
	layout(xfb_offset = 48) sA c;
	// layout(xfb_offset = 0) mediump ivec4 a; // missing field
	layout(xfb_offset = 16) highp mat4x2 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 64) dmat4x3 e;
	layout(xfb_offset = 56) highp float d;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 160) highp vec2 f;
};

void main (void)
{
	blockB.b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.c.mA = 31u;
	blockC.d = 68.0f;
	blockC.e = dmat4x3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	f = vec2(48.0f, 4.0f);
}
#version 450

struct sA
{
	dvec4 mA;
	dvec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=4
{
	layout(xfb_offset = 20) lowp uvec4 c;
	layout(xfb_offset = 0) highp mat2 a;
	layout(xfb_offset = 16) highp uint b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	// layout(xfb_offset = 88) lowp ivec4 e; // missing field
	layout(xfb_offset = 40) sA d;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = 72u;
	c = uvec4(102u, 100u, 84u, 31u);
	d.mA = dvec4(68.0, 104.0, 14.0, 83.0);
	d.mB = dvec2(-117.0, 75.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 8) dvec3 b[4];
	layout(xfb_offset = 0) lowp ivec2 a;
};

void main (void)
{
	a = ivec2(-89, 30);
	b[0] = dvec3(-70.0, -60.0, 72.0);
	b[1] = dvec3(-102.0, -100.0, 84.0);
	b[2] = dvec3(-31.0, 68.0, 104.0);
	b[3] = dvec3(14.0, 83.0, -117.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=6
{
	layout(xfb_offset = 36) mediump vec3 c;
	// layout(xfb_offset = 0) mediump int a; // missing field
	layout(xfb_offset = 4) lowp mat4x2 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=120 sizeInLocations=11
{
	// layout(xfb_offset = 144) highp mat3x2 e; // missing field
	layout(xfb_offset = 48) dmat4x3 d;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 176) dmat3 g;
	layout(xfb_offset = 168) highp int f;
} blockD;

void main (void)
{
	blockB.b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.c = vec3(-31.0f, 68.0f, 104.0f);
	d = dmat4x3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockD.f = 4;
	blockD.g = dmat3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 0) dvec4 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 32) highp mat2x3 b;
} blockC;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockC.b = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=112 sizeInLocations=8
{
	layout(xfb_offset = 96) dvec4 d;
	// layout(xfb_offset = 16) dmat2 b; // missing field
	layout(xfb_offset = 48) dmat2x3 c;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=64 sizeInLocations=7
{
	// layout(xfb_offset = 160) mediump mat4x2 g[1]; // missing field
	layout(xfb_offset = 128) mediump ivec4 e;
	layout(xfb_offset = 144) highp mat2 f;
} blockD;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockC.c = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.d = dvec4(104.0, 14.0, 83.0, -117.0);
	blockD.e = ivec4(75, 12, -18, -101);
	blockD.f = mat2(100.0, -34.0, -35.0, -43.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 16) dmat4 b;
	layout(xfb_offset = 0) dvec2 a;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 144) dmat3x4 c;
};

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = dmat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=5
{
	layout(xfb_offset = 12) mediump mat4x2 b; // unassigned
	layout(xfb_offset = 0) mediump uvec3 a;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 44) out BlockC // sizeInBytes=104 sizeInLocations=10
{
	layout(xfb_offset = 124) lowp mat3x2 e;
	layout(xfb_offset = 44) lowp vec2 c;
	layout(xfb_offset = 52) mediump mat3 d[2];
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 152) dmat4 f;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockC.c = vec2(-60.0f, 72.0f);
	blockC.d[0] = mat3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.d[1] = mat3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.e = mat3x2(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	f = dmat4(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
}
#version 450

struct sA
{
	highp vec3 mA;
	highp mat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	// layout(xfb_offset = 112) highp vec4 c[1]; // missing field
	layout(xfb_offset = 0) mediump uvec4 a;
	layout(xfb_offset = 16) dmat4x3 b;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 128) dvec3 d;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 152) sA e;
};

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = dmat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	d = dvec3(-18.0, -101.0, 100.0);
	e.mA = vec3(-34.0f, -35.0f, -43.0f);
	e.mB = mat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 24) mediump vec3 b;
	layout(xfb_offset = 0) dvec3 a;
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockB.b = vec3(-60.0f, 72.0f, -102.0f);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	// layout(xfb_offset = 32) dvec3 c; // missing field
	layout(xfb_offset = 0) highp vec3 a;
	layout(xfb_offset = 12) highp mat2 b;
} blockB;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = mat2(-60.0, 72.0, -102.0, -100.0);
}
#version 450

struct sA
{
	mediump ivec4 mA;
	highp mat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp uvec2 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=28 sizeInLocations=2
{
	layout(xfb_offset = 20) lowp vec4 c;
	layout(xfb_offset = 8) lowp vec3 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 36) out BlockD // sizeInBytes=84 sizeInLocations=9
{
	layout(xfb_offset = 72) sA f;
	// layout(xfb_offset = 36) lowp mat3x2 d; // missing field
	layout(xfb_offset = 60) lowp vec3 e[1];
} blockD;

void main (void)
{
	blockB.a = uvec2(89u, 30u);
	b = vec3(-70.0f, -60.0f, 72.0f);
	c = vec4(-102.0f, -100.0f, 84.0f, -31.0f);
	blockD.e[0] = vec3(68.0f, 104.0f, 14.0f);
	blockD.f.mA = ivec4(83, -117, 75, 12);
	blockD.f.mB = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 4) mediump uvec4 b;
	layout(xfb_offset = 0) highp float a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 104) mediump uvec3 e;
	layout(xfb_offset = 24) dmat3x2 c;
	// layout(xfb_offset = 72) dvec4 d; // missing field
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 120) dmat4 f;
};

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = uvec4(30u, 70u, 60u, 72u);
	c = dmat3x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	e = uvec3(14u, 83u, 117u);
	f = dmat4(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=13
{
	// layout(xfb_offset = 136) highp mat4 c; // missing field
	layout(xfb_offset = 0) dmat4 a;
	layout(xfb_offset = 128) double b; // unassigned
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 8) lowp mat2x3 b;
	layout(xfb_offset = 0) lowp ivec2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=100 sizeInLocations=8
{
	// layout(xfb_offset = 128) highp float e; // missing field
	// layout(xfb_offset = 32) mediump mat4x3 c; // missing field
	layout(xfb_offset = 80) mediump mat3x4 d;
} blockC;

void main (void)
{
	a = ivec2(-89, 30);
	b = mat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC.d = mat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 0) dmat2 a;
} blockB;

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec3 a[1];
};

void main (void)
{
	a[0] = ivec3(-89, 30, -70);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3x4 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=116 sizeInLocations=14
{
	layout(xfb_offset = 152) highp ivec3 d;
	layout(xfb_offset = 48) lowp mat3x2 b[4];
	layout(xfb_offset = 144) mediump ivec2 c;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0] = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	b[1] = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[2] = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	b[3] = mat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	c = ivec2(-120, 48);
	d = ivec3(-71, -59, -40);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) double a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=160 sizeInLocations=14
{
	layout(xfb_offset = 72) dmat4x3 d;
	layout(xfb_offset = 8) highp mat2 b;
	layout(xfb_offset = 24) lowp mat4x3 c;
};

void main (void)
{
	blockB.a = -89.0;
	b = mat2(30.0, -70.0, -60.0, 72.0);
	c = mat4x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	d = dmat4x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
}
#version 450

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=224 sizeInLocations=14
{
	layout(xfb_offset = 128) dmat3x4 b;
	layout(xfb_offset = 0) dmat4 a; // unassigned
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 224) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 224) lowp mat3x4 c;
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 272) out BlockD // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 352) dmat4 f; // unassigned
	layout(xfb_offset = 272) mediump mat3x4 d;
	layout(xfb_offset = 320) dvec4 e;
};

void main (void)
{
	b = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	e = dvec4(-120.0, 48.0, -71.0, -59.0);
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	mediump uint a;
	lowp int b; // unassigned
	highp float c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	highp int d;
	mediump uint e; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp int f;
} blockD;

void main (void)
{
	a = 89u;
	c = 30.0f;
	d = -70;
	blockD.f = -60;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	highp float b;
	mediump int c;
	mediump uint d;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	lowp float e;
	mediump float f; // unassigned
	mediump float g;
} blockD;

void main (void)
{
	a = -89;
	blockC.b = 30.0f;
	blockC.c = -70;
	blockC.d = 60u;
	blockD.e = 72.0f;
	blockD.g = -102.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump float a;
	highp int b;
} blockB;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	highp float b; // unassigned
	highp uint c;
	mediump int d;
} blockC;

void main (void)
{
	a = 89u;
	blockC.c = 30u;
	blockC.d = -70;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp float a;
	lowp uint b;
	highp uint c; // unassigned
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp float d;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	mediump int e;
	highp int f;
};

void main (void)
{
	a = -89.0f;
	b = 30u;
	blockC.d = -70.0f;
	e = -60;
	f = 72;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	highp float a;
	lowp uint b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	mediump float c;
	highp float d;
	mediump int e;
} blockC;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30u;
	blockC.c = -70.0f;
	blockC.d = -60.0f;
	blockC.e = 72;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump uint a;
	lowp uint b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	lowp int c;
	mediump float d;
	mediump int e;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	highp int f;
	lowp int g;
} blockD;

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30u;
	c = -70;
	d = -60.0f;
	e = 72;
	blockD.f = -102;
	blockD.g = -100;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	mediump float a;
	mediump uint b; // unassigned
} blockB;

void main (void)
{
	blockB.a = -89.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	mediump float a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump float b;
	highp float c; // unassigned
} blockC;

void main (void)
{
	a = -89.0f;
	blockC.b = 30.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp float a;
	lowp float b;
	mediump float c;
};

void main (void)
{
	a = -89.0f;
	b = 30.0f;
	c = -70.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};

void main (void)
{
	a = -89;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	lowp uint a;
	mediump float b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp int c;
};

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30.0f;
	c = -70;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp uint a;
	lowp int b;
	lowp uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump int d;
	mediump int e;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp float f;
};

void main (void)
{
	a = 89u;
	b = 30;
	c = 70u;
	d = -60;
	e = 72;
	f = -102.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	lowp float a;
	mediump int b;
	mediump uint c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump float d;
	mediump int e;
} blockC;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30;
	blockB.c = 70u;
	blockC.d = -60.0f;
	blockC.e = 72;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	highp float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=12 sizeInLocations=3
{
	mediump uint b;
	mediump float c; // unassigned
	mediump uint d;
};

void main (void)
{
	blockB.a = -89.0f;
	b = 30u;
	d = 70u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	lowp float a;
	lowp int b;
	lowp float c;
};

void main (void)
{
	a = -89.0f;
	b = 30;
	c = -70.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	highp float a;
	mediump int b;
	highp int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=2
{
	mediump uint d;
	lowp float e;
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	lowp int f;
	lowp float g;
};

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = 30;
	blockB.c = -70;
	blockC.d = 60u;
	blockC.e = 72.0f;
	f = -102;
	g = -100.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	highp int a;
	mediump float b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	lowp int d;
	mediump int e;
	mediump int f;
} blockD;

void main (void)
{
	a = -89;
	b = 30.0f;
	c = 70u;
	blockD.d = -60;
	blockD.e = 72;
	blockD.f = -102;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	mediump int a;
	mediump int b;
	highp int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	highp int d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=12 sizeInLocations=3
{
	highp float e; // unassigned
	lowp uint f;
	mediump uint g;
} blockD;

void main (void)
{
	blockB.a = -89;
	blockB.b = 30;
	blockB.c = -70;
	d = -60;
	blockD.f = 72u;
	blockD.g = 102u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	highp float a;
	highp ivec2 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	highp float d;
};

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = ivec2(30, -70);
	blockC.c = ivec4(-60, 72, -102, -100);
	d = 84.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=3
{
	lowp float a;
	mediump float b;
	highp int c;
};

void main (void)
{
	a = -89.0f;
	b = 30.0f;
	c = -70;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	mediump vec3 a;
	highp uint b;
};

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = 60u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=28 sizeInLocations=2
{
	highp ivec4 b;
	mediump vec3 c; // unassigned
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=28 sizeInLocations=3
{
	mediump uint d;
	highp vec4 e;
	lowp uvec2 f;
};

void main (void)
{
	blockB.a = -89.0f;
	b = ivec4(30, -70, -60, 72);
	d = 102u;
	e = vec4(-100.0f, 84.0f, -31.0f, 68.0f);
	f = uvec2(104u, 14u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump vec4 a;
} blockB;

void main (void)
{
	blockB.a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	mediump ivec2 a;
	mediump vec4 b;
	lowp vec4 c;
};

void main (void)
{
	a = ivec2(-89, 30);
	b = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
	c = vec4(-100.0f, 84.0f, -31.0f, 68.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=3
{
	highp vec2 a; // unassigned
	mediump ivec2 b;
	lowp uint c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 20) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 d;
} blockC;

void main (void)
{
	blockB.b = ivec2(-89, 30);
	blockB.c = 70u;
	blockC.d = vec2(-60.0f, 72.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	lowp ivec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=28 sizeInLocations=3
{
	lowp uvec2 b;
	mediump uint c; // unassigned
	mediump vec4 d;
} blockC;

void main (void)
{
	a = ivec4(-89, 30, -70, -60);
	blockC.b = uvec2(72u, 102u);
	blockC.d = vec4(-100.0f, 84.0f, -31.0f, 68.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 b;
};

void main (void)
{
	a = uvec4(89u, 30u, 70u, 60u);
	b = vec4(72.0f, -102.0f, -100.0f, 84.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=3
{
	highp vec2 a;
	lowp int b;
	lowp uint c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=20 sizeInLocations=2
{
	highp uvec2 e; // unassigned
	highp ivec3 f;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = -70;
	c = 60u;
	d = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	f = ivec3(-31, 68, 104);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump uvec3 b;
	mediump uint c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 20) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 d;
};

void main (void)
{
	a = -89;
	blockC.b = uvec3(30u, 70u, 60u);
	blockC.c = 72u;
	d = uvec4(102u, 100u, 84u, 31u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	mediump int a;
	lowp ivec4 b;
	mediump ivec2 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	mediump vec2 d;
};

void main (void)
{
	blockB.a = -89;
	blockB.b = ivec4(30, -70, -60, 72);
	blockB.c = ivec2(-102, -100);
	d = vec2(84.0f, -31.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	mediump uvec2 a;
	mediump int b;
	highp vec4 c; // unassigned
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = -70;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	mediump uvec4 a;
	mediump ivec2 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	mediump ivec3 c;
	mediump ivec3 d;
	highp ivec4 e; // unassigned
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	lowp vec4 f;
};

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = ivec2(72, -102);
	blockC.c = ivec3(-100, 84, -31);
	blockC.d = ivec3(68, 104, 14);
	f = vec4(83.0f, -117.0f, 75.0f, 12.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	highp ivec3 a;
	lowp uvec4 b;
	highp uvec3 c;
};

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = uvec4(60u, 72u, 102u, 100u);
	c = uvec3(84u, 31u, 68u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	highp ivec2 a;
	lowp int b;
	lowp vec3 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump uint d;
	highp uvec3 e; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	mediump ivec2 f;
	mediump ivec4 g;
};

void main (void)
{
	a = ivec2(-89, 30);
	b = -70;
	c = vec3(-60.0f, 72.0f, -102.0f);
	d = 100u;
	f = ivec2(84, -31);
	g = ivec4(68, 104, 14, 83);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp vec3 a;
	lowp float b;
	mediump vec2 c;
} blockB;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = -60.0f;
	blockB.c = vec2(72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	mediump uint a;
	mediump ivec4 b;
	mediump ivec4 c;
} blockB;

void main (void)
{
	blockB.a = 89u;
	blockB.b = ivec4(30, -70, -60, 72);
	blockB.c = ivec4(-102, -100, 84, -31);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	mediump uvec4 a;
	lowp uvec3 b;
	mediump uint c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=12 sizeInLocations=2
{
	lowp uint d;
	mediump uvec2 e;
} blockC;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = uvec3(72u, 102u, 100u);
	blockB.c = 84u;
	blockC.d = 31u;
	blockC.e = uvec2(68u, 104u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=28 sizeInLocations=3
{
	highp vec3 b;
	highp ivec2 c;
	highp vec2 d;
};

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	b = vec3(-60.0f, 72.0f, -102.0f);
	c = ivec2(-100, 84);
	d = vec2(-31.0f, 68.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	highp ivec4 b;
	highp vec3 c;
	highp uvec2 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 44) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 e;
} blockD;

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = ivec4(-70, -60, 72, -102);
	c = vec3(-100.0f, 84.0f, -31.0f);
	d = uvec2(68u, 104u);
	blockD.e = vec3(14.0f, 83.0f, -117.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	highp ivec4 a;
	highp uvec4 b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	mediump uvec2 c;
	highp int d;
	mediump ivec2 e;
};

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b = uvec4(72u, 102u, 100u, 84u);
	c = uvec2(31u, 68u);
	d = 104;
	e = ivec2(14, 83);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	mediump uvec3 a;
	lowp vec3 b;
	lowp int c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp uint d;
	highp uvec4 e; // unassigned
	lowp float f;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.b = vec3(-60.0f, 72.0f, -102.0f);
	blockB.c = -100;
	d = 84u;
	f = -31.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	lowp ivec4 a;
	highp vec2 b;
} blockB;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockB.b = vec2(72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	highp uvec3 a;
	mediump uvec2 b;
};

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b = uvec2(60u, 72u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=5
{
	dvec2 a;
	mediump mat3x2 b; // unassigned
	mediump vec2 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	c = vec2(-70.0f, -60.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	highp vec4 a;
	dmat3x4 b; // unassigned
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=112 sizeInLocations=10
{
	lowp int c;
	dmat4x3 d;
	mediump vec2 e; // unassigned
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 224) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	dvec4 f; // unassigned
	mediump ivec3 g;
	lowp uvec2 h;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.c = 72;
	blockC.d = dmat4x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	g = ivec3(-101, 100, -34);
	h = uvec2(35u, 43u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	lowp float a;
	mediump uvec2 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	dmat4 c;
};

void main (void)
{
	a = -89.0f;
	b = uvec2(30u, 70u);
	c = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=184 sizeInLocations=14
{
	highp mat4 a; // unassigned
	dmat2x3 b;
	dmat3 c; // unassigned
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 184) out BlockC // sizeInBytes=152 sizeInLocations=15
{
	dmat4x3 d;
	lowp mat4x2 e;
	lowp mat3x2 f;
};

void main (void)
{
	blockB.b = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	d = dmat4x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	e = mat4x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	f = mat3x2(52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	mediump uvec4 a;
	dmat3x4 b;
};

void main (void)
{
	a = uvec4(89u, 30u, 70u, 60u);
	b = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 a;
} blockB;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	highp mat3x4 a; // unassigned
	highp uvec4 b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=152 sizeInLocations=10
{
	mediump vec2 c;
	dmat4 d;
	highp uvec4 e;
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	dvec3 f;
	double g;
	dmat3x2 h;
};

void main (void)
{
	blockB.b = uvec4(89u, 30u, 70u, 60u);
	c = vec2(72.0f, -102.0f);
	d = dmat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = uvec4(48u, 4u, 60u, 37u);
	f = dvec3(52.0, 98.0, -80.0);
	g = -62.0;
	h = dmat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=5
{
	dmat2 a;
	dmat3x2 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=128 sizeInLocations=10
{
	dmat2 c;
	dmat4x3 d;
};

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	c = dmat2(104.0, 14.0, 83.0, -117.0);
	d = dmat4x3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=9
{
	double a;
	dmat3 b;
	dmat2 c;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	dmat3 d;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 184) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 e;
};

void main (void)
{
	blockB.a = -89.0;
	blockB.b = dmat3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockB.c = dmat2(104.0, 14.0, 83.0, -117.0);
	blockC.d = dmat3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = dmat3x2(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	highp mat2x3 a;
} blockB;

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=5
{
	lowp mat3x4 a; // unassigned
	mediump ivec4 b;
	dvec2 c;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	mediump mat2 d;
	dvec4 e;
	mediump vec2 f;
} blockC;

void main (void)
{
	b = ivec4(-89, 30, -70, -60);
	c = dvec2(72.0, -102.0);
	blockC.d = mat2(-100.0, 84.0, -31.0, 68.0);
	blockC.e = dvec4(104.0, 14.0, 83.0, -117.0);
	blockC.f = vec2(75.0f, 12.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat2 a;
	lowp uvec2 b; // unassigned
	lowp uvec4 c;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	c = uvec4(72u, 102u, 100u, 84u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	mediump uint a;
	mediump vec4 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=152 sizeInLocations=11
{
	double c;
	dmat3x4 d;
	dmat2x3 e;
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 176) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 f;
};

void main (void)
{
	a = 89u;
	b = vec4(30.0f, -70.0f, -60.0f, 72.0f);
	c = -102.0;
	d = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	e = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	f = ivec3(-60, 37, 52);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	mediump mat3x2 a;
	mediump mat4 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	lowp mat4x2 c;
} blockC;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.c = mat4x2(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump ivec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=92 sizeInLocations=6
{
	lowp vec4 b;
	highp mat4 c;
	highp uvec3 d;
} blockC;

void main (void)
{
	a = ivec2(-89, 30);
	blockC.b = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
	blockC.c = mat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = uvec3(48u, 4u, 60u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	dvec2 b;
	dvec3 c;
} blockC;

void main (void)
{
	a = 89u;
	blockC.b = dvec2(30.0, -70.0);
	blockC.c = dvec3(-60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=112 sizeInLocations=7
{
	dmat3x2 b;
	dmat4x2 c;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=120 sizeInLocations=9
{
	lowp mat4x3 d;
	highp mat3 e;
	dvec4 f;
} blockD;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockC.b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = dmat4x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockD.d = mat4x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockD.e = mat3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockD.f = dvec4(-59.0, -40.0, -62.0, 114.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	mediump float a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	lowp uint b; // unassigned
	dmat4x3 c;
};

void main (void)
{
	blockB.a = -89.0f;
	c = dmat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=52 sizeInLocations=4
{
	mediump mat3x4 b;
	highp uint c;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 d;
} blockD;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = 100u;
	blockD.d = dmat3x4(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=7
{
	dmat2x3 a;
	mediump mat3x2 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 c;
} blockC;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat2 a;
	highp uvec4 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=232 sizeInLocations=17
{
	lowp uint c; // unassigned
	dmat4x3 d;
	dmat4 e;
};
layout(location = 20, xfb_buffer = 0, xfb_offset = 280) out BlockD // sizeInBytes=8 sizeInLocations=2
{
	lowp int f;
	mediump uint g; // unassigned
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = uvec4(72u, 102u, 100u, 84u);
	d = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	e = dmat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	f = -120;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	dmat3x2 a; // unassigned
	mediump vec2 b;
	mediump mat4x3 c;
} blockB;

void main (void)
{
	blockB.b = vec2(-89.0f, 30.0f);
	blockB.c = mat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	mediump vec3 a;
	dmat2x3 b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=200 sizeInLocations=15
{
	dmat4 c;
	lowp mat3 d;
	mediump mat4x2 e;
};
layout(location = 20, xfb_buffer = 0, xfb_offset = 264) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 f;
} blockD;

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = dmat2x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	c = dmat4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	d = mat3(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	e = mat4x2(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockD.f = dmat4x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=60 sizeInLocations=4
{
	lowp ivec3 b;
	highp mat3x4 c; // unassigned
} blockC;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	lowp mat2x3 d[4];
} blockD;

void main (void)
{
	a = 89u;
	blockC.b = ivec3(30, -70, -60);
	blockD.d[0] = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockD.d[1] = mat2x3(104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockD.d[2] = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.d[3] = mat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	highp int a;
	dmat3x4 b;
	lowp ivec3 c;
} blockB;

void main (void)
{
	blockB.a = -89;
	blockB.b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.c = ivec3(-117, 75, 12);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=320 sizeInLocations=26
{
	highp vec4 a; // unassigned
	dmat4x3 b[3];
	mediump ivec4 c;
};

void main (void)
{
	b[0] = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[1] = dmat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[2] = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	c = ivec4(-120, 48, -71, -59);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	lowp int a[1];
	lowp vec4 b;
} blockB;

void main (void)
{
	blockB.a[0] = -89;
	blockB.b = vec4(30.0f, -70.0f, -60.0f, 72.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=17
{
	dvec2 a;
	dmat4 b;
	dmat4x3 c[1];
} blockB;

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB.c[0] = dmat4x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	dvec2 a;
	lowp ivec2 b;
	highp ivec4 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = ivec2(-70, -60);
	c = ivec4(72, -102, -100, 84);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=12
{
	dmat4 a; // unassigned
	dmat4x2 b;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=120 sizeInLocations=9
{
	dmat3 c;
	mediump mat3x4 d;
};
layout(location = 21, xfb_buffer = 0, xfb_offset = 312) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	mediump uvec2 e;
	dmat2 f;
	highp float g;
} blockD;

void main (void)
{
	blockB.b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	d = mat3x4(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockD.e = uvec2(62u, 54u);
	blockD.f = dmat2(-79.0, 3.0, -97.0, -118.0);
	blockD.g = -108.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	double a;
	double b;
};

void main (void)
{
	a = -89.0;
	b = 30.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=184 sizeInLocations=12
{
	dvec3 a;
	dmat4x2 b;
	dmat3x4 c; // unassigned
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockB.b = dmat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=9
{
	dmat2x3 a; // unassigned
	highp mat3x4 b;
	mediump mat2 c; // unassigned
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	lowp mat2 d;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 e;
};

void main (void)
{
	b = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.d = mat2(83.0, -117.0, 75.0, 12.0);
	e = mat3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockD // sizeInBytes=168 sizeInLocations=11
{
	dmat4 c;
	dvec4 d;
	mediump ivec2 e;
};

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	b = mat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = dmat4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	d = dvec4(-80.0, -62.0, -54.0, -79.0);
	e = ivec2(3, -97);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	dmat2x3 b;
	double c;
	lowp float d; // unassigned
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = 100.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	highp uint a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=32 sizeInLocations=3
{
	mediump uvec2 b;
	mediump int c;
	dvec2 d;
};

void main (void)
{
	a = 89u;
	b = uvec2(30u, 70u);
	c = -60;
	d = dvec2(72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=512 sizeInLocations=32
{
	dmat4 a[4];
} blockB;
layout(location = 32, xfb_buffer = 0, xfb_offset = 512) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dmat2 b;
};
layout(location = 34, xfb_buffer = 0, xfb_offset = 544) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 c;
};

void main (void)
{
	blockB.a[0] = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[1] = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB.a[2] = dmat4(3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockB.a[3] = dmat4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	b = dmat2(58.0, -109.0, -38.0, -103.0);
	c = dmat2x3(-63.0, -6.0, 37.0, -112.0, 88.0, -40.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	dmat3x2 a; // unassigned
	lowp uvec3 b; // unassigned
	mediump uint c;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 d;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=32 sizeInLocations=2
{
	dmat2 e;
} blockD;

void main (void)
{
	c = 89u;
	blockC.d = vec3(30.0f, -70.0f, -60.0f);
	blockD.e = dmat2(72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=212 sizeInLocations=14
{
	mediump int a[1];
	lowp mat3x4 b[4];
	lowp vec4 c;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 216) out BlockC // sizeInBytes=128 sizeInLocations=9
{
	highp vec4 d;
	highp uvec3 e[4];
	dmat4x2 f;
};

void main (void)
{
	blockB.a[0] = -89;
	blockB.b[0] = mat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.b[1] = mat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockB.b[2] = mat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockB.b[3] = mat3x4(48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0);
	blockB.c = vec4(-11.0f, 66.0f, -11.0f, 87.0f);
	d = vec4(-87.0f, 87.0f, 95.0f, -46.0f);
	e[0] = uvec3(122u, 97u, 108u);
	e[1] = uvec3(127u, 10u, 113u);
	e[2] = uvec3(60u, 58u, 109u);
	e[3] = uvec3(38u, 103u, 63u);
	f = dmat4x2(-6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=8
{
	dvec4 a;
	dvec4 b;
	highp mat4x3 c; // unassigned
};

void main (void)
{
	a = dvec4(-89.0, 30.0, -70.0, -60.0);
	b = dvec4(72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	mediump vec4 b;
	mediump uvec2 c; // unassigned
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = vec4(72.0f, -102.0f, -100.0f, 84.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat3x2 a;
	highp uvec2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=80 sizeInLocations=6
{
	mediump uvec2 c;
	highp ivec2 d; // unassigned
	dmat2 e[2];
} blockC;
layout(location = 10, xfb_buffer = 0, xfb_offset = 136) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	mediump uvec4 f;
	dmat2 g; // unassigned
} blockD;

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = uvec2(100u, 84u);
	blockC.c = uvec2(31u, 68u);
	blockC.e[0] = dmat2(104.0, 14.0, 83.0, -117.0);
	blockC.e[1] = dmat2(75.0, 12.0, -18.0, -101.0);
	blockD.f = uvec4(100u, 34u, 35u, 43u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	lowp uvec2 a;
	dmat4x2 b;
} blockB;

void main (void)
{
	blockB.a = uvec2(89u, 30u);
	blockB.b = dmat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	dmat2 a;
	lowp mat3x2 b;
	mediump ivec2 c;
} blockB[1];

void main (void)
{
	blockB[0].a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = mat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockB[0].c = ivec2(104, 14);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	mediump mat2 a;
	dvec2 b; // unassigned
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	highp vec2 c;
};

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	c = vec2(72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 b;
};

void main (void)
{
	blockB[0].a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	lowp vec3 a;
} blockB;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 a;
};

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	dmat4 a;
	dvec2 b;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	mediump mat3x4 c;
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b = dvec2(-18.0, -101.0);
	c = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=4
{
	highp mat3x2 a;
	highp int b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	highp uvec3 c; // unassigned
	lowp uint d;
} blockC;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = -100;
	blockC.d = 84u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 a;
} blockB;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 104) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	lowp vec3 a;
	dmat2 b;
	mediump uvec3 c;
} blockB[2];
layout(location = 8, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=40 sizeInLocations=4
{
	mediump ivec4 d;
	lowp mat3x2 e;
};

void main (void)
{
	blockB[0].a = vec3(-89.0f, 30.0f, -70.0f);
	blockB[0].b = dmat2(-60.0, 72.0, -102.0, -100.0);
	blockB[0].c = uvec3(84u, 31u, 68u);
	blockB[1].a = vec3(104.0f, 14.0f, 83.0f);
	blockB[1].b = dmat2(-117.0, 75.0, 12.0, -18.0);
	blockB[1].c = uvec3(101u, 100u, 34u);
	d = ivec4(-35, -43, 48, 4);
	e = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	mediump int a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8, xfb_stride = 32) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 b;
} blockC[3];

void main (void)
{
	a = -89;
	blockC[0].b = dvec3(30.0, -70.0, -60.0);
	blockC[1].b = dvec3(72.0, -102.0, -100.0);
	blockC[2].b = dvec3(84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dmat2 b;
	lowp mat2 c;
};

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = dmat2(83.0, -117.0, 75.0, 12.0);
	c = mat2(-18.0, -101.0, 100.0, -34.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	mediump ivec2 a;
	mediump mat4x3 b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 c;
} blockC[1];
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	highp vec4 d;
} blockD[1];

void main (void)
{
	a = ivec2(-89, 30);
	b = mat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC[0].c = mat4x3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockD[0].d = vec4(52.0f, 98.0f, -80.0f, -62.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	dvec4 b;
	lowp ivec3 c;
} blockC;

void main (void)
{
	blockB[0].a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.b = dvec4(-100.0, 84.0, -31.0, 68.0);
	blockC.c = ivec3(104, 14, 83);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp uvec3 a;
} blockB;

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
};

void main (void)
{
	a = dvec3(-89.0, 30.0, -70.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	double a;
	dmat3x2 b; // unassigned
} blockB[3];

void main (void)
{
	blockB[0].a = -89.0;
	blockB[1].a = 30.0;
	blockB[2].a = -70.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16, xfb_stride = 224) out BlockC // sizeInBytes=208 sizeInLocations=13
{
	dmat4x2 b; // unassigned
	dmat3x4 c;
	mediump mat3x4 d;
} blockC[2];

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockC[0].c = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].d = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC[1].c = dmat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC[1].d = mat3x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	mediump ivec2 a;
	dmat2x3 b;
};

void main (void)
{
	a = ivec2(-89, 30);
	b = dmat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	lowp uvec3 a;
	highp vec4 b;
	dmat3 c;
} blockB[1];
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=52 sizeInLocations=6
{
	mediump uint d;
	highp mat3x2 e;
	lowp mat2x3 f;
} blockC[1];

void main (void)
{
	blockB[0].a = uvec3(89u, 30u, 70u);
	blockB[0].b = vec4(-60.0f, 72.0f, -102.0f, -100.0f);
	blockB[0].c = dmat3(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].d = 18u;
	blockC[0].e = mat3x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC[0].f = mat2x3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	dmat4x3 a;
	dvec4 b;
	lowp uint c;
} blockB;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dvec4(83.0, -117.0, 75.0, 12.0);
	blockB.c = 18u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	mediump vec3 b;
} blockC;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockC.b = vec3(-60.0f, 72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=12
{
	dmat3x4 a;
	highp mat3x4 b;
	mediump mat3x4 c;
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	highp mat2 a;
	highp mat2x3 b;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	lowp mat2 b;
	mediump int c;
};

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = mat2(-60.0, 72.0, -102.0, -100.0);
	c = 84;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=44 sizeInLocations=3
{
	highp ivec3 b;
	highp ivec4 c;
	lowp ivec4 d;
} blockC;

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.b = ivec3(72, -102, -100);
	blockC.c = ivec4(84, -31, 68, 104);
	blockC.d = ivec4(14, 83, -117, 75);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	dmat3x2 b;
	sA c;
} blockC;

void main (void)
{
	a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b = dmat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC.c.mA = dvec4(12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	lowp mat2 a; // unassigned
	mediump uint b;
	dmat3x2 c; // unassigned
};

void main (void)
{
	b = 89u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=14
{
	dmat4 a;
	dvec3 b;
	mediump mat4x3 c;
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b = dvec3(-18.0, -101.0, 100.0);
	c = mat4x3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	mediump float a;
	lowp ivec2 b;
	dvec4 c;
};

void main (void)
{
	a = -89.0f;
	b = ivec2(30, -70);
	c = dvec4(-60.0, 72.0, -102.0, -100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	dmat2 a;
	lowp ivec2 b;
	lowp mat3x2 c;
} blockB;

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = ivec2(72, -102);
	blockB.c = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=10
{
	highp ivec2 a;
	dmat4 b;
	highp ivec3 c;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 152) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 d;
};

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB.c = ivec3(100, -34, -35);
	d = ivec3(-43, 48, 4);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	dmat4x2 a;
	mediump mat4 b;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 c;
};

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = mat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = dmat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	mediump mat3x2 a;
	highp mat3x4 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 c;
} blockC;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = mat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC.c = dvec3(100.0, -34.0, -35.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	lowp mat4 a;
} blockB;

void main (void)
{
	blockB.a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	dvec3 a;
	dmat2x3 b;
	dvec2 c;
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockB.b = dmat2x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.c = dvec2(68.0, 104.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	lowp float a;
	highp mat2x3 b;
	highp uint c;
} blockB;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockB.c = 84u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	dmat2 b;
	lowp vec3 c;
};

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	b = dmat2(68.0, 104.0, 14.0, 83.0);
	c = vec3(-117.0f, 75.0f, 12.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	lowp ivec3 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 b;
} blockC;

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	blockC.b = uvec2(60u, 72u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec4 mA;
	dmat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=11
{
	sA a;
	highp mat4x2 b;
	dvec2 c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	mediump mat2x3 d;
} blockC;
layout(location = 13, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=88 sizeInLocations=8
{
	lowp vec3 e;
	dmat2x3 f;
	highp mat3x2 g; // unassigned
};

void main (void)
{
	a.mA = dvec4(-89.0, 30.0, -70.0, -60.0);
	a.mB = dmat4x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	c = dvec2(-35.0, -43.0);
	blockC.d = mat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	e = vec3(-80.0f, -62.0f, -54.0f);
	f = dmat2x3(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump uint mA;
};
struct sB
{
	sA mA;
	lowp mat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	sB a;
	highp int b;
};

void main (void)
{
	a.mA.mA = 89u;
	a.mB = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	b = 84;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump vec4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	sA a;
	mediump mat3x4 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=136 sizeInLocations=11
{
	dmat3x4 c;
	highp ivec2 d;
	lowp mat4x2 e;
};

void main (void)
{
	a.mA = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = dmat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	d = ivec2(-80, -62);
	e = mat4x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	lowp int a;
} blockB;

void main (void)
{
	blockB.a = -89;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	lowp ivec3 a; // unassigned
	dvec4 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	double c;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockD // sizeInBytes=32 sizeInLocations=4
{
	mediump ivec2 d;
	mediump mat3x2 e; // unassigned
};

void main (void)
{
	b = dvec4(-89.0, 30.0, -70.0, -60.0);
	c = 72.0;
	d = ivec2(-102, -100);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	dmat2x3 a;
	highp ivec4 b; // unassigned
	mediump ivec4 c;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=80 sizeInLocations=8
{
	lowp int d;
	lowp mat3x2 e;
	sA f;
};

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.c = ivec4(-100, 84, -31, 68);
	d = 104;
	e = mat3x2(14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	f.mA = dmat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x2 mA;
};
struct sB
{
	sA mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	dmat4x2 a; // unassigned
	lowp vec2 b; // unassigned
	sB c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	highp vec3 d;
} blockC;

void main (void)
{
	c.mA.mA = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.d = vec3(-100.0f, 84.0f, -31.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump ivec2 a;
};

void main (void)
{
	a = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=6
{
	mediump mat2x3 a;
	dmat4x2 b;
} blockB;

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dmat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec2 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	mediump vec3 a;
	mediump vec2 b;
	lowp ivec3 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=80 sizeInLocations=7
{
	double d[4];
	mediump ivec4 e[3];
} blockC;
layout(location = 10, xfb_buffer = 0, xfb_offset = 112) out BlockD // sizeInBytes=56 sizeInLocations=6
{
	sA f;
	mediump ivec4 g;
	mediump mat4x2 h;
};

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = vec2(-60.0f, 72.0f);
	c = ivec3(-102, -100, 84);
	blockC.d[0] = -31.0;
	blockC.d[1] = 68.0;
	blockC.d[2] = 104.0;
	blockC.d[3] = 14.0;
	blockC.e[0] = ivec4(83, -117, 75, 12);
	blockC.e[1] = ivec4(-18, -101, 100, -34);
	blockC.e[2] = ivec4(-35, -43, 48, 4);
	g = ivec4(-60, 37, 52, 98);
	h = mat4x2(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=10
{
	dmat4x3 a;
	lowp mat2x3 b;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=28 sizeInLocations=2
{
	highp uvec3 c; // unassigned
	highp vec4 d;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=144 sizeInLocations=9
{
	mediump mat3x4 e; // unassigned
	dmat3x4 f;
};

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	d = vec4(100.0f, -34.0f, -35.0f, -43.0f);
	f = dmat3x4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	mediump int a;
	lowp ivec2 b;
};

void main (void)
{
	a = -89;
	b = ivec2(30, -70);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	highp mat4x3 a;
	lowp mat2 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	lowp mat2 c;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=120 sizeInLocations=8
{
	mediump int d; // unassigned
	dmat4x2 e;
	dmat3x2 f;
};

void main (void)
{
	a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat2(83.0, -117.0, 75.0, 12.0);
	blockC.c = mat2(-18.0, -101.0, 100.0, -34.0);
	e = dmat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	f = dmat3x2(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	mediump uvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=152 sizeInLocations=10
{
	mediump float b; // unassigned
	dmat4 c;
	mediump vec3 d; // unassigned
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 e;
};

void main (void)
{
	a = uvec2(89u, 30u);
	blockC.c = dmat4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	e = dmat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=11
{
	mediump ivec3 a[4]; // unassigned
	dmat4x2 b;
	mediump mat3x4 c;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	dvec4 d;
	mediump uvec4 e;
} blockC;

void main (void)
{
	blockB.b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.c = mat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.d = dvec4(-35.0, -43.0, 48.0, 4.0);
	blockC.e = uvec4(60u, 37u, 52u, 98u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp uvec4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 a;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	dvec3 b;
	dvec2 c;
	lowp uint d;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 144) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	dmat3 e;
	sA f;
	highp uvec2 g;
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = dvec3(83.0, -117.0, 75.0);
	c = dvec2(12.0, -18.0);
	d = 101u;
	e = dmat3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	f.mA = uvec4(98u, 80u, 62u, 54u);
	g = uvec2(79u, 3u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	mediump uvec3 a;
} blockB;

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump uvec2 mA;
	lowp mat4x3 mB;
};
struct sB
{
	dmat2 mA;
};
struct sC
{
	dmat2x3 mA;
};
struct sD
{
	sC mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	sA a; // unassigned
	sB b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	sD c;
	dmat3x4 d[1];
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 232) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	dmat2 e;
	lowp ivec4 f;
	highp uvec2 g;
};

void main (void)
{
	blockB.b.mA = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC.c.mA.mA = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.d[0] = dmat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = dmat2(48.0, 4.0, -60.0, 37.0);
	f = ivec4(52, 98, -80, -62);
	g = uvec2(54u, 79u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat2x3 mA;
	lowp mat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=5
{
	highp uvec3 a;
	dmat4x2 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=120 sizeInLocations=10
{
	sA c;
	lowp ivec2 d;
	dmat4x2 e;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.b = dmat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	c.mA = mat2x3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	c.mB = mat3x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d = ivec2(4, -60);
	e = dmat4x2(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dvec4 a;
	dvec4 b;
	highp uvec2 c;
} blockB;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB.b = dvec4(72.0, -102.0, -100.0, 84.0);
	blockB.c = uvec2(31u, 68u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=4
{
	lowp int a;
	lowp mat3x2 b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 c;
} blockC;

void main (void)
{
	blockB.a = -89;
	blockB.b = mat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockC.c = mat3(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	mediump mat4x2 a;
	mediump uvec3 b;
	highp uvec3 c;
} blockB;

void main (void)
{
	blockB.a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = uvec3(31u, 68u, 104u);
	blockB.c = uvec3(14u, 83u, 117u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=13
{
	dmat4x2 a[3];
	mediump int b;
} blockB;
layout(location = 13, xfb_buffer = 0, xfb_offset = 200) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 c;
} blockC;
layout(location = 16, xfb_buffer = 0, xfb_offset = 224) out BlockD // sizeInBytes=80 sizeInLocations=5
{
	dmat2 d[1];
	lowp mat3x4 e;
};

void main (void)
{
	blockB.a[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB.b = -60;
	blockC.c = mat3x2(37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	d[0] = dmat2(-79.0, 3.0, -97.0, -118.0);
	e = mat3x4(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	dmat2x3 a;
	highp ivec2 b;
	dvec4 c;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dmat2 d;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=168 sizeInLocations=14
{
	dvec3 e;
	mediump mat3 f[4];
} blockD;

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = ivec2(-100, 84);
	c = dvec4(-31.0, 68.0, 104.0, 14.0);
	d = dmat2(83.0, -117.0, 75.0, 12.0);
	blockD.e = dvec3(-18.0, -101.0, 100.0);
	blockD.f[0] = mat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.f[1] = mat3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.f[2] = mat3(48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	blockD.f[3] = mat3(113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	mediump uint a;
	dvec4 b;
	highp vec2 c;
} blockB;

void main (void)
{
	blockB.a = 89u;
	blockB.b = dvec4(30.0, -70.0, -60.0, 72.0);
	blockB.c = vec2(-102.0f, -100.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=10
{
	highp ivec4 a[2];
	sA b;
	dmat2 c;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=200 sizeInLocations=15
{
	dvec3 d[4];
	lowp mat3 e;
	dmat2 f[2];
};
layout(location = 25, xfb_buffer = 0, xfb_offset = 360) out BlockD // sizeInBytes=56 sizeInLocations=6
{
	mediump uvec2 g;
	mediump mat4x2 h; // unassigned
	dvec2 i;
};

void main (void)
{
	blockB.a[0] = ivec4(-89, 30, -70, -60);
	blockB.a[1] = ivec4(72, -102, -100, 84);
	blockB.b.mA = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.c = dmat2(-35.0, -43.0, 48.0, 4.0);
	d[0] = dvec3(-60.0, 37.0, 52.0);
	d[1] = dvec3(98.0, -80.0, -62.0);
	d[2] = dvec3(-54.0, -79.0, 3.0);
	d[3] = dvec3(-97.0, -118.0, -108.0);
	e = mat3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	f[0] = dmat2(32.0, 113.0, -44.0, -77.0);
	f[1] = dmat2(-11.0, 66.0, -11.0, 87.0);
	g = uvec2(87u, 87u);
	i = dvec2(95.0, -46.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 a;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 b;
};

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec3 mA;
	lowp mat3x4 mB[2];
};
struct sB
{
	mediump uvec4 mA;
};
struct sC
{
	dmat4x3 mA[4];
	dmat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	sA a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=464 sizeInLocations=38
{
	sB b; // unassigned
	double c[2];
	sC d;
} blockC;
layout(location = 46, xfb_buffer = 0, xfb_offset = 584) out BlockD // sizeInBytes=24 sizeInLocations=3
{
	mediump mat3x2 e;
};

void main (void)
{
	blockB.a.mA = dvec3(-89.0, 30.0, -70.0);
	blockB.a.mB[0] = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.a.mB[1] = mat3x4(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockC.c[0] = 98.0;
	blockC.c[1] = -80.0;
	blockC.d.mA[0] = dmat4x3(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0);
	blockC.d.mA[1] = dmat4x3(-62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0);
	blockC.d.mA[2] = dmat4x3(-87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0);
	blockC.d.mA[3] = dmat4x3(-109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0);
	blockC.d.mB = dmat3x2(54.0, -50.0, -84.0, -49.0, -6.0, 98.0);
	e = mat3x2(-34.0, -69.0, -57.0, -8.0, -89.0, 91.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=9
{
	dmat2x3 a;
	lowp mat3x4 b; // unassigned
	mediump mat2x3 c;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 120) out BlockC // sizeInBytes=84 sizeInLocations=8
{
	lowp mat3 d; // unassigned
	mediump uvec4 e;
	lowp mat4x2 f;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 208) out BlockD // sizeInBytes=40 sizeInLocations=3
{
	mediump int g;
	dmat2 h;
} blockD;

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = mat2x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	e = uvec4(83u, 117u, 75u, 12u);
	f = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockD.g = -60;
	blockD.h = dmat2(37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	mediump ivec2 a;
	lowp float b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	dvec2 c;
	highp mat4 d;
} blockC;

void main (void)
{
	a = ivec2(-89, 30);
	b = -70.0f;
	blockC.c = dvec2(-60.0, 72.0);
	blockC.d = mat4(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat4 mA;
	lowp vec4 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=7
{
	highp mat2 a;
	dvec2 b;
	dmat4x2 c; // unassigned
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=144 sizeInLocations=9
{
	sA d;
} blockC;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = dvec2(72.0, -102.0);
	blockC.d.mA = dmat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d.mB = vec4(48.0f, 4.0f, -60.0f, 37.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	dvec4 a;
	dmat3 b;
};

void main (void)
{
	a = dvec4(-89.0, 30.0, -70.0, -60.0);
	b = dmat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	highp mat4 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 b;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=44 sizeInLocations=4
{
	highp mat2 c; // unassigned
	mediump ivec4 d;
	lowp ivec3 e;
};

void main (void)
{
	a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b = dvec4(-18.0, -101.0, 100.0, -34.0);
	d = ivec4(-35, -43, 48, 4);
	e = ivec3(-60, 37, 52);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	highp mat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	highp vec3 b; // unassigned
	dvec3 c;
	lowp int d; // unassigned
} blockC;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.c = dvec3(-100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	lowp mat3 a;
	highp ivec3 b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=32 sizeInLocations=3
{
	dvec3 c;
	mediump uvec2 d;
} blockC;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = ivec3(68, 104, 14);
	blockC.c = dvec3(83.0, -117.0, 75.0);
	blockC.d = uvec2(12u, 18u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
	dmat4x3 mB; // unassigned
};
struct sB
{
	highp mat2 mA;
};
struct sC
{
	mediump mat2x3 mA;
	sB mB; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=13
{
	dmat4x2 a; // unassigned
	dmat4x3 b;
	lowp ivec4 c;
} blockB;
layout(location = 13, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=168 sizeInLocations=14
{
	sA d;
	mediump uvec2 e;
	mediump vec4 f;
};
layout(location = 27, xfb_buffer = 0, xfb_offset = 344) out BlockD // sizeInBytes=100 sizeInLocations=8
{
	sC g;
	lowp mat3x4 h;
	lowp uvec3 i; // unassigned
} blockD;

void main (void)
{
	blockB.b = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.c = ivec4(83, -117, 75, 12);
	d.mA = dmat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = uvec2(48u, 4u);
	f = vec4(-60.0f, 37.0f, 52.0f, 98.0f);
	blockD.g.mA = mat2x3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	blockD.h = mat3x4(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp float mA;
	mediump uvec4 mB;
	lowp mat4x2 mC;
};
struct sB
{
	lowp vec2 mA;
	lowp mat4 mB;
};
struct sC
{
	sA mA;
	sB mB; // unassigned
	lowp mat3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	lowp uint a;
	dvec4 b; // unassigned
	highp vec2 c;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 48, xfb_stride = 392) out BlockC // sizeInBytes=264 sizeInLocations=22
{
	dmat3 d;
	sC e;
	dvec4 f;
} blockC[3];
layout(location = 70, xfb_buffer = 0, xfb_offset = 312) out BlockD // sizeInBytes=80 sizeInLocations=7
{
	mediump mat3x2 g;
	mediump mat3x4 h;
	double i;
};

void main (void)
{
	a = 89u;
	c = vec2(30.0f, -70.0f);
	blockC[0].d = dmat3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC[0].e.mA.mA = 83.0f;
	blockC[0].e.mA.mB = uvec4(117u, 75u, 12u, 18u);
	blockC[0].e.mA.mC = mat4x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockC[0].e.mC = mat3(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	blockC[0].f = dvec4(-118.0, -108.0, -120.0, 48.0);
	blockC[1].d = dmat3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	blockC[1].e.mA.mA = -44.0f;
	blockC[1].e.mA.mB = uvec4(77u, 11u, 66u, 11u);
	blockC[1].e.mA.mC = mat4x2(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	blockC[1].e.mC = mat3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0);
	blockC[1].f = dvec4(-6.0, 37.0, -112.0, 88.0);
	blockC[2].d = dmat3(-40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0);
	blockC[2].e.mA.mA = 98.0f;
	blockC[2].e.mA.mB = uvec4(34u, 69u, 57u, 8u);
	blockC[2].e.mA.mC = mat4x2(-89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0);
	blockC[2].e.mC = mat3(-127.0, 44.0, 56.0, -33.0, 109.0, -119.0, 34.0, -102.0, 104.0);
	blockC[2].f = dvec4(33.0, 127.0, 121.0, 42.0);
	g = mat3x2(-34.0, -92.0, 75.0, -68.0, 84.0, -4.0);
	h = mat3x4(38.0, 119.0, -79.0, 39.0, -7.0, 119.0, -75.0, 19.0, -79.0, -31.0, 50.0, 79.0);
	i = -21.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
	dmat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	lowp ivec2 b;
	highp ivec4 c; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 48, xfb_stride = 256) out BlockD // sizeInBytes=208 sizeInLocations=14
{
	sA d;
	dmat4x2 e; // unassigned
} blockD[2];

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = ivec2(-100, 84);
	blockD[0].d.mA = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockD[0].d.mB = dmat2x3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockD[1].d.mA = dmat3x4(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockD[1].d.mB = dmat2x3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out BlockB // sizeInBytes=88 sizeInLocations=8
{
	lowp uvec2 a;
	dmat3 b;
	mediump vec2 c;
} blockB[3];
layout(location = 24, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 d;
} blockC[1];

void main (void)
{
	blockB[0].a = uvec2(89u, 30u);
	blockB[0].b = dmat3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockB[0].c = vec2(14.0f, 83.0f);
	blockB[1].a = uvec2(117u, 75u);
	blockB[1].b = dmat3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[1].c = vec2(-60.0f, 37.0f);
	blockB[2].a = uvec2(52u, 98u);
	blockB[2].b = dmat3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockB[2].c = vec2(48.0f, -71.0f);
	blockC[0].d = mat4x2(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 b;
} blockC;

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.b = mat4x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat3 mA; // unassigned
	highp uvec4 mB;
	mediump mat3x4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	dvec2 a;
	sA b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b.mB = uvec4(70u, 60u, 72u, 102u);
	b.mC = mat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump vec2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=4
{
	lowp mat2x3 a;
	sA b;
	lowp vec3 c;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=120 sizeInLocations=8
{
	dmat3x4 d;
	lowp mat2x3 e;
};

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b.mA = vec2(-100.0f, 84.0f);
	blockB.c = vec3(-31.0f, 68.0f, 104.0f);
	d = dmat3x4(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = mat2x3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp ivec3 mA;
	highp mat3 mB;
	lowp mat4x2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=336 sizeInLocations=24
{
	dmat4 a;
	dmat4 b;
	sA c;
} blockB;

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.b = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB.c.mA = ivec3(3, -97, -118);
	blockB.c.mB = mat3(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockB.c.mC = mat4x2(-51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	dvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	highp ivec2 b;
} blockC;

void main (void)
{
	a = dvec2(-89.0, 30.0);
	blockC.b = ivec2(-70, -60);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp uvec3 b;
	highp vec2 c;
	highp float d;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=136 sizeInLocations=10
{
	highp mat4 e;
	dmat3 f;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = uvec3(72u, 102u, 100u);
	c = vec2(84.0f, -31.0f);
	d = 68.0f;
	e = mat4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	f = dmat3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	mediump mat3x4 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=120 sizeInLocations=10
{
	dmat4x3 b; // unassigned
	dvec3 c;
};

void main (void)
{
	blockB.a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = dvec3(83.0, -117.0, 75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
	lowp vec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 152) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	sA a;
	highp vec4 b;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=76 sizeInLocations=5
{
	mediump mat4 c;
	lowp uvec3 d;
};

void main (void)
{
	blockB[0].a.mA = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].a.mB = vec2(-100.0f, 84.0f);
	blockB[0].b = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockB[1].a.mA = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].a.mB = vec2(100.0f, -34.0f);
	blockB[1].b = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	c = mat4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	d = uvec3(40u, 62u, 114u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=160 sizeInLocations=12
{
	dmat2 b;
	dmat3x4 c;
	lowp mat4x2 d;
} blockC;

void main (void)
{
	blockB[0].a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC.b = dmat2(-100.0, 84.0, -31.0, 68.0);
	blockC.c = dmat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.d = mat4x2(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	dvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	lowp mat3x2 b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = mat3x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	highp vec4 a;
	mediump float b;
	dvec2 c;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 d;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	mediump ivec3 e;
} blockD;

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = 72.0f;
	c = dvec2(-102.0, -100.0);
	d = dvec3(84.0, -31.0, 68.0);
	blockD.e = ivec3(104, 14, 83);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
	mediump mat3x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 120) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec4 a;
} blockB[2];
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=72 sizeInLocations=7
{
	sA b;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 c;
} blockD;

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[1].a = dvec4(72.0, -102.0, -100.0, 84.0);
	blockC.b.mA = dmat2x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.b.mB = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockD.c = uvec3(35u, 43u, 48u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	double a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 b;
} blockC;

void main (void)
{
	blockB.a = -89.0;
	blockC.b = mat2(30.0, -70.0, -60.0, 72.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat3x2 mA;
	dmat2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	dvec4 a;
	dmat4x3 b;
} blockB;
layout(location = 10, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	sA c;
} blockC;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB.b = dmat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c.mA = mat3x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC.c.mB = dmat2(48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dvec4 a;
} blockB;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	dmat3x2 a;
	highp uvec2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=160 sizeInLocations=13
{
	mediump mat4x3 c;
	mediump vec4 d;
	dmat4x3 e;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=144 sizeInLocations=11
{
	highp mat4 f;
	mediump mat4x2 g;
	sA h;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = uvec2(100u, 84u);
	c = mat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	d = vec4(-35.0f, -43.0f, 48.0f, 4.0f);
	e = dmat4x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	f = mat4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	g = mat4x2(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	h.mA = dmat3x2(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	lowp uvec2 a;
	lowp vec2 b; // unassigned
};

void main (void)
{
	a = uvec2(89u, 30u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat2x3 mA;
	highp mat4 mB;
	dvec2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	dmat4 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=176 sizeInLocations=13
{
	sA b;
	dmat3 c;
} blockC[1];

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].b.mA = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockC[0].b.mB = mat4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockC[0].b.mC = dvec2(-71.0, -59.0);
	blockC[0].c = dmat3(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	mediump mat2 a;
} blockB[3];

void main (void)
{
	blockB[0].a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB[1].a = mat2(72.0, -102.0, -100.0, 84.0);
	blockB[2].a = mat2(-31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	lowp mat3x4 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	highp uvec3 b;
	double c;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = uvec3(83u, 117u, 75u);
	c = 12.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 64) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	dmat2 a;
	dvec2 b;
	lowp mat2 c;
} blockB[2];

void main (void)
{
	blockB[0].a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = dvec2(72.0, -102.0);
	blockB[0].c = mat2(-100.0, 84.0, -31.0, 68.0);
	blockB[1].a = dmat2(104.0, 14.0, 83.0, -117.0);
	blockB[1].b = dvec2(75.0, 12.0);
	blockB[1].c = mat2(-18.0, -101.0, 100.0, -34.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=3
{
	lowp uvec3 a;
	mediump uint b;
	mediump float c; // unassigned
};

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b = 60u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec3 mA; // unassigned
	lowp ivec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	sA a; // unassigned
	mediump float b;
};

void main (void)
{
	b = -89.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat3 mA; // unassigned
};
struct sB
{
	dmat2 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 136) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	highp mat3x4 a;
} blockB[2];
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=88 sizeInLocations=6
{
	lowp uvec3 b;
	sB c;
} blockC[1];

void main (void)
{
	blockB[0].a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[1].a = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC[0].b = uvec3(60u, 37u, 52u);
	blockC[0].c.mA = dmat2(98.0, -80.0, -62.0, -54.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	double a;
	dvec4 b;
} blockB[1];
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=60 sizeInLocations=4
{
	lowp mat3x4 c;
	highp ivec3 d;
} blockC;

void main (void)
{
	blockB[0].a = -89.0;
	blockB[0].b = dvec4(30.0, -70.0, -60.0, 72.0);
	blockC.c = mat3x4(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = ivec3(-101, 100, -34);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec2 mA; // unassigned
	dmat2 mB;
};
struct sB
{
	highp int mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=8
{
	sB a;
	highp mat3x2 b;
	highp int c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 d;
} blockC;

void main (void)
{
	a.mA = -89;
	a.mB.mB = dmat2(30.0, -70.0, -60.0, 72.0);
	b = mat3x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	c = 14;
	blockC.d = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp vec2 mA;
	dmat2 mB;
	mediump float mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=14
{
	dmat2x3 a;
	dmat4 b;
	dmat2 c;
} blockB[1];
layout(location = 14, xfb_buffer = 0, xfb_offset = 208, xfb_stride = 408) out BlockC // sizeInBytes=176 sizeInLocations=12
{
	dmat3x4 d;
	sA e; // unassigned
	dmat2 f;
} blockC[3];
layout(location = 50, xfb_buffer = 0, xfb_offset = 384) out BlockD // sizeInBytes=24 sizeInLocations=3
{
	highp vec2 g;
	lowp vec3 h;
	mediump float i; // unassigned
};

void main (void)
{
	blockB[0].a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b = dmat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockB[0].c = dmat2(48.0, 4.0, -60.0, 37.0);
	blockC[0].d = dmat3x4(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	blockC[0].f = dmat2(-71.0, -59.0, -40.0, -62.0);
	blockC[1].d = dmat3x4(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockC[1].f = dmat2(87.0, 95.0, -46.0, -122.0);
	blockC[2].d = dmat3x4(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0);
	blockC[2].f = dmat2(37.0, -112.0, 88.0, -40.0);
	g = vec2(-22.0f, 40.0f);
	h = vec3(-17.0f, 54.0f, -50.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp float mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=12 sizeInLocations=2
{
	mediump ivec2 b;
	sA c;
} blockC;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockC.b = ivec2(-60, 72);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat4x2 mA;
};
struct sB
{
	dmat2 mA;
};
struct sC
{
	mediump mat4x2 mA; // unassigned
	highp uvec4 mB;
	mediump ivec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=12
{
	sA a;
	sB b;
	sC c;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	dvec2 d;
} blockC;

void main (void)
{
	blockB.a.mA = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b.mA = dmat2(-31.0, 68.0, 104.0, 14.0);
	blockB.c.mB = uvec4(83u, 117u, 75u, 12u);
	blockB.c.mC = ivec4(-18, -101, 100, -34);
	blockC.d = dvec2(-35.0, -43.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	lowp uvec2 a;
	dmat4x2 b;
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = dmat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	mediump mat2x3 a;
	mediump vec3 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	dmat3x2 c;
	lowp uint d[2];
};

void main (void)
{
	a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = vec3(-100.0f, 84.0f, -31.0f);
	c = dmat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	d[0] = 12u;
	d[1] = 18u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 88) out BlockB // sizeInBytes=88 sizeInLocations=9
{
	mediump ivec2 a; // unassigned
	lowp mat4x2 b;
	lowp mat4x3 c;
} blockB[3];

void main (void)
{
	blockB[0].b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[0].c = mat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB[1].b = mat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB[1].c = mat4x3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockB[2].b = mat4x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockB[2].c = mat4x3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=12
{
	dmat4x3 a;
	highp int b;
	lowp mat3 c;
} blockB;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = 83;
	blockB.c = mat3(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat4x3 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96, xfb_stride = 120) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	dvec3 b;
} blockC[3];

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC[0].b = dvec3(83.0, -117.0, 75.0);
	blockC[1].b = dvec3(12.0, -18.0, -101.0);
	blockC[2].b = dvec3(100.0, -34.0, -35.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp uint a;
	highp uint b;
	mediump vec4 c;
} blockB;

void main (void)
{
	blockB.a = 89u;
	blockB.b = 30u;
	blockB.c = vec4(-70.0f, -60.0f, 72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	highp uvec2 a[1];
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=96 sizeInLocations=7
{
	mediump mat2x3 b;
	dmat4x2 c;
	highp float d; // unassigned
} blockC[1];
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=96 sizeInLocations=8
{
	dmat2x3 e;
	dmat2x3 f;
} blockD;

void main (void)
{
	blockB[0].a[0] = uvec2(89u, 30u);
	blockC[0].b = mat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC[0].c = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockD.e = dmat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.f = dmat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec3 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=11
{
	sA a;
	lowp mat3x2 b;
	dmat3x4 c;
};

void main (void)
{
	b = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	dvec2 a;
	mediump int b;
	mediump uvec3 c;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b = -70;
	c = uvec3(60u, 72u, 102u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3 mA;
	dvec2 mB; // unassigned
};
struct sB
{
	lowp uvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	sA a[1];
	mediump uvec2 b;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	dmat3x4 c;
	lowp mat3 d;
	sB e;
};
layout(location = 18, xfb_buffer = 0, xfb_offset = 240) out BlockD // sizeInBytes=16 sizeInLocations=2
{
	highp mat2 f;
} blockD;

void main (void)
{
	blockB.a[0].mA = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = uvec2(68u, 104u);
	c = dmat3x4(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d = mat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	e.mA = uvec3(3u, 97u, 118u);
	blockD.f = mat2(-108.0, -120.0, 48.0, -71.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec3 mA;
	highp mat3x2 mB;
	dmat4x2 mC;
};
struct sB
{
	lowp mat3 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=12
{
	sB a;
	highp int b;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockC // sizeInBytes=128 sizeInLocations=12
{
	dmat4x3 c;
	lowp mat3x2 d;
	highp int e;
} blockC;

void main (void)
{
	blockB.a.mA = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.a.mB.mA = vec3(68.0f, 104.0f, 14.0f);
	blockB.a.mB.mB = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB.a.mB.mC = dmat4x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockB.b = 52;
	blockC.c = dmat4x3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockC.d = mat3x2(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0);
	blockC.e = 32;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2 mA;
	lowp mat2 mB;
	double mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	highp vec3 a;
	mediump uint b;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	highp uvec4 c;
	highp vec4 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockD // sizeInBytes=120 sizeInLocations=9
{
	sA e;
	mediump mat4 f;
} blockD;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = 60u;
	c = uvec4(72u, 102u, 100u, 84u);
	d = vec4(-31.0f, 68.0f, 104.0f, 14.0f);
	blockD.e.mA = dmat2(83.0, -117.0, 75.0, 12.0);
	blockD.e.mB = mat2(-18.0, -101.0, 100.0, -34.0);
	blockD.e.mC = -35.0;
	blockD.f = mat4(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	dmat2x3 a;
} blockB;

void main (void)
{
	blockB.a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	dmat2 a; // unassigned
	dvec3 b[1];
	lowp int c;
} blockB;

void main (void)
{
	blockB.b[0] = dvec3(-89.0, 30.0, -70.0);
	blockB.c = -60;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=5
{
	mediump mat4x2 a;
	highp float b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=88 sizeInLocations=8
{
	mediump mat2 c[1];
	dmat2x3 d;
	dvec3 e;
} blockC;

void main (void)
{
	a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = -31.0f;
	blockC.c[0] = mat2(68.0, 104.0, 14.0, 83.0);
	blockC.d = dmat2x3(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockC.e = dvec3(-34.0, -35.0, -43.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	dmat4x3 a;
	mediump uvec4 b;
	lowp vec3 c;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 128, xfb_stride = 232) out BlockC // sizeInBytes=104 sizeInLocations=8
{
	highp vec4 d;
	dmat3 e;
	highp uvec3 f;
} blockC[2];

void main (void)
{
	a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = uvec4(83u, 117u, 75u, 12u);
	c = vec3(-18.0f, -101.0f, 100.0f);
	blockC[0].d = vec4(-34.0f, -35.0f, -43.0f, 48.0f);
	blockC[0].e = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC[0].f = uvec3(3u, 97u, 118u);
	blockC[1].d = vec4(-108.0f, -120.0f, 48.0f, -71.0f);
	blockC[1].e = dmat3(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC[1].f = uvec3(77u, 11u, 66u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec2 mA;
	dvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	sA a;
	dmat4x2 b;
};

void main (void)
{
	a.mA = dvec2(-89.0, 30.0);
	a.mB = dvec3(-70.0, -60.0, 72.0);
	b = dmat4x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=10
{
	lowp vec3 a;
	mediump mat3x4 b[1];
	dvec3 c[3];
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	lowp vec2 d;
};

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b[0] = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	c[0] = dvec3(12.0, -18.0, -101.0);
	c[1] = dvec3(100.0, -34.0, -35.0);
	c[2] = dvec3(-43.0, 48.0, 4.0);
	d = vec2(-60.0f, 37.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 144) out BlockB // sizeInBytes=112 sizeInLocations=10
{
	highp mat3x2 a;
	dmat4x2 b;
	lowp mat3x2 c;
} blockB[3];
layout(location = 30, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=32 sizeInLocations=4
{
	highp mat4x2 d;
} blockC;

void main (void)
{
	blockB[0].a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b = dmat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB[0].c = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB[1].a = mat3x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockB[1].b = dmat4x2(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	blockB[1].c = mat3x2(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockB[2].a = mat3x2(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	blockB[2].b = dmat4x2(113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockB[2].c = mat3x2(87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	blockC.d = mat4x2(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat2 a; // unassigned
	highp ivec4 b[1];
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=272 sizeInLocations=22
{
	mediump mat4x3 c[4]; // unassigned
	dmat2 d;
	dmat2x3 e;
};

void main (void)
{
	b[0] = ivec4(-89, 30, -70, -60);
	d = dmat2(72.0, -102.0, -100.0, 84.0);
	e = dmat2x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 136) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	highp vec4 a; // unassigned
	lowp mat3x2 b;
} blockB[2];
layout(location = 8, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	highp mat3x4 c;
	dmat3x2 d;
} blockC;

void main (void)
{
	blockB[0].b = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[1].b = mat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.d = dmat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=5
{
	highp ivec4 a;
	mediump vec4 b;
	mediump mat3 c;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 68) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	mediump mat3 d;
} blockC;

void main (void)
{
	a = ivec4(-89, 30, -70, -60);
	b = vec4(72.0f, -102.0f, -100.0f, 84.0f);
	c = mat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = mat3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=7
{
	highp mat2 a;
	lowp uint b;
	dmat2x3 c;
} blockB;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = 72u;
	blockB.c = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	mediump mat3x2 a;
	dvec2 b;
} blockB;

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = dvec2(-100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	double a;
	mediump mat4 b; // unassigned
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat4x3 c;
};

void main (void)
{
	blockB.a = -89.0;
	c = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=16 sizeInLocations=2
{
	lowp mat2 b;
};

void main (void)
{
	a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat2(-31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	highp mat3x4 a;
	lowp mat3x2 b;
} blockB[3];

void main (void)
{
	blockB[0].a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[0].b = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].a = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockB[1].b = mat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockB[2].a = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockB[2].b = mat3x2(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump int mA;
	dmat3x4 mB; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=100 sizeInLocations=8
{
	lowp uint a;
	highp mat4x3 b;
	mediump mat3x4 c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=112 sizeInLocations=8
{
	lowp int d;
	sA e; // unassigned
} blockC[1];
layout(location = 16, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=88 sizeInLocations=7
{
	dmat3 f;
	mediump uvec3 g;
} blockD[1];

void main (void)
{
	a = 89u;
	b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c = mat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockC[0].d = 37;
	blockD[0].f = dmat3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD[0].g = uvec3(108u, 120u, 48u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
	lowp vec3 mB;
	dmat2 mC;
};
struct sB
{
	sA mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 352) out BlockB // sizeInBytes=272 sizeInLocations=17
{
	dmat4 a;
	sB b;
} blockB[3];
layout(location = 51, xfb_buffer = 0, xfb_offset = 272) out BlockC // sizeInBytes=80 sizeInLocations=7
{
	dvec4 c;
	mediump ivec4 d[1];
	highp mat4x2 e;
} blockC;

void main (void)
{
	blockB[0].a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB[0].b.mA.mA = dmat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB[0].b.mA.mB = vec3(-80.0f, -62.0f, -54.0f);
	blockB[0].b.mA.mC = dmat2(-79.0, 3.0, -97.0, -118.0);
	blockB[1].a = dmat4(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockB[1].b.mA.mA = dmat3x4(-11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0);
	blockB[1].b.mA.mB = vec3(-60.0f, 58.0f, -109.0f);
	blockB[1].b.mA.mC = dmat2(-38.0, -103.0, -63.0, -6.0);
	blockB[2].a = dmat4(37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0, -69.0, -57.0);
	blockB[2].b.mA.mA = dmat3x4(-8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0, 44.0, 56.0);
	blockB[2].b.mA.mB = vec3(-33.0f, 109.0f, -119.0f);
	blockB[2].b.mA.mC = dmat2(34.0, -102.0, 104.0, 33.0);
	blockC.c = dvec4(127.0, 121.0, 42.0, -34.0);
	blockC.d[0] = ivec4(-92, 75, -68, 84);
	blockC.e = mat4x2(-4.0, 38.0, 119.0, -79.0, 39.0, -7.0, 119.0, -75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=7
{
	highp mat3x2 a;
	mediump mat4x2 b;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dmat2 c;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=288 sizeInLocations=19
{
	highp mat3x4 d;
	sA e;
	highp mat4 f[1][3];
} blockD[1];

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.c = dmat2(75.0, 12.0, -18.0, -101.0);
	blockD[0].d = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	blockD[0].e.mA = dmat2x3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD[0].f[0][0] = mat4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	blockD[0].f[0][1] = mat4(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0);
	blockD[0].f[0][2] = mat4(-63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0, -34.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dmat3x2 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=112 sizeInLocations=7
{
	dmat3x4 b;
	lowp uvec3 c;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 160, xfb_stride = 176) out BlockD // sizeInBytes=16 sizeInLocations=2
{
	mediump vec2 d[1];
	double e;
} blockD[2];

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = uvec3(100u, 34u, 35u);
	blockD[0].d[0] = vec2(-43.0f, 48.0f);
	blockD[0].e = 4.0;
	blockD[1].d[0] = vec2(-60.0f, 37.0f);
	blockD[1].e = 52.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp uint mA;
	dvec3 mB;
	lowp uvec4 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 312) out BlockB // sizeInBytes=264 sizeInLocations=18
{
	dmat3 a;
	dmat4x2 b;
	dmat4 c;
} blockB[2];
layout(location = 36, xfb_buffer = 0, xfb_offset = 264, xfb_stride = 312) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	sA d;
} blockC[3];

void main (void)
{
	blockB[0].a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB[0].b = dmat4x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockB[0].c = dmat4(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockB[1].a = dmat3(-97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockB[1].b = dmat4x2(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0);
	blockB[1].c = dmat4(66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0);
	blockC[0].d.mA = 38u;
	blockC[0].d.mB = dvec3(-103.0, -63.0, -6.0);
	blockC[0].d.mC = uvec4(37u, 112u, 88u, 40u);
	blockC[1].d.mA = 22u;
	blockC[1].d.mB = dvec3(40.0, -17.0, 54.0);
	blockC[1].d.mC = uvec4(50u, 84u, 49u, 6u);
	blockC[2].d.mA = 98u;
	blockC[2].d.mB = dvec3(-34.0, -69.0, -57.0);
	blockC[2].d.mC = uvec4(8u, 89u, 91u, 114u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=18
{
	dmat3x4 a;
	dmat2x3 b[3];
} blockB[1];

void main (void)
{
	blockB[0].a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB[0].b[0] = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[0].b[1] = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[0].b[2] = dmat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	mediump uvec3 a;
	dmat3x2 b; // unassigned
	lowp uint c;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 72, xfb_stride = 264) out BlockC // sizeInBytes=144 sizeInLocations=9
{
	dmat3x4 d;
	lowp mat3x4 e;
} blockC[3];
layout(location = 32, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	dmat2 f; // unassigned
	mediump ivec2 g; // unassigned
	double h;
} blockD[1];

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.c = 60u;
	blockC[0].d = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].e = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC[1].d = dmat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	blockC[1].e = mat3x4(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	blockC[2].d = dmat3x4(87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	blockC[2].e = mat3x4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	blockD[0].h = -17.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	dmat4x2 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=160 sizeInLocations=10
{
	mediump uvec3 b;
	dmat4 c;
	lowp vec3 d;
};

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = uvec3(31u, 68u, 104u);
	c = dmat4(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	d = vec3(98.0f, -80.0f, -62.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=12
{
	lowp mat4 a;
	dvec3 b[4];
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=28 sizeInLocations=3
{
	highp float c;
	highp uvec3 d[1][2];
} blockC[1];
layout(location = 15, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=144 sizeInLocations=9
{
	mediump vec4 e;
	dmat2 f;
	dmat3x4 g;
} blockD;

void main (void)
{
	blockB.a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.b[0] = dvec3(-18.0, -101.0, 100.0);
	blockB.b[1] = dvec3(-34.0, -35.0, -43.0);
	blockB.b[2] = dvec3(48.0, 4.0, -60.0);
	blockB.b[3] = dvec3(37.0, 52.0, 98.0);
	blockC[0].c = -80.0f;
	blockC[0].d[0][0] = uvec3(62u, 54u, 79u);
	blockC[0].d[0][1] = uvec3(3u, 97u, 118u);
	blockD.e = vec4(-108.0f, -120.0f, 48.0f, -71.0f);
	blockD.f = dmat2(-59.0, -40.0, -62.0, 114.0);
	blockD.g = dmat3x4(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat3x2 mA;
};
struct sB
{
	sA mA;
};
struct sC
{
	highp vec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 140) out BlockB // sizeInBytes=36 sizeInLocations=4
{
	sB a;
	sC b[1];
} blockB[3];
layout(location = 12, xfb_buffer = 0, xfb_offset = 36) out BlockC // sizeInBytes=36 sizeInLocations=3
{
	lowp mat3 c;
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=68 sizeInLocations=5
{
	mediump mat3x4 d;
	highp vec4 e; // unassigned
	mediump int f;
};

void main (void)
{
	blockB[0].a.mA.mA = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB[0].b[0].mA = vec3(-100.0f, 84.0f, -31.0f);
	blockB[1].a.mA.mA = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB[1].b[0].mA = vec3(12.0f, -18.0f, -101.0f);
	blockB[2].a.mA.mA = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockB[2].b[0].mA = vec3(-60.0f, 37.0f, 52.0f);
	blockC.c = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	d = mat3x4(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	f = -77;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=14
{
	lowp mat3 a;
	mediump mat3x2 b;
	dmat4x3 c;
} blockB;
layout(location = 14, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=176 sizeInLocations=11
{
	lowp vec4 d;
	dmat3x4 e;
	dmat4x2 f;
};

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.b = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.c = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	d = vec4(98.0f, -80.0f, -62.0f, -54.0f);
	e = dmat3x4(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
	f = dmat4x2(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp ivec4 mA;
	mediump mat2 mB;
	dmat2x3 mC;
};
struct sB
{
	lowp mat3x2 mA;
	mediump mat4x2 mB;
};
struct sC
{
	sA mA;
	sB mB;
	highp uint mC;
};
struct sD
{
	dmat3 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 304) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dmat4x2 a;
	mediump uvec2 b;
} blockB[3];
layout(location = 15, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=232 sizeInLocations=22
{
	lowp uvec4 c;
	sC d; // unassigned
	sD e; // unassigned
} blockC;

void main (void)
{
	blockB[0].a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[0].b = uvec2(31u, 68u);
	blockB[1].a = dmat4x2(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockB[1].b = uvec2(100u, 34u);
	blockB[2].a = dmat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB[2].b = uvec2(80u, 62u);
	blockC.c = uvec4(54u, 79u, 3u, 97u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	dvec2 a;
	lowp uvec4 b;
	highp vec4 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=20 sizeInLocations=3
{
	mediump uint d;
	lowp mat2 e;
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	mediump mat2 f;
	dmat4x2 g;
} blockD[1];

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = uvec4(70u, 60u, 72u, 102u);
	blockB.c = vec4(-100.0f, 84.0f, -31.0f, 68.0f);
	blockC.d = 104u;
	blockC.e = mat2(14.0, 83.0, -117.0, 75.0);
	blockD[0].f = mat2(12.0, -18.0, -101.0, 100.0);
	blockD[0].g = dmat4x2(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	dmat3 a;
	mediump int b; // unassigned
	lowp ivec4 c;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=160 sizeInLocations=10
{
	dmat3x4 d;
	highp mat3x4 e;
	lowp uvec3 f; // unassigned
};

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.c = ivec4(68, 104, 14, 83);
	d = dmat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	e = mat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 184) out BlockB // sizeInBytes=112 sizeInLocations=8
{
	highp mat4x3 a; // unassigned
	dmat4x2 b;
} blockB[2];
layout(location = 16, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=72 sizeInLocations=7
{
	mediump mat3x2 c;
	dmat2x3 d;
};

void main (void)
{
	blockB[0].b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[1].b = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = mat3x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	d = dmat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=400 sizeInLocations=33
{
	dvec2 a;
	dmat4x3 b[4];
};
layout(location = 33, xfb_buffer = 0, xfb_offset = 400, xfb_stride = 488) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	dvec4 c;
} blockC[3];
layout(location = 39, xfb_buffer = 0, xfb_offset = 432) out BlockD // sizeInBytes=56 sizeInLocations=5
{
	lowp mat4x3 d;
	lowp ivec2 e;
} blockD;

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b[0] = dmat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	b[1] = dmat4x3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	b[2] = dmat4x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	b[3] = dmat4x3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0);
	blockC[0].c = dvec4(66.0, -11.0, 87.0, -87.0);
	blockC[1].c = dvec4(87.0, 95.0, -46.0, -122.0);
	blockC[2].c = dvec4(-97.0, 108.0, -127.0, -10.0);
	blockD.d = mat4x3(113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0);
	blockD.e = ivec2(-22, 40);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=19
{
	highp mat4x2 a[3]; // unassigned
	dmat3 b; // unassigned
	lowp float c;
} blockB;
layout(location = 19, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=40 sizeInLocations=4
{
	highp uvec2 d[3];
	dvec2 e;
};

void main (void)
{
	blockB.c = -89.0f;
	d[0] = uvec2(30u, 70u);
	d[1] = uvec2(60u, 72u);
	d[2] = uvec2(102u, 100u);
	e = dvec2(84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	dmat2 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32, xfb_stride = 208) out BlockC // sizeInBytes=176 sizeInLocations=13
{
	lowp mat3x4 b;
	lowp mat4x2 c;
	sA d; // unassigned
} blockC[3];

void main (void)
{
	blockB.a = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC[0].b = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC[0].c = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC[1].b = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockC[1].c = mat4x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);
	blockC[2].b = mat3x4(-51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	blockC[2].c = mat4x2(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	double a[2];
};

void main (void)
{
	a[0] = -89.0;
	a[1] = 30.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
} blockB[1];
layout(location = 6, xfb_buffer = 0, xfb_offset = 72, xfb_stride = 264) out BlockC // sizeInBytes=136 sizeInLocations=9
{
	lowp mat4 b;
	dmat4x2 c;
	mediump uint d;
} blockC[3];
layout(location = 33, xfb_buffer = 0, xfb_offset = 208) out BlockD // sizeInBytes=52 sizeInLocations=5
{
	mediump mat4x3 e;
	highp uint f;
} blockD;

void main (void)
{
	blockB[0].a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC[0].b = mat4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	blockC[0].c = dmat4x2(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[0].d = 97u;
	blockC[1].b = mat4(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0);
	blockC[1].c = dmat4x2(66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0);
	blockC[1].d = 97u;
	blockC[2].b = mat4(108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0);
	blockC[2].c = dmat4x2(40.0, -17.0, 54.0, -50.0, -84.0, -49.0, -6.0, 98.0);
	blockC[2].d = 34u;
	blockD.e = mat4x3(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
	blockD.f = 44u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=16
{
	dmat2x3 a;
	highp mat4x3 b[2];
	highp mat4x3 c;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	lowp vec4 d;
	dmat3x2 e;
};

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b[0] = mat4x3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	b[1] = mat4x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	c = mat4x3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	d = vec4(114.0f, -109.0f, -51.0f, 32.0f);
	e = dmat3x2(113.0, -44.0, -77.0, -11.0, 66.0, -11.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=28 sizeInLocations=3
{
	lowp ivec2 a;
	highp uvec2 b;
	mediump vec3 c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 28) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	lowp uvec3 d;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=200 sizeInLocations=13
{
	dmat3x4 e; // unassigned
	highp ivec2 f;
	dmat3x4 g;
} blockD;

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = uvec2(70u, 60u);
	blockB.c = vec3(72.0f, -102.0f, -100.0f);
	d = uvec3(84u, 31u, 68u);
	blockD.f = ivec2(104, 14);
	blockD.g = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	lowp mat4x3 a;
} blockB[1];

void main (void)
{
	blockB[0].a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	highp vec3 a;
	dmat3x4 b;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 112, xfb_stride = 224) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	lowp uvec4 c;
} blockC[2];
layout(location = 9, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 d;
} blockD;

void main (void)
{
	a = vec3(-89.0f, 30.0f, -70.0f);
	b = dmat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC[0].c = uvec4(12u, 18u, 101u, 100u);
	blockC[1].c = uvec4(34u, 35u, 43u, 48u);
	blockD.d = dmat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 80) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	dvec4 a;
	lowp mat4x3 b;
} blockB[3];

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = mat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB[1].a = dvec4(-18.0, -101.0, 100.0, -34.0);
	blockB[1].b = mat4x3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB[2].a = dvec4(3.0, -97.0, -118.0, -108.0);
	blockB[2].b = mat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=7
{
	lowp vec2 a;
	dmat3x4 b;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = dmat3x4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=7
{
	lowp int a;
	lowp mat4x3 b;
	lowp mat2 c;
};

void main (void)
{
	a = -89;
	b = mat4x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c = mat2(-117.0, 75.0, 12.0, -18.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	dmat3 a;
};

void main (void)
{
	a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	mediump ivec3 a[4]; // unassigned
	dvec4 b;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	lowp ivec2 c;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dmat3x4 d;
} blockD;

void main (void)
{
	blockB.b = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockC.c = ivec2(72, -102);
	blockD.d = dmat3x4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump vec2 mA;
};
struct sB
{
	mediump mat3 mA;
	sA mB;
};
struct sC
{
	dmat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	dmat2 a;
	dmat2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	dvec3 c;
	sB d;
	highp mat3 e;
} blockC;
layout(location = 13, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	dvec4 f;
	sC g; // unassigned
	dvec2 h;
} blockD[1];

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat2(72.0, -102.0, -100.0, 84.0);
	blockC.c = dvec3(-31.0, 68.0, 104.0);
	blockC.d.mA = mat3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.d.mB.mA = vec2(-35.0f, -43.0f);
	blockC.e = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	blockD[0].f = dvec4(-79.0, 3.0, -97.0, -118.0);
	blockD[0].h = dvec2(-108.0, -120.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=92 sizeInLocations=10
{
	mediump mat3x4 b;
	highp mat4x2 c;
	mediump int d[3];
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=72 sizeInLocations=6
{
	dvec3 e; // unassigned
	dmat2x3 f;
} blockD[1];

void main (void)
{
	blockB[0].a = ivec3(-89, 30, -70);
	b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	c = mat4x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d[0] = 4;
	d[1] = -60;
	d[2] = 37;
	blockD[0].f = dmat2x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=6
{
	highp float a;
	lowp uint b;
	mediump mat4x3 c;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	lowp mat3x2 d;
	dmat2 e;
	lowp int f;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	double g;
	dvec2 h;
} blockD;

void main (void)
{
	a = -89.0f;
	b = 30u;
	c = mat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.d = mat3x2(75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockC.e = dmat2(-35.0, -43.0, 48.0, 4.0);
	blockC.f = -60;
	blockD.g = 37.0;
	blockD.h = dvec2(52.0, 98.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	mediump uvec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	highp mat3x4 b;
	sA c;
	mediump ivec4 d;
} blockC;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockC.b = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c.mA = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC.d = ivec4(3, -97, -118, -108);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp ivec4 mA;
	dmat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	double a;
	sA b;
} blockB[3];

void main (void)
{
	blockB[0].a = -89.0;
	blockB[0].b.mA = ivec4(30, -70, -60, 72);
	blockB[0].b.mB = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockB[1].a = 14.0;
	blockB[1].b.mA = ivec4(83, -117, 75, 12);
	blockB[1].b.mB = dmat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockB[2].a = 48.0;
	blockB[2].b.mA = ivec4(4, -60, 37, 52);
	blockB[2].b.mB = dmat2x3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 72) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	dvec3 a;
	highp uvec4 b; // unassigned
	dmat2 c;
} blockB[2];

void main (void)
{
	blockB[0].a = dvec3(-89.0, 30.0, -70.0);
	blockB[0].c = dmat2(-60.0, 72.0, -102.0, -100.0);
	blockB[1].a = dvec3(84.0, -31.0, 68.0);
	blockB[1].c = dmat2(104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	double mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 56) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	lowp int a;
	highp ivec3 b[1];
	sA c;
} blockB[3];
layout(location = 9, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=20 sizeInLocations=2
{
	mediump float d;
	highp ivec4 e;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 44) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	highp ivec3 f;
};

void main (void)
{
	blockB[0].a = -89;
	blockB[0].b[0] = ivec3(30, -70, -60);
	blockB[0].c.mA = 72.0;
	blockB[1].a = -102;
	blockB[1].b[0] = ivec3(-100, 84, -31);
	blockB[1].c.mA = 68.0;
	blockB[2].a = 104;
	blockB[2].b[0] = ivec3(14, 83, -117);
	blockB[2].c.mA = 75.0;
	d = 12.0f;
	e = ivec4(-18, -101, 100, -34);
	f = ivec3(-35, -43, 48);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	dvec3 a;
} blockB[1];
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=256 sizeInLocations=16
{
	dvec4 b;
	dmat4 c;
	dmat3x4 d[1];
};
layout(location = 18, xfb_buffer = 0, xfb_offset = 280) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	lowp mat2x3 e;
};

void main (void)
{
	blockB[0].a = dvec3(-89.0, 30.0, -70.0);
	b = dvec4(-60.0, 72.0, -102.0, -100.0);
	c = dmat4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	d[0] = dmat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	e = mat2x3(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=15
{
	mediump vec4 a;
	dmat3x4 b;
	dmat4 c;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = dmat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = dmat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=8
{
	mediump uint a;
	dmat3x4 b;
	mediump uvec2 c;
} blockB;

void main (void)
{
	blockB.a = 89u;
	blockB.b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.c = uvec2(117u, 75u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp uvec2 mA;
};
struct sB
{
	sA mA;
	lowp vec4 mB;
	mediump uvec4 mC[4][2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=10
{
	sB a;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 152, xfb_stride = 248) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	mediump mat2 b;
	dvec4 c;
} blockC[3];
layout(location = 22, xfb_buffer = 0, xfb_offset = 200) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	highp mat4x3 d;
} blockD;

void main (void)
{
	a.mA.mA = uvec2(89u, 30u);
	a.mB = vec4(-70.0f, -60.0f, 72.0f, -102.0f);
	a.mC[0][0] = uvec4(100u, 84u, 31u, 68u);
	a.mC[0][1] = uvec4(104u, 14u, 83u, 117u);
	a.mC[1][0] = uvec4(75u, 12u, 18u, 101u);
	a.mC[1][1] = uvec4(100u, 34u, 35u, 43u);
	a.mC[2][0] = uvec4(48u, 4u, 60u, 37u);
	a.mC[2][1] = uvec4(52u, 98u, 80u, 62u);
	a.mC[3][0] = uvec4(54u, 79u, 3u, 97u);
	a.mC[3][1] = uvec4(118u, 108u, 120u, 48u);
	blockC[0].b = mat2(-71.0, -59.0, -40.0, -62.0);
	blockC[0].c = dvec4(114.0, -109.0, -51.0, 32.0);
	blockC[1].b = mat2(113.0, -44.0, -77.0, -11.0);
	blockC[1].c = dvec4(66.0, -11.0, 87.0, -87.0);
	blockC[2].b = mat2(87.0, 95.0, -46.0, -122.0);
	blockC[2].c = dvec4(-97.0, 108.0, -127.0, -10.0);
	blockD.d = mat4x3(113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=10
{
	dmat4x2 a;
	dmat3 b;
};

void main (void)
{
	a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=12
{
	dmat4x3 a;
	lowp mat4x2 b;
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=80 sizeInLocations=8
{
	mediump mat4 c;
	highp float d[4];
};

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = mat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	c = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	d[0] = -120.0f;
	d[1] = 48.0f;
	d[2] = -71.0f;
	d[3] = -59.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=7
{
	mediump mat3x4 a;
	dmat2x3 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 96, xfb_stride = 208) out BlockC // sizeInBytes=112 sizeInLocations=10
{
	lowp mat3x2 c;
	dmat3 d;
	highp vec3 e;
} blockC[3];

void main (void)
{
	blockB.a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC[0].c = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC[0].d = dmat3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[0].e = vec3(-97.0f, -118.0f, -108.0f);
	blockC[1].c = mat3x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockC[1].d = dmat3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockC[1].e = vec3(-11.0f, 87.0f, -87.0f);
	blockC[2].c = mat3x2(87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	blockC[2].d = dmat3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0);
	blockC[2].e = vec3(-6.0f, 37.0f, -112.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 0) highp mat4x2 a;
} blockB[1];
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=128 sizeInLocations=12
{
	layout(xfb_offset = 88) dmat3 d; // unassigned
	layout(xfb_offset = 32) mediump mat4x2 b;
	layout(xfb_offset = 64) highp mat2x3 c;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 160) mediump uvec2 e;
} blockD;

void main (void)
{
	blockB[0].a = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = mat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	blockD.e = uvec2(48u, 4u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat3 mA;
	highp ivec4 mB;
};
struct sB
{
	lowp uint mA;
};
struct sC
{
	sB mA;
	mediump mat2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 0) mediump mat2x3 a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 36) sA c;
	layout(xfb_offset = 24) mediump vec3 b; // unassigned
} blockC[1];
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=28 sizeInLocations=4
{
	layout(xfb_offset = 96) sC e;
	layout(xfb_offset = 88) highp ivec2 d;
} blockD;

void main (void)
{
	a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockC[0].c.mA = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC[0].c.mB = ivec4(12, -18, -101, 100);
	blockD.d = ivec2(-34, -35);
	blockD.e.mA.mA = 43u;
	blockD.e.mB = mat2(48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 24) double b;
	layout(xfb_offset = 0) lowp mat3x2 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 32) lowp mat3x4 c;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 88) dmat3 e;
	layout(xfb_offset = 80) double d;
} blockD;

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = -100.0;
	blockC.c = mat3x4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD.d = -34.0;
	blockD.e = dmat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) double a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8, xfb_stride = 136) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 8) dmat4 b;
} blockC[3];

void main (void)
{
	blockB.a = -89.0;
	blockC[0].b = dmat4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC[1].b = dmat4(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[2].b = dmat4(-97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec2 a;
};

void main (void)
{
	a = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
	mediump float mB;
};
struct sB
{
	dvec3 mA;
	dvec4 mB;
	sA mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 60) lowp ivec3 c;
	layout(xfb_offset = 0) lowp mat2x3 a;
	layout(xfb_offset = 24) mediump mat3 b; // unassigned
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 72) lowp mat2x3 d;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 208) dvec3 f;
	layout(xfb_offset = 96) sB e;
} blockD;

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.c = ivec3(-100, 84, -31);
	d = mat2x3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockD.e.mA = dvec3(12.0, -18.0, -101.0);
	blockD.e.mB = dvec4(100.0, -34.0, -35.0, -43.0);
	blockD.e.mC.mA = dmat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockD.e.mC.mB = -80.0f;
	blockD.f = dvec3(-62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp vec4 mA;
};
struct sB
{
	dmat2 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 32) dmat3 c;
	layout(xfb_offset = 0) lowp mat2 a;
	layout(xfb_offset = 16) highp uvec4 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=96 sizeInLocations=7
{
	layout(xfb_offset = 152) lowp mat3x4 e;
	layout(xfb_offset = 104) dmat2x3 d;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 200) out BlockD // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 200) sB f[3];
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = uvec4(72u, 102u, 100u, 84u);
	blockB.c = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	d = dmat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	e = mat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD.f[0].mA = dmat2(-108.0, -120.0, 48.0, -71.0);
	blockD.f[0].mB.mA = vec4(-59.0f, -40.0f, -62.0f, 114.0f);
	blockD.f[1].mA = dmat2(-109.0, -51.0, 32.0, 113.0);
	blockD.f[1].mB.mA = vec4(-44.0f, -77.0f, -11.0f, 66.0f);
	blockD.f[2].mA = dmat2(-11.0, 87.0, -87.0, 87.0);
	blockD.f[2].mB.mA = vec4(95.0f, -46.0f, -122.0f, -97.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp ivec4 mA[1];
	lowp uvec4 mB;
};
struct sB
{
	lowp mat3x4 mA;
	lowp mat4 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) dmat3x2 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 48) sA b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=168 sizeInLocations=12
{
	layout(xfb_offset = 224) lowp mat3x2 e;
	layout(xfb_offset = 80) dvec4 c;
	layout(xfb_offset = 112) sB d;
};

void main (void)
{
	blockB.a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b.mA[0] = ivec4(-100, 84, -31, 68);
	b.mB = uvec4(104u, 14u, 83u, 117u);
	c = dvec4(75.0, 12.0, -18.0, -101.0);
	d.mA = mat3x4(100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	d.mB = mat4(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	e = mat3x2(113.0, -44.0, -77.0, -11.0, 66.0, -11.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 48) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 12) highp uvec2 b;
	layout(xfb_offset = 0) mediump vec3 a;
} blockB[3];
layout(location = 6, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 24) dvec3 c;
} blockC;

void main (void)
{
	blockB[0].a = vec3(-89.0f, 30.0f, -70.0f);
	blockB[0].b = uvec2(60u, 72u);
	blockB[1].a = vec3(-102.0f, -100.0f, 84.0f);
	blockB[1].b = uvec2(31u, 68u);
	blockB[2].a = vec3(104.0f, 14.0f, 83.0f);
	blockB[2].b = uvec2(117u, 75u);
	blockC.c = dvec3(12.0, -18.0, -101.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 80) mediump vec3 c;
	layout(xfb_offset = 0) dvec4 a;
	layout(xfb_offset = 32) dmat3x2 b;
} blockB[1];
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 112) mediump float e;
	layout(xfb_offset = 96) lowp vec4 d;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 192) lowp float h;
	layout(xfb_offset = 120) highp mat3x4 f; // unassigned
	layout(xfb_offset = 168) dvec3 g; // unassigned
} blockD[1];

void main (void)
{
	blockB[0].a = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB[0].b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockB[0].c = vec3(104.0f, 14.0f, 83.0f);
	blockC.d = vec4(-117.0f, 75.0f, 12.0f, -18.0f);
	blockC.e = -101.0f;
	blockD[0].h = 100.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=7
{
	layout(xfb_offset = 60) highp mat3 c;
	layout(xfb_offset = 0) mediump uvec3 a;
	layout(xfb_offset = 12) mediump mat3x4 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 120) dmat3 e[1][1];
	layout(xfb_offset = 96) highp mat2x3 d;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockB.b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.c = mat3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = mat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	e[0][0] = dmat3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 280) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat3 a;
} blockB[2];
layout(location = 12, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=144 sizeInLocations=10
{
	layout(xfb_offset = 88) dmat4 d;
	layout(xfb_offset = 72) double b;
	layout(xfb_offset = 80) double c;
} blockC;
layout(location = 22, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 216) dmat4x2 e;
} blockD;

void main (void)
{
	blockB[0].a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB[1].a = dmat3(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC.b = 100.0;
	blockC.c = -34.0;
	blockC.d = dmat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockD.e = dmat4x2(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp ivec4 a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 56) highp ivec4 d[4];
	layout(xfb_offset = 16) mediump mat2x3 b;
	layout(xfb_offset = 40) mediump ivec4 c;
} blockC;

void main (void)
{
	blockB[0].a = ivec4(-89, 30, -70, -60);
	blockC.b = mat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = ivec4(104, 14, 83, -117);
	blockC.d[0] = ivec4(75, 12, -18, -101);
	blockC.d[1] = ivec4(100, -34, -35, -43);
	blockC.d[2] = ivec4(48, 4, -60, 37);
	blockC.d[3] = ivec4(52, 98, -80, -62);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
	highp ivec3 mB;
	lowp vec3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat3x4 a;
} blockB[1];
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=360 sizeInLocations=24
{
	layout(xfb_offset = 96) sA b[3];
} blockC;

void main (void)
{
	blockB[0].a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.b[0].mA = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.b[0].mB = ivec3(-60, 37, 52);
	blockC.b[0].mC = vec3(98.0f, -80.0f, -62.0f);
	blockC.b[1].mA = dmat3x4(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	blockC.b[1].mB = ivec3(114, -109, -51);
	blockC.b[1].mC = vec3(32.0f, 113.0f, -44.0f);
	blockC.b[2].mA = dmat3x4(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	blockC.b[2].mB = ivec3(-127, -10, 113);
	blockC.b[2].mC = vec3(-60.0f, 58.0f, -109.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat2 mA;
	dmat3x4 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 24) dmat2x3 c;
	layout(xfb_offset = 0) mediump int a;
	layout(xfb_offset = 4) mediump vec4 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=192 sizeInLocations=13
{
	layout(xfb_offset = 200) dmat4x2 f; // unassigned
	layout(xfb_offset = 72) sA d;
	layout(xfb_offset = 184) highp ivec3 e;
} blockC;

void main (void)
{
	a = -89;
	b = vec4(30.0f, -70.0f, -60.0f, 72.0f);
	c = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockC.d.mA = mat2(14.0, 83.0, -117.0, 75.0);
	blockC.d.mB = dmat3x4(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockC.e = ivec3(98, -80, -62);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3 a;
} blockB;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp uvec4 mA[2];
	dmat3x4 mB;
};
struct sB
{
	mediump mat2x3 mA; // unassigned
	sA mB;
	dvec2 mC;
};
struct sC
{
	lowp mat3 mA;
	dmat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=11
{
	layout(xfb_offset = 0) sB a;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 168) lowp vec4 b;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 184) out BlockD // sizeInBytes=152 sizeInLocations=13
{
	layout(xfb_offset = 200) sC e;
	layout(xfb_offset = 184) mediump ivec2 c; // unassigned
	layout(xfb_offset = 192) lowp uint d;
};

void main (void)
{
	blockB.a.mB.mA[0] = uvec4(89u, 30u, 70u, 60u);
	blockB.a.mB.mA[1] = uvec4(72u, 102u, 100u, 84u);
	blockB.a.mB.mB = dmat3x4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockB.a.mC = dvec2(-35.0, -43.0);
	blockC.b = vec4(48.0f, 4.0f, -60.0f, 37.0f);
	d = 52u;
	e.mA = mat3(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	e.mB = dmat4x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 16) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uvec4 a;
} blockB[3];

void main (void)
{
	blockB[0].a = uvec4(89u, 30u, 70u, 60u);
	blockB[1].a = uvec4(72u, 102u, 100u, 84u);
	blockB[2].a = uvec4(31u, 68u, 104u, 14u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3x2 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 24) dmat3x2 b;
};

void main (void)
{
	blockB.a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = dmat3x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 128) mediump uvec4 c;
	layout(xfb_offset = 0) mediump mat4 a;
	layout(xfb_offset = 64) lowp mat4 b;
} blockB;

void main (void)
{
	blockB.a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.b = mat4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockB.c = uvec4(3u, 97u, 118u, 108u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	layout(xfb_offset = 48) highp float b;
	layout(xfb_offset = 0) dmat2x3 a; // unassigned
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 56, xfb_stride = 168) out BlockC // sizeInBytes=112 sizeInLocations=8
{
	layout(xfb_offset = 104) dmat4x2 d;
	layout(xfb_offset = 56) dmat2x3 c;
} blockC[3];

void main (void)
{
	blockB.b = -89.0f;
	blockC[0].c = dmat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockC[0].d = dmat4x2(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC[1].c = dmat2x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockC[1].d = dmat4x2(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockC[2].c = dmat2x3(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockC[2].d = dmat4x2(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=432 sizeInLocations=35
{
	layout(xfb_offset = 48) highp mat2x3 b[4][4];
	layout(xfb_offset = 0) mediump uvec4 a[3];
};
layout(location = 35, xfb_buffer = 0, xfb_offset = 432) out BlockC // sizeInBytes=208 sizeInLocations=15
{
	layout(xfb_offset = 632) lowp uint e; // unassigned
	layout(xfb_offset = 432) dmat3 c;
	layout(xfb_offset = 504) dmat4 d; // unassigned
};
layout(location = 50, xfb_buffer = 0, xfb_offset = 640) out BlockD // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 736) highp ivec2 g;
	layout(xfb_offset = 640) mediump mat2x3 f[4];
} blockD[1];

void main (void)
{
	a[0] = uvec4(89u, 30u, 70u, 60u);
	a[1] = uvec4(72u, 102u, 100u, 84u);
	a[2] = uvec4(31u, 68u, 104u, 14u);
	b[0][0] = mat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	b[0][1] = mat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[0][2] = mat2x3(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	b[0][3] = mat2x3(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	b[1][0] = mat2x3(-120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	b[1][1] = mat2x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	b[1][2] = mat2x3(-77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	b[1][3] = mat2x3(87.0, 95.0, -46.0, -122.0, -97.0, 108.0);
	b[2][0] = mat2x3(-127.0, -10.0, 113.0, -60.0, 58.0, -109.0);
	b[2][1] = mat2x3(-38.0, -103.0, -63.0, -6.0, 37.0, -112.0);
	b[2][2] = mat2x3(88.0, -40.0, -22.0, 40.0, -17.0, 54.0);
	b[2][3] = mat2x3(-50.0, -84.0, -49.0, -6.0, 98.0, -34.0);
	b[3][0] = mat2x3(-69.0, -57.0, -8.0, -89.0, 91.0, 114.0);
	b[3][1] = mat2x3(40.0, -110.0, 28.0, -112.0, -35.0, -127.0);
	b[3][2] = mat2x3(44.0, 56.0, -33.0, 109.0, -119.0, 34.0);
	b[3][3] = mat2x3(-102.0, 104.0, 33.0, 127.0, 121.0, 42.0);
	c = dmat3(-34.0, -92.0, 75.0, -68.0, 84.0, -4.0, 38.0, 119.0, -79.0);
	blockD[0].f[0] = mat2x3(39.0, -7.0, 119.0, -75.0, 19.0, -79.0);
	blockD[0].f[1] = mat2x3(-31.0, 50.0, 79.0, -21.0, -5.0, -88.0);
	blockD[0].f[2] = mat2x3(-104.0, -84.0, -36.0, 61.0, -37.0, 15.0);
	blockD[0].f[3] = mat2x3(107.0, 112.0, -16.0, 5.0, -11.0, -98.0);
	blockD[0].g = ivec2(29, -61);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp vec4 mA;
	mediump ivec3 mB; // unassigned
	dmat2x3 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=11
{
	layout(xfb_offset = 88) highp mat4x2 c;
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 80) lowp vec2 b;
} blockB;

void main (void)
{
	blockB.a.mA = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockB.b = vec2(72.0f, -102.0f);
	blockB.c = mat4x2(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec3 mA[1];
	dvec3 mB;
	dmat3 mC;
};
struct sB
{
	mediump uint mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=4
{
	layout(xfb_offset = 24) dvec2 c; // unassigned
	layout(xfb_offset = 0) mediump mat2 a;
	layout(xfb_offset = 16) mediump int b;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=152 sizeInLocations=12
{
	layout(xfb_offset = 176) lowp vec4 f;
	layout(xfb_offset = 40) sA d; // unassigned
	layout(xfb_offset = 160) highp vec4 e; // unassigned
} blockC;
layout(location = 16, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 192) sB g;
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = 72;
	blockC.f = vec4(-102.0f, -100.0f, 84.0f, -31.0f);
	blockD.g.mA = 68u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 80) highp uvec3 d; // unassigned
	layout(xfb_offset = 8) double b;
	layout(xfb_offset = 16) lowp mat4 c;
} blockC;

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	blockC.b = -70.0;
	blockC.c = mat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 20) lowp float c; // unassigned
	layout(xfb_offset = 0) highp uvec2 a;
	layout(xfb_offset = 8) sA b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 24, xfb_stride = 28) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 24) highp int d;
} blockC[3];

void main (void)
{
	a = uvec2(89u, 30u);
	b.mA = vec3(-70.0f, -60.0f, 72.0f);
	blockC[0].d = -102;
	blockC[1].d = -100;
	blockC[2].d = 84;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=5
{
	layout(xfb_offset = 12) mediump mat4x2 b;
	layout(xfb_offset = 0) lowp ivec3 a; // unassigned
} blockB;

void main (void)
{
	blockB.b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec4 mA[2];
	lowp uvec4 mB;
	highp int mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=216 sizeInLocations=14
{
	layout(xfb_offset = 128) sA b;
	layout(xfb_offset = 0) dmat4 a;
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b.mA[0] = dvec4(-18.0, -101.0, 100.0, -34.0);
	b.mA[1] = dvec4(-35.0, -43.0, 48.0, 4.0);
	b.mB = uvec4(60u, 37u, 52u, 98u);
	b.mC = -80;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 136) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp int a;
} blockB[3];
layout(location = 3, xfb_buffer = 0, xfb_offset = 8, xfb_stride = 136) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 72) dmat4x2 c;
	layout(xfb_offset = 8) highp mat4 b;
} blockC[3];

void main (void)
{
	blockB[0].a = -89;
	blockB[1].a = 30;
	blockB[2].a = -70;
	blockC[0].b = mat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockC[0].c = dmat4x2(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockC[1].b = mat4(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
	blockC[1].c = dmat4x2(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockC[2].b = mat4(-11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0);
	blockC[2].c = dmat4x2(-103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat4x2 mA;
	highp uvec4 mB;
	dmat4x2 mC[2];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=256 sizeInLocations=16
{
	layout(xfb_offset = 48) sA c;
	layout(xfb_offset = 0) lowp uvec4 a;
	layout(xfb_offset = 16) dmat2 b;
} blockB;

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = dmat2(72.0, -102.0, -100.0, 84.0);
	blockB.c.mA = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.c.mB = uvec4(18u, 101u, 100u, 34u);
	blockB.c.mC[0] = dmat4x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockB.c.mC[1] = dmat4x2(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4x3 a;
} blockB;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=92 sizeInLocations=7
{
	layout(xfb_offset = 28) highp mat4 c;
	layout(xfb_offset = 0) mediump float a;
	layout(xfb_offset = 4) lowp mat2x3 b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 92) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 92) highp uint d;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockD // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 96) highp mat3x4 e;
} blockD;

void main (void)
{
	blockB.a = -89.0f;
	blockB.b = mat2x3(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);
	blockB.c = mat4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.d = 4u;
	blockD.e = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 0) dvec4 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 80) dmat3x2 c;
	layout(xfb_offset = 32) highp mat3x4 b; // unassigned
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=40 sizeInLocations=5
{
	layout(xfb_offset = 136) lowp mat4x2 e;
	layout(xfb_offset = 128) double d;
} blockD;

void main (void)
{
	blockB.a = dvec4(-89.0, 30.0, -70.0, -60.0);
	c = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockD.d = 104.0;
	blockD.e = mat4x2(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 8) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp vec2 a;
} blockB[2];

void main (void)
{
	blockB[0].a = vec2(-89.0f, 30.0f);
	blockB[1].a = vec2(-70.0f, -60.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=10
{
	layout(xfb_offset = 112) highp vec4 c;
	layout(xfb_offset = 0) mediump mat4x3 a[2];
	layout(xfb_offset = 96) dvec2 b; // unassigned
};

void main (void)
{
	a[0] = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	a[1] = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	c = vec4(-60.0f, 37.0f, 52.0f, 98.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump uint mA;
	dmat3x4 mB;
	mediump mat2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=152 sizeInLocations=13
{
	layout(xfb_offset = 32) sA b;
	layout(xfb_offset = 0) lowp mat4x2 a; // unassigned
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 152) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 200) mediump ivec4 d;
	layout(xfb_offset = 152) dmat3x2 c;
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=48 sizeInLocations=5
{
	layout(xfb_offset = 248) dvec2 g; // unassigned
	layout(xfb_offset = 216) double e[3]; // unassigned
	layout(xfb_offset = 240) lowp vec2 f;
} blockD;

void main (void)
{
	b.mA = 89u;
	b.mB = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	b.mC = mat2(-117.0, 75.0, 12.0, -18.0);
	blockC.c = dmat3x2(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.d = ivec4(4, -60, 37, 52);
	blockD.f = vec2(98.0f, -80.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec4 mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 16) lowp uint b;
	layout(xfb_offset = 0) sA a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 20) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 20) highp mat3x2 c;
};

void main (void)
{
	blockB.b = 89u;
	c = mat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x4 mA;
	highp uvec2 mB;
	lowp ivec2 mC[2]; // unassigned
};
struct sB
{
	sA mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat3 a;
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=200 sizeInLocations=14
{
	layout(xfb_offset = 256) highp vec4 d[1]; // unassigned
	layout(xfb_offset = 72) sB b;
	layout(xfb_offset = 192) mediump mat4 c;
} blockC;

void main (void)
{
	blockB.a = dmat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC.b.mA.mA = dmat3x4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockC.b.mA.mB = uvec2(43u, 48u);
	blockC.c = mat4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat3x4 a;
};

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0, xfb_stride = 144) out BlockB // sizeInBytes=40 sizeInLocations=5
{
	layout(xfb_offset = 8) mediump mat4x2 b;
	layout(xfb_offset = 0) highp uvec2 a; // unassigned
} blockB[2];
layout(location = 10, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=104 sizeInLocations=7
{
	layout(xfb_offset = 104) highp mat3 e;
	layout(xfb_offset = 40) dvec2 c[2];
	layout(xfb_offset = 72) dmat2 d; // unassigned
} blockC;

void main (void)
{
	blockB[0].b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB[1].b = mat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.c[0] = dvec2(-18.0, -101.0);
	blockC.c[1] = dvec2(100.0, -34.0);
	blockC.e = mat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x2 mA;
	dmat3x4 mB;
};
struct sB
{
	sA mA;
	mediump mat2x3 mB;
	dmat3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) lowp mat3 a;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40, xfb_stride = 344) out BlockC // sizeInBytes=280 sizeInLocations=21
{
	layout(xfb_offset = 304) lowp vec4 d;
	layout(xfb_offset = 40) highp mat3x2 b;
	layout(xfb_offset = 64) sB c;
} blockC[3];
layout(location = 66, xfb_buffer = 0, xfb_offset = 320) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 320) dvec3 e;
} blockD;

void main (void)
{
	blockB.a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockC[0].b = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC[0].c.mA.mA = dmat3x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockC[0].c.mA.mB = dmat3x4(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0);
	blockC[0].c.mB = mat2x3(-97.0, -118.0, -108.0, -120.0, 48.0, -71.0);
	blockC[0].c.mC = dmat3(-59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0);
	blockC[0].d = vec4(-77.0f, -11.0f, 66.0f, -11.0f);
	blockC[1].b = mat3x2(87.0, -87.0, 87.0, 95.0, -46.0, -122.0);
	blockC[1].c.mA.mA = dmat3x2(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	blockC[1].c.mA.mB = dmat3x4(58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	blockC[1].c.mB = mat2x3(-17.0, 54.0, -50.0, -84.0, -49.0, -6.0);
	blockC[1].c.mC = dmat3(98.0, -34.0, -69.0, -57.0, -8.0, -89.0, 91.0, 114.0, 40.0);
	blockC[1].d = vec4(-110.0f, 28.0f, -112.0f, -35.0f);
	blockC[2].b = mat3x2(-127.0, 44.0, 56.0, -33.0, 109.0, -119.0);
	blockC[2].c.mA.mA = dmat3x2(34.0, -102.0, 104.0, 33.0, 127.0, 121.0);
	blockC[2].c.mA.mB = dmat3x4(42.0, -34.0, -92.0, 75.0, -68.0, 84.0, -4.0, 38.0, 119.0, -79.0, 39.0, -7.0);
	blockC[2].c.mB = mat2x3(119.0, -75.0, 19.0, -79.0, -31.0, 50.0);
	blockC[2].c.mC = dmat3(79.0, -21.0, -5.0, -88.0, -104.0, -84.0, -36.0, 61.0, -37.0);
	blockC[2].d = vec4(15.0f, 107.0f, 112.0f, -16.0f);
	blockD.e = dvec3(5.0, -11.0, -98.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 48) dvec3 c;
	layout(xfb_offset = 0) lowp mat2x3 a;
	layout(xfb_offset = 24) mediump mat2x3 b; // unassigned
};

void main (void)
{
	a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = dvec3(-100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat3x4 mA;
};
struct sB
{
	dmat4x3 mA;
	dmat4x2 mB;
	dmat4x3 mC;
};
struct sC
{
	sA mA;
	sB mB;
	mediump vec4 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=11
{
	layout(xfb_offset = 48) dmat2 b[4];
	layout(xfb_offset = 0) lowp mat3x4 a;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 176) out BlockC // sizeInBytes=328 sizeInLocations=25
{
	layout(xfb_offset = 184) sC d;
	layout(xfb_offset = 176) mediump ivec2 c;
};
layout(location = 36, xfb_buffer = 0, xfb_offset = 504) out BlockD // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 528) highp uvec3 f;
	layout(xfb_offset = 504) lowp mat2x3 e;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0] = dmat2(83.0, -117.0, 75.0, 12.0);
	b[1] = dmat2(-18.0, -101.0, 100.0, -34.0);
	b[2] = dmat2(-35.0, -43.0, 48.0, 4.0);
	b[3] = dmat2(-60.0, 37.0, 52.0, 98.0);
	c = ivec2(-80, -62);
	d.mA.mA = mat3x4(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0);
	d.mB.mA = dmat4x3(114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	d.mB.mB = dmat4x2(87.0, 95.0, -46.0, -122.0, -97.0, 108.0, -127.0, -10.0);
	d.mB.mC = dmat4x3(113.0, -60.0, 58.0, -109.0, -38.0, -103.0, -63.0, -6.0, 37.0, -112.0, 88.0, -40.0);
	e = mat2x3(-22.0, 40.0, -17.0, 54.0, -50.0, -84.0);
	f = uvec3(49u, 6u, 98u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 56) mediump mat2x3 c; // unassigned
	layout(xfb_offset = 0) highp mat3x4 a;
	layout(xfb_offset = 48) mediump vec2 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 80) lowp uvec4 d;
} blockC;

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = vec2(83.0f, -117.0f);
	blockC.d = uvec4(75u, 12u, 18u, 101u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=68 sizeInLocations=5
{
	layout(xfb_offset = 52) lowp ivec4 c;
	layout(xfb_offset = 0) highp mat3x4 a; // unassigned
	layout(xfb_offset = 48) mediump int b;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 68) out BlockC // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 92) mediump mat4x3 f;
	layout(xfb_offset = 68) highp ivec2 d;
	layout(xfb_offset = 76) lowp ivec4 e;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 168) sA h; // unassigned
	layout(xfb_offset = 144) dvec3 g;
} blockD;

void main (void)
{
	b = -89;
	c = ivec4(30, -70, -60, 72);
	blockC.d = ivec2(-102, -100);
	blockC.e = ivec4(84, -31, 68, 104);
	blockC.f = mat4x3(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockD.g = dvec3(4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump uvec2 mA;
	lowp int mB;
	highp ivec2 mC;
};
struct sB
{
	dmat2x3 mA;
	double mB;
	dmat2x3 mC;
};
struct sC
{
	sB mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=12
{
	layout(xfb_offset = 24) sC b;
	layout(xfb_offset = 0) sA a;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 184) dmat2 e;
	layout(xfb_offset = 128) highp mat3x2 c;
	layout(xfb_offset = 152) dmat2 d;
};
layout(location = 19, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 248) dmat2 g;
	layout(xfb_offset = 216) dvec4 f;
} blockD[1];

void main (void)
{
	a.mA = uvec2(89u, 30u);
	a.mB = -70;
	a.mC = ivec2(-60, 72);
	b.mA.mA = dmat2x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	b.mA.mB = 14.0;
	b.mA.mC = dmat2x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	c = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = dmat2(-60.0, 37.0, 52.0, 98.0);
	e = dmat2(-80.0, -62.0, -54.0, -79.0);
	blockD[0].f = dvec4(3.0, -97.0, -118.0, -108.0);
	blockD[0].g = dmat2(-120.0, 48.0, -71.0, -59.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 0) dvec3 a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 56) highp uvec4 c;
	layout(xfb_offset = 24) dvec4 b;
} blockC;

void main (void)
{
	a = dvec3(-89.0, 30.0, -70.0);
	blockC.b = dvec4(-60.0, 72.0, -102.0, -100.0);
	blockC.c = uvec4(84u, 31u, 68u, 104u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 16) dvec4 b;
} blockC;

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.b = dvec4(72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=424 sizeInLocations=27
{
	layout(xfb_offset = 40) dmat4 c[3];
	layout(xfb_offset = 0) highp vec2 a;
	layout(xfb_offset = 8) dmat2 b;
};
layout(location = 27, xfb_buffer = 0, xfb_offset = 424, xfb_stride = 488) out BlockC // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 440) dmat2x3 f;
	layout(xfb_offset = 424) lowp float d;
	layout(xfb_offset = 428) lowp vec3 e;
} blockC[2];

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	b = dmat2(-70.0, -60.0, 72.0, -102.0);
	c[0] = dmat4(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	c[1] = dmat4(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);
	c[2] = dmat4(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0);
	blockC[0].d = 87.0f;
	blockC[0].e = vec3(95.0f, -46.0f, -122.0f);
	blockC[0].f = dmat2x3(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	blockC[1].d = 58.0f;
	blockC[1].e = vec3(-109.0f, -38.0f, -103.0f);
	blockC[1].f = dmat2x3(-63.0, -6.0, 37.0, -112.0, 88.0, -40.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat2x3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 40) highp mat3x2 c;
	layout(xfb_offset = 0) dvec2 a;
	layout(xfb_offset = 16) sA b;
};

void main (void)
{
	a = dvec2(-89.0, 30.0);
	b.mA = mat2x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c = mat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat4x2 mA;
	dmat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump float a;
} blockB[1];
layout(location = 1, xfb_buffer = 0, xfb_offset = 4, xfb_stride = 432) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 4) mediump uint b;
} blockC[2];
layout(location = 3, xfb_buffer = 0, xfb_offset = 8) out BlockD // sizeInBytes=424 sizeInLocations=33
{
	layout(xfb_offset = 424) mediump int e;
	layout(xfb_offset = 8) dmat4 c;
	layout(xfb_offset = 136) sA d[3];
} blockD;

void main (void)
{
	blockB[0].a = -89.0f;
	blockC[0].b = 30u;
	blockC[1].b = 70u;
	blockD.c = dmat4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockD.d[0].mA = mat4x2(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockD.d[0].mB = dmat4x2(98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);
	blockD.d[1].mA = mat4x2(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);
	blockD.d[1].mB = dmat4x2(-109.0, -51.0, 32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockD.d[2].mA = mat4x2(-11.0, 87.0, -87.0, 87.0, 95.0, -46.0, -122.0, -97.0);
	blockD.d[2].mB = dmat4x2(108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0);
	blockD.e = -103;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 0) highp ivec2 a[4];
	layout(xfb_offset = 32) dvec4 b;
} blockB;

void main (void)
{
	blockB.a[0] = ivec2(-89, 30);
	blockB.a[1] = ivec2(-70, -60);
	blockB.a[2] = ivec2(72, -102);
	blockB.a[3] = ivec2(-100, 84);
	blockB.b = dvec4(-31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat4x2 mA;
	dmat4x2 mB[1]; // unassigned
	dmat3 mC;
};
struct sB
{
	dvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=14
{
	layout(xfb_offset = 0) sA a;
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 168) dvec2 b;
	// layout(xfb_offset = 184) sB c; // missing field
} blockC;

void main (void)
{
	a.mA = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	a.mC = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.b = dvec2(-101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat4 mA; // unassigned
	mediump uvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=8
{
	layout(xfb_offset = 0) lowp mat4x2 a; // unassigned
	layout(xfb_offset = 32) highp mat2x3 b;
	layout(xfb_offset = 56) lowp mat2 c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=92 sizeInLocations=6
{
	layout(xfb_offset = 72) mediump uvec4 d[1];
	layout(xfb_offset = 88) sA e;
} blockC;

void main (void)
{
	b = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	c = mat2(-100.0, 84.0, -31.0, 68.0);
	blockC.d[0] = uvec4(104u, 14u, 83u, 117u);
	blockC.e.mB = uvec3(75u, 12u, 18u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=60 sizeInLocations=5
{
	layout(xfb_offset = 0) lowp ivec3 a;
	layout(xfb_offset = 12) mediump mat4x3 b;
};

void main (void)
{
	a = ivec3(-89, 30, -70);
	b = mat4x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp uvec3 mA;
	dmat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 0) sA a;
} blockB;

void main (void)
{
	blockB.a.mA = uvec3(89u, 30u, 70u);
	blockB.a.mB = dmat4x3(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 0) dmat4 a;
	layout(xfb_offset = 128) lowp uvec4 b;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 144) mediump mat2 c;
	layout(xfb_offset = 160) double d;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=96 sizeInLocations=6
{
	layout(xfb_offset = 168) dmat3x4 e;
} blockD;

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b = uvec4(18u, 101u, 100u, 34u);
	c = mat2(-35.0, -43.0, 48.0, 4.0);
	d = -60.0;
	blockD.e = dmat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA; // unassigned
	lowp float mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 56) lowp ivec3 b; // unassigned
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=24 sizeInLocations=3
{
	layout(xfb_offset = 72) mediump mat3x2 c;
} blockC;

void main (void)
{
	a.mB = -89.0f;
	blockC.c = mat3x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat3x4 a;
	layout(xfb_offset = 96) dvec4 b; // unassigned
} blockB;

void main (void)
{
	blockB.a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2 mA;
};
struct sB
{
	sA mA[1][1];
	dmat2x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 16) dmat3x2 b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 64) highp float c;
	layout(xfb_offset = 72) sB d;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	c = 104.0f;
	d.mA[0][0].mA = dmat2(14.0, 83.0, -117.0, 75.0);
	d.mB = dmat2x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) highp uvec4 a;
	layout(xfb_offset = 16) highp ivec4 b;
	layout(xfb_offset = 32) dmat2 c;
};

void main (void)
{
	a = uvec4(89u, 30u, 70u, 60u);
	b = ivec4(72, -102, -100, 84);
	c = dmat2(-31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump uvec3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 0) dmat2 a;
	layout(xfb_offset = 32) dmat4x3 b;
	layout(xfb_offset = 128) double c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 136) lowp ivec3 d;
	layout(xfb_offset = 148) highp ivec4 e;
	layout(xfb_offset = 164) sA f;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat4x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	c = -18.0;
	d = ivec3(-101, 100, -34);
	e = ivec4(-35, -43, 48, 4);
	f.mA = uvec3(60u, 37u, 52u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 0) dmat4x2 a;
	layout(xfb_offset = 64) mediump vec2 b;
	layout(xfb_offset = 72) highp int c; // unassigned
} blockB;
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 80) dmat4x3 d; // unassigned
	layout(xfb_offset = 176) mediump uint e;
};

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = vec2(-31.0f, 68.0f);
	e = 104u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	// layout(xfb_offset = 0) highp uint a; // missing field
	layout(xfb_offset = 4) mediump ivec2 b;
} blockB;

void main (void)
{
	blockB.b = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=2
{
	layout(xfb_offset = 0) sA a;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=256 sizeInLocations=19
{
	layout(xfb_offset = 16) highp mat3 b[4];
	layout(xfb_offset = 160) dvec4 c[3];
	// layout(xfb_offset = 256) highp uvec3 d; // missing field
};

void main (void)
{
	a.mA = mat2(-89.0, 30.0, -70.0, -60.0);
	b[0] = mat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	b[1] = mat3(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	b[2] = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	b[3] = mat3(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	c[0] = dvec4(-40.0, -62.0, 114.0, -109.0);
	c[1] = dvec4(-51.0, 32.0, 113.0, -44.0);
	c[2] = dvec4(-77.0, -11.0, 66.0, -11.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 0) highp uvec3 a; // unassigned
	// layout(xfb_offset = 16) dmat4x2 b; // missing field
	layout(xfb_offset = 80) dmat4x2 c;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 144) mediump ivec3 d[4];
};
layout(location = 13, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	// layout(xfb_offset = 192) lowp mat2 e[1]; // missing field
	layout(xfb_offset = 208) mediump mat4 f;
} blockD;

void main (void)
{
	blockB.c = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	d[0] = ivec3(-31, 68, 104);
	d[1] = ivec3(14, 83, -117);
	d[2] = ivec3(75, 12, -18);
	d[3] = ivec3(-101, 100, -34);
	blockD.f = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=11
{
	layout(xfb_offset = 0) dmat3x2 a;
	// layout(xfb_offset = 48) dmat4x3 b; // missing field
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockC // sizeInBytes=168 sizeInLocations=12
{
	// layout(xfb_offset = 144) dmat3 c; // missing field
	// layout(xfb_offset = 216) mediump mat4 d; // missing field
	layout(xfb_offset = 280) dvec4 e;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	e = dvec4(-100.0, 84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	// layout(xfb_offset = 0) lowp ivec4 a; // missing field
	layout(xfb_offset = 16) dvec2 b;
	layout(xfb_offset = 32) double c;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 40) lowp uvec3 d;
} blockC;

void main (void)
{
	blockB.b = dvec2(-89.0, 30.0);
	blockB.c = -70.0;
	blockC.d = uvec3(60u, 72u, 102u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat2x3 a;
	layout(xfb_offset = 24) highp uvec3 b;
} blockB;
layout(location = 3, xfb_buffer = 0, xfb_offset = 36) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 36) mediump int c;
} blockC;
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockD // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 40) dmat4 d;
};

void main (void)
{
	blockB.a = mat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b = uvec3(100u, 84u, 31u);
	blockC.c = 68;
	d = dmat4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 0) dmat4 a;
	layout(xfb_offset = 128) lowp mat3x4 b;
	// layout(xfb_offset = 176) dvec4 c; // missing field
} blockB;
layout(location = 13, xfb_buffer = 0, xfb_offset = 208) out BlockC // sizeInBytes=36 sizeInLocations=5
{
	layout(xfb_offset = 208) mediump mat4x2 d;
	layout(xfb_offset = 240) mediump uint e;
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 248) out BlockD // sizeInBytes=200 sizeInLocations=16
{
	layout(xfb_offset = 248) mediump int f;
	layout(xfb_offset = 256) dmat3 g[2];
	layout(xfb_offset = 400) mediump mat3x4 h;
};

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.b = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC.d = mat4x2(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	blockC.e = 120u;
	f = 48;
	g[0] = dmat3(-71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	g[1] = dmat3(-44.0, -77.0, -11.0, 66.0, -11.0, 87.0, -87.0, 87.0, 95.0);
	h = mat3x4(-46.0, -122.0, -97.0, 108.0, -127.0, -10.0, 113.0, -60.0, 58.0, -109.0, -38.0, -103.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=12
{
	layout(xfb_offset = 0) dmat4x2 a[3];
} blockB;
layout(location = 12, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 192) dmat4x2 b;
} blockC;

void main (void)
{
	blockB.a[0] = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.a[1] = dmat4x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockB.a[2] = dmat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.b = dmat4x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) highp int a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 4) out BlockC // sizeInBytes=40 sizeInLocations=5
{
	layout(xfb_offset = 4) mediump vec2 b; // unassigned
	layout(xfb_offset = 12) mediump mat4x2 c;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockD // sizeInBytes=24 sizeInLocations=2
{
	layout(xfb_offset = 48) dvec3 d;
} blockD;

void main (void)
{
	blockB.a = -89;
	c = mat4x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockD.d = dvec3(68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=5
{
	// layout(xfb_offset = 0) dmat2 a; // missing field
	layout(xfb_offset = 32) mediump vec3 b;
	layout(xfb_offset = 48) dvec4 c;
};

void main (void)
{
	b = vec3(-89.0f, 30.0f, -70.0f);
	c = dvec4(-60.0, 72.0, -102.0, -100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat4 mA;
	lowp ivec2 mB;
	highp uint mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 0) lowp vec3 a;
	layout(xfb_offset = 12) lowp uvec2 b;
	layout(xfb_offset = 24) dvec4 c;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=104 sizeInLocations=8
{
	// layout(xfb_offset = 56) sA d; // missing field
	layout(xfb_offset = 132) lowp uvec3 e;
	// layout(xfb_offset = 144) dvec2 f; // missing field
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockD // sizeInBytes=264 sizeInLocations=18
{
	layout(xfb_offset = 160) dmat4x2 g;
	layout(xfb_offset = 224) dmat3 h;
	layout(xfb_offset = 296) dmat4 i;
} blockD;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = uvec2(60u, 72u);
	blockB.c = dvec4(-102.0, -100.0, 84.0, -31.0);
	blockC.e = uvec3(68u, 104u, 14u);
	blockD.g = dmat4x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	blockD.h = dmat3(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockD.i = dmat4(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	layout(xfb_offset = 0) mediump float a; // unassigned
	layout(xfb_offset = 4) highp vec2 b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 12) mediump mat3x4 c;
};

void main (void)
{
	b = vec2(-89.0f, 30.0f);
	c = mat3x4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump ivec2 a;
	layout(xfb_offset = 8) lowp uvec3 b;
	layout(xfb_offset = 24) double c;
} blockB;

void main (void)
{
	blockB.a = ivec2(-89, 30);
	blockB.b = uvec3(70u, 60u, 72u);
	blockB.c = -102.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=232 sizeInLocations=15
{
	layout(xfb_offset = 0) dmat3x4 a;
	layout(xfb_offset = 96) dmat4 b; // unassigned
	layout(xfb_offset = 224) highp float c;
};
layout(location = 15, xfb_buffer = 0, xfb_offset = 232) out BlockC // sizeInBytes=80 sizeInLocations=5
{
	// layout(xfb_offset = 232) highp ivec3 d; // missing field
	layout(xfb_offset = 248) dmat4x2 e;
} blockC;
layout(location = 20, xfb_buffer = 0, xfb_offset = 312) out BlockD // sizeInBytes=80 sizeInLocations=6
{
	// layout(xfb_offset = 312) dmat4x2 f; // missing field
	layout(xfb_offset = 376) highp mat2 g;
} blockD;

void main (void)
{
	a = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	c = 83.0f;
	blockC.e = dmat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockD.g = mat2(-43.0, 48.0, 4.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp vec4 mA;
};
struct sB
{
	sA mA;
	lowp float mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 0) sB a;
};

void main (void)
{
	a.mA.mA = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	a.mB = 72.0f;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=2
{
	layout(xfb_offset = 0) lowp float a;
	layout(xfb_offset = 4) lowp float b;
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 8) lowp mat4x2 c;
	layout(xfb_offset = 40) mediump mat3x4 d;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 88) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 88) highp uvec2 e;
};

void main (void)
{
	a = -89.0f;
	b = 30.0f;
	c = mat4x2(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	d = mat3x4(104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	e = uvec2(48u, 4u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump vec4 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=56 sizeInLocations=5
{
	layout(xfb_offset = 16) dmat3x2 b;
	layout(xfb_offset = 64) lowp int c;
	// layout(xfb_offset = 68) lowp int d; // missing field
} blockC;
layout(location = 6, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 72) highp vec4 e;
	layout(xfb_offset = 88) dmat4x3 f;
};

void main (void)
{
	a = vec4(-89.0f, 30.0f, -70.0f, -60.0f);
	blockC.b = dmat3x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.c = 104;
	e = vec4(14.0f, 83.0f, -117.0f, 75.0f);
	f = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=168 sizeInLocations=15
{
	layout(xfb_offset = 0) mediump uint a;
	layout(xfb_offset = 8) dmat3x4 b;
	layout(xfb_offset = 104) highp mat4x2 c[2];
};
layout(location = 15, xfb_buffer = 0, xfb_offset = 168) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 168) dmat4x2 d;
} blockC;
layout(location = 19, xfb_buffer = 0, xfb_offset = 232) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 232) dmat2x3 e;
} blockD;

void main (void)
{
	a = 89u;
	b = dmat3x4(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	c[0] = mat4x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	c[1] = mat4x2(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockC.d = dmat4x2(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.e = dmat2x3(48.0, -71.0, -59.0, -40.0, -62.0, 114.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	// layout(xfb_offset = 0) dmat3x2 a; // missing field
	layout(xfb_offset = 48) dvec2 b;
} blockB;

void main (void)
{
	blockB.b = dvec2(-89.0, 30.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat3x2 mA;
	lowp uvec3 mB;
};
struct sB
{
	mediump mat4x2 mA;
	mediump int mB;
	sA mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=11
{
	layout(xfb_offset = 0) dvec4 a[1];
	layout(xfb_offset = 32) sB b;
} blockB;

void main (void)
{
	blockB.a[0] = dvec4(-89.0, 30.0, -70.0, -60.0);
	blockB.b.mA = mat4x2(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b.mB = 83;
	blockB.b.mC.mA = mat3x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	blockB.b.mC.mB = uvec3(34u, 35u, 43u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp int mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 0) highp mat4x3 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=36 sizeInLocations=4
{
	layout(xfb_offset = 48) sA b;
	// layout(xfb_offset = 52) lowp uvec2 c; // missing field
	layout(xfb_offset = 60) mediump mat2x3 d; // unassigned
};

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b.mA = 83;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	double mA;
	dvec2 mB;
	highp mat3x4 mC; // unassigned
};
struct sB
{
	lowp mat2 mA;
	dvec4 mB;
	mediump ivec2 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=176 sizeInLocations=14
{
	layout(xfb_offset = 0) sA a; // unassigned
	layout(xfb_offset = 72) sB b; // unassigned
	layout(xfb_offset = 128) dmat2x3 c;
};

void main (void)
{
	c = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=6
{
	// layout(xfb_offset = 0) mediump mat3x4 a; // missing field
	layout(xfb_offset = 48) dmat2 b;
	// layout(xfb_offset = 80) lowp ivec3 c; // missing field
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 96) dvec2 d; // unassigned
	// layout(xfb_offset = 112) mediump ivec3 e[2]; // missing field
	layout(xfb_offset = 136) dvec4 f;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 168) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 168) highp ivec4 g;
} blockD;

void main (void)
{
	b = dmat2(-89.0, 30.0, -70.0, -60.0);
	blockC.f = dvec4(72.0, -102.0, -100.0, 84.0);
	blockD.g = ivec4(-31, 68, 104, 14);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA[4][4][1];
	lowp vec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 0) mediump uvec4 a;
	layout(xfb_offset = 16) dmat2x3 b;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 64) dmat3 c; // unassigned
	layout(xfb_offset = 136) highp ivec3 d;
} blockC;
layout(location = 12, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=856 sizeInLocations=70
{
	layout(xfb_offset = 152) lowp ivec3 e;
	// layout(xfb_offset = 164) lowp mat4 f; // missing field
	layout(xfb_offset = 232) sA g;
};

void main (void)
{
	blockB.a = uvec4(89u, 30u, 70u, 60u);
	blockB.b = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.d = ivec3(104, 14, 83);
	e = ivec3(-117, 75, 12);
	g.mA[0][0][0] = dmat2x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0);
	g.mA[0][1][0] = dmat2x3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	g.mA[0][2][0] = dmat2x3(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0);
	g.mA[0][3][0] = dmat2x3(-118.0, -108.0, -120.0, 48.0, -71.0, -59.0);
	g.mA[1][0][0] = dmat2x3(-40.0, -62.0, 114.0, -109.0, -51.0, 32.0);
	g.mA[1][1][0] = dmat2x3(113.0, -44.0, -77.0, -11.0, 66.0, -11.0);
	g.mA[1][2][0] = dmat2x3(87.0, -87.0, 87.0, 95.0, -46.0, -122.0);
	g.mA[1][3][0] = dmat2x3(-97.0, 108.0, -127.0, -10.0, 113.0, -60.0);
	g.mA[2][0][0] = dmat2x3(58.0, -109.0, -38.0, -103.0, -63.0, -6.0);
	g.mA[2][1][0] = dmat2x3(37.0, -112.0, 88.0, -40.0, -22.0, 40.0);
	g.mA[2][2][0] = dmat2x3(-17.0, 54.0, -50.0, -84.0, -49.0, -6.0);
	g.mA[2][3][0] = dmat2x3(98.0, -34.0, -69.0, -57.0, -8.0, -89.0);
	g.mA[3][0][0] = dmat2x3(91.0, 114.0, 40.0, -110.0, 28.0, -112.0);
	g.mA[3][1][0] = dmat2x3(-35.0, -127.0, 44.0, 56.0, -33.0, 109.0);
	g.mA[3][2][0] = dmat2x3(-119.0, 34.0, -102.0, 104.0, 33.0, 127.0);
	g.mA[3][3][0] = dmat2x3(121.0, 42.0, -34.0, -92.0, 75.0, -68.0);
	g.mB = vec2(84.0f, -4.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=6
{
	layout(xfb_offset = 0) highp mat4x3 a;
	layout(xfb_offset = 48) highp uvec3 b;
	layout(xfb_offset = 60) highp ivec3 c;
};

void main (void)
{
	a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = uvec3(83u, 117u, 75u);
	c = ivec3(12, -18, -101);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=3
{
	// layout(xfb_offset = 0) dvec3 a; // missing field
	layout(xfb_offset = 24) lowp int b;
};

void main (void)
{
	b = -89;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3x2 mA[3];
	highp mat2 mB;
	mediump vec3 mC[1];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=8
{
	layout(xfb_offset = 0) highp mat3x2 a; // unassigned
	layout(xfb_offset = 24) mediump mat4x2 b;
	layout(xfb_offset = 56) mediump ivec4 c;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=200 sizeInLocations=14
{
	layout(xfb_offset = 72) lowp float d;
	// layout(xfb_offset = 80) sA e; // missing field
	layout(xfb_offset = 256) mediump ivec3 f;
};

void main (void)
{
	b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c = ivec4(-31, 68, 104, 14);
	d = 83.0f;
	f = ivec3(-117, 75, 12);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 0) dmat4x3 a;
	layout(xfb_offset = 96) highp float b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=144 sizeInLocations=9
{
	layout(xfb_offset = 104) dmat4 c;
	layout(xfb_offset = 232) mediump vec3 d;
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 248) out BlockD // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 248) mediump uvec3 e;
} blockD;

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.b = 83.0f;
	blockC.c = dmat4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	blockC.d = vec3(-62.0f, -54.0f, -79.0f);
	blockD.e = uvec3(3u, 97u, 118u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 0) highp uint a;
} blockB;

void main (void)
{
	blockB.a = 89u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=120 sizeInLocations=8
{
	layout(xfb_offset = 0) highp vec2 a;
	layout(xfb_offset = 8) dmat3x4 b;
	layout(xfb_offset = 104) lowp ivec4 c;
} blockB;

void main (void)
{
	blockB.a = vec2(-89.0f, 30.0f);
	blockB.b = dmat3x4(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockB.c = ivec4(75, 12, -18, -101);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=8
{
	layout(xfb_offset = 64) lowp uvec2 c[2];
	layout(xfb_offset = 0) dmat2 a; // unassigned
	layout(xfb_offset = 32) highp mat4x2 b;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=24 sizeInLocations=4
{
	layout(xfb_offset = 100) highp uint f;
	layout(xfb_offset = 80) lowp mat2 d;
	layout(xfb_offset = 96) highp int e;
};

void main (void)
{
	b = mat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	c[0] = uvec2(31u, 68u);
	c[1] = uvec2(104u, 14u);
	d = mat2(83.0, -117.0, 75.0, 12.0);
	e = -18;
	f = 101u;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat3 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 32) sA b;
	// layout(xfb_offset = 0) dmat2 a; // missing field
};

void main (void)
{
	b.mA = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 0) mediump uvec2 a[4];
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 32) out BlockC // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 32) dmat4 b;
};

void main (void)
{
	blockB.a[0] = uvec2(89u, 30u);
	blockB.a[1] = uvec2(70u, 60u);
	blockB.a[2] = uvec2(72u, 102u);
	blockB.a[3] = uvec2(100u, 84u);
	b = dmat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat3x4 mA;
	highp mat3x4 mB;
};
struct sB
{
	lowp ivec4 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 208) sB d;
	layout(xfb_offset = 16) sA b;
	layout(xfb_offset = 112) dvec4 c[3];
} blockC;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockC.b.mA = mat3x4(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b.mB = mat3x4(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	blockC.c[0] = dvec4(-80.0, -62.0, -54.0, -79.0);
	blockC.c[1] = dvec4(3.0, -97.0, -118.0, -108.0);
	blockC.c[2] = dvec4(-120.0, 48.0, -71.0, -59.0);
	blockC.d.mA = ivec4(-40, -62, 114, -109);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp mat2x3 mA; // unassigned
	mediump int mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=144 sizeInLocations=12
{
	// layout(xfb_offset = 112) sA c; // missing field
	layout(xfb_offset = 0) mediump mat3 a;
	// layout(xfb_offset = 40) dmat3 b; // missing field
};

void main (void)
{
	a = mat3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat3x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 112) sA c;
	layout(xfb_offset = 0) lowp mat4x3 a;
	// layout(xfb_offset = 48) highp mat4 b; // missing field
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=100 sizeInLocations=7
{
	layout(xfb_offset = 188) highp mat3x4 f;
	layout(xfb_offset = 136) lowp uvec4 d;
	layout(xfb_offset = 152) lowp mat3 e;
} blockC;

void main (void)
{
	blockB.a = mat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockB.c.mA = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	blockC.d = uvec4(100u, 34u, 35u, 43u);
	blockC.e = mat3(48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0);
	blockC.f = mat3x4(-79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2 mA[3][3];
	mediump ivec3 mB[4];
	dmat3x4 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) lowp mat4 a;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=504 sizeInLocations=34
{
	layout(xfb_offset = 520) dmat2x3 d;
	layout(xfb_offset = 64) sA b;
	layout(xfb_offset = 496) lowp mat2x3 c; // unassigned
};

void main (void)
{
	a = mat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	b.mA[0][0] = dmat2(-18.0, -101.0, 100.0, -34.0);
	b.mA[0][1] = dmat2(-35.0, -43.0, 48.0, 4.0);
	b.mA[0][2] = dmat2(-60.0, 37.0, 52.0, 98.0);
	b.mA[1][0] = dmat2(-80.0, -62.0, -54.0, -79.0);
	b.mA[1][1] = dmat2(3.0, -97.0, -118.0, -108.0);
	b.mA[1][2] = dmat2(-120.0, 48.0, -71.0, -59.0);
	b.mA[2][0] = dmat2(-40.0, -62.0, 114.0, -109.0);
	b.mA[2][1] = dmat2(-51.0, 32.0, 113.0, -44.0);
	b.mA[2][2] = dmat2(-77.0, -11.0, 66.0, -11.0);
	b.mB[0] = ivec3(87, -87, 87);
	b.mB[1] = ivec3(95, -46, -122);
	b.mB[2] = ivec3(-97, 108, -127);
	b.mB[3] = ivec3(-10, 113, -60);
	d = dmat2x3(58.0, -109.0, -38.0, -103.0, -63.0, -6.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 128) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 128) mediump ivec2 b;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 136) out BlockD // sizeInBytes=144 sizeInLocations=10
{
	// layout(xfb_offset = 232) highp mat3x4 e; // missing field
	layout(xfb_offset = 136) dmat2x3 c;
	layout(xfb_offset = 184) dmat3x2 d;
} blockD;

void main (void)
{
	blockB.a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);
	blockC.b = ivec2(-18, -101);
	blockD.c = dmat2x3(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockD.d = dmat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 16) dmat2x3 b;
	layout(xfb_offset = 0) lowp ivec4 a;
};

void main (void)
{
	a = ivec4(-89, 30, -70, -60);
	b = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat4x2 mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 72) double c;
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 64) lowp uint b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 80) lowp int d;
} blockC;
layout(location = 7, xfb_buffer = 0, xfb_offset = 84) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 92) mediump mat3x4 f; // unassigned
	layout(xfb_offset = 84) mediump vec2 e;
};

void main (void)
{
	a.mA = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = 31u;
	c = 68.0;
	blockC.d = 104;
	e = vec2(14.0f, 83.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat4 mA;
	mediump uvec3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=160 sizeInLocations=12
{
	layout(xfb_offset = 64) dmat4x3 c;
	layout(xfb_offset = 0) dmat2 a;
	layout(xfb_offset = 32) dmat2 b;
};
layout(location = 12, xfb_buffer = 0, xfb_offset = 160) out BlockC // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 236) lowp uvec3 e[1];
	layout(xfb_offset = 160) sA d;
};

void main (void)
{
	a = dmat2(-89.0, 30.0, -70.0, -60.0);
	b = dmat2(72.0, -102.0, -100.0, 84.0);
	c = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	d.mA = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	d.mB = uvec3(120u, 48u, 71u);
	e[0] = uvec3(59u, 40u, 62u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) highp ivec2 a;
};

void main (void)
{
	a = ivec2(-89, 30);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec3 mA;
	mediump mat2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=7
{
	// layout(xfb_offset = 40) lowp mat3x2 b; // missing field
	layout(xfb_offset = 0) sA a;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 64) lowp int c;
};

void main (void)
{
	a.mA = dvec3(-89.0, 30.0, -70.0);
	a.mB = mat2(-60.0, 72.0, -102.0, -100.0);
	c = 84;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp uvec2 mA;
};
struct sB
{
	lowp mat3x4 mA; // unassigned
	sA mB; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 20) sB c;
	layout(xfb_offset = 0) double a[2];
	layout(xfb_offset = 16) mediump uint b;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 80) dmat4x2 d;
} blockC;
layout(location = 11, xfb_buffer = 0, xfb_offset = 144) out BlockD // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 144) lowp mat4x2 e;
} blockD;

void main (void)
{
	blockB.a[0] = -89.0;
	blockB.a[1] = 30.0;
	blockB.b = 70u;
	blockC.d = dmat4x2(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	blockD.e = mat4x2(14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat2x3 mA;
	lowp ivec3 mB; // unassigned
};
struct sB
{
	lowp mat3x2 mA[1];
	lowp mat4x3 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	layout(xfb_offset = 64) mediump mat3 b;
	layout(xfb_offset = 0) sA a;
};
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=488 sizeInLocations=41
{
	layout(xfb_offset = 584) highp uvec2 e;
	// layout(xfb_offset = 104) sB c[4]; // missing field
	// layout(xfb_offset = 392) dmat3x2 d[4]; // missing field
} blockC;

void main (void)
{
	a.mA = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = mat3(-100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockC.e = uvec2(12u, 18u);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=288 sizeInLocations=18
{
	layout(xfb_offset = 256) dvec4 b;
	// layout(xfb_offset = 0) highp mat4 a[2][2]; // missing field
} blockB;

void main (void)
{
	blockB.b = dvec4(-89.0, 30.0, -70.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump mat2 mA;
	highp ivec4 mB;
};
struct sB
{
	lowp ivec2 mA[2]; // unassigned
	dmat4x3 mB;
	dmat3x2 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=192 sizeInLocations=16
{
	layout(xfb_offset = 32) sB b;
	layout(xfb_offset = 0) sA a;
};
layout(location = 16, xfb_buffer = 0, xfb_offset = 192) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 192) lowp mat4 c;
};

void main (void)
{
	a.mA = mat2(-89.0, 30.0, -70.0, -60.0);
	a.mB = ivec4(72, -102, -100, 84);
	b.mB = dmat4x3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0);
	c = mat4(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp uvec3 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=64 sizeInLocations=5
{
	// layout(xfb_offset = 60) lowp mat2 c; // missing field
	layout(xfb_offset = 12) lowp mat3x4 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 176) dvec2 e;
	layout(xfb_offset = 80) dmat4x3 d;
} blockD;

void main (void)
{
	a = uvec3(89u, 30u, 70u);
	b = mat3x4(-60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockD.d = dmat4x3(12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0);
	blockD.e = dvec2(98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 16) mediump float b;
	// layout(xfb_offset = 0) highp vec4 a; // missing field
};
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 24) double c;
} blockC;
layout(location = 3, xfb_buffer = 0, xfb_offset = 32) out BlockD // sizeInBytes=48 sizeInLocations=4
{
	layout(xfb_offset = 32) dvec3 d[2];
};

void main (void)
{
	b = -89.0f;
	blockC.c = 30.0;
	d[0] = dvec3(-70.0, -60.0, 72.0);
	d[1] = dvec3(-102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump uvec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=136 sizeInLocations=9
{
	layout(xfb_offset = 96) dmat3x2 d;
	layout(xfb_offset = 8) dvec3 b;
	layout(xfb_offset = 32) lowp mat4 c;
};

void main (void)
{
	a = uvec2(89u, 30u);
	b = dvec3(-70.0, -60.0, 72.0);
	c = mat4(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	d = dmat3x2(-43.0, 48.0, 4.0, -60.0, 37.0, 52.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 24) dmat4x2 b;
	// layout(xfb_offset = 0) mediump mat2x3 a; // missing field
};

void main (void)
{
	b = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp uvec3 mA;
	lowp float mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=6
{
	layout(xfb_offset = 16) highp ivec2 c[4];
	// layout(xfb_offset = 0) mediump ivec3 a; // missing field
	layout(xfb_offset = 12) highp int b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 48) dvec2 d;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 64) out BlockD // sizeInBytes=28 sizeInLocations=4
{
	layout(xfb_offset = 84) lowp ivec2 g;
	layout(xfb_offset = 64) highp uint e;
	layout(xfb_offset = 68) sA f;
} blockD;

void main (void)
{
	b = -89;
	c[0] = ivec2(30, -70);
	c[1] = ivec2(-60, 72);
	c[2] = ivec2(-102, -100);
	c[3] = ivec2(84, -31);
	d = dvec2(68.0, 104.0);
	blockD.e = 14u;
	blockD.f.mA = uvec3(83u, 117u, 75u);
	blockD.f.mB = 12.0f;
	blockD.g = ivec2(-18, -101);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) lowp mat3x4 a;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec4 mA;
};
struct sB
{
	dvec3 mA;
	sA mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=9
{
	layout(xfb_offset = 72) dmat4x2 c;
	layout(xfb_offset = 0) highp uint a;
	layout(xfb_offset = 8) dmat4x2 b;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=128 sizeInLocations=11
{
	layout(xfb_offset = 256) highp ivec2 f;
	layout(xfb_offset = 136) dmat2x3 d;
	layout(xfb_offset = 184) dmat3 e;
} blockC;
layout(location = 20, xfb_buffer = 0, xfb_offset = 264) out BlockD // sizeInBytes=88 sizeInLocations=6
{
	layout(xfb_offset = 296) sB h;
	layout(xfb_offset = 264) dmat2 g;
};

void main (void)
{
	blockB.a = 89u;
	blockB.b = dmat4x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	blockB.c = dmat4x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockC.d = dmat2x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.e = dmat3(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0);
	blockC.f = ivec2(3, -97);
	g = dmat2(-118.0, -108.0, -120.0, 48.0);
	h.mA = dvec3(-71.0, -59.0, -40.0);
	h.mB.mA = dvec4(-62.0, 114.0, -109.0, -51.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp mat3x2 mA;
};
struct sB
{
	lowp int mA;
	dmat4x2 mB;
};
struct sC
{
	dvec2 mA;
	mediump float mB;
	dvec2 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 96) sC c[1];
	layout(xfb_offset = 0) sA a;
	layout(xfb_offset = 24) sB b;
} blockB;
layout(location = 11, xfb_buffer = 0, xfb_offset = 136) out BlockC // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 136) highp ivec2 d;
} blockC;

void main (void)
{
	blockB.a.mA = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	blockB.b.mA = -100;
	blockB.b.mB = dmat4x2(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	blockB.c[0].mA = dvec2(12.0, -18.0);
	blockB.c[0].mB = -101.0f;
	blockB.c[0].mC = dvec2(100.0, -34.0);
	blockC.d = ivec2(-35, -43);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=96 sizeInLocations=8
{
	layout(xfb_offset = 0) dmat4x3 a;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 96) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 96) highp int b;
};
layout(location = 9, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=112 sizeInLocations=7
{
	// layout(xfb_offset = 200) dvec2 d; // missing field
	layout(xfb_offset = 104) dmat3x4 c;
};

void main (void)
{
	blockB.a = dmat4x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b = 83;
	c = dmat3x4(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) dmat3x2 a;
};

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump float mA; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) highp vec2 a;
};
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=4 sizeInLocations=1
{
	layout(xfb_offset = 8) sA b;
} blockC;
layout(location = 2, xfb_buffer = 0, xfb_offset = 16) out BlockD // sizeInBytes=32 sizeInLocations=2
{
	layout(xfb_offset = 16) dmat2 c;
};

void main (void)
{
	a = vec2(-89.0f, 30.0f);
	c = dmat2(-70.0, -60.0, 72.0, -102.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=20 sizeInLocations=2
{
	layout(xfb_offset = 12) mediump uvec2 b;
	layout(xfb_offset = 0) highp ivec3 a;
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 24) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 56) dvec2 e;
	// layout(xfb_offset = 24) lowp uvec4 c; // missing field
	layout(xfb_offset = 40) lowp ivec4 d; // unassigned
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockD // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 136) lowp mat3x4 g;
	layout(xfb_offset = 72) highp uvec4 f[4]; // unassigned
} blockD;

void main (void)
{
	blockB.a = ivec3(-89, 30, -70);
	blockB.b = uvec2(60u, 72u);
	e = dvec2(-102.0, -100.0);
	blockD.g = mat3x4(84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=8
{
	layout(xfb_offset = 56) dmat3x2 c;
	layout(xfb_offset = 0) mediump mat2 a;
	layout(xfb_offset = 16) mediump mat3 b;
} blockB;
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockC // sizeInBytes=112 sizeInLocations=9
{
	// layout(xfb_offset = 208) highp ivec2 f; // missing field
	layout(xfb_offset = 104) dmat3 d;
	layout(xfb_offset = 176) dvec4 e;
};
layout(location = 17, xfb_buffer = 0, xfb_offset = 216) out BlockD // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 216) highp vec4 g;
} blockD;

void main (void)
{
	blockB.a = mat2(-89.0, 30.0, -70.0, -60.0);
	blockB.b = mat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockB.c = dmat3x2(-117.0, 75.0, 12.0, -18.0, -101.0, 100.0);
	d = dmat3(-34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	e = dvec4(-80.0, -62.0, -54.0, -79.0);
	blockD.g = vec4(3.0f, -97.0f, -118.0f, -108.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=88 sizeInLocations=7
{
	layout(xfb_offset = 16) dmat3 b;
	layout(xfb_offset = 0) highp ivec4 a;
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 88) out BlockC // sizeInBytes=12 sizeInLocations=1
{
	layout(xfb_offset = 88) mediump ivec3 c;
} blockC;
layout(location = 8, xfb_buffer = 0, xfb_offset = 104) out BlockD // sizeInBytes=144 sizeInLocations=11
{
	layout(xfb_offset = 200) highp mat3x4 e;
	layout(xfb_offset = 104) dmat4x3 d;
};

void main (void)
{
	a = ivec4(-89, 30, -70, -60);
	b = dmat3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0);
	blockC.c = ivec3(-117, 75, 12);
	d = dmat4x3(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0);
	e = mat3x4(-80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	highp uvec2 mA; // unassigned
	mediump mat2 mB;
	lowp int mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=4
{
	layout(xfb_offset = 0) dmat4x2 a;
} blockB;
layout(location = 4, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=176 sizeInLocations=13
{
	layout(xfb_offset = 208) sA d;
	layout(xfb_offset = 64) dmat4 b;
	layout(xfb_offset = 192) highp uvec4 c;
} blockC;

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockC.b = dmat4(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.c = uvec4(60u, 37u, 52u, 98u);
	blockC.d.mB = mat2(-80.0, -62.0, -54.0, -79.0);
	blockC.d.mC = 3;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=32 sizeInLocations=4
{
	layout(xfb_offset = 24) double b;
	layout(xfb_offset = 0) mediump mat3x2 a;
};

void main (void)
{
	a = mat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = -100.0;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 8) dmat3x2 b;
	layout(xfb_offset = 0) lowp float a; // unassigned
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 56) out BlockC // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 84) mediump vec3 e;
	layout(xfb_offset = 56) mediump vec4 c; // unassigned
	layout(xfb_offset = 72) lowp ivec3 d;
};

void main (void)
{
	b = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	d = ivec3(-100, 84, -31);
	e = vec3(68.0f, 104.0f, 14.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=9
{
	layout(xfb_offset = 16) dmat4x3 b;
	layout(xfb_offset = 0) dvec2 a;
} blockB;
layout(location = 9, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=36 sizeInLocations=9
{
	layout(xfb_offset = 112) highp int c[3][3];
} blockC;
layout(location = 18, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=72 sizeInLocations=5
{
	// layout(xfb_offset = 200) dvec3 e; // missing field
	layout(xfb_offset = 152) mediump mat3x4 d;
};

void main (void)
{
	blockB.a = dvec2(-89.0, 30.0);
	blockB.b = dmat4x3(-70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.c[0][0] = 75;
	blockC.c[0][1] = 12;
	blockC.c[0][2] = -18;
	blockC.c[1][0] = -101;
	blockC.c[1][1] = 100;
	blockC.c[1][2] = -34;
	blockC.c[2][0] = -35;
	blockC.c[2][1] = -43;
	blockC.c[2][2] = 48;
	d = mat3x4(4.0, -60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec4 mA;
	dvec2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=36 sizeInLocations=4
{
	layout(xfb_offset = 20) lowp uvec4 c;
	layout(xfb_offset = 0) highp mat2 a;
	layout(xfb_offset = 16) highp uint b;
};
layout(location = 4, xfb_buffer = 0, xfb_offset = 40) out BlockC // sizeInBytes=64 sizeInLocations=4
{
	// layout(xfb_offset = 88) lowp ivec4 e; // missing field
	layout(xfb_offset = 40) sA d;
};

void main (void)
{
	a = mat2(-89.0, 30.0, -70.0, -60.0);
	b = 72u;
	c = uvec4(102u, 100u, 84u, 31u);
	d.mA = dvec4(68.0, 104.0, 14.0, 83.0);
	d.mB = dvec2(-117.0, 75.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=12 sizeInLocations=2
{
	layout(xfb_offset = 4) mediump vec2 b;
	layout(xfb_offset = 0) lowp uint a; // unassigned
} blockB;
layout(location = 2, xfb_buffer = 0, xfb_offset = 12) out BlockC // sizeInBytes=64 sizeInLocations=5
{
	layout(xfb_offset = 64) lowp uvec3 e;
	layout(xfb_offset = 12) lowp mat3x4 c; // unassigned
	layout(xfb_offset = 60) mediump uint d; // unassigned
};
layout(location = 7, xfb_buffer = 0, xfb_offset = 80) out BlockD // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 128) lowp vec2 g;
	layout(xfb_offset = 80) dmat3x2 f;
};

void main (void)
{
	blockB.b = vec2(-89.0f, 30.0f);
	e = uvec3(70u, 60u, 72u);
	f = dmat3x2(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0);
	g = vec2(14.0f, 83.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=104 sizeInLocations=9
{
	layout(xfb_offset = 8) dvec3 b[4];
	layout(xfb_offset = 0) lowp ivec2 a;
};

void main (void)
{
	a = ivec2(-89, 30);
	b[0] = dvec3(-70.0, -60.0, 72.0);
	b[1] = dvec3(-102.0, -100.0, 84.0);
	b[2] = dvec3(-31.0, 68.0, 104.0);
	b[3] = dvec3(14.0, 83.0, -117.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=16 sizeInLocations=1
{
	layout(xfb_offset = 0) mediump ivec4 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 16) out BlockC // sizeInBytes=112 sizeInLocations=8
{
	layout(xfb_offset = 96) dvec4 d;
	// layout(xfb_offset = 16) dmat2 b; // missing field
	layout(xfb_offset = 48) dmat2x3 c;
} blockC;
layout(location = 9, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=64 sizeInLocations=7
{
	// layout(xfb_offset = 160) mediump mat4x2 g[1]; // missing field
	layout(xfb_offset = 128) mediump ivec4 e;
	layout(xfb_offset = 144) highp mat2 f;
} blockD;

void main (void)
{
	blockB.a = ivec4(-89, 30, -70, -60);
	blockC.c = dmat2x3(72.0, -102.0, -100.0, 84.0, -31.0, 68.0);
	blockC.d = dvec4(104.0, 14.0, 83.0, -117.0);
	blockD.e = ivec4(75, 12, -18, -101);
	blockD.f = mat2(100.0, -34.0, -35.0, -43.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=44 sizeInLocations=5
{
	layout(xfb_offset = 12) mediump mat4x2 b; // unassigned
	layout(xfb_offset = 0) mediump uvec3 a;
} blockB;
layout(location = 5, xfb_buffer = 0, xfb_offset = 44) out BlockC // sizeInBytes=104 sizeInLocations=10
{
	layout(xfb_offset = 124) lowp mat3x2 e;
	layout(xfb_offset = 44) lowp vec2 c;
	layout(xfb_offset = 52) mediump mat3 d[2];
} blockC;
layout(location = 15, xfb_buffer = 0, xfb_offset = 152) out BlockD // sizeInBytes=128 sizeInLocations=8
{
	layout(xfb_offset = 152) dmat4 f;
};

void main (void)
{
	blockB.a = uvec3(89u, 30u, 70u);
	blockC.c = vec2(-60.0f, 72.0f);
	blockC.d[0] = mat3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.d[1] = mat3(75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0);
	blockC.e = mat3x2(4.0, -60.0, 37.0, 52.0, 98.0, -80.0);
	f = dmat4(-62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=240 sizeInLocations=18
{
	layout(xfb_offset = 192) highp mat3x2 b[2];
	layout(xfb_offset = 0) dmat3x4 a[2];
};

void main (void)
{
	a[0] = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	a[1] = dmat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[0] = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	b[1] = mat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dmat3 mA;
	mediump uvec3 mB; // unassigned
	lowp mat4x3 mC;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) dmat3x2 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=80 sizeInLocations=7
{
	layout(xfb_offset = 56) dmat3 c;
	layout(xfb_offset = 48) highp vec2 b;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 128) out BlockD // sizeInBytes=136 sizeInLocations=11
{
	layout(xfb_offset = 128) sA d;
} blockD;

void main (void)
{
	a = dmat3x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = vec2(-100.0f, 84.0f);
	c = dmat3(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	blockD.d.mA = dmat3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0);
	blockD.d.mC = mat4x3(52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0, 48.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=40 sizeInLocations=3
{
	layout(xfb_offset = 24) mediump vec3 b;
	layout(xfb_offset = 0) dvec3 a;
} blockB;

void main (void)
{
	blockB.a = dvec3(-89.0, 30.0, -70.0);
	blockB.b = vec3(-60.0f, 72.0f, -102.0f);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	dvec2 mA[2];
	lowp mat3x4 mB;
	mediump ivec2 mC[4];
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 8) dmat4x2 b;
	layout(xfb_offset = 0) highp int a;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=48 sizeInLocations=6
{
	layout(xfb_offset = 96) lowp mat3x2 d;
	layout(xfb_offset = 72) lowp mat3x2 c;
};
layout(location = 11, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=192 sizeInLocations=15
{
	layout(xfb_offset = 280) dvec4 g;
	layout(xfb_offset = 120) sA e;
	layout(xfb_offset = 232) dmat2x3 f;
} blockD;

void main (void)
{
	a = -89;
	b = dmat4x2(30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0);
	c = mat3x2(68.0, 104.0, 14.0, 83.0, -117.0, 75.0);
	d = mat3x2(12.0, -18.0, -101.0, 100.0, -34.0, -35.0);
	blockD.e.mA[0] = dvec2(-43.0, 48.0);
	blockD.e.mA[1] = dvec2(4.0, -60.0);
	blockD.e.mB = mat3x4(37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0, -120.0);
	blockD.e.mC[0] = ivec2(48, -71);
	blockD.e.mC[1] = ivec2(-59, -40);
	blockD.e.mC[2] = ivec2(-62, 114);
	blockD.e.mC[3] = ivec2(-109, -51);
	blockD.f = dmat2x3(32.0, 113.0, -44.0, -77.0, -11.0, 66.0);
	blockD.g = dvec4(-11.0, 87.0, -87.0, 87.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=72 sizeInLocations=5
{
	layout(xfb_offset = 64) double b;
	layout(xfb_offset = 0) dmat4x2 a;
};
layout(location = 5, xfb_buffer = 0, xfb_offset = 72) out BlockC // sizeInBytes=68 sizeInLocations=5
{
	layout(xfb_offset = 136) mediump int d;
	layout(xfb_offset = 72) highp mat4 c;
};

void main (void)
{
	a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	b = -31.0;
	c = mat4(68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0);
	d = 37;

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp ivec4 mA; // unassigned
	dmat2 mB;
};
struct sB
{
	sA mA;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=64 sizeInLocations=6
{
	layout(xfb_offset = 56) mediump float c;
	layout(xfb_offset = 0) dmat2x3 a;
	layout(xfb_offset = 48) lowp ivec2 b;
};
layout(location = 6, xfb_buffer = 0, xfb_offset = 64) out BlockC // sizeInBytes=56 sizeInLocations=4
{
	layout(xfb_offset = 72) sB e; // unassigned
	layout(xfb_offset = 64) mediump vec2 d;
};
layout(location = 10, xfb_buffer = 0, xfb_offset = 120) out BlockD // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 120) mediump ivec2 f;
} blockD;

void main (void)
{
	a = dmat2x3(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0);
	b = ivec2(-100, 84);
	c = -31.0f;
	d = vec2(68.0f, 104.0f);
	blockD.f = ivec2(14, 83);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=56 sizeInLocations=5
{
	// layout(xfb_offset = 32) dvec3 c; // missing field
	layout(xfb_offset = 0) highp vec3 a;
	layout(xfb_offset = 12) highp mat2 b;
} blockB;

void main (void)
{
	blockB.a = vec3(-89.0f, 30.0f, -70.0f);
	blockB.b = mat2(-60.0, 72.0, -102.0, -100.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	mediump ivec4 mA;
	highp mat4x2 mB;
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) lowp uvec2 a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=28 sizeInLocations=2
{
	layout(xfb_offset = 20) lowp vec4 c;
	layout(xfb_offset = 8) lowp vec3 b;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 36) out BlockD // sizeInBytes=84 sizeInLocations=9
{
	layout(xfb_offset = 72) sA f;
	// layout(xfb_offset = 36) lowp mat3x2 d; // missing field
	layout(xfb_offset = 60) lowp vec3 e[1];
} blockD;

void main (void)
{
	blockB.a = uvec2(89u, 30u);
	b = vec3(-70.0f, -60.0f, 72.0f);
	c = vec4(-102.0f, -100.0f, 84.0f, -31.0f);
	blockD.e[0] = vec3(68.0f, 104.0f, 14.0f);
	blockD.f.mA = ivec4(83, -117, 75, 12);
	blockD.f.mB = mat4x2(-18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=200 sizeInLocations=13
{
	// layout(xfb_offset = 136) highp mat4 c; // missing field
	layout(xfb_offset = 0) dmat4 a;
	layout(xfb_offset = 128) double b; // unassigned
};

void main (void)
{
	a = dmat4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 16) dmat3x4 b;
	// layout(xfb_offset = 0) lowp ivec3 a; // missing field
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=80 sizeInLocations=6
{
	layout(xfb_offset = 160) highp ivec4 d[2];
	layout(xfb_offset = 112) mediump mat4x3 c;
} blockC;
layout(location = 13, xfb_buffer = 0, xfb_offset = 192) out BlockD // sizeInBytes=76 sizeInLocations=6
{
	layout(xfb_offset = 252) highp ivec4 g;
	layout(xfb_offset = 192) mediump ivec3 e;
	layout(xfb_offset = 204) highp mat4x3 f;
};

void main (void)
{
	blockB.b = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = mat4x3(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	blockC.d[0] = ivec4(-60, 37, 52, 98);
	blockC.d[1] = ivec4(-80, -62, -54, -79);
	e = ivec3(3, -97, -118);
	f = mat4x3(-108.0, -120.0, 48.0, -71.0, -59.0, -40.0, -62.0, 114.0, -109.0, -51.0, 32.0, 113.0);
	g = ivec4(-44, -77, -11, 66);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

struct sA
{
	lowp ivec2 mA;
	lowp uvec4 mB;
	dvec3 mC; // unassigned
};
layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=112 sizeInLocations=7
{
	layout(xfb_offset = 64) dmat3x2 b;
	layout(xfb_offset = 0) dmat4x2 a;
} blockB;
layout(location = 7, xfb_buffer = 0, xfb_offset = 112) out BlockC // sizeInBytes=88 sizeInLocations=8
{
	// layout(xfb_offset = 184) mediump uvec4 e; // missing field
	layout(xfb_offset = 112) sA c;
	layout(xfb_offset = 160) highp mat3x2 d;
} blockC;

void main (void)
{
	blockB.a = dmat4x2(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0);
	blockB.b = dmat3x2(-31.0, 68.0, 104.0, 14.0, 83.0, -117.0);
	blockC.c.mA = ivec2(75, 12);
	blockC.c.mB = uvec4(18u, 101u, 100u, 34u);
	blockC.d = mat3x2(-35.0, -43.0, 48.0, 4.0, -60.0, 37.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 0) mediump mat3x4 a;
};
layout(location = 3, xfb_buffer = 0, xfb_offset = 48) out BlockC // sizeInBytes=116 sizeInLocations=14
{
	layout(xfb_offset = 152) highp ivec3 d;
	layout(xfb_offset = 48) lowp mat3x2 b[4];
	layout(xfb_offset = 144) mediump ivec2 c;
};

void main (void)
{
	a = mat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	b[0] = mat3x2(83.0, -117.0, 75.0, 12.0, -18.0, -101.0);
	b[1] = mat3x2(100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	b[2] = mat3x2(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0);
	b[3] = mat3x2(-54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	c = ivec2(-120, 48);
	d = ivec3(-71, -59, -40);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=8 sizeInLocations=1
{
	layout(xfb_offset = 0) double a;
} blockB;
layout(location = 1, xfb_buffer = 0, xfb_offset = 8) out BlockC // sizeInBytes=160 sizeInLocations=14
{
	layout(xfb_offset = 72) dmat4x3 d;
	layout(xfb_offset = 8) highp mat2 b;
	layout(xfb_offset = 24) lowp mat4x3 c;
};

void main (void)
{
	blockB.a = -89.0;
	b = mat2(30.0, -70.0, -60.0, 72.0);
	c = mat4x3(-102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0, 83.0, -117.0, 75.0, 12.0, -18.0);
	d = dmat4x3(-101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0, -60.0, 37.0, 52.0, 98.0, -80.0);

	EmitVertex();
	EndPrimitive();
}
#version 450

layout(points) in;
layout(points, max_vertices = 1) out;

layout(location = 0, xfb_buffer = 0, xfb_offset = 0) out BlockB // sizeInBytes=224 sizeInLocations=14
{
	layout(xfb_offset = 128) dmat3x4 b;
	layout(xfb_offset = 0) dmat4 a; // unassigned
};
layout(location = 14, xfb_buffer = 0, xfb_offset = 224) out BlockC // sizeInBytes=48 sizeInLocations=3
{
	layout(xfb_offset = 224) lowp mat3x4 c;
} blockC;
layout(location = 17, xfb_buffer = 0, xfb_offset = 272) out BlockD // sizeInBytes=208 sizeInLocations=13
{
	layout(xfb_offset = 352) dmat4 f; // unassigned
	layout(xfb_offset = 272) mediump mat3x4 d;
	layout(xfb_offset = 320) dvec4 e;
};

void main (void)
{
	b = dmat3x4(-89.0, 30.0, -70.0, -60.0, 72.0, -102.0, -100.0, 84.0, -31.0, 68.0, 104.0, 14.0);
	blockC.c = mat3x4(83.0, -117.0, 75.0, 12.0, -18.0, -101.0, 100.0, -34.0, -35.0, -43.0, 48.0, 4.0);
	d = mat3x4(-60.0, 37.0, 52.0, 98.0, -80.0, -62.0, -54.0, -79.0, 3.0, -97.0, -118.0, -108.0);
	e = dvec4(-120.0, 48.0, -71.0, -59.0);

	EmitVertex();
	EndPrimitive();
}
