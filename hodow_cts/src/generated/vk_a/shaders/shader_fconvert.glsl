#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    saturatedConvertEXT(ossbo.val[gl_WorkGroupID.x], f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate5m2_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[528]; } ossbo;
void main()
{
    floate5m2_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate5m2_t val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate5m2_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[264]; } ossbo;
void main()
{
    fe5m2vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[176]; } ossbo;
void main()
{
    fe5m2vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe5m2vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[132]; } ossbo;
void main()
{
    fe5m2vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe5m2vec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe5m2vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[66]; } ossbo;
void main()
{
    vector<floate5m2_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate5m2_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[33]; } ossbo;
void main()
{
    vector<floate5m2_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate5m2_t, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate5m2_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { floate4m3_t val[528]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[528]; } ossbo;
void main()
{
    floate4m3_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { floate4m3_t val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = floate4m3_t(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec2 val[264]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[264]; } ossbo;
void main()
{
    fe4m3vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec2(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec3 val[176]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[176]; } ossbo;
void main()
{
    fe4m3vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec3(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { fe4m3vec4 val[132]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[132]; } ossbo;
void main()
{
    fe4m3vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { fe4m3vec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = fe4m3vec4(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 8> val[66]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[66]; } ossbo;
void main()
{
    vector<floate4m3_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 8>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<floate4m3_t, 16> val[33]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[33]; } ossbo;
void main()
{
    vector<floate4m3_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_float_e4m3 : enable
#extension GL_EXT_float_e5m2 : enable
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<floate4m3_t, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<floate4m3_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bfloat16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[66288]; } ossbo;
void main()
{
    bfloat16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bfloat16_t val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bfloat16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[33144]; } ossbo;
void main()
{
    bf16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[22096]; } ossbo;
void main()
{
    bf16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { bf16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[16572]; } ossbo;
void main()
{
    bf16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { bf16vec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = bf16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[8286]; } ossbo;
void main()
{
    vector<bfloat16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<bfloat16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[4143]; } ossbo;
void main()
{
    vector<bfloat16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_bfloat16: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<bfloat16_t, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<bfloat16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float16_t val[66288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[66288]; } ossbo;
void main()
{
    float16_t f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float16_t val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float16_t(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec2 val[33144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[33144]; } ossbo;
void main()
{
    f16vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec2(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec3 val[22096]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[22096]; } ossbo;
void main()
{
    f16vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec3(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { f16vec4 val[16572]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[16572]; } ossbo;
void main()
{
    f16vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { f16vec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = f16vec4(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 8> val[8286]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[8286]; } ossbo;
void main()
{
    vector<float16_t, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 8>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float16_t, 16> val[4143]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[4143]; } ossbo;
void main()
{
    vector<float16_t, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_shader_16bit_storage: require
#extension GL_EXT_shader_explicit_arithmetic_types: require
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float16_t, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float16_t, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { float val[1248]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[1248]; } ossbo;
void main()
{
    float f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { float val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = float(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec2 val[624]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[624]; } ossbo;
void main()
{
    vec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec3 val[416]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[416]; } ossbo;
void main()
{
    vec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vec4 val[312]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[312]; } ossbo;
void main()
{
    vec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 8> val[156]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[156]; } ossbo;
void main()
{
    vector<float, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<float, 16> val[78]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[78]; } ossbo;
void main()
{
    vector<float, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<float, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<float, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { int val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = int(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { int val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[288]; } ossbo;
void main()
{
    int f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[144]; } ossbo;
void main()
{
    ivec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[96]; } ossbo;
void main()
{
    ivec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { ivec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = ivec4(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { ivec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[72]; } ossbo;
void main()
{
    ivec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[36]; } ossbo;
void main()
{
    vector<int, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<int, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<int, 16>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<int, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[18]; } ossbo;
void main()
{
    vector<int, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { double val[1488]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uint val[1488]; } ossbo;
void main()
{
    double f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uint(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uint val[288]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { double val[288]; } ossbo;
void main()
{
    uint f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = double(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec2 val[744]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec2 val[744]; } ossbo;
void main()
{
    dvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec2 val[144]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec2 val[144]; } ossbo;
void main()
{
    uvec2 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec2(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec3 val[496]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec3 val[496]; } ossbo;
void main()
{
    dvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec3 val[96]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec3 val[96]; } ossbo;
void main()
{
    uvec3 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec3(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { dvec4 val[372]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { uvec4 val[372]; } ossbo;
void main()
{
    dvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = uvec4(f);
}
#version 450 core
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { uvec4 val[72]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { dvec4 val[72]; } ossbo;
void main()
{
    uvec4 f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = dvec4(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 8> val[186]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 8> val[186]; } ossbo;
void main()
{
    vector<double, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 8> val[36]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 8> val[36]; } ossbo;
void main()
{
    vector<uint, 8> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 8>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<double, 16> val[93]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<uint, 16> val[93]; } ossbo;
void main()
{
    vector<double, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<uint, 16>(f);
}
#version 450 core
#extension GL_EXT_long_vector: require
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(set = 0, binding = 0, std140) buffer issbodef { vector<uint, 16> val[18]; } issbo;
layout(set = 0, binding = 1, std140) buffer ossbodef { vector<double, 16> val[18]; } ossbo;
void main()
{
    vector<uint, 16> f = issbo.val[gl_WorkGroupID.x];
    ossbo.val[gl_WorkGroupID.x] = vector<double, 16>(f);
}
