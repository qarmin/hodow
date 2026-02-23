# OpenGL functions coverage summary

Total functions in registry: **3299**
- Supported (can be tested): **695** (21.1%)
- Unsupported (not in bindings): **2604** (78.9%)

Supported functions used at least once: **384/695** (55.3%)

# Supported functions

Functions that are available in the OpenGL bindings and can be tested.

## Version 1.0

- Supported: **48**
- Unsupported: **258**
- Used at least once: **40/48** (83.3%)

| Function name            | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------------ | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBlendFunc              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClear                  | x                  |                      | x                     |                         |                         | x                         |                    |                      | x                          |                       | x                         |                       | x                | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      | x                    |                    |                        | x                |
| glClearColor             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       | x                         |                       | x                | x                    |                  |                  |                   | x                       | x                | x                         |                                | x                            |                             |                      | x                    |                    |                        | x                |
| glClearDepth             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearStencil           | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorMask              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCullFace               | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDepthFunc              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDepthMask              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDepthRange             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDisable                | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDrawBuffer             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEnable                 | x                  | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFinish                 | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFlush                  |                    |                      | x                     |                         |                         | x                         |                    |                      | x                          |                       | x                         |                       | x                | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      | x                    |                    |                        | x                |
| glFrontFace              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetBooleanv            | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetDoublev             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetError               |                    |                      | x                     |                         |                         |                           |                    |                      |                            |                       |                           |                       | x                | x                    | x                |                  |                   |                         | x                |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetFloatv              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetIntegerv            | x                  |                      | x                     |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetString              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  | x                    |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexImage            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexLevelParameterfv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexLevelParameteriv |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexParameterfv      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexParameteriv      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glHint                   | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsEnabled              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glLineWidth              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glLogicOp                | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPixelStoref            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPixelStorei            | x                  |                      | x                     |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPointSize              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPolygonMode            | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glReadBuffer             | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glReadPixels             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       | x                         |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glScissor                | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glStencilFunc            | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glStencilMask            | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glStencilOp              | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexImage1D             |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexImage2D             |                    | x                    | x                     |                         |                         | x                         |                    |                      |                            |                       | x                         | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      | x                    | x                  | x                      |                  |
| glTexParameterf          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexParameterfv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexParameteri          |                    |                      | x                     | x                       |                         | x                         |                    |                      |                            |                       | x                         |                       | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      | x                    |                    |                        |                  |
| glTexParameteriv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glViewport               | x                  |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 1.1

- Supported: **14**
- Unsupported: **16**
- Used at least once: **13/14** (92.9%)

| Function name       | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindTexture       |                    | x                    | x                     | x                       | x                       | x                         |                    |                      |                            |                       | x                         | x                     | x                |                      |                  |                  | x                 |                         |                  |                           |                                |                              | x                           | x                    | x                    | x                  | x                      |                  |
| glCopyTexImage1D    |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTexImage2D    |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTexSubImage1D |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTexSubImage2D |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDeleteTextures    |                    | x                    | x                     | x                       | x                       | x                         |                    |                      |                            |                       | x                         | x                     | x                |                      |                  |                  | x                 |                         |                  |                           |                                |                              | x                           | x                    | x                    | x                  | x                      | x                |
| glDrawArrays        |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    | x                | x                |                   |                         |                  | x                         |                                | x                            |                             |                      |                      |                    |                        |                  |
| glDrawElements      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         | x                |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glGenTextures       |                    | x                    | x                     | x                       | x                       | x                         |                    |                      |                            |                       | x                         | x                     | x                |                      |                  |                  | x                 |                         |                  |                           |                                |                              | x                           | x                    | x                    | x                  | x                      |                  |
| glGetPointerv       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsTexture         |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPolygonOffset     |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexSubImage1D     |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexSubImage2D     |                    | x                    |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 1.2

- Supported: **4**
- Unsupported: **0**
- Used at least once: **4/4** (100.0%)

| Function name       | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glCopyTexSubImage3D |                    |                      |                       | x                       |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDrawRangeElements |                    |                      |                       | x                       |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexImage3D        |                    |                      |                       | x                       |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexSubImage3D     |                    |                      |                       | x                       |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 1.3

- Supported: **9**
- Unsupported: **37**
- Used at least once: **9/9** (100.0%)

| Function name             | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glActiveTexture           |                    |                      |                       |                         |                         | x                         |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      | x                    |                    |                        |                  |
| glCompressedTexImage1D    |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTexImage2D    |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTexImage3D    |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTexSubImage1D |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTexSubImage2D |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTexSubImage3D |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetCompressedTexImage   |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSampleCoverage          |                    |                      |                       |                         | x                       |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 1.4

- Supported: **9**
- Unsupported: **38**
- Used at least once: **9/9** (100.0%)

| Function name       | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBlendColor        |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBlendEquation     |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBlendFuncSeparate |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiDrawArrays   |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiDrawElements |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPointParameterf   |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPointParameterfv  |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPointParameteri   |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPointParameteriv  |                    |                      |                       |                         |                         |                           | x                  |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 1.5

- Supported: **19**
- Unsupported: **0**
- Used at least once: **19/19** (100.0%)

| Function name          | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ---------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBeginQuery           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindBuffer           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       | x                         | x                     |                  | x                    | x                | x                | x                 | x                       | x                | x                         | x                              | x                            | x                           | x                    |                      | x                  | x                      |                  |
| glBufferData           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       | x                         | x                     |                  | x                    | x                | x                | x                 | x                       | x                | x                         | x                              | x                            | x                           | x                    |                      | x                  |                        |                  |
| glBufferSubData        |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      | x                | x                |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDeleteBuffers        |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       | x                         | x                     |                  | x                    | x                | x                | x                 | x                       | x                | x                         | x                              | x                            | x                           | x                    |                      | x                  | x                      | x                |
| glDeleteQueries        |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           | x                     |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glEndQuery             |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenBuffers           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       | x                         | x                     |                  | x                    | x                | x                | x                 | x                       | x                | x                         | x                              | x                            | x                           | x                    |                      | x                  | x                      |                  |
| glGenQueries           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           | x                     |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glGetBufferParameteriv |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      | x                |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetBufferPointerv    |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetBufferSubData     |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glGetQueryiv           |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryObjectiv     |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryObjectuiv    |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsBuffer             |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsQuery              |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMapBuffer            |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUnmapBuffer          |                    |                      |                       |                         |                         |                           |                    | x                    |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 2.0

- Supported: **93**
- Unsupported: **0**
- Used at least once: **39/93** (41.9%)

| Function name              | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| -------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glAttachShader             |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glBindAttribLocation       |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBlendEquationSeparate    |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompileShader            |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glCreateProgram            |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glCreateShader             |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glDeleteProgram            |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              | x                            | x                           |                      | x                    | x                  |                        | x                |
| glDeleteShader             |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glDetachShader             |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glDisableVertexAttribArray |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    |                  | x                |                   |                         |                  | x                         |                                | x                            |                             |                      |                      |                    |                        |                  |
| glDrawBuffers              |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEnableVertexAttribArray  |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetActiveAttrib          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveUniform         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetAttachedShaders       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetAttribLocation        |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    | x                | x                |                   |                         |                  | x                         |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramInfoLog        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  | x                    |                  |                  |                   |                         | x                |                           |                                |                              |                             |                      | x                    |                    |                        |                  |
| glGetProgramiv             |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    |                  |                  |                   |                         | x                |                           |                                | x                            | x                           |                      | x                    |                    |                        |                  |
| glGetShaderInfoLog         |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    |                  |                  |                   |                         | x                |                           |                                |                              |                             |                      | x                    |                    |                        |                  |
| glGetShaderiv              |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    |                  |                  |                   |                         | x                |                           |                                |                              | x                           |                      | x                    |                    |                        |                  |
| glGetShaderSource          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformfv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformiv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformLocation       |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribdv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribfv        |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribiv        |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribPointerv  |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsProgram                |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsShader                 |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glLinkProgram              |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glShaderSource             |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    | x                  |                        | x                |
| glStencilFuncSeparate      |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glStencilMaskSeparate      |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glStencilOpSeparate        |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1f                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1fv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1i                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1iv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2f                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2fv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2i                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2iv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3f                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3fv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3i                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3iv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4f                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4fv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4i                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4iv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix2fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUseProgram               |                    |                      |                       |                         |                         |                           |                    |                      | x                          | x                     |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         | x                              |                              | x                           |                      | x                    |                    |                        | x                |
| glValidateProgram          |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1f           |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1fv          |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1s           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib1sv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2f           |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2fv          |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2s           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib2sv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3f           |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3fv          |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3s           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib3sv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4bv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4f           |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4fv          |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4iv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nbv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Niv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nsv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nub         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nubv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nuiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4Nusv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4s           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4sv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4ubv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4uiv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttrib4usv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribPointer      |                    |                      |                       |                         |                         |                           |                    |                      | x                          |                       |                           |                       |                  | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      |                      |                    |                        |                  |

## Version 2.1

- Supported: **6**
- Unsupported: **0**
- Used at least once: **6/6** (100.0%)

| Function name        | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| -------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glUniformMatrix2x3fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix2x4fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3x2fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3x4fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4x2fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4x3fv |                    |                      |                       |                         |                         |                           |                    |                      |                            | x                     |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 3.0

- Supported: **84**
- Unsupported: **0**
- Used at least once: **70/84** (83.3%)

| Function name                         | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBeginConditionalRender              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBeginTransformFeedback              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindBufferBase                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  | x                |                   |                         |                  |                           | x                              |                              | x                           | x                    |                      |                    |                        |                  |
| glBindBufferRange                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindFragDataLocation                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindFramebuffer                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glBindRenderbuffer                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindVertexArray                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      |                      |                    |                        | x                |
| glBlitFramebuffer                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCheckFramebufferStatus              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClampColor                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearBufferfi                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearBufferfv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearBufferiv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearBufferuiv                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorMaski                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDeleteFramebuffers                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        | x                |
| glDeleteRenderbuffers                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glDeleteVertexArrays                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      |                      |                    |                        | x                |
| glDisablei                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEnablei                             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEndConditionalRender                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEndTransformFeedback                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFlushMappedBufferRange              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferRenderbuffer             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferTexture1D                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferTexture2D                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferTexture3D                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferTextureLayer             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenerateMipmap                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenFramebuffers                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGenRenderbuffers                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenVertexArrays                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  | x                    | x                | x                |                   | x                       | x                | x                         |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetBooleani_v                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetFragDataLocation                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetFramebufferAttachmentParameteriv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetIntegeri_v                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetRenderbufferParameteriv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetStringi                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexParameterIiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTexParameterIuiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTransformFeedbackVarying         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformuiv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribIiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribIuiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsEnabledi                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsFramebuffer                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsRenderbuffer                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsVertexArray                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMapBufferRange                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glRenderbufferStorage                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     | x                |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glRenderbufferStorageMultisample      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexParameterIiv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexParameterIuiv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTransformFeedbackVaryings           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1ui                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1uiv                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2ui                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2uiv                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3ui                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3uiv                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4ui                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4uiv                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI1i                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI1iv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI1ui                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI1uiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI2i                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI2iv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI2ui                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI2uiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI3i                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI3iv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI3ui                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI3uiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4bv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4i                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4iv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4sv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4ubv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4ui                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4uiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribI4usv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribIPointer                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           | x                     |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 3.1

- Supported: **12**
- Unsupported: **0**
- Used at least once: **5/12** (41.7%)

| Function name               | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| --------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glCopyBufferSubData         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDrawArraysInstanced       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDrawElementsInstanced     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveUniformBlockiv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveUniformBlockName |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveUniformName      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveUniformsiv       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformBlockIndex      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  | x                |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformIndices         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPrimitiveRestartIndex     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexBuffer                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glUniformBlockBinding       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  | x                |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 3.2

- Supported: **19**
- Unsupported: **0**
- Used at least once: **17/19** (89.5%)

| Function name                     | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| --------------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glClientWaitSync                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDeleteSync                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDrawElementsBaseVertex          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glDrawElementsInstancedBaseVertex |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glDrawRangeElementsBaseVertex     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFenceSync                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferTexture              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetBufferParameteri64v          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetInteger64i_v                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetInteger64v                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetMultisamplefv                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetSynciv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsSync                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiDrawElementsBaseVertex     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProvokingVertex                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSampleMaski                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexImage2DMultisample           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexImage3DMultisample           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glWaitSync                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  | x                 |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 3.3

- Supported: **58**
- Unsupported: **0**
- Used at least once: **27/58** (46.6%)

| Function name                 | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ----------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindFragDataLocationIndexed |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glBindSampler                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorP3ui                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorP3uiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorP4ui                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glColorP4uiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDeleteSamplers              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glGenSamplers                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glGetFragDataIndex            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryObjecti64v          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glGetQueryObjectui64v         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glGetSamplerParameterfv       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetSamplerParameterIiv      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetSamplerParameterIuiv     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetSamplerParameteriv       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsSampler                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP1ui           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP1uiv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP2ui           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP2uiv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP3ui           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP3uiv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP4ui           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMultiTexCoordP4uiv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNormalP3ui                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNormalP3uiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glQueryCounter                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glSamplerParameterf           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSamplerParameterfv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSamplerParameteri           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSamplerParameterIiv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSamplerParameterIuiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSamplerParameteriv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSecondaryColorP3ui          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glSecondaryColorP3uiv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP1ui                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP1uiv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP2ui                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP2uiv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP3ui                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP3uiv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP4ui                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTexCoordP4uiv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribDivisor         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP1ui            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP1uiv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP2ui            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP2uiv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP3ui            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP3uiv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP4ui            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribP4uiv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   | x                       |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP2ui                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP2uiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP3ui                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP3uiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP4ui                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexP4uiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 4.0

- Supported: **46**
- Unsupported: **0**
- Used at least once: **26/46** (56.5%)

| Function name                    | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| -------------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBeginQueryIndexed              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glBindTransformFeedback          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             | x                    |                      |                    |                        |                  |
| glBlendEquationi                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glBlendEquationSeparatei         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glBlendFunci                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glBlendFuncSeparatei             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glDeleteTransformFeedbacks       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             | x                    |                      |                    |                        |                  |
| glDrawArraysIndirect             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glDrawElementsIndirect           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glDrawTransformFeedback          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glDrawTransformFeedbackStream    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glEndQueryIndexed                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGenTransformFeedbacks          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             | x                    |                      |                    |                        |                  |
| glGetActiveSubroutineName        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveSubroutineUniformiv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetActiveSubroutineUniformName |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramStageiv              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryIndexediv              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetSubroutineIndex             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetSubroutineUniformLocation   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformdv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetUniformSubroutineuiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsTransformFeedback            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glMinSampleShading               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glPatchParameterfv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPatchParameteri                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  | x                         |                                |                              |                             |                      |                      |                    |                        |                  |
| glPauseTransformFeedback         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glResumeTransformFeedback        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |
| glUniform1d                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform1dv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2d                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform2dv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3d                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform3dv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4d                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniform4dv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix2dv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix2x3dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix2x4dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3dv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3x2dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix3x4dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4dv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4x2dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformMatrix4x3dv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUniformSubroutinesuiv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           | x                              |                              |                             |                      |                      |                    |                        |                  |

## Version 4.1

- Supported: **88**
- Unsupported: **0**
- Used at least once: **14/88** (15.9%)

| Function name               | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| --------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glActiveShaderProgram       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glBindProgramPipeline       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glClearDepthf               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glCreateShaderProgramv      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glDeleteProgramPipelines    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glDepthRangeArrayv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDepthRangef               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glDepthRangeIndexed         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenProgramPipelines       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetDoublei_v              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetFloati_v               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramBinary          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramPipelineInfoLog |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramPipelineiv      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetShaderPrecisionFormat  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glGetVertexAttribLdv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glIsProgramPipeline         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glProgramBinary             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramParameteri         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glProgramUniform1d          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1dv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1f          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1i          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1iv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1ui         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform1uiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2d          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2dv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2f          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2i          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2iv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2ui         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform2uiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3d          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3dv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3f          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3i          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3iv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3ui         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform3uiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4d          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4dv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4f          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4fv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4i          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4iv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4ui         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniform4uiv        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2dv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2fv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2x3dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2x3fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2x4dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix2x4fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3dv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3fv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3x2dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3x2fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3x4dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix3x4fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4dv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4fv   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4x2dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4x2fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4x3dv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glProgramUniformMatrix4x3fv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glReleaseShaderCompiler     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glScissorArrayv             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glScissorIndexed            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glScissorIndexedv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glShaderBinary              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUseProgramStages          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glValidateProgramPipeline   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            |                             |                      |                      |                    |                        |                  |
| glVertexAttribL1d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL1dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL2d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL2dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL3d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL3dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL4d           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribL4dv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribLPointer      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glViewportArrayv            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glViewportIndexedf          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glViewportIndexedfv         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

