#version 450
layout(constant_id = 0) const int arraySize = 1;
layout(location = 0) flat in ivec4 inputData[arraySize];
layout(location = 0) out vec4 color;
void main()
{
    color = vec4(1.0, 0.0, 0.0, 1.0);
    int i;
    bool result = true;
    for (i = 0; i < arraySize; i++)
    {
        if (result && inputData[i] != ivec4(i))
            result = false;
    }
    if (result)
        color = vec4(0.0, 1.0, 0.0, 1.0);
}
