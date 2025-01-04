#version 430

layout (local_size_x = 1) in;

layout(binding = 0) buffer binding0 {
   float src[];
};

layout(binding = 1) buffer binding1 {
   float dst[];
};

void main() {
   dst[0] = src[1021] + src[1022] + src[1023] + src[1024];
}