## Version 4.2

- Supported: **12**
- Unsupported: **0**
- Used at least once: **12/12** (100.0%)

| Function name                                 | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| --------------------------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindImageTexture                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      | x                    |                    |                        |                  |
| glDrawArraysInstancedBaseInstance             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glDrawElementsInstancedBaseInstance           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glDrawElementsInstancedBaseVertexBaseInstance |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glDrawTransformFeedbackInstanced              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glDrawTransformFeedbackStreamInstanced        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glGetActiveAtomicCounterBufferiv              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glGetInternalformativ                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glMemoryBarrier                               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                | x                            | x                           |                      | x                    |                    |                        | x                |
| glTexStorage1D                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |
| glTexStorage2D                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      |                      |                    |                        |                  |
| glTexStorage3D                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             | x                    |                      |                    |                        |                  |

## Version 4.3

- Supported: **43**
- Unsupported: **0**
- Used at least once: **34/43** (79.1%)

| Function name                     | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| --------------------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindVertexBuffer                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glClearBufferData                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glClearBufferSubData              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glCopyImageSubData                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glDebugMessageCallback            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glDebugMessageControl             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glDebugMessageInsert              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glDispatchCompute                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              | x                           |                      | x                    |                    |                        |                  |
| glDispatchComputeIndirect         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glFramebufferParameteri           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetDebugMessageLog              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetFramebufferParameteriv       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetInternalformati64v           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetObjectLabel                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetObjectPtrLabel               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetProgramInterfaceiv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetProgramResourceIndex         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetProgramResourceiv            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetProgramResourceLocation      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetProgramResourceLocationIndex |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glGetProgramResourceName          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glInvalidateBufferData            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glInvalidateBufferSubData         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glInvalidateFramebuffer           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glInvalidateSubFramebuffer        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glInvalidateTexImage              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glInvalidateTexSubImage           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glMultiDrawArraysIndirect         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glMultiDrawElementsIndirect       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glObjectLabel                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glObjectPtrLabel                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPopDebugGroup                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glPushDebugGroup                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glShaderStorageBlockBinding       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glTexBufferRange                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glTexStorage2DMultisample         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glTexStorage3DMultisample         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glTextureView                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexAttribBinding             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glVertexAttribFormat              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glVertexAttribIFormat             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glVertexAttribLFormat             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |
| glVertexBindingDivisor            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      | x                  |                        |                  |

## Version 4.4

- Supported: **9**
- Unsupported: **0**
- Used at least once: **9/9** (100.0%)

| Function name       | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------- | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindBuffersBase   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBindBuffersRange  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBindImageTextures |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBindSamplers      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBindTextures      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBindVertexBuffers |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glBufferStorage     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glClearTexImage     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |
| glClearTexSubImage  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    | x                      |                  |

## Version 4.5

- Supported: **122**
- Unsupported: **0**
- Used at least once: **31/122** (25.4%)

| Function name                              | State <br/> GL 1.0 | TexCopy <br/> GL 1.1 | Textures <br/> GL 1.1 | Textures3D <br/> GL 1.2 | Compressed <br/> GL 1.3 | Multitexture <br/> GL 1.3 | Blend <br/> GL 1.4 | Queries <br/> GL 1.5 | VertexAttribs <br/> GL 2.0 | Matrices <br/> GL 2.1 | PixelBuffers <br/> GL 2.1 | Advanced <br/> GL 3.0 | FBO <br/> GL 3.0 | Shaders <br/> GL 3.0 | VBO <br/> GL 3.0 | UBO <br/> GL 3.1 | Sync <br/> GL 3.2 | Instancing <br/> GL 3.3 | VAO <br/> GL 3.3 | Tessellation <br/> GL 4.0 | TransformFeedback <br/> GL 4.0 | ProgramPipeline <br/> GL 4.1 | ImageLoadStore <br/> GL 4.2 | Storage <br/> GL 4.2 | Compute <br/> GL 4.3 | Debug <br/> GL 4.3 | BatchBind <br/> GL 4.4 | DSA <br/> GL 4.5 |
| ------------------------------------------ | ------------------ | -------------------- | --------------------- | ----------------------- | ----------------------- | ------------------------- | ------------------ | -------------------- | -------------------------- | --------------------- | ------------------------- | --------------------- | ---------------- | -------------------- | ---------------- | ---------------- | ----------------- | ----------------------- | ---------------- | ------------------------- | ------------------------------ | ---------------------------- | --------------------------- | -------------------- | -------------------- | ------------------ | ---------------------- | ---------------- |
| glBindTextureUnit                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glBlitNamedFramebuffer                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCheckNamedFramebufferStatus              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glClearNamedBufferData                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearNamedBufferSubData                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearNamedFramebufferfi                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glClearNamedFramebufferfv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glClearNamedFramebufferiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClearNamedFramebufferuiv                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glClipControl                              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCompressedTextureSubImage1D              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTextureSubImage2D              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCompressedTextureSubImage3D              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyNamedBufferSubData                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTextureSubImage1D                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTextureSubImage2D                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCopyTextureSubImage3D                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCreateBuffers                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCreateFramebuffers                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCreateProgramPipelines                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCreateQueries                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCreateRenderbuffers                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCreateSamplers                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCreateTextures                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glCreateTransformFeedbacks                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glCreateVertexArrays                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glDisableVertexArrayAttrib                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glEnableVertexArrayAttrib                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glFlushMappedNamedBufferRange              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGenerateTextureMipmap                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glGetCompressedTextureImage                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetCompressedTextureSubImage             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetGraphicsResetStatus                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glGetNamedBufferParameteri64v              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedBufferParameteriv                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedBufferPointerv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedBufferSubData                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedFramebufferAttachmentParameteriv |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedFramebufferParameteriv           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetNamedRenderbufferParameteriv          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnColorTable                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnCompressedTexImage                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnConvolutionFilter                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnHistogram                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnMapdv                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnMapfv                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnMapiv                                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnMinmax                               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnPixelMapfv                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnPixelMapuiv                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnPixelMapusv                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnPolygonStipple                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnSeparableFilter                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnTexImage                             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnUniformdv                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnUniformfv                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnUniformiv                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetnUniformuiv                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryBufferObjecti64v                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryBufferObjectiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryBufferObjectui64v                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetQueryBufferObjectuiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureImage                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureLevelParameterfv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureLevelParameteriv               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureParameterfv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureParameterIiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureParameterIuiv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureParameteriv                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTextureSubImage                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTransformFeedbacki64_v                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTransformFeedbacki_v                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetTransformFeedbackiv                   |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexArrayIndexed64iv                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexArrayIndexediv                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glGetVertexArrayiv                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glInvalidateNamedFramebufferData           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glInvalidateNamedFramebufferSubData        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMapNamedBuffer                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMapNamedBufferRange                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glMemoryBarrierByRegion                    |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNamedBufferData                          |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedBufferStorage                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedBufferSubData                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNamedFramebufferDrawBuffer               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedFramebufferDrawBuffers              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedFramebufferParameteri               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNamedFramebufferReadBuffer               |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedFramebufferRenderbuffer             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedFramebufferTexture                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedFramebufferTextureLayer             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glNamedRenderbufferStorage                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glNamedRenderbufferStorageMultisample      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glReadnPixels                              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureBarrier                           |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glTextureBuffer                            |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureBufferRange                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureParameterf                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureParameterfv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureParameteri                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glTextureParameterIiv                      |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureParameterIuiv                     |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureParameteriv                       |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureStorage1D                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureStorage2D                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glTextureStorage2DMultisample              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureStorage3D                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureStorage3DMultisample              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureSubImage1D                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTextureSubImage2D                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glTextureSubImage3D                        |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTransformFeedbackBufferBase              |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glTransformFeedbackBufferRange             |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glUnmapNamedBuffer                         |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexArrayAttribBinding                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glVertexArrayAttribFormat                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glVertexArrayAttribIFormat                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexArrayAttribLFormat                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexArrayBindingDivisor                |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |
| glVertexArrayElementBuffer                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glVertexArrayVertexBuffer                  |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        | x                |
| glVertexArrayVertexBuffers                 |                    |                      |                       |                         |                         |                           |                    |                      |                            |                       |                           |                       |                  |                      |                  |                  |                   |                         |                  |                           |                                |                              |                             |                      |                      |                    |                        |                  |

# Unsupported functions

Functions that are NOT available in the OpenGL bindings and cannot be tested.
Grouped by vendor suffix.

## core (435 functions)

### Version 1.0 (258 functions)

- `glAccum`
- `glAlphaFunc`
- `glBegin`
- `glBitmap`
- `glCallList`
- `glCallLists`
- `glClearAccum`
- `glClearIndex`
- `glClipPlane`
- `glColor3b`
- `glColor3bv`
- `glColor3d`
- `glColor3dv`
- `glColor3f`
- `glColor3fv`
- `glColor3i`
- `glColor3iv`
- `glColor3s`
- `glColor3sv`
- `glColor3ub`
- `glColor3ubv`
- `glColor3ui`
- `glColor3uiv`
- `glColor3us`
- `glColor3usv`
- `glColor4b`
- `glColor4bv`
- `glColor4d`
- `glColor4dv`
- `glColor4f`
- `glColor4fv`
- `glColor4i`
- `glColor4iv`
- `glColor4s`
- `glColor4sv`
- `glColor4ub`
- `glColor4ubv`
- `glColor4ui`
- `glColor4uiv`
- `glColor4us`
- `glColor4usv`
- `glColorMaterial`
- `glCopyPixels`
- `glDeleteLists`
- `glDrawPixels`
- `glEdgeFlag`
- `glEdgeFlagv`
- `glEnd`
- `glEndList`
- `glEvalCoord1d`
- `glEvalCoord1dv`
- `glEvalCoord1f`
- `glEvalCoord1fv`
- `glEvalCoord2d`
- `glEvalCoord2dv`
- `glEvalCoord2f`
- `glEvalCoord2fv`
- `glEvalMesh1`
- `glEvalMesh2`
- `glEvalPoint1`
- `glEvalPoint2`
- `glFeedbackBuffer`
- `glFogf`
- `glFogfv`
- `glFogi`
- `glFogiv`
- `glFrustum`
- `glGenLists`
- `glGetClipPlane`
- `glGetLightfv`
- `glGetLightiv`
- `glGetMapdv`
- `glGetMapfv`
- `glGetMapiv`
- `glGetMaterialfv`
- `glGetMaterialiv`
- `glGetPixelMapfv`
- `glGetPixelMapuiv`
- `glGetPixelMapusv`
- `glGetPolygonStipple`
- `glGetTexEnvfv`
- `glGetTexEnviv`
- `glGetTexGendv`
- `glGetTexGenfv`
- `glGetTexGeniv`
- `glIndexd`
- `glIndexdv`
- `glIndexf`
- `glIndexfv`
- `glIndexi`
- `glIndexiv`
- `glIndexMask`
- `glIndexs`
- `glIndexsv`
- `glInitNames`
- `glIsList`
- `glLightf`
- `glLightfv`
- `glLighti`
- `glLightiv`
- `glLightModelf`
- `glLightModelfv`
- `glLightModeli`
- `glLightModeliv`
- `glLineStipple`
- `glListBase`
- `glLoadIdentity`
- `glLoadMatrixd`
- `glLoadMatrixf`
- `glLoadName`
- `glMap1d`
- `glMap1f`
- `glMap2d`
- `glMap2f`
- `glMapGrid1d`
- `glMapGrid1f`
- `glMapGrid2d`
- `glMapGrid2f`
- `glMaterialf`
- `glMaterialfv`
- `glMateriali`
- `glMaterialiv`
- `glMatrixMode`
- `glMultMatrixd`
- `glMultMatrixf`
- `glNewList`
- `glNormal3b`
- `glNormal3bv`
- `glNormal3d`
- `glNormal3dv`
- `glNormal3f`
- `glNormal3fv`
- `glNormal3i`
- `glNormal3iv`
- `glNormal3s`
- `glNormal3sv`
- `glOrtho`
- `glPassThrough`
- `glPixelMapfv`
- `glPixelMapuiv`
- `glPixelMapusv`
- `glPixelTransferf`
- `glPixelTransferi`
- `glPixelZoom`
- `glPolygonStipple`
- `glPopAttrib`
- `glPopMatrix`
- `glPopName`
- `glPushAttrib`
- `glPushMatrix`
- `glPushName`
- `glRasterPos2d`
- `glRasterPos2dv`
- `glRasterPos2f`
- `glRasterPos2fv`
- `glRasterPos2i`
- `glRasterPos2iv`
- `glRasterPos2s`
- `glRasterPos2sv`
- `glRasterPos3d`
- `glRasterPos3dv`
- `glRasterPos3f`
- `glRasterPos3fv`
- `glRasterPos3i`
- `glRasterPos3iv`
- `glRasterPos3s`
- `glRasterPos3sv`
- `glRasterPos4d`
- `glRasterPos4dv`
- `glRasterPos4f`
- `glRasterPos4fv`
- `glRasterPos4i`
- `glRasterPos4iv`
- `glRasterPos4s`
- `glRasterPos4sv`
- `glRectd`
- `glRectdv`
- `glRectf`
- `glRectfv`
- `glRecti`
- `glRectiv`
- `glRects`
- `glRectsv`
- `glRenderMode`
- `glRotated`
- `glRotatef`
- `glScaled`
- `glScalef`
- `glSelectBuffer`
- `glShadeModel`
- `glTexCoord1d`
- `glTexCoord1dv`
- `glTexCoord1f`
- `glTexCoord1fv`
- `glTexCoord1i`
- `glTexCoord1iv`
- `glTexCoord1s`
- `glTexCoord1sv`
- `glTexCoord2d`
- `glTexCoord2dv`
- `glTexCoord2f`
- `glTexCoord2fv`
- `glTexCoord2i`
- `glTexCoord2iv`
- `glTexCoord2s`
- `glTexCoord2sv`
- `glTexCoord3d`
- `glTexCoord3dv`
- `glTexCoord3f`
- `glTexCoord3fv`
- `glTexCoord3i`
- `glTexCoord3iv`
- `glTexCoord3s`
- `glTexCoord3sv`
- `glTexCoord4d`
- `glTexCoord4dv`
- `glTexCoord4f`
- `glTexCoord4fv`
- `glTexCoord4i`
- `glTexCoord4iv`
- `glTexCoord4s`
- `glTexCoord4sv`
- `glTexEnvf`
- `glTexEnvfv`
- `glTexEnvi`
- `glTexEnviv`
- `glTexGend`
- `glTexGendv`
- `glTexGenf`
- `glTexGenfv`
- `glTexGeni`
- `glTexGeniv`
- `glTranslated`
- `glTranslatef`
- `glVertex2d`
- `glVertex2dv`
- `glVertex2f`
- `glVertex2fv`
- `glVertex2i`
- `glVertex2iv`
- `glVertex2s`
- `glVertex2sv`
- `glVertex3d`
- `glVertex3dv`
- `glVertex3f`
- `glVertex3fv`
- `glVertex3i`
- `glVertex3iv`
- `glVertex3s`
- `glVertex3sv`
- `glVertex4d`
- `glVertex4dv`
- `glVertex4f`
- `glVertex4fv`
- `glVertex4i`
- `glVertex4iv`
- `glVertex4s`
- `glVertex4sv`

### Version 1.1 (16 functions)

- `glAreTexturesResident`
- `glArrayElement`
- `glColorPointer`
- `glDisableClientState`
- `glEdgeFlagPointer`
- `glEnableClientState`
- `glIndexPointer`
- `glIndexub`
- `glIndexubv`
- `glInterleavedArrays`
- `glNormalPointer`
- `glPopClientAttrib`
- `glPrioritizeTextures`
- `glPushClientAttrib`
- `glTexCoordPointer`
- `glVertexPointer`

