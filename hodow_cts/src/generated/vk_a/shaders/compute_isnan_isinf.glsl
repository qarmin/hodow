#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float16 : enable

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0) buffer OutputBuffer {
    float invalue;
};

layout(set = 0, binding = 1) buffer ResultBuffer {
    uint result;
};

void main() {
    float16_t f16 = float16_t(invalue);
    result = isnan(f16) ? 1u : 0u;
    result += isinf(f16) ? 1u : 0u;
}
#version 450
#extension GL_EXT_shader_explicit_arithmetic_types_float64 : enable

layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(set = 0, binding = 0) buffer OutputBuffer {
    float invalue;
};

layout(set = 0, binding = 1) buffer ResultBuffer {
    uint result;
};

void main() {
    float64_t f64 = float64_t(invalue);
    result = isnan(f64) ? 1u : 0u;
    result += isinf(f64) ? 1u : 0u;
}
