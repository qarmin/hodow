#version 460
${'#extension GL_EXT_scalar_block_layout : require\n' if layout == 'scalar' else ''}layout (location=0) out vec4 outColor;
${'layout (location=0) in flat ' + t0 + ' inData0;\nlayout (set=0, binding=0, ' + layout + ') buffer VerificationBlock0 {\n    ' + t0 + ' value[];\n} verificationBuffer0;\n' if t0 else ''}${'layout (location=1) in flat ' + t1 + ' inData1;\nlayout (set=0, binding=1, ' + layout + ') buffer VerificationBlock1 {\n    ' + t1 + ' value[];\n} verificationBuffer1;\n' if t1 else ''}${'layout (location=2) in flat ' + t2 + ' inData2;\nlayout (set=0, binding=2, ' + layout + ') buffer VerificationBlock2 {\n    ' + t2 + ' value[];\n} verificationBuffer2;\n' if t2 else ''}void main (void) {
    outColor = vec4(0.0, 0.0, 1.0, 1.0);
    const int index = int(gl_FragCoord.x);
${'    verificationBuffer0.value[index] = inData0;\n' if t0 else ''}${'    verificationBuffer1.value[index] = inData1;\n' if t1 else ''}${'    verificationBuffer2.value[index] = inData2;\n' if t2 else ''}}