### Version 1.3 (37 functions)

- `glClientActiveTexture`
- `glLoadTransposeMatrixd`
- `glLoadTransposeMatrixf`
- `glMultiTexCoord1d`
- `glMultiTexCoord1dv`
- `glMultiTexCoord1f`
- `glMultiTexCoord1fv`
- `glMultiTexCoord1i`
- `glMultiTexCoord1iv`
- `glMultiTexCoord1s`
- `glMultiTexCoord1sv`
- `glMultiTexCoord2d`
- `glMultiTexCoord2dv`
- `glMultiTexCoord2f`
- `glMultiTexCoord2fv`
- `glMultiTexCoord2i`
- `glMultiTexCoord2iv`
- `glMultiTexCoord2s`
- `glMultiTexCoord2sv`
- `glMultiTexCoord3d`
- `glMultiTexCoord3dv`
- `glMultiTexCoord3f`
- `glMultiTexCoord3fv`
- `glMultiTexCoord3i`
- `glMultiTexCoord3iv`
- `glMultiTexCoord3s`
- `glMultiTexCoord3sv`
- `glMultiTexCoord4d`
- `glMultiTexCoord4dv`
- `glMultiTexCoord4f`
- `glMultiTexCoord4fv`
- `glMultiTexCoord4i`
- `glMultiTexCoord4iv`
- `glMultiTexCoord4s`
- `glMultiTexCoord4sv`
- `glMultTransposeMatrixd`
- `glMultTransposeMatrixf`

### Version 1.4 (38 functions)

- `glFogCoordd`
- `glFogCoorddv`
- `glFogCoordf`
- `glFogCoordfv`
- `glFogCoordPointer`
- `glSecondaryColor3b`
- `glSecondaryColor3bv`
- `glSecondaryColor3d`
- `glSecondaryColor3dv`
- `glSecondaryColor3f`
- `glSecondaryColor3fv`
- `glSecondaryColor3i`
- `glSecondaryColor3iv`
- `glSecondaryColor3s`
- `glSecondaryColor3sv`
- `glSecondaryColor3ub`
- `glSecondaryColor3ubv`
- `glSecondaryColor3ui`
- `glSecondaryColor3uiv`
- `glSecondaryColor3us`
- `glSecondaryColor3usv`
- `glSecondaryColorPointer`
- `glWindowPos2d`
- `glWindowPos2dv`
- `glWindowPos2f`
- `glWindowPos2fv`
- `glWindowPos2i`
- `glWindowPos2iv`
- `glWindowPos2s`
- `glWindowPos2sv`
- `glWindowPos3d`
- `glWindowPos3dv`
- `glWindowPos3f`
- `glWindowPos3fv`
- `glWindowPos3i`
- `glWindowPos3iv`
- `glWindowPos3s`
- `glWindowPos3sv`

### Version 4.6 (4 functions)

- `glMultiDrawArraysIndirectCount`
- `glMultiDrawElementsIndirectCount`
- `glPolygonOffsetClamp`
- `glSpecializeShader`

### Version extension-only (82 functions)

- `glAlphaFuncx`
- `glBlendBarrier`
- `glClearColorx`
- `glClearDepthx`
- `glClipPlanef`
- `glClipPlanex`
- `glColor4x`
- `glColorSubTable`
- `glColorTable`
- `glColorTableParameterfv`
- `glColorTableParameteriv`
- `glConvolutionFilter1D`
- `glConvolutionFilter2D`
- `glConvolutionParameterf`
- `glConvolutionParameterfv`
- `glConvolutionParameteri`
- `glConvolutionParameteriv`
- `glCopyColorSubTable`
- `glCopyColorTable`
- `glCopyConvolutionFilter1D`
- `glCopyConvolutionFilter2D`
- `glDepthRangex`
- `glFinishTextureSUNX`
- `glFogx`
- `glFogxv`
- `glFrustumf`
- `glFrustumx`
- `glGetClipPlanef`
- `glGetClipPlanex`
- `glGetColorTable`
- `glGetColorTableParameterfv`
- `glGetColorTableParameteriv`
- `glGetConvolutionFilter`
- `glGetConvolutionParameterfv`
- `glGetConvolutionParameteriv`
- `glGetFixedv`
- `glGetHistogram`
- `glGetHistogramParameterfv`
- `glGetHistogramParameteriv`
- `glGetLightxv`
- `glGetMaterialxv`
- `glGetMinmax`
- `glGetMinmaxParameterfv`
- `glGetMinmaxParameteriv`
- `glGetPixelMapxv`
- `glGetSeparableFilter`
- `glGetTexEnvxv`
- `glGetTexParameterxv`
- `glHistogram`
- `glLightModelx`
- `glLightModelxv`
- `glLightx`
- `glLightxv`
- `glLineWidthx`
- `glLoadMatrixx`
- `glMaterialx`
- `glMaterialxv`
- `glMaxActiveShaderCoresARM`
- `glMinmax`
- `glMultiTexCoord4x`
- `glMultMatrixx`
- `glNormal3x`
- `glOrthof`
- `glOrthox`
- `glPixelMapx`
- `glPixelStorex`
- `glPointParameterx`
- `glPointParameterxv`
- `glPointSizex`
- `glPolygonOffsetx`
- `glPrimitiveBoundingBox`
- `glResetHistogram`
- `glResetMinmax`
- `glRotatex`
- `glSampleCoveragex`
- `glScalex`
- `glSeparableFilter2D`
- `glTexEnvx`
- `glTexEnvxv`
- `glTexParameterx`
- `glTexParameterxv`
- `glTranslatex`

## 3DFX (1 functions)

### Version extension-only (1 functions)

- `glTbufferMask3DFX`

## AMD (38 functions)

### Version extension-only (38 functions)

- `glBeginPerfMonitorAMD`
- `glBlendEquationIndexedAMD`
- `glBlendEquationSeparateIndexedAMD`
- `glBlendFuncIndexedAMD`
- `glBlendFuncSeparateIndexedAMD`
- `glDebugMessageCallbackAMD`
- `glDebugMessageEnableAMD`
- `glDebugMessageInsertAMD`
- `glDeleteNamesAMD`
- `glDeletePerfMonitorsAMD`
- `glEndPerfMonitorAMD`
- `glFramebufferSamplePositionsfvAMD`
- `glGenNamesAMD`
- `glGenPerfMonitorsAMD`
- `glGetDebugMessageLogAMD`
- `glGetFramebufferParameterfvAMD`
- `glGetNamedFramebufferParameterfvAMD`
- `glGetPerfMonitorCounterDataAMD`
- `glGetPerfMonitorCounterInfoAMD`
- `glGetPerfMonitorCountersAMD`
- `glGetPerfMonitorCounterStringAMD`
- `glGetPerfMonitorGroupsAMD`
- `glGetPerfMonitorGroupStringAMD`
- `glIsNameAMD`
- `glMultiDrawArraysIndirectAMD`
- `glMultiDrawElementsIndirectAMD`
- `glNamedFramebufferSamplePositionsfvAMD`
- `glNamedRenderbufferStorageMultisampleAdvancedAMD`
- `glQueryObjectParameteruiAMD`
- `glRenderbufferStorageMultisampleAdvancedAMD`
- `glSelectPerfMonitorCountersAMD`
- `glSetMultisamplefvAMD`
- `glStencilOpValueAMD`
- `glTessellationFactorAMD`
- `glTessellationModeAMD`
- `glTexStorageSparseAMD`
- `glTextureStorageSparseAMD`
- `glVertexAttribParameteriAMD`

## ANGLE (6 functions)

### Version extension-only (6 functions)

- `glBlitFramebufferANGLE`
- `glDrawArraysInstancedANGLE`
- `glDrawElementsInstancedANGLE`
- `glGetTranslatedShaderSourceANGLE`
- `glRenderbufferStorageMultisampleANGLE`
- `glVertexAttribDivisorANGLE`

## APPLE (44 functions)

### Version extension-only (44 functions)

- `glBindVertexArrayAPPLE`
- `glBufferParameteriAPPLE`
- `glClientWaitSyncAPPLE`
- `glCopyTextureLevelsAPPLE`
- `glDeleteFencesAPPLE`
- `glDeleteSyncAPPLE`
- `glDeleteVertexArraysAPPLE`
- `glDisableVertexAttribAPPLE`
- `glDrawElementArrayAPPLE`
- `glDrawRangeElementArrayAPPLE`
- `glElementPointerAPPLE`
- `glEnableVertexAttribAPPLE`
- `glFenceSyncAPPLE`
- `glFinishFenceAPPLE`
- `glFinishObjectAPPLE`
- `glFlushMappedBufferRangeAPPLE`
- `glFlushVertexArrayRangeAPPLE`
- `glGenFencesAPPLE`
- `glGenVertexArraysAPPLE`
- `glGetInteger64vAPPLE`
- `glGetObjectParameterivAPPLE`
- `glGetSyncivAPPLE`
- `glGetTexParameterPointervAPPLE`
- `glIsFenceAPPLE`
- `glIsSyncAPPLE`
- `glIsVertexArrayAPPLE`
- `glIsVertexAttribEnabledAPPLE`
- `glMapVertexAttrib1dAPPLE`
- `glMapVertexAttrib1fAPPLE`
- `glMapVertexAttrib2dAPPLE`
- `glMapVertexAttrib2fAPPLE`
- `glMultiDrawElementArrayAPPLE`
- `glMultiDrawRangeElementArrayAPPLE`
- `glObjectPurgeableAPPLE`
- `glObjectUnpurgeableAPPLE`
- `glRenderbufferStorageMultisampleAPPLE`
- `glResolveMultisampleFramebufferAPPLE`
- `glSetFenceAPPLE`
- `glTestFenceAPPLE`
- `glTestObjectAPPLE`
- `glTextureRangeAPPLE`
- `glVertexArrayParameteriAPPLE`
- `glVertexArrayRangeAPPLE`
- `glWaitSyncAPPLE`

## ARB (312 functions)

### Version extension-only (312 functions)

- `glActiveTextureARB`
- `glAttachObjectARB`
- `glBeginQueryARB`
- `glBindAttribLocationARB`
- `glBindBufferARB`
- `glBindProgramARB`
- `glBlendEquationiARB`
- `glBlendEquationSeparateiARB`
- `glBlendFunciARB`
- `glBlendFuncSeparateiARB`
- `glBufferDataARB`
- `glBufferPageCommitmentARB`
- `glBufferSubDataARB`
- `glClampColorARB`
- `glClientActiveTextureARB`
- `glCompileShaderARB`
- `glCompileShaderIncludeARB`
- `glCompressedTexImage1DARB`
- `glCompressedTexImage2DARB`
- `glCompressedTexImage3DARB`
- `glCompressedTexSubImage1DARB`
- `glCompressedTexSubImage2DARB`
- `glCompressedTexSubImage3DARB`
- `glCreateProgramObjectARB`
- `glCreateShaderObjectARB`
- `glCreateSyncFromCLeventARB`
- `glCurrentPaletteMatrixARB`
- `glDebugMessageCallbackARB`
- `glDebugMessageControlARB`
- `glDebugMessageInsertARB`
- `glDeleteBuffersARB`
- `glDeleteNamedStringARB`
- `glDeleteObjectARB`
- `glDeleteProgramsARB`
- `glDeleteQueriesARB`
- `glDetachObjectARB`
- `glDisableVertexAttribArrayARB`
- `glDispatchComputeGroupSizeARB`
- `glDrawArraysInstancedARB`
- `glDrawBuffersARB`
- `glDrawElementsInstancedARB`
- `glEnableVertexAttribArrayARB`
- `glEndQueryARB`
- `glEvaluateDepthValuesARB`
- `glFramebufferSampleLocationsfvARB`
- `glFramebufferTextureARB`
- `glFramebufferTextureFaceARB`
- `glFramebufferTextureLayerARB`
- `glGenBuffersARB`
- `glGenProgramsARB`
- `glGenQueriesARB`
- `glGetActiveAttribARB`
- `glGetActiveUniformARB`
- `glGetAttachedObjectsARB`
- `glGetAttribLocationARB`
- `glGetBufferParameterivARB`
- `glGetBufferPointervARB`
- `glGetBufferSubDataARB`
- `glGetCompressedTexImageARB`
- `glGetDebugMessageLogARB`
- `glGetGraphicsResetStatusARB`
- `glGetHandleARB`
- `glGetImageHandleARB`
- `glGetInfoLogARB`
- `glGetNamedStringARB`
- `glGetNamedStringivARB`
- `glGetnColorTableARB`
- `glGetnCompressedTexImageARB`
- `glGetnConvolutionFilterARB`
- `glGetnHistogramARB`
- `glGetnMapdvARB`
- `glGetnMapfvARB`
- `glGetnMapivARB`
- `glGetnMinmaxARB`
- `glGetnPixelMapfvARB`
- `glGetnPixelMapuivARB`
- `glGetnPixelMapusvARB`
- `glGetnPolygonStippleARB`
- `glGetnSeparableFilterARB`
- `glGetnTexImageARB`
- `glGetnUniformdvARB`
- `glGetnUniformfvARB`
- `glGetnUniformi64vARB`
- `glGetnUniformivARB`
- `glGetnUniformui64vARB`
- `glGetnUniformuivARB`
- `glGetObjectParameterfvARB`
- `glGetObjectParameterivARB`
- `glGetProgramEnvParameterdvARB`
- `glGetProgramEnvParameterfvARB`
- `glGetProgramivARB`
- `glGetProgramLocalParameterdvARB`
- `glGetProgramLocalParameterfvARB`
- `glGetProgramStringARB`
- `glGetQueryivARB`
- `glGetQueryObjectivARB`
- `glGetQueryObjectuivARB`
- `glGetShaderSourceARB`
- `glGetTextureHandleARB`
- `glGetTextureSamplerHandleARB`
- `glGetUniformfvARB`
- `glGetUniformi64vARB`
- `glGetUniformivARB`
- `glGetUniformLocationARB`
- `glGetUniformui64vARB`
- `glGetVertexAttribdvARB`
- `glGetVertexAttribfvARB`
- `glGetVertexAttribivARB`
- `glGetVertexAttribLui64vARB`
- `glGetVertexAttribPointervARB`
- `glIsBufferARB`
- `glIsImageHandleResidentARB`
- `glIsNamedStringARB`
- `glIsProgramARB`
- `glIsQueryARB`
- `glIsTextureHandleResidentARB`
- `glLinkProgramARB`
- `glLoadTransposeMatrixdARB`
- `glLoadTransposeMatrixfARB`
- `glMakeImageHandleNonResidentARB`
- `glMakeImageHandleResidentARB`
- `glMakeTextureHandleNonResidentARB`
- `glMakeTextureHandleResidentARB`
- `glMapBufferARB`
- `glMatrixIndexPointerARB`
- `glMatrixIndexubvARB`
- `glMatrixIndexuivARB`
- `glMatrixIndexusvARB`
- `glMaxShaderCompilerThreadsARB`
- `glMinSampleShadingARB`
- `glMultiDrawArraysIndirectCountARB`
- `glMultiDrawElementsIndirectCountARB`
- `glMultiTexCoord1dARB`
- `glMultiTexCoord1dvARB`
- `glMultiTexCoord1fARB`
- `glMultiTexCoord1fvARB`
- `glMultiTexCoord1iARB`
- `glMultiTexCoord1ivARB`
- `glMultiTexCoord1sARB`
- `glMultiTexCoord1svARB`
- `glMultiTexCoord2dARB`
- `glMultiTexCoord2dvARB`
- `glMultiTexCoord2fARB`
- `glMultiTexCoord2fvARB`
- `glMultiTexCoord2iARB`
- `glMultiTexCoord2ivARB`
- `glMultiTexCoord2sARB`
- `glMultiTexCoord2svARB`
- `glMultiTexCoord3dARB`
- `glMultiTexCoord3dvARB`
- `glMultiTexCoord3fARB`
- `glMultiTexCoord3fvARB`
- `glMultiTexCoord3iARB`
- `glMultiTexCoord3ivARB`
- `glMultiTexCoord3sARB`
- `glMultiTexCoord3svARB`
- `glMultiTexCoord4dARB`
- `glMultiTexCoord4dvARB`
- `glMultiTexCoord4fARB`
- `glMultiTexCoord4fvARB`
- `glMultiTexCoord4iARB`
- `glMultiTexCoord4ivARB`
- `glMultiTexCoord4sARB`
- `glMultiTexCoord4svARB`
- `glMultTransposeMatrixdARB`
- `glMultTransposeMatrixfARB`
- `glNamedBufferPageCommitmentARB`
- `glNamedFramebufferSampleLocationsfvARB`
- `glNamedStringARB`
- `glPointParameterfARB`
- `glPointParameterfvARB`
- `glPrimitiveBoundingBoxARB`
- `glProgramEnvParameter4dARB`
- `glProgramEnvParameter4dvARB`
- `glProgramEnvParameter4fARB`
- `glProgramEnvParameter4fvARB`
- `glProgramLocalParameter4dARB`
- `glProgramLocalParameter4dvARB`
- `glProgramLocalParameter4fARB`
- `glProgramLocalParameter4fvARB`
- `glProgramParameteriARB`
- `glProgramStringARB`
- `glProgramUniform1i64ARB`
- `glProgramUniform1i64vARB`
- `glProgramUniform1ui64ARB`
- `glProgramUniform1ui64vARB`
- `glProgramUniform2i64ARB`
- `glProgramUniform2i64vARB`
- `glProgramUniform2ui64ARB`
- `glProgramUniform2ui64vARB`
- `glProgramUniform3i64ARB`
- `glProgramUniform3i64vARB`
- `glProgramUniform3ui64ARB`
- `glProgramUniform3ui64vARB`
- `glProgramUniform4i64ARB`
- `glProgramUniform4i64vARB`
- `glProgramUniform4ui64ARB`
- `glProgramUniform4ui64vARB`
- `glProgramUniformHandleui64ARB`
- `glProgramUniformHandleui64vARB`
- `glReadnPixelsARB`
- `glSampleCoverageARB`
- `glShaderSourceARB`
- `glSpecializeShaderARB`
- `glTexBufferARB`
- `glTexPageCommitmentARB`
- `glUniform1fARB`
- `glUniform1fvARB`
- `glUniform1i64ARB`
- `glUniform1i64vARB`
- `glUniform1iARB`
- `glUniform1ivARB`
- `glUniform1ui64ARB`
- `glUniform1ui64vARB`
- `glUniform2fARB`
- `glUniform2fvARB`
- `glUniform2i64ARB`
- `glUniform2i64vARB`
- `glUniform2iARB`
- `glUniform2ivARB`
- `glUniform2ui64ARB`
- `glUniform2ui64vARB`
- `glUniform3fARB`
- `glUniform3fvARB`
- `glUniform3i64ARB`
- `glUniform3i64vARB`
- `glUniform3iARB`
- `glUniform3ivARB`
- `glUniform3ui64ARB`
- `glUniform3ui64vARB`
- `glUniform4fARB`
- `glUniform4fvARB`
- `glUniform4i64ARB`
- `glUniform4i64vARB`
- `glUniform4iARB`
- `glUniform4ivARB`
- `glUniform4ui64ARB`
- `glUniform4ui64vARB`
- `glUniformHandleui64ARB`
- `glUniformHandleui64vARB`
- `glUniformMatrix2fvARB`
- `glUniformMatrix3fvARB`
- `glUniformMatrix4fvARB`
- `glUnmapBufferARB`
- `glUseProgramObjectARB`
- `glValidateProgramARB`
- `glVertexAttrib1dARB`
- `glVertexAttrib1dvARB`
- `glVertexAttrib1fARB`
- `glVertexAttrib1fvARB`
- `glVertexAttrib1sARB`
- `glVertexAttrib1svARB`
- `glVertexAttrib2dARB`
- `glVertexAttrib2dvARB`
- `glVertexAttrib2fARB`
- `glVertexAttrib2fvARB`
- `glVertexAttrib2sARB`
- `glVertexAttrib2svARB`
- `glVertexAttrib3dARB`
- `glVertexAttrib3dvARB`
- `glVertexAttrib3fARB`
- `glVertexAttrib3fvARB`
- `glVertexAttrib3sARB`
- `glVertexAttrib3svARB`
- `glVertexAttrib4bvARB`
- `glVertexAttrib4dARB`
- `glVertexAttrib4dvARB`
- `glVertexAttrib4fARB`
- `glVertexAttrib4fvARB`
- `glVertexAttrib4ivARB`
- `glVertexAttrib4NbvARB`
- `glVertexAttrib4NivARB`
- `glVertexAttrib4NsvARB`
- `glVertexAttrib4NubARB`
- `glVertexAttrib4NubvARB`
- `glVertexAttrib4NuivARB`
- `glVertexAttrib4NusvARB`
- `glVertexAttrib4sARB`
- `glVertexAttrib4svARB`
- `glVertexAttrib4ubvARB`
- `glVertexAttrib4uivARB`
- `glVertexAttrib4usvARB`
- `glVertexAttribDivisorARB`
- `glVertexAttribL1ui64ARB`
- `glVertexAttribL1ui64vARB`
- `glVertexAttribPointerARB`
- `glVertexBlendARB`
- `glWeightbvARB`
- `glWeightdvARB`
- `glWeightfvARB`
- `glWeightivARB`
- `glWeightPointerARB`
- `glWeightsvARB`
- `glWeightubvARB`
- `glWeightuivARB`
- `glWeightusvARB`
- `glWindowPos2dARB`
- `glWindowPos2dvARB`
- `glWindowPos2fARB`
- `glWindowPos2fvARB`
- `glWindowPos2iARB`
- `glWindowPos2ivARB`
- `glWindowPos2sARB`
- `glWindowPos2svARB`
- `glWindowPos3dARB`
- `glWindowPos3dvARB`
- `glWindowPos3fARB`
- `glWindowPos3fvARB`
- `glWindowPos3iARB`
- `glWindowPos3ivARB`
- `glWindowPos3sARB`
- `glWindowPos3svARB`

