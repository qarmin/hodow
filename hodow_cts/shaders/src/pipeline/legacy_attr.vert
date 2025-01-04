#version 460
layout (location=0) in vec4 inPos;
${'layout (location=1) in ' + t0 + ' inData0;\nlayout (location=0) out flat ' + t0 + ' outData0;\n' if t0 else ''}${'layout (location=2) in ' + t1 + ' inData1;\nlayout (location=1) out flat ' + t1 + ' outData1;\n' if t1 else ''}${'layout (location=3) in ' + t2 + ' inData2;\nlayout (location=2) out flat ' + t2 + ' outData2;\n' if t2 else ''}void main (void) {
    gl_Position = inPos;
${'    outData0 = inData0;\n' if t0 else ''}${'    outData1 = inData1;\n' if t1 else ''}${'    outData2 = inData2;\n' if t2 else ''}}
