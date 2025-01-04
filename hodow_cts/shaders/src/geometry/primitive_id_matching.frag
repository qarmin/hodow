#version 450
layout(location = 0) flat in uint tesc_primitive_id;
layout(location = 1) flat in uint tese_primitive_id;
layout(location = 2) flat in uint geom_primitive_id;
layout (location = 0) out vec4 outColor;
void main() {
    outColor = vec4(
                    float(tesc_primitive_id) / 255.0f,
                    float(tese_primitive_id) / 255.0f,
                    float(geom_primitive_id) / 255.0f,
                    1.0f
                    );
}