## ATI (88 functions)

### Version extension-only (88 functions)

- `glAlphaFragmentOp1ATI`
- `glAlphaFragmentOp2ATI`
- `glAlphaFragmentOp3ATI`
- `glArrayObjectATI`
- `glBeginFragmentShaderATI`
- `glBindFragmentShaderATI`
- `glClientActiveVertexStreamATI`
- `glColorFragmentOp1ATI`
- `glColorFragmentOp2ATI`
- `glColorFragmentOp3ATI`
- `glDeleteFragmentShaderATI`
- `glDrawBuffersATI`
- `glDrawElementArrayATI`
- `glDrawRangeElementArrayATI`
- `glElementPointerATI`
- `glEndFragmentShaderATI`
- `glFreeObjectBufferATI`
- `glGenFragmentShadersATI`
- `glGetArrayObjectfvATI`
- `glGetArrayObjectivATI`
- `glGetObjectBufferfvATI`
- `glGetObjectBufferivATI`
- `glGetTexBumpParameterfvATI`
- `glGetTexBumpParameterivATI`
- `glGetVariantArrayObjectfvATI`
- `glGetVariantArrayObjectivATI`
- `glGetVertexAttribArrayObjectfvATI`
- `glGetVertexAttribArrayObjectivATI`
- `glIsObjectBufferATI`
- `glMapObjectBufferATI`
- `glNewObjectBufferATI`
- `glNormalStream3bATI`
- `glNormalStream3bvATI`
- `glNormalStream3dATI`
- `glNormalStream3dvATI`
- `glNormalStream3fATI`
- `glNormalStream3fvATI`
- `glNormalStream3iATI`
- `glNormalStream3ivATI`
- `glNormalStream3sATI`
- `glNormalStream3svATI`
- `glPassTexCoordATI`
- `glPNTrianglesfATI`
- `glPNTrianglesiATI`
- `glSampleMapATI`
- `glSetFragmentShaderConstantATI`
- `glStencilFuncSeparateATI`
- `glStencilOpSeparateATI`
- `glTexBumpParameterfvATI`
- `glTexBumpParameterivATI`
- `glUnmapObjectBufferATI`
- `glUpdateObjectBufferATI`
- `glVariantArrayObjectATI`
- `glVertexAttribArrayObjectATI`
- `glVertexBlendEnvfATI`
- `glVertexBlendEnviATI`
- `glVertexStream1dATI`
- `glVertexStream1dvATI`
- `glVertexStream1fATI`
- `glVertexStream1fvATI`
- `glVertexStream1iATI`
- `glVertexStream1ivATI`
- `glVertexStream1sATI`
- `glVertexStream1svATI`
- `glVertexStream2dATI`
- `glVertexStream2dvATI`
- `glVertexStream2fATI`
- `glVertexStream2fvATI`
- `glVertexStream2iATI`
- `glVertexStream2ivATI`
- `glVertexStream2sATI`
- `glVertexStream2svATI`
- `glVertexStream3dATI`
- `glVertexStream3dvATI`
- `glVertexStream3fATI`
- `glVertexStream3fvATI`
- `glVertexStream3iATI`
- `glVertexStream3ivATI`
- `glVertexStream3sATI`
- `glVertexStream3svATI`
- `glVertexStream4dATI`
- `glVertexStream4dvATI`
- `glVertexStream4fATI`
- `glVertexStream4fvATI`
- `glVertexStream4iATI`
- `glVertexStream4ivATI`
- `glVertexStream4sATI`
- `glVertexStream4svATI`

## EXT (661 functions)

### Version extension-only (661 functions)

- `glAcquireKeyedMutexWin32EXT`
- `glActiveProgramEXT`
- `glActiveShaderProgramEXT`
- `glActiveStencilFaceEXT`
- `glApplyTextureEXT`
- `glAreTexturesResidentEXT`
- `glArrayElementEXT`
- `glBeginQueryEXT`
- `glBeginTransformFeedbackEXT`
- `glBeginVertexShaderEXT`
- `glBindBufferBaseEXT`
- `glBindBufferOffsetEXT`
- `glBindBufferRangeEXT`
- `glBindFragDataLocationEXT`
- `glBindFragDataLocationIndexedEXT`
- `glBindFramebufferEXT`
- `glBindImageTextureEXT`
- `glBindLightParameterEXT`
- `glBindMaterialParameterEXT`
- `glBindMultiTextureEXT`
- `glBindParameterEXT`
- `glBindProgramPipelineEXT`
- `glBindRenderbufferEXT`
- `glBindTexGenParameterEXT`
- `glBindTextureEXT`
- `glBindTextureUnitParameterEXT`
- `glBindVertexShaderEXT`
- `glBinormal3bEXT`
- `glBinormal3bvEXT`
- `glBinormal3dEXT`
- `glBinormal3dvEXT`
- `glBinormal3fEXT`
- `glBinormal3fvEXT`
- `glBinormal3iEXT`
- `glBinormal3ivEXT`
- `glBinormal3sEXT`
- `glBinormal3svEXT`
- `glBinormalPointerEXT`
- `glBlendColorEXT`
- `glBlendEquationEXT`
- `glBlendEquationiEXT`
- `glBlendEquationSeparateEXT`
- `glBlendEquationSeparateiEXT`
- `glBlendFunciEXT`
- `glBlendFuncSeparateEXT`
- `glBlendFuncSeparateiEXT`
- `glBlitFramebufferEXT`
- `glBlitFramebufferLayerEXT`
- `glBlitFramebufferLayersEXT`
- `glBufferStorageEXT`
- `glBufferStorageExternalEXT`
- `glBufferStorageMemEXT`
- `glCheckFramebufferStatusEXT`
- `glCheckNamedFramebufferStatusEXT`
- `glClearColorIiEXT`
- `glClearColorIuiEXT`
- `glClearNamedBufferDataEXT`
- `glClearNamedBufferSubDataEXT`
- `glClearPixelLocalStorageuiEXT`
- `glClearTexImageEXT`
- `glClearTexSubImageEXT`
- `glClientAttribDefaultEXT`
- `glClipControlEXT`
- `glColorMaskiEXT`
- `glColorMaskIndexedEXT`
- `glColorPointerEXT`
- `glColorSubTableEXT`
- `glColorTableEXT`
- `glCompressedMultiTexImage1DEXT`
- `glCompressedMultiTexImage2DEXT`
- `glCompressedMultiTexImage3DEXT`
- `glCompressedMultiTexSubImage1DEXT`
- `glCompressedMultiTexSubImage2DEXT`
- `glCompressedMultiTexSubImage3DEXT`
- `glCompressedTextureImage1DEXT`
- `glCompressedTextureImage2DEXT`
- `glCompressedTextureImage3DEXT`
- `glCompressedTextureSubImage1DEXT`
- `glCompressedTextureSubImage2DEXT`
- `glCompressedTextureSubImage3DEXT`
- `glConvolutionFilter1DEXT`
- `glConvolutionFilter2DEXT`
- `glConvolutionParameterfEXT`
- `glConvolutionParameterfvEXT`
- `glConvolutionParameteriEXT`
- `glConvolutionParameterivEXT`
- `glCopyColorSubTableEXT`
- `glCopyConvolutionFilter1DEXT`
- `glCopyConvolutionFilter2DEXT`
- `glCopyImageSubDataEXT`
- `glCopyMultiTexImage1DEXT`
- `glCopyMultiTexImage2DEXT`
- `glCopyMultiTexSubImage1DEXT`
- `glCopyMultiTexSubImage2DEXT`
- `glCopyMultiTexSubImage3DEXT`
- `glCopyTexImage1DEXT`
- `glCopyTexImage2DEXT`
- `glCopyTexSubImage1DEXT`
- `glCopyTexSubImage2DEXT`
- `glCopyTexSubImage3DEXT`
- `glCopyTextureImage1DEXT`
- `glCopyTextureImage2DEXT`
- `glCopyTextureSubImage1DEXT`
- `glCopyTextureSubImage2DEXT`
- `glCopyTextureSubImage3DEXT`
- `glCreateMemoryObjectsEXT`
- `glCreateShaderProgramEXT`
- `glCreateShaderProgramvEXT`
- `glCullParameterdvEXT`
- `glCullParameterfvEXT`
- `glDeleteFramebuffersEXT`
- `glDeleteMemoryObjectsEXT`
- `glDeleteProgramPipelinesEXT`
- `glDeleteQueriesEXT`
- `glDeleteRenderbuffersEXT`
- `glDeleteSemaphoresEXT`
- `glDeleteTexturesEXT`
- `glDeleteVertexShaderEXT`
- `glDepthBoundsEXT`
- `glDisableClientStateiEXT`
- `glDisableClientStateIndexedEXT`
- `glDisableiEXT`
- `glDisableIndexedEXT`
- `glDisableVariantClientStateEXT`
- `glDisableVertexArrayAttribEXT`
- `glDisableVertexArrayEXT`
- `glDiscardFramebufferEXT`
- `glDrawArraysEXT`
- `glDrawArraysInstancedBaseInstanceEXT`
- `glDrawArraysInstancedEXT`
- `glDrawBuffersEXT`
- `glDrawBuffersIndexedEXT`
- `glDrawElementsBaseVertexEXT`
- `glDrawElementsInstancedBaseInstanceEXT`
- `glDrawElementsInstancedBaseVertexBaseInstanceEXT`
- `glDrawElementsInstancedBaseVertexEXT`
- `glDrawElementsInstancedEXT`
- `glDrawMeshTasksEXT`
- `glDrawMeshTasksIndirectEXT`
- `glDrawRangeElementsBaseVertexEXT`
- `glDrawRangeElementsEXT`
- `glDrawTransformFeedbackEXT`
- `glDrawTransformFeedbackInstancedEXT`
- `glEdgeFlagPointerEXT`
- `glEGLImageTargetTexStorageEXT`
- `glEGLImageTargetTextureStorageEXT`
- `glEnableClientStateiEXT`
- `glEnableClientStateIndexedEXT`
- `glEnableiEXT`
- `glEnableIndexedEXT`
- `glEnableVariantClientStateEXT`
- `glEnableVertexArrayAttribEXT`
- `glEnableVertexArrayEXT`
- `glEndQueryEXT`
- `glEndTransformFeedbackEXT`
- `glEndVertexShaderEXT`
- `glExtractComponentEXT`
- `glFlushMappedBufferRangeEXT`
- `glFlushMappedNamedBufferRangeEXT`
- `glFogCoorddEXT`
- `glFogCoorddvEXT`
- `glFogCoordfEXT`
- `glFogCoordfvEXT`
- `glFogCoordPointerEXT`
- `glFramebufferDrawBufferEXT`
- `glFramebufferDrawBuffersEXT`
- `glFramebufferFetchBarrierEXT`
- `glFramebufferPixelLocalStorageSizeEXT`
- `glFramebufferReadBufferEXT`
- `glFramebufferRenderbufferEXT`
- `glFramebufferShadingRateEXT`
- `glFramebufferTexture1DEXT`
- `glFramebufferTexture2DEXT`
- `glFramebufferTexture2DMultisampleEXT`
- `glFramebufferTexture3DEXT`
- `glFramebufferTextureEXT`
- `glFramebufferTextureFaceEXT`
- `glFramebufferTextureLayerEXT`
- `glGenerateMipmapEXT`
- `glGenerateMultiTexMipmapEXT`
- `glGenerateTextureMipmapEXT`
- `glGenFramebuffersEXT`
- `glGenProgramPipelinesEXT`
- `glGenQueriesEXT`
- `glGenRenderbuffersEXT`
- `glGenSemaphoresEXT`
- `glGenSymbolsEXT`
- `glGenTexturesEXT`
- `glGenVertexShadersEXT`
- `glGetBooleanIndexedvEXT`
- `glGetColorTableEXT`
- `glGetColorTableParameterfvEXT`
- `glGetColorTableParameterivEXT`
- `glGetCompressedMultiTexImageEXT`
- `glGetCompressedTextureImageEXT`
- `glGetConvolutionFilterEXT`
- `glGetConvolutionParameterfvEXT`
- `glGetConvolutionParameterivEXT`
- `glGetDoublei_vEXT`
- `glGetDoubleIndexedvEXT`
- `glGetFloati_vEXT`
- `glGetFloatIndexedvEXT`
- `glGetFragDataIndexEXT`
- `glGetFragDataLocationEXT`
- `glGetFragmentShadingRatesEXT`
- `glGetFramebufferAttachmentParameterivEXT`
- `glGetFramebufferParameterivEXT`
- `glGetFramebufferPixelLocalStorageSizeEXT`
- `glGetGraphicsResetStatusEXT`
- `glGetHistogramEXT`
- `glGetHistogramParameterfvEXT`
- `glGetHistogramParameterivEXT`
- `glGetInteger64vEXT`
- `glGetIntegeri_vEXT`
- `glGetIntegerIndexedvEXT`
- `glGetInvariantBooleanvEXT`
- `glGetInvariantFloatvEXT`
- `glGetInvariantIntegervEXT`
- `glGetLocalConstantBooleanvEXT`
- `glGetLocalConstantFloatvEXT`
- `glGetLocalConstantIntegervEXT`
- `glGetMemoryObjectParameterivEXT`
- `glGetMinmaxEXT`
- `glGetMinmaxParameterfvEXT`
- `glGetMinmaxParameterivEXT`
- `glGetMultiTexEnvfvEXT`
- `glGetMultiTexEnvivEXT`
- `glGetMultiTexGendvEXT`
- `glGetMultiTexGenfvEXT`
- `glGetMultiTexGenivEXT`
- `glGetMultiTexImageEXT`
- `glGetMultiTexLevelParameterfvEXT`
- `glGetMultiTexLevelParameterivEXT`
- `glGetMultiTexParameterfvEXT`
- `glGetMultiTexParameterIivEXT`
- `glGetMultiTexParameterIuivEXT`
- `glGetMultiTexParameterivEXT`
- `glGetNamedBufferParameterivEXT`
- `glGetNamedBufferPointervEXT`
- `glGetNamedBufferSubDataEXT`
- `glGetNamedFramebufferAttachmentParameterivEXT`
- `glGetNamedFramebufferParameterivEXT`
- `glGetNamedProgramivEXT`
- `glGetNamedProgramLocalParameterdvEXT`
- `glGetNamedProgramLocalParameterfvEXT`
- `glGetNamedProgramLocalParameterIivEXT`
- `glGetNamedProgramLocalParameterIuivEXT`
- `glGetNamedProgramStringEXT`
- `glGetNamedRenderbufferParameterivEXT`
- `glGetnUniformfvEXT`
- `glGetnUniformivEXT`
- `glGetObjectLabelEXT`
- `glGetPixelTransformParameterfvEXT`
- `glGetPixelTransformParameterivEXT`
- `glGetPointeri_vEXT`
- `glGetPointerIndexedvEXT`
- `glGetPointervEXT`
- `glGetProgramPipelineInfoLogEXT`
- `glGetProgramPipelineivEXT`
- `glGetProgramResourceLocationIndexEXT`
- `glGetQueryivEXT`
- `glGetQueryObjecti64vEXT`
- `glGetQueryObjectivEXT`
- `glGetQueryObjectui64vEXT`
- `glGetQueryObjectuivEXT`
- `glGetRenderbufferParameterivEXT`
- `glGetSamplerParameterIivEXT`
- `glGetSamplerParameterIuivEXT`
- `glGetSemaphoreParameterui64vEXT`
- `glGetSeparableFilterEXT`
- `glGetTexParameterIivEXT`
- `glGetTexParameterIuivEXT`
- `glGetTextureImageEXT`
- `glGetTextureLevelParameterfvEXT`
- `glGetTextureLevelParameterivEXT`
- `glGetTextureParameterfvEXT`
- `glGetTextureParameterIivEXT`
- `glGetTextureParameterIuivEXT`
- `glGetTextureParameterivEXT`
- `glGetTransformFeedbackVaryingEXT`
- `glGetUniformBufferSizeEXT`
- `glGetUniformOffsetEXT`
- `glGetUniformuivEXT`
- `glGetUnsignedBytei_vEXT`
- `glGetUnsignedBytevEXT`
- `glGetVariantBooleanvEXT`
- `glGetVariantFloatvEXT`
- `glGetVariantIntegervEXT`
- `glGetVariantPointervEXT`
- `glGetVertexArrayIntegeri_vEXT`
- `glGetVertexArrayIntegervEXT`
- `glGetVertexArrayPointeri_vEXT`
- `glGetVertexArrayPointervEXT`
- `glGetVertexAttribIivEXT`
- `glGetVertexAttribIuivEXT`
- `glGetVertexAttribLdvEXT`
- `glHistogramEXT`
- `glImportMemoryFdEXT`
- `glImportMemoryWin32HandleEXT`
- `glImportMemoryWin32NameEXT`
- `glImportSemaphoreFdEXT`
- `glImportSemaphoreWin32HandleEXT`
- `glImportSemaphoreWin32NameEXT`
- `glImportSyncEXT`
- `glIndexFuncEXT`
- `glIndexMaterialEXT`
- `glIndexPointerEXT`
- `glInsertComponentEXT`
- `glInsertEventMarkerEXT`
- `glIsEnablediEXT`
- `glIsEnabledIndexedEXT`
- `glIsFramebufferEXT`
- `glIsMemoryObjectEXT`
- `glIsProgramPipelineEXT`
- `glIsQueryEXT`
- `glIsRenderbufferEXT`
- `glIsSemaphoreEXT`
- `glIsTextureEXT`
- `glIsVariantEnabledEXT`
- `glLabelObjectEXT`
- `glLockArraysEXT`
- `glMapBufferRangeEXT`
- `glMapNamedBufferEXT`
- `glMapNamedBufferRangeEXT`
- `glMatrixFrustumEXT`
- `glMatrixLoaddEXT`
- `glMatrixLoadfEXT`
- `glMatrixLoadIdentityEXT`
- `glMatrixLoadTransposedEXT`
- `glMatrixLoadTransposefEXT`
- `glMatrixMultdEXT`
- `glMatrixMultfEXT`
- `glMatrixMultTransposedEXT`
- `glMatrixMultTransposefEXT`
- `glMatrixOrthoEXT`
- `glMatrixPopEXT`
- `glMatrixPushEXT`
- `glMatrixRotatedEXT`
- `glMatrixRotatefEXT`
- `glMatrixScaledEXT`
- `glMatrixScalefEXT`
- `glMatrixTranslatedEXT`
- `glMatrixTranslatefEXT`
- `glMemoryBarrierEXT`
- `glMemoryObjectParameterivEXT`
- `glMinmaxEXT`
- `glMultiDrawArraysEXT`
- `glMultiDrawArraysIndirectEXT`
- `glMultiDrawElementsBaseVertexEXT`
- `glMultiDrawElementsEXT`
- `glMultiDrawElementsIndirectEXT`
- `glMultiDrawMeshTasksIndirectCountEXT`
- `glMultiDrawMeshTasksIndirectEXT`
- `glMultiTexBufferEXT`
- `glMultiTexCoordPointerEXT`
- `glMultiTexEnvfEXT`
- `glMultiTexEnvfvEXT`
- `glMultiTexEnviEXT`
- `glMultiTexEnvivEXT`
- `glMultiTexGendEXT`
- `glMultiTexGendvEXT`
- `glMultiTexGenfEXT`
- `glMultiTexGenfvEXT`
- `glMultiTexGeniEXT`
- `glMultiTexGenivEXT`
- `glMultiTexImage1DEXT`
- `glMultiTexImage2DEXT`
- `glMultiTexImage3DEXT`
- `glMultiTexParameterfEXT`
- `glMultiTexParameterfvEXT`
- `glMultiTexParameteriEXT`
- `glMultiTexParameterIivEXT`
- `glMultiTexParameterIuivEXT`
- `glMultiTexParameterivEXT`
- `glMultiTexRenderbufferEXT`
- `glMultiTexSubImage1DEXT`
- `glMultiTexSubImage2DEXT`
- `glMultiTexSubImage3DEXT`
- `glNamedBufferDataEXT`
- `glNamedBufferPageCommitmentEXT`
- `glNamedBufferStorageEXT`
- `glNamedBufferStorageExternalEXT`
- `glNamedBufferStorageMemEXT`
- `glNamedBufferSubDataEXT`
- `glNamedCopyBufferSubDataEXT`
- `glNamedFramebufferParameteriEXT`
- `glNamedFramebufferRenderbufferEXT`
- `glNamedFramebufferTexture1DEXT`
- `glNamedFramebufferTexture2DEXT`
- `glNamedFramebufferTexture3DEXT`
- `glNamedFramebufferTextureEXT`
- `glNamedFramebufferTextureFaceEXT`
- `glNamedFramebufferTextureLayerEXT`
- `glNamedProgramLocalParameter4dEXT`
- `glNamedProgramLocalParameter4dvEXT`
- `glNamedProgramLocalParameter4fEXT`
- `glNamedProgramLocalParameter4fvEXT`
- `glNamedProgramLocalParameterI4iEXT`
- `glNamedProgramLocalParameterI4ivEXT`
- `glNamedProgramLocalParameterI4uiEXT`
- `glNamedProgramLocalParameterI4uivEXT`
- `glNamedProgramLocalParameters4fvEXT`
- `glNamedProgramLocalParametersI4ivEXT`
- `glNamedProgramLocalParametersI4uivEXT`
- `glNamedProgramStringEXT`
- `glNamedRenderbufferStorageEXT`
- `glNamedRenderbufferStorageMultisampleCoverageEXT`
- `glNamedRenderbufferStorageMultisampleEXT`
- `glNormalPointerEXT`
- `glPatchParameteriEXT`
- `glPixelTransformParameterfEXT`
- `glPixelTransformParameterfvEXT`
- `glPixelTransformParameteriEXT`
- `glPixelTransformParameterivEXT`
- `glPointParameterfEXT`
- `glPointParameterfvEXT`
- `glPolygonOffsetClampEXT`
- `glPolygonOffsetEXT`
- `glPopGroupMarkerEXT`
- `glPrimitiveBoundingBoxEXT`
- `glPrioritizeTexturesEXT`
- `glProgramEnvParameters4fvEXT`
- `glProgramLocalParameters4fvEXT`
- `glProgramParameteriEXT`
- `glProgramUniform1dEXT`
- `glProgramUniform1dvEXT`
- `glProgramUniform1fEXT`
- `glProgramUniform1fvEXT`
- `glProgramUniform1iEXT`
- `glProgramUniform1ivEXT`
- `glProgramUniform1uiEXT`
- `glProgramUniform1uivEXT`
- `glProgramUniform2dEXT`
- `glProgramUniform2dvEXT`
- `glProgramUniform2fEXT`
- `glProgramUniform2fvEXT`
- `glProgramUniform2iEXT`
- `glProgramUniform2ivEXT`
- `glProgramUniform2uiEXT`
- `glProgramUniform2uivEXT`
- `glProgramUniform3dEXT`
- `glProgramUniform3dvEXT`
- `glProgramUniform3fEXT`
- `glProgramUniform3fvEXT`
- `glProgramUniform3iEXT`
- `glProgramUniform3ivEXT`
- `glProgramUniform3uiEXT`
- `glProgramUniform3uivEXT`
- `glProgramUniform4dEXT`
- `glProgramUniform4dvEXT`
- `glProgramUniform4fEXT`
- `glProgramUniform4fvEXT`
- `glProgramUniform4iEXT`
- `glProgramUniform4ivEXT`
- `glProgramUniform4uiEXT`
- `glProgramUniform4uivEXT`
- `glProgramUniformMatrix2dvEXT`
- `glProgramUniformMatrix2fvEXT`
- `glProgramUniformMatrix2x3dvEXT`
- `glProgramUniformMatrix2x3fvEXT`
- `glProgramUniformMatrix2x4dvEXT`
- `glProgramUniformMatrix2x4fvEXT`
- `glProgramUniformMatrix3dvEXT`
- `glProgramUniformMatrix3fvEXT`
- `glProgramUniformMatrix3x2dvEXT`
- `glProgramUniformMatrix3x2fvEXT`
- `glProgramUniformMatrix3x4dvEXT`
- `glProgramUniformMatrix3x4fvEXT`
- `glProgramUniformMatrix4dvEXT`
- `glProgramUniformMatrix4fvEXT`
- `glProgramUniformMatrix4x2dvEXT`
- `glProgramUniformMatrix4x2fvEXT`
- `glProgramUniformMatrix4x3dvEXT`
- `glProgramUniformMatrix4x3fvEXT`
- `glProvokingVertexEXT`
- `glPushClientAttribDefaultEXT`
- `glPushGroupMarkerEXT`
- `glQueryCounterEXT`
- `glRasterSamplesEXT`
- `glReadBufferIndexedEXT`
- `glReadnPixelsEXT`
- `glReleaseKeyedMutexWin32EXT`
- `glRenderbufferStorageEXT`
- `glRenderbufferStorageMultisampleEXT`
- `glResetHistogramEXT`
- `glResetMinmaxEXT`
- `glSampleMaskEXT`
- `glSamplePatternEXT`
- `glSamplerParameterIivEXT`
- `glSamplerParameterIuivEXT`
- `glSecondaryColor3bEXT`
- `glSecondaryColor3bvEXT`
- `glSecondaryColor3dEXT`
- `glSecondaryColor3dvEXT`
- `glSecondaryColor3fEXT`
- `glSecondaryColor3fvEXT`
- `glSecondaryColor3iEXT`
- `glSecondaryColor3ivEXT`
- `glSecondaryColor3sEXT`
- `glSecondaryColor3svEXT`
- `glSecondaryColor3ubEXT`
- `glSecondaryColor3ubvEXT`
- `glSecondaryColor3uiEXT`
- `glSecondaryColor3uivEXT`
- `glSecondaryColor3usEXT`
- `glSecondaryColor3usvEXT`
- `glSecondaryColorPointerEXT`
- `glSemaphoreParameterui64vEXT`
- `glSeparableFilter2DEXT`
- `glSetInvariantEXT`
- `glSetLocalConstantEXT`
- `glShaderOp1EXT`
- `glShaderOp2EXT`
- `glShaderOp3EXT`
- `glShadingRateCombinerOpsEXT`
- `glShadingRateEXT`
- `glSignalSemaphoreEXT`
- `glStencilClearTagEXT`
- `glSwizzleEXT`
- `glTangent3bEXT`
- `glTangent3bvEXT`
- `glTangent3dEXT`
- `glTangent3dvEXT`
- `glTangent3fEXT`
- `glTangent3fvEXT`
- `glTangent3iEXT`
- `glTangent3ivEXT`
- `glTangent3sEXT`
- `glTangent3svEXT`
- `glTangentPointerEXT`
- `glTexBufferEXT`
- `glTexBufferRangeEXT`
- `glTexCoordPointerEXT`
- `glTexImage3DEXT`
- `glTexPageCommitmentEXT`
- `glTexParameterIivEXT`
- `glTexParameterIuivEXT`
- `glTexStorage1DEXT`
- `glTexStorage2DEXT`
- `glTexStorage3DEXT`
- `glTexStorageAttribs2DEXT`
- `glTexStorageAttribs3DEXT`
- `glTexStorageMem1DEXT`
- `glTexStorageMem2DEXT`
- `glTexStorageMem2DMultisampleEXT`
- `glTexStorageMem3DEXT`
- `glTexStorageMem3DMultisampleEXT`
- `glTexSubImage1DEXT`
- `glTexSubImage2DEXT`
- `glTexSubImage3DEXT`
- `glTextureBufferEXT`
- `glTextureBufferRangeEXT`
- `glTextureImage1DEXT`
- `glTextureImage2DEXT`
- `glTextureImage3DEXT`
- `glTextureLightEXT`
- `glTextureMaterialEXT`
- `glTextureNormalEXT`
- `glTexturePageCommitmentEXT`
- `glTextureParameterfEXT`
- `glTextureParameterfvEXT`
- `glTextureParameteriEXT`
- `glTextureParameterIivEXT`
- `glTextureParameterIuivEXT`
- `glTextureParameterivEXT`
- `glTextureRenderbufferEXT`
- `glTextureStorage1DEXT`
- `glTextureStorage2DEXT`
- `glTextureStorage2DMultisampleEXT`
- `glTextureStorage3DEXT`
- `glTextureStorage3DMultisampleEXT`
- `glTextureStorageMem1DEXT`
- `glTextureStorageMem2DEXT`
- `glTextureStorageMem2DMultisampleEXT`
- `glTextureStorageMem3DEXT`
- `glTextureStorageMem3DMultisampleEXT`
- `glTextureSubImage1DEXT`
- `glTextureSubImage2DEXT`
- `glTextureSubImage3DEXT`
- `glTextureViewEXT`
- `glTransformFeedbackVaryingsEXT`
- `glUniform1uiEXT`
- `glUniform1uivEXT`
- `glUniform2uiEXT`
- `glUniform2uivEXT`
- `glUniform3uiEXT`
- `glUniform3uivEXT`
- `glUniform4uiEXT`
- `glUniform4uivEXT`
- `glUniformBufferEXT`
- `glUnlockArraysEXT`
- `glUnmapNamedBufferEXT`
- `glUseProgramStagesEXT`
- `glUseShaderProgramEXT`
- `glValidateProgramPipelineEXT`
- `glVariantbvEXT`
- `glVariantdvEXT`
- `glVariantfvEXT`
- `glVariantivEXT`
- `glVariantPointerEXT`
- `glVariantsvEXT`
- `glVariantubvEXT`
- `glVariantuivEXT`
- `glVariantusvEXT`
- `glVertexArrayBindVertexBufferEXT`
- `glVertexArrayColorOffsetEXT`
- `glVertexArrayEdgeFlagOffsetEXT`
- `glVertexArrayFogCoordOffsetEXT`
- `glVertexArrayIndexOffsetEXT`
- `glVertexArrayMultiTexCoordOffsetEXT`
- `glVertexArrayNormalOffsetEXT`
- `glVertexArraySecondaryColorOffsetEXT`
- `glVertexArrayTexCoordOffsetEXT`
- `glVertexArrayVertexAttribBindingEXT`
- `glVertexArrayVertexAttribDivisorEXT`
- `glVertexArrayVertexAttribFormatEXT`
- `glVertexArrayVertexAttribIFormatEXT`
- `glVertexArrayVertexAttribIOffsetEXT`
- `glVertexArrayVertexAttribLFormatEXT`
- `glVertexArrayVertexAttribLOffsetEXT`
- `glVertexArrayVertexAttribOffsetEXT`
- `glVertexArrayVertexBindingDivisorEXT`
- `glVertexArrayVertexOffsetEXT`
- `glVertexAttribDivisorEXT`
- `glVertexAttribI1iEXT`
- `glVertexAttribI1ivEXT`
- `glVertexAttribI1uiEXT`
- `glVertexAttribI1uivEXT`
- `glVertexAttribI2iEXT`
- `glVertexAttribI2ivEXT`
- `glVertexAttribI2uiEXT`
- `glVertexAttribI2uivEXT`
- `glVertexAttribI3iEXT`
- `glVertexAttribI3ivEXT`
- `glVertexAttribI3uiEXT`
- `glVertexAttribI3uivEXT`
- `glVertexAttribI4bvEXT`
- `glVertexAttribI4iEXT`
- `glVertexAttribI4ivEXT`
- `glVertexAttribI4svEXT`
- `glVertexAttribI4ubvEXT`
- `glVertexAttribI4uiEXT`
- `glVertexAttribI4uivEXT`
- `glVertexAttribI4usvEXT`
- `glVertexAttribIPointerEXT`
- `glVertexAttribL1dEXT`
- `glVertexAttribL1dvEXT`
- `glVertexAttribL2dEXT`
- `glVertexAttribL2dvEXT`
- `glVertexAttribL3dEXT`
- `glVertexAttribL3dvEXT`
- `glVertexAttribL4dEXT`
- `glVertexAttribL4dvEXT`
- `glVertexAttribLPointerEXT`
- `glVertexPointerEXT`
- `glVertexWeightfEXT`
- `glVertexWeightfvEXT`
- `glVertexWeightPointerEXT`
- `glWaitSemaphoreEXT`
- `glWindowRectanglesEXT`
- `glWriteMaskEXT`

## GREMEDY (2 functions)

### Version extension-only (2 functions)

- `glFrameTerminatorGREMEDY`
- `glStringMarkerGREMEDY`

## HP (6 functions)

### Version extension-only (6 functions)

- `glGetImageTransformParameterfvHP`
- `glGetImageTransformParameterivHP`
- `glImageTransformParameterfHP`
- `glImageTransformParameterfvHP`
- `glImageTransformParameteriHP`
- `glImageTransformParameterivHP`

## IBM (11 functions)

### Version extension-only (11 functions)

- `glColorPointerListIBM`
- `glEdgeFlagPointerListIBM`
- `glFlushStaticDataIBM`
- `glFogCoordPointerListIBM`
- `glIndexPointerListIBM`
- `glMultiModeDrawArraysIBM`
- `glMultiModeDrawElementsIBM`
- `glNormalPointerListIBM`
- `glSecondaryColorPointerListIBM`
- `glTexCoordPointerListIBM`
- `glVertexPointerListIBM`

## IMG (12 functions)

### Version extension-only (12 functions)

- `glClipPlanefIMG`
- `glClipPlanexIMG`
- `glFramebufferTexture2DDownsampleIMG`
- `glFramebufferTexture2DMultisampleIMG`
- `glFramebufferTextureLayerDownsampleIMG`
- `glGetTextureHandleIMG`
- `glGetTextureSamplerHandleIMG`
- `glProgramUniformHandleui64IMG`
- `glProgramUniformHandleui64vIMG`
- `glRenderbufferStorageMultisampleIMG`
- `glUniformHandleui64IMG`
- `glUniformHandleui64vIMG`

## INGR (1 functions)

### Version extension-only (1 functions)

- `glBlendFuncSeparateINGR`

## INTEL (18 functions)

### Version extension-only (18 functions)

- `glApplyFramebufferAttachmentCMAAINTEL`
- `glBeginPerfQueryINTEL`
- `glColorPointervINTEL`
- `glCreatePerfQueryINTEL`
- `glDeletePerfQueryINTEL`
- `glEndPerfQueryINTEL`
- `glGetFirstPerfQueryIdINTEL`
- `glGetNextPerfQueryIdINTEL`
- `glGetPerfCounterInfoINTEL`
- `glGetPerfQueryDataINTEL`
- `glGetPerfQueryIdByNameINTEL`
- `glGetPerfQueryInfoINTEL`
- `glMapTexture2DINTEL`
- `glNormalPointervINTEL`
- `glSyncTextureINTEL`
- `glTexCoordPointervINTEL`
- `glUnmapTexture2DINTEL`
- `glVertexPointervINTEL`

## KHR (18 functions)

### Version extension-only (18 functions)

- `glBlendBarrierKHR`
- `glDebugMessageCallbackKHR`
- `glDebugMessageControlKHR`
- `glDebugMessageInsertKHR`
- `glGetDebugMessageLogKHR`
- `glGetGraphicsResetStatusKHR`
- `glGetnUniformfvKHR`
- `glGetnUniformivKHR`
- `glGetnUniformuivKHR`
- `glGetObjectLabelKHR`
- `glGetObjectPtrLabelKHR`
- `glGetPointervKHR`
- `glMaxShaderCompilerThreadsKHR`
- `glObjectLabelKHR`
- `glObjectPtrLabelKHR`
- `glPopDebugGroupKHR`
- `glPushDebugGroupKHR`
- `glReadnPixelsKHR`

## MESA (27 functions)

### Version extension-only (27 functions)

- `glFramebufferParameteriMESA`
- `glGetFramebufferParameterivMESA`
- `glResizeBuffersMESA`
- `glWindowPos2dMESA`
- `glWindowPos2dvMESA`
- `glWindowPos2fMESA`
- `glWindowPos2fvMESA`
- `glWindowPos2iMESA`
- `glWindowPos2ivMESA`
- `glWindowPos2sMESA`
- `glWindowPos2svMESA`
- `glWindowPos3dMESA`
- `glWindowPos3dvMESA`
- `glWindowPos3fMESA`
- `glWindowPos3fvMESA`
- `glWindowPos3iMESA`
- `glWindowPos3ivMESA`
- `glWindowPos3sMESA`
- `glWindowPos3svMESA`
- `glWindowPos4dMESA`
- `glWindowPos4dvMESA`
- `glWindowPos4fMESA`
- `glWindowPos4fvMESA`
- `glWindowPos4iMESA`
- `glWindowPos4ivMESA`
- `glWindowPos4sMESA`
- `glWindowPos4svMESA`

## NV (520 functions)

### Version extension-only (520 functions)

- `glActiveVaryingNV`
- `glAlphaToCoverageDitherControlNV`
- `glAreProgramsResidentNV`
- `glBeginConditionalRenderNV`
- `glBeginOcclusionQueryNV`
- `glBeginTransformFeedbackNV`
- `glBeginVideoCaptureNV`
- `glBindBufferBaseNV`
- `glBindBufferOffsetNV`
- `glBindBufferRangeNV`
- `glBindProgramNV`
- `glBindShadingRateImageNV`
- `glBindTransformFeedbackNV`
- `glBindVideoCaptureStreamBufferNV`
- `glBindVideoCaptureStreamTextureNV`
- `glBlendBarrierNV`
- `glBlendParameteriNV`
- `glBlitFramebufferNV`
- `glBufferAddressRangeNV`
- `glBufferAttachMemoryNV`
- `glBufferPageCommitmentMemNV`
- `glCallCommandListNV`
- `glClearDepthdNV`
- `glColor3hNV`
- `glColor3hvNV`
- `glColor4hNV`
- `glColor4hvNV`
- `glColorFormatNV`
- `glCombinerInputNV`
- `glCombinerOutputNV`
- `glCombinerParameterfNV`
- `glCombinerParameterfvNV`
- `glCombinerParameteriNV`
- `glCombinerParameterivNV`
- `glCombinerStageParameterfvNV`
- `glCommandListSegmentsNV`
- `glCompileCommandListNV`
- `glConservativeRasterParameterfNV`
- `glConservativeRasterParameteriNV`
- `glCopyBufferSubDataNV`
- `glCopyImageSubDataNV`
- `glCopyPathNV`
- `glCoverageMaskNV`
- `glCoverageModulationNV`
- `glCoverageModulationTableNV`
- `glCoverageOperationNV`
- `glCoverFillPathInstancedNV`
- `glCoverFillPathNV`
- `glCoverStrokePathInstancedNV`
- `glCoverStrokePathNV`
- `glCreateCommandListsNV`
- `glCreateSemaphoresNV`
- `glCreateStatesNV`
- `glDeleteCommandListsNV`
- `glDeleteFencesNV`
- `glDeleteOcclusionQueriesNV`
- `glDeletePathsNV`
- `glDeleteProgramsNV`
- `glDeleteQueryResourceTagNV`
- `glDeleteStatesNV`
- `glDeleteTransformFeedbacksNV`
- `glDepthBoundsdNV`
- `glDepthRangeArraydvNV`
- `glDepthRangeArrayfvNV`
- `glDepthRangedNV`
- `glDepthRangeIndexeddNV`
- `glDepthRangeIndexedfNV`
- `glDisableiNV`
- `glDrawArraysInstancedNV`
- `glDrawBuffersNV`
- `glDrawCommandsAddressNV`
- `glDrawCommandsNV`
- `glDrawCommandsStatesAddressNV`
- `glDrawCommandsStatesNV`
- `glDrawElementsInstancedNV`
- `glDrawMeshTasksIndirectNV`
- `glDrawMeshTasksNV`
- `glDrawTextureNV`
- `glDrawTransformFeedbackNV`
- `glDrawVkImageNV`
- `glEdgeFlagFormatNV`
- `glEnableiNV`
- `glEndConditionalRenderNV`
- `glEndOcclusionQueryNV`
- `glEndTransformFeedbackNV`
- `glEndVideoCaptureNV`
- `glEvalMapsNV`
- `glExecuteProgramNV`
- `glFinalCombinerInputNV`
- `glFinishFenceNV`
- `glFlushPixelDataRangeNV`
- `glFlushVertexArrayRangeNV`
- `glFogCoordFormatNV`
- `glFogCoordhNV`
- `glFogCoordhvNV`
- `glFragmentCoverageColorNV`
- `glFramebufferSampleLocationsfvNV`
- `glGenFencesNV`
- `glGenOcclusionQueriesNV`
- `glGenPathsNV`
- `glGenProgramsNV`
- `glGenQueryResourceTagNV`
- `glGenTransformFeedbacksNV`
- `glGetActiveVaryingNV`
- `glGetBufferParameterui64vNV`
- `glGetCombinerInputParameterfvNV`
- `glGetCombinerInputParameterivNV`
- `glGetCombinerOutputParameterfvNV`
- `glGetCombinerOutputParameterivNV`
- `glGetCombinerStageParameterfvNV`
- `glGetCommandHeaderNV`
- `glGetCoverageModulationTableNV`
- `glGetFenceivNV`
- `glGetFinalCombinerInputParameterfvNV`
- `glGetFinalCombinerInputParameterivNV`
- `glGetFloati_vNV`
- `glGetImageHandleNV`
- `glGetIntegerui64i_vNV`
- `glGetIntegerui64vNV`
- `glGetInternalformatSampleivNV`
- `glGetMapAttribParameterfvNV`
- `glGetMapAttribParameterivNV`
- `glGetMapControlPointsNV`
- `glGetMapParameterfvNV`
- `glGetMapParameterivNV`
- `glGetMemoryObjectDetachedResourcesuivNV`
- `glGetMultisamplefvNV`
- `glGetNamedBufferParameterui64vNV`
- `glGetOcclusionQueryivNV`
- `glGetOcclusionQueryuivNV`
- `glGetPathColorGenfvNV`
- `glGetPathColorGenivNV`
- `glGetPathCommandsNV`
- `glGetPathCoordsNV`
- `glGetPathDashArrayNV`
- `glGetPathLengthNV`
- `glGetPathMetricRangeNV`
- `glGetPathMetricsNV`
- `glGetPathParameterfvNV`
- `glGetPathParameterivNV`
- `glGetPathSpacingNV`
- `glGetPathTexGenfvNV`
- `glGetPathTexGenivNV`
- `glGetProgramEnvParameterIivNV`
- `glGetProgramEnvParameterIuivNV`
- `glGetProgramivNV`
- `glGetProgramLocalParameterIivNV`
- `glGetProgramLocalParameterIuivNV`
- `glGetProgramNamedParameterdvNV`
- `glGetProgramNamedParameterfvNV`
- `glGetProgramParameterdvNV`
- `glGetProgramParameterfvNV`
- `glGetProgramResourcefvNV`
- `glGetProgramStringNV`
- `glGetProgramSubroutineParameteruivNV`
- `glGetSemaphoreParameterivNV`
- `glGetShadingRateImagePaletteNV`
- `glGetShadingRateSampleLocationivNV`
- `glGetStageIndexNV`
- `glGetTextureHandleNV`
- `glGetTextureSamplerHandleNV`
- `glGetTrackMatrixivNV`
- `glGetTransformFeedbackVaryingNV`
- `glGetUniformi64vNV`
- `glGetUniformui64vNV`
- `glGetVaryingLocationNV`
- `glGetVertexAttribdvNV`
- `glGetVertexAttribfvNV`
- `glGetVertexAttribivNV`
- `glGetVertexAttribLi64vNV`
- `glGetVertexAttribLui64vNV`
- `glGetVertexAttribPointervNV`
- `glGetVideoCaptureivNV`
- `glGetVideoCaptureStreamdvNV`
- `glGetVideoCaptureStreamfvNV`
- `glGetVideoCaptureStreamivNV`
- `glGetVideoi64vNV`
- `glGetVideoivNV`
- `glGetVideoui64vNV`
- `glGetVideouivNV`
- `glGetVkProcAddrNV`
- `glIndexFormatNV`
- `glInterpolatePathsNV`
- `glIsBufferResidentNV`
- `glIsCommandListNV`
- `glIsEnablediNV`
- `glIsFenceNV`
- `glIsImageHandleResidentNV`
- `glIsNamedBufferResidentNV`
- `glIsOcclusionQueryNV`
- `glIsPathNV`
- `glIsPointInFillPathNV`
- `glIsPointInStrokePathNV`
- `glIsProgramNV`
- `glIsStateNV`
- `glIsTextureHandleResidentNV`
- `glIsTransformFeedbackNV`
- `glListDrawCommandsStatesClientNV`
- `glLoadProgramNV`
- `glMakeBufferNonResidentNV`
- `glMakeBufferResidentNV`
- `glMakeImageHandleNonResidentNV`
- `glMakeImageHandleResidentNV`
- `glMakeNamedBufferNonResidentNV`
- `glMakeNamedBufferResidentNV`
- `glMakeTextureHandleNonResidentNV`
- `glMakeTextureHandleResidentNV`
- `glMapControlPointsNV`
- `glMapParameterfvNV`
- `glMapParameterivNV`
- `glMatrixLoad3x2fNV`
- `glMatrixLoad3x3fNV`
- `glMatrixLoadTranspose3x3fNV`
- `glMatrixMult3x2fNV`
- `glMatrixMult3x3fNV`
- `glMatrixMultTranspose3x3fNV`
- `glMulticastBarrierNV`
- `glMulticastBlitFramebufferNV`
- `glMulticastBufferSubDataNV`
- `glMulticastCopyBufferSubDataNV`
- `glMulticastCopyImageSubDataNV`
- `glMulticastFramebufferSampleLocationsfvNV`
- `glMulticastGetQueryObjecti64vNV`
- `glMulticastGetQueryObjectivNV`
- `glMulticastGetQueryObjectui64vNV`
- `glMulticastGetQueryObjectuivNV`
- `glMulticastWaitSyncNV`
- `glMultiDrawArraysIndirectBindlessCountNV`
- `glMultiDrawArraysIndirectBindlessNV`
- `glMultiDrawElementsIndirectBindlessCountNV`
- `glMultiDrawElementsIndirectBindlessNV`
- `glMultiDrawMeshTasksIndirectCountNV`
- `glMultiDrawMeshTasksIndirectNV`
- `glMultiTexCoord1hNV`
- `glMultiTexCoord1hvNV`
- `glMultiTexCoord2hNV`
- `glMultiTexCoord2hvNV`
- `glMultiTexCoord3hNV`
- `glMultiTexCoord3hvNV`
- `glMultiTexCoord4hNV`
- `glMultiTexCoord4hvNV`
- `glNamedBufferAttachMemoryNV`
- `glNamedBufferPageCommitmentMemNV`
- `glNamedFramebufferSampleLocationsfvNV`
- `glNormal3hNV`
- `glNormal3hvNV`
- `glNormalFormatNV`
- `glPathColorGenNV`
- `glPathCommandsNV`
- `glPathCoordsNV`
- `glPathCoverDepthFuncNV`
- `glPathDashArrayNV`
- `glPathFogGenNV`
- `glPathGlyphIndexArrayNV`
- `glPathGlyphIndexRangeNV`
- `glPathGlyphRangeNV`
- `glPathGlyphsNV`
- `glPathMemoryGlyphIndexArrayNV`
- `glPathParameterfNV`
- `glPathParameterfvNV`
- `glPathParameteriNV`
- `glPathParameterivNV`
- `glPathStencilDepthOffsetNV`
- `glPathStencilFuncNV`
- `glPathStringNV`
- `glPathSubCommandsNV`
- `glPathSubCoordsNV`
- `glPathTexGenNV`
- `glPauseTransformFeedbackNV`
- `glPixelDataRangeNV`
- `glPointAlongPathNV`
- `glPointParameteriNV`
- `glPointParameterivNV`
- `glPolygonModeNV`
- `glPresentFrameDualFillNV`
- `glPresentFrameKeyedNV`
- `glPrimitiveRestartIndexNV`
- `glPrimitiveRestartNV`
- `glProgramBufferParametersfvNV`
- `glProgramBufferParametersIivNV`
- `glProgramBufferParametersIuivNV`
- `glProgramEnvParameterI4iNV`
- `glProgramEnvParameterI4ivNV`
- `glProgramEnvParameterI4uiNV`
- `glProgramEnvParameterI4uivNV`
- `glProgramEnvParametersI4ivNV`
- `glProgramEnvParametersI4uivNV`
- `glProgramLocalParameterI4iNV`
- `glProgramLocalParameterI4ivNV`
- `glProgramLocalParameterI4uiNV`
- `glProgramLocalParameterI4uivNV`
- `glProgramLocalParametersI4ivNV`
- `glProgramLocalParametersI4uivNV`
- `glProgramNamedParameter4dNV`
- `glProgramNamedParameter4dvNV`
- `glProgramNamedParameter4fNV`
- `glProgramNamedParameter4fvNV`
- `glProgramParameter4dNV`
- `glProgramParameter4dvNV`
- `glProgramParameter4fNV`
- `glProgramParameter4fvNV`
- `glProgramParameters4dvNV`
- `glProgramParameters4fvNV`
- `glProgramPathFragmentInputGenNV`
- `glProgramSubroutineParametersuivNV`
- `glProgramUniform1i64NV`
- `glProgramUniform1i64vNV`
- `glProgramUniform1ui64NV`
- `glProgramUniform1ui64vNV`
- `glProgramUniform2i64NV`
- `glProgramUniform2i64vNV`
- `glProgramUniform2ui64NV`
- `glProgramUniform2ui64vNV`
- `glProgramUniform3i64NV`
- `glProgramUniform3i64vNV`
- `glProgramUniform3ui64NV`
- `glProgramUniform3ui64vNV`
- `glProgramUniform4i64NV`
- `glProgramUniform4i64vNV`
- `glProgramUniform4ui64NV`
- `glProgramUniform4ui64vNV`
- `glProgramUniformHandleui64NV`
- `glProgramUniformHandleui64vNV`
- `glProgramUniformui64NV`
- `glProgramUniformui64vNV`
- `glProgramVertexLimitNV`
- `glQueryResourceNV`
- `glQueryResourceTagNV`
- `glReadBufferNV`
- `glRenderbufferStorageMultisampleCoverageNV`
- `glRenderbufferStorageMultisampleNV`
- `glRenderGpuMaskNV`
- `glRequestResidentProgramsNV`
- `glResetMemoryObjectParameterNV`
- `glResolveDepthValuesNV`
- `glResumeTransformFeedbackNV`
- `glSampleMaskIndexedNV`
- `glScissorArrayvNV`
- `glScissorExclusiveArrayvNV`
- `glScissorExclusiveNV`
- `glScissorIndexedNV`
- `glScissorIndexedvNV`
- `glSecondaryColor3hNV`
- `glSecondaryColor3hvNV`
- `glSecondaryColorFormatNV`
- `glSemaphoreParameterivNV`
- `glSetFenceNV`
- `glShadingRateImageBarrierNV`
- `glShadingRateImagePaletteNV`
- `glShadingRateSampleOrderCustomNV`
- `glShadingRateSampleOrderNV`
- `glSignalVkFenceNV`
- `glSignalVkSemaphoreNV`
- `glStateCaptureNV`
- `glStencilFillPathInstancedNV`
- `glStencilFillPathNV`
- `glStencilStrokePathInstancedNV`
- `glStencilStrokePathNV`
- `glStencilThenCoverFillPathInstancedNV`
- `glStencilThenCoverFillPathNV`
- `glStencilThenCoverStrokePathInstancedNV`
- `glStencilThenCoverStrokePathNV`
- `glSubpixelPrecisionBiasNV`
- `glTestFenceNV`
- `glTexAttachMemoryNV`
- `glTexCoord1hNV`
- `glTexCoord1hvNV`
- `glTexCoord2hNV`
- `glTexCoord2hvNV`
- `glTexCoord3hNV`
- `glTexCoord3hvNV`
- `glTexCoord4hNV`
- `glTexCoord4hvNV`
- `glTexCoordFormatNV`
- `glTexImage2DMultisampleCoverageNV`
- `glTexImage3DMultisampleCoverageNV`
- `glTexPageCommitmentMemNV`
- `glTexRenderbufferNV`
- `glTextureAttachMemoryNV`
- `glTextureBarrierNV`
- `glTextureImage2DMultisampleCoverageNV`
- `glTextureImage2DMultisampleNV`
- `glTextureImage3DMultisampleCoverageNV`
- `glTextureImage3DMultisampleNV`
- `glTexturePageCommitmentMemNV`
- `glTrackMatrixNV`
- `glTransformFeedbackAttribsNV`
- `glTransformFeedbackStreamAttribsNV`
- `glTransformFeedbackVaryingsNV`
- `glTransformPathNV`
- `glUniform1i64NV`
- `glUniform1i64vNV`
- `glUniform1ui64NV`
- `glUniform1ui64vNV`
- `glUniform2i64NV`
- `glUniform2i64vNV`
- `glUniform2ui64NV`
- `glUniform2ui64vNV`
- `glUniform3i64NV`
- `glUniform3i64vNV`
- `glUniform3ui64NV`
- `glUniform3ui64vNV`
- `glUniform4i64NV`
- `glUniform4i64vNV`
- `glUniform4ui64NV`
- `glUniform4ui64vNV`
- `glUniformHandleui64NV`
- `glUniformHandleui64vNV`
- `glUniformMatrix2x3fvNV`
- `glUniformMatrix2x4fvNV`
- `glUniformMatrix3x2fvNV`
- `glUniformMatrix3x4fvNV`
- `glUniformMatrix4x2fvNV`
- `glUniformMatrix4x3fvNV`
- `glUniformui64NV`
- `glUniformui64vNV`
- `glVDPAUFiniNV`
- `glVDPAUGetSurfaceivNV`
- `glVDPAUInitNV`
- `glVDPAUIsSurfaceNV`
- `glVDPAUMapSurfacesNV`
- `glVDPAURegisterOutputSurfaceNV`
- `glVDPAURegisterVideoSurfaceNV`
- `glVDPAURegisterVideoSurfaceWithPictureStructureNV`
- `glVDPAUSurfaceAccessNV`
- `glVDPAUUnmapSurfacesNV`
- `glVDPAUUnregisterSurfaceNV`
- `glVertex2hNV`
- `glVertex2hvNV`
- `glVertex3hNV`
- `glVertex3hvNV`
- `glVertex4hNV`
- `glVertex4hvNV`
- `glVertexArrayRangeNV`
- `glVertexAttrib1dNV`
- `glVertexAttrib1dvNV`
- `glVertexAttrib1fNV`
- `glVertexAttrib1fvNV`
- `glVertexAttrib1hNV`
- `glVertexAttrib1hvNV`
- `glVertexAttrib1sNV`
- `glVertexAttrib1svNV`
- `glVertexAttrib2dNV`
- `glVertexAttrib2dvNV`
- `glVertexAttrib2fNV`
- `glVertexAttrib2fvNV`
- `glVertexAttrib2hNV`
- `glVertexAttrib2hvNV`
- `glVertexAttrib2sNV`
- `glVertexAttrib2svNV`
- `glVertexAttrib3dNV`
- `glVertexAttrib3dvNV`
- `glVertexAttrib3fNV`
- `glVertexAttrib3fvNV`
- `glVertexAttrib3hNV`
- `glVertexAttrib3hvNV`
- `glVertexAttrib3sNV`
- `glVertexAttrib3svNV`
- `glVertexAttrib4dNV`
- `glVertexAttrib4dvNV`
- `glVertexAttrib4fNV`
- `glVertexAttrib4fvNV`
- `glVertexAttrib4hNV`
- `glVertexAttrib4hvNV`
- `glVertexAttrib4sNV`
- `glVertexAttrib4svNV`
- `glVertexAttrib4ubNV`
- `glVertexAttrib4ubvNV`
- `glVertexAttribDivisorNV`
- `glVertexAttribFormatNV`
- `glVertexAttribIFormatNV`
- `glVertexAttribL1i64NV`
- `glVertexAttribL1i64vNV`
- `glVertexAttribL1ui64NV`
- `glVertexAttribL1ui64vNV`
- `glVertexAttribL2i64NV`
- `glVertexAttribL2i64vNV`
- `glVertexAttribL2ui64NV`
- `glVertexAttribL2ui64vNV`
- `glVertexAttribL3i64NV`
- `glVertexAttribL3i64vNV`
- `glVertexAttribL3ui64NV`
- `glVertexAttribL3ui64vNV`
- `glVertexAttribL4i64NV`
- `glVertexAttribL4i64vNV`
- `glVertexAttribL4ui64NV`
- `glVertexAttribL4ui64vNV`
- `glVertexAttribLFormatNV`
- `glVertexAttribPointerNV`
- `glVertexAttribs1dvNV`
- `glVertexAttribs1fvNV`
- `glVertexAttribs1hvNV`
- `glVertexAttribs1svNV`
- `glVertexAttribs2dvNV`
- `glVertexAttribs2fvNV`
- `glVertexAttribs2hvNV`
- `glVertexAttribs2svNV`
- `glVertexAttribs3dvNV`
- `glVertexAttribs3fvNV`
- `glVertexAttribs3hvNV`
- `glVertexAttribs3svNV`
- `glVertexAttribs4dvNV`
- `glVertexAttribs4fvNV`
- `glVertexAttribs4hvNV`
- `glVertexAttribs4svNV`
- `glVertexAttribs4ubvNV`
- `glVertexFormatNV`
- `glVertexWeighthNV`
- `glVertexWeighthvNV`
- `glVideoCaptureNV`
- `glVideoCaptureStreamParameterdvNV`
- `glVideoCaptureStreamParameterfvNV`
- `glVideoCaptureStreamParameterivNV`
- `glViewportArrayvNV`
- `glViewportIndexedfNV`
- `glViewportIndexedfvNV`
- `glViewportPositionWScaleNV`
- `glViewportSwizzleNV`
- `glWaitVkSemaphoreNV`
- `glWeightPathsNV`

## NVX (15 functions)

### Version extension-only (15 functions)

- `glAsyncCopyBufferSubDataNVX`
- `glAsyncCopyImageSubDataNVX`
- `glBeginConditionalRenderNVX`
- `glClientWaitSemaphoreui64NVX`
- `glCreateProgressFenceNVX`
- `glEndConditionalRenderNVX`
- `glLGPUCopyImageSubDataNVX`
- `glLGPUInterlockNVX`
- `glLGPUNamedBufferSubDataNVX`
- `glMulticastScissorArrayvNVX`
- `glMulticastViewportArrayvNVX`
- `glMulticastViewportPositionWScaleNVX`
- `glSignalSemaphoreui64NVX`
- `glUploadGpuMaskNVX`
- `glWaitSemaphoreui64NVX`

## OES (224 functions)

### Version extension-only (224 functions)

- `glAccumxOES`
- `glAlphaFuncxOES`
- `glBindFramebufferOES`
- `glBindRenderbufferOES`
- `glBindVertexArrayOES`
- `glBitmapxOES`
- `glBlendColorxOES`
- `glBlendEquationiOES`
- `glBlendEquationOES`
- `glBlendEquationSeparateiOES`
- `glBlendEquationSeparateOES`
- `glBlendFunciOES`
- `glBlendFuncSeparateiOES`
- `glBlendFuncSeparateOES`
- `glCheckFramebufferStatusOES`
- `glClearAccumxOES`
- `glClearColorxOES`
- `glClearDepthfOES`
- `glClearDepthxOES`
- `glClipPlanefOES`
- `glClipPlanexOES`
- `glColor3xOES`
- `glColor3xvOES`
- `glColor4xOES`
- `glColor4xvOES`
- `glColorMaskiOES`
- `glCompressedTexImage3DOES`
- `glCompressedTexSubImage3DOES`
- `glConvolutionParameterxOES`
- `glConvolutionParameterxvOES`
- `glCopyImageSubDataOES`
- `glCopyTexSubImage3DOES`
- `glCurrentPaletteMatrixOES`
- `glDeleteFramebuffersOES`
- `glDeleteRenderbuffersOES`
- `glDeleteVertexArraysOES`
- `glDepthRangeArrayfvOES`
- `glDepthRangefOES`
- `glDepthRangeIndexedfOES`
- `glDepthRangexOES`
- `glDisableiOES`
- `glDrawElementsBaseVertexOES`
- `glDrawElementsInstancedBaseVertexOES`
- `glDrawRangeElementsBaseVertexOES`
- `glDrawTexfOES`
- `glDrawTexfvOES`
- `glDrawTexiOES`
- `glDrawTexivOES`
- `glDrawTexsOES`
- `glDrawTexsvOES`
- `glDrawTexxOES`
- `glDrawTexxvOES`
- `glEGLImageTargetRenderbufferStorageOES`
- `glEGLImageTargetTexture2DOES`
- `glEnableiOES`
- `glEvalCoord1xOES`
- `glEvalCoord1xvOES`
- `glEvalCoord2xOES`
- `glEvalCoord2xvOES`
- `glFeedbackBufferxOES`
- `glFogxOES`
- `glFogxvOES`
- `glFramebufferRenderbufferOES`
- `glFramebufferTexture2DOES`
- `glFramebufferTexture3DOES`
- `glFramebufferTextureOES`
- `glFrustumfOES`
- `glFrustumxOES`
- `glGenerateMipmapOES`
- `glGenFramebuffersOES`
- `glGenRenderbuffersOES`
- `glGenVertexArraysOES`
- `glGetBufferPointervOES`
- `glGetClipPlanefOES`
- `glGetClipPlanexOES`
- `glGetConvolutionParameterxvOES`
- `glGetFixedvOES`
- `glGetFloati_vOES`
- `glGetFramebufferAttachmentParameterivOES`
- `glGetHistogramParameterxvOES`
- `glGetLightxOES`
- `glGetLightxvOES`
- `glGetMapxvOES`
- `glGetMaterialxOES`
- `glGetMaterialxvOES`
- `glGetProgramBinaryOES`
- `glGetRenderbufferParameterivOES`
- `glGetSamplerParameterIivOES`
- `glGetSamplerParameterIuivOES`
- `glGetTexEnvxvOES`
- `glGetTexGenfvOES`
- `glGetTexGenivOES`
- `glGetTexGenxvOES`
- `glGetTexLevelParameterxvOES`
- `glGetTexParameterIivOES`
- `glGetTexParameterIuivOES`
- `glGetTexParameterxvOES`
- `glIndexxOES`
- `glIndexxvOES`
- `glIsEnablediOES`
- `glIsFramebufferOES`
- `glIsRenderbufferOES`
- `glIsVertexArrayOES`
- `glLightModelxOES`
- `glLightModelxvOES`
- `glLightxOES`
- `glLightxvOES`
- `glLineWidthxOES`
- `glLoadMatrixxOES`
- `glLoadPaletteFromModelViewMatrixOES`
- `glLoadTransposeMatrixxOES`
- `glMap1xOES`
- `glMap2xOES`
- `glMapBufferOES`
- `glMapGrid1xOES`
- `glMapGrid2xOES`
- `glMaterialxOES`
- `glMaterialxvOES`
- `glMatrixIndexPointerOES`
- `glMinSampleShadingOES`
- `glMultiTexCoord1bOES`
- `glMultiTexCoord1bvOES`
- `glMultiTexCoord1xOES`
- `glMultiTexCoord1xvOES`
- `glMultiTexCoord2bOES`
- `glMultiTexCoord2bvOES`
- `glMultiTexCoord2xOES`
- `glMultiTexCoord2xvOES`
- `glMultiTexCoord3bOES`
- `glMultiTexCoord3bvOES`
- `glMultiTexCoord3xOES`
- `glMultiTexCoord3xvOES`
- `glMultiTexCoord4bOES`
- `glMultiTexCoord4bvOES`
- `glMultiTexCoord4xOES`
- `glMultiTexCoord4xvOES`
- `glMultMatrixxOES`
- `glMultTransposeMatrixxOES`
- `glNormal3xOES`
- `glNormal3xvOES`
- `glOrthofOES`
- `glOrthoxOES`
- `glPassThroughxOES`
- `glPatchParameteriOES`
- `glPixelTransferxOES`
- `glPixelZoomxOES`
- `glPointParameterxOES`
- `glPointParameterxvOES`
- `glPointSizePointerOES`
- `glPointSizexOES`
- `glPolygonOffsetxOES`
- `glPrimitiveBoundingBoxOES`
- `glPrioritizeTexturesxOES`
- `glProgramBinaryOES`
- `glQueryMatrixxOES`
- `glRasterPos2xOES`
- `glRasterPos2xvOES`
- `glRasterPos3xOES`
- `glRasterPos3xvOES`
- `glRasterPos4xOES`
- `glRasterPos4xvOES`
- `glRectxOES`
- `glRectxvOES`
- `glRenderbufferStorageOES`
- `glRotatexOES`
- `glSampleCoveragexOES`
- `glSamplerParameterIivOES`
- `glSamplerParameterIuivOES`
- `glScalexOES`
- `glScissorArrayvOES`
- `glScissorIndexedOES`
- `glScissorIndexedvOES`
- `glTexBufferOES`
- `glTexBufferRangeOES`
- `glTexCoord1bOES`
- `glTexCoord1bvOES`
- `glTexCoord1xOES`
- `glTexCoord1xvOES`
- `glTexCoord2bOES`
- `glTexCoord2bvOES`
- `glTexCoord2xOES`
- `glTexCoord2xvOES`
- `glTexCoord3bOES`
- `glTexCoord3bvOES`
- `glTexCoord3xOES`
- `glTexCoord3xvOES`
- `glTexCoord4bOES`
- `glTexCoord4bvOES`
- `glTexCoord4xOES`
- `glTexCoord4xvOES`
- `glTexEnvxOES`
- `glTexEnvxvOES`
- `glTexGenfOES`
- `glTexGenfvOES`
- `glTexGeniOES`
- `glTexGenivOES`
- `glTexGenxOES`
- `glTexGenxvOES`
- `glTexImage3DOES`
- `glTexParameterIivOES`
- `glTexParameterIuivOES`
- `glTexParameterxOES`
- `glTexParameterxvOES`
- `glTexStorage3DMultisampleOES`
- `glTexSubImage3DOES`
- `glTextureViewOES`
- `glTranslatexOES`
- `glUnmapBufferOES`
- `glVertex2bOES`
- `glVertex2bvOES`
- `glVertex2xOES`
- `glVertex2xvOES`
- `glVertex3bOES`
- `glVertex3bvOES`
- `glVertex3xOES`
- `glVertex3xvOES`
- `glVertex4bOES`
- `glVertex4bvOES`
- `glVertex4xOES`
- `glVertex4xvOES`
- `glViewportArrayvOES`
- `glViewportIndexedfOES`
- `glViewportIndexedfvOES`
- `glWeightPointerOES`

## OVR (3 functions)

### Version extension-only (3 functions)

- `glFramebufferTextureMultisampleMultiviewOVR`
- `glFramebufferTextureMultiviewOVR`
- `glNamedFramebufferTextureMultiviewOVR`

## PGI (1 functions)

### Version extension-only (1 functions)

- `glHintPGI`

## QCOM (27 functions)

### Version extension-only (27 functions)

- `glAlphaFuncQCOM`
- `glDisableDriverControlQCOM`
- `glEnableDriverControlQCOM`
- `glEndTilingQCOM`
- `glExtGetBufferPointervQCOM`
- `glExtGetBuffersQCOM`
- `glExtGetFramebuffersQCOM`
- `glExtGetProgramBinarySourceQCOM`
- `glExtGetProgramsQCOM`
- `glExtGetRenderbuffersQCOM`
- `glExtGetShadersQCOM`
- `glExtGetTexLevelParameterivQCOM`
- `glExtGetTexSubImageQCOM`
- `glExtGetTexturesQCOM`
- `glExtIsProgramBinaryQCOM`
- `glExtrapolateTex2DQCOM`
- `glExtTexObjectStateOverrideiQCOM`
- `glFramebufferFetchBarrierQCOM`
- `glFramebufferFoveationConfigQCOM`
- `glFramebufferFoveationParametersQCOM`
- `glGetDriverControlsQCOM`
- `glGetDriverControlStringQCOM`
- `glShadingRateQCOM`
- `glStartTilingQCOM`
- `glTexEstimateMotionQCOM`
- `glTexEstimateMotionRegionsQCOM`
- `glTextureFoveationParametersQCOM`

## SGI (7 functions)

### Version extension-only (7 functions)

- `glColorTableParameterfvSGI`
- `glColorTableParameterivSGI`
- `glColorTableSGI`
- `glCopyColorTableSGI`
- `glGetColorTableParameterfvSGI`
- `glGetColorTableParameterivSGI`
- `glGetColorTableSGI`

## SGIS (21 functions)

### Version extension-only (21 functions)

- `glDetailTexFuncSGIS`
- `glFogFuncSGIS`
- `glGetDetailTexFuncSGIS`
- `glGetFogFuncSGIS`
- `glGetPixelTexGenParameterfvSGIS`
- `glGetPixelTexGenParameterivSGIS`
- `glGetSharpenTexFuncSGIS`
- `glGetTexFilterFuncSGIS`
- `glPixelTexGenParameterfSGIS`
- `glPixelTexGenParameterfvSGIS`
- `glPixelTexGenParameteriSGIS`
- `glPixelTexGenParameterivSGIS`
- `glPointParameterfSGIS`
- `glPointParameterfvSGIS`
- `glSampleMaskSGIS`
- `glSamplePatternSGIS`
- `glSharpenTexFuncSGIS`
- `glTexFilterFuncSGIS`
- `glTexImage4DSGIS`
- `glTexSubImage4DSGIS`
- `glTextureColorMaskSGIS`

## SGIX (50 functions)

### Version extension-only (50 functions)

- `glAsyncMarkerSGIX`
- `glDeformationMap3dSGIX`
- `glDeformationMap3fSGIX`
- `glDeformSGIX`
- `glDeleteAsyncMarkersSGIX`
- `glFinishAsyncSGIX`
- `glFlushRasterSGIX`
- `glFragmentColorMaterialSGIX`
- `glFragmentLightfSGIX`
- `glFragmentLightfvSGIX`
- `glFragmentLightiSGIX`
- `glFragmentLightivSGIX`
- `glFragmentLightModelfSGIX`
- `glFragmentLightModelfvSGIX`
- `glFragmentLightModeliSGIX`
- `glFragmentLightModelivSGIX`
- `glFragmentMaterialfSGIX`
- `glFragmentMaterialfvSGIX`
- `glFragmentMaterialiSGIX`
- `glFragmentMaterialivSGIX`
- `glFrameZoomSGIX`
- `glGenAsyncMarkersSGIX`
- `glGetFragmentLightfvSGIX`
- `glGetFragmentLightivSGIX`
- `glGetFragmentMaterialfvSGIX`
- `glGetFragmentMaterialivSGIX`
- `glGetInstrumentsSGIX`
- `glGetListParameterfvSGIX`
- `glGetListParameterivSGIX`
- `glIglooInterfaceSGIX`
- `glInstrumentsBufferSGIX`
- `glIsAsyncMarkerSGIX`
- `glLightEnviSGIX`
- `glListParameterfSGIX`
- `glListParameterfvSGIX`
- `glListParameteriSGIX`
- `glListParameterivSGIX`
- `glLoadIdentityDeformationMapSGIX`
- `glPixelTexGenSGIX`
- `glPollAsyncSGIX`
- `glPollInstrumentsSGIX`
- `glReadInstrumentsSGIX`
- `glReferencePlaneSGIX`
- `glSpriteParameterfSGIX`
- `glSpriteParameterfvSGIX`
- `glSpriteParameteriSGIX`
- `glSpriteParameterivSGIX`
- `glStartInstrumentsSGIX`
- `glStopInstrumentsSGIX`
- `glTagSampleBufferSGIX`

## SUN (56 functions)

### Version extension-only (56 functions)

- `glColor3fVertex3fSUN`
- `glColor3fVertex3fvSUN`
- `glColor4fNormal3fVertex3fSUN`
- `glColor4fNormal3fVertex3fvSUN`
- `glColor4ubVertex2fSUN`
- `glColor4ubVertex2fvSUN`
- `glColor4ubVertex3fSUN`
- `glColor4ubVertex3fvSUN`
- `glDrawMeshArraysSUN`
- `glGlobalAlphaFactorbSUN`
- `glGlobalAlphaFactordSUN`
- `glGlobalAlphaFactorfSUN`
- `glGlobalAlphaFactoriSUN`
- `glGlobalAlphaFactorsSUN`
- `glGlobalAlphaFactorubSUN`
- `glGlobalAlphaFactoruiSUN`
- `glGlobalAlphaFactorusSUN`
- `glNormal3fVertex3fSUN`
- `glNormal3fVertex3fvSUN`
- `glReplacementCodePointerSUN`
- `glReplacementCodeubSUN`
- `glReplacementCodeubvSUN`
- `glReplacementCodeuiColor3fVertex3fSUN`
- `glReplacementCodeuiColor3fVertex3fvSUN`
- `glReplacementCodeuiColor4fNormal3fVertex3fSUN`
- `glReplacementCodeuiColor4fNormal3fVertex3fvSUN`
- `glReplacementCodeuiColor4ubVertex3fSUN`
- `glReplacementCodeuiColor4ubVertex3fvSUN`
- `glReplacementCodeuiNormal3fVertex3fSUN`
- `glReplacementCodeuiNormal3fVertex3fvSUN`
- `glReplacementCodeuiSUN`
- `glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN`
- `glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN`
- `glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN`
- `glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN`
- `glReplacementCodeuiTexCoord2fVertex3fSUN`
- `glReplacementCodeuiTexCoord2fVertex3fvSUN`
- `glReplacementCodeuiVertex3fSUN`
- `glReplacementCodeuiVertex3fvSUN`
- `glReplacementCodeuivSUN`
- `glReplacementCodeusSUN`
- `glReplacementCodeusvSUN`
- `glTexCoord2fColor3fVertex3fSUN`
- `glTexCoord2fColor3fVertex3fvSUN`
- `glTexCoord2fColor4fNormal3fVertex3fSUN`
- `glTexCoord2fColor4fNormal3fVertex3fvSUN`
- `glTexCoord2fColor4ubVertex3fSUN`
- `glTexCoord2fColor4ubVertex3fvSUN`
- `glTexCoord2fNormal3fVertex3fSUN`
- `glTexCoord2fNormal3fVertex3fvSUN`
- `glTexCoord2fVertex3fSUN`
- `glTexCoord2fVertex3fvSUN`
- `glTexCoord4fColor4fNormal3fVertex4fSUN`
- `glTexCoord4fColor4fNormal3fVertex4fvSUN`
- `glTexCoord4fVertex4fSUN`
- `glTexCoord4fVertex4fvSUN`
