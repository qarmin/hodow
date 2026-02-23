//! GL_VERSION: 4.5

use std::error::Error;

use crate::opengl::test_trait::{GLTest, GLVersion};

pub struct GL45DSAExtendedTest;

impl GLTest for GL45DSAExtendedTest {
    fn name(&self) -> &'static str {
        "GL45_DSA_Extended"
    }

    fn gl_version(&self) -> GLVersion {
        GLVersion::new(4, 5)
    }

    fn run(&self) -> Result<String, Box<dyn Error>> {
        unsafe {
            const COLOR_TABLE: u32 = 0x80D0;
            const CONVOLUTION_1D: u32 = 0x8010;
            const SEPARABLE_2D: u32 = 0x8012;
            const HISTOGRAM: u32 = 0x8024;
            const MINMAX: u32 = 0x802E;
            const MAP1_VERTEX_3: u32 = 0x0D97;
            const COEFF: u32 = 0x0A00;
            const PIXEL_MAP_I_TO_R: u32 = 0x0C70;
            let mut buffer = 0;
            gl::CreateBuffers(1, &mut buffer);
            let data: [f32; 16] = [1.0; 16];
            gl::NamedBufferData(buffer, (data.len() * std::mem::size_of::<f32>()) as isize, data.as_ptr() as *const _, gl::STATIC_DRAW);
            let subdata: [f32; 4] = [2.0, 3.0, 4.0, 5.0];
            gl::NamedBufferSubData(buffer, 0, (subdata.len() * std::mem::size_of::<f32>()) as isize, subdata.as_ptr() as *const _);
            let clear_data: [u8; 4] = [0, 0, 0, 0];
            gl::ClearNamedBufferData(buffer, gl::RGBA8, gl::RGBA, gl::UNSIGNED_BYTE, clear_data.as_ptr() as *const _);
            gl::ClearNamedBufferSubData(buffer, gl::RGBA8, 0, 64, gl::RGBA, gl::UNSIGNED_BYTE, clear_data.as_ptr() as *const _);
            let mapped = gl::MapNamedBuffer(buffer, gl::READ_ONLY);
            if !mapped.is_null() {
                gl::UnmapNamedBuffer(buffer);
            }
            let mapped_range = gl::MapNamedBufferRange(buffer, 0, 256, gl::MAP_READ_BIT);
            if !mapped_range.is_null() {
                gl::FlushMappedNamedBufferRange(buffer, 0, 128);
                gl::UnmapNamedBuffer(buffer);
            }
            let mut param = 0;
            gl::GetNamedBufferParameteriv(buffer, gl::BUFFER_SIZE, &mut param);
            let mut param64 = 0i64;
            gl::GetNamedBufferParameteri64v(buffer, gl::BUFFER_SIZE, &mut param64);
            let mut retrieved_data: [u8; 16] = [0; 16];
            gl::GetNamedBufferSubData(buffer, 0, 16, retrieved_data.as_mut_ptr() as *mut _);
            let mut buffer2 = 0;
            gl::CreateBuffers(1, &mut buffer2);
            gl::NamedBufferData(buffer2, 256, std::ptr::null(), gl::STATIC_DRAW);
            gl::CopyNamedBufferSubData(buffer, buffer2, 0, 0, 128);
            let mut fbo = 0;
            gl::CreateFramebuffers(1, &mut fbo);
            let mut texture = 0;
            gl::CreateTextures(gl::TEXTURE_2D, 1, &mut texture);
            gl::TextureStorage2D(texture, 4, gl::RGBA8, 512, 512);
            gl::NamedFramebufferTexture(fbo, gl::COLOR_ATTACHMENT0, texture, 0);
            gl::NamedFramebufferTextureLayer(fbo, gl::COLOR_ATTACHMENT0, texture, 0, 0);
            let mut rbo = 0;
            gl::CreateRenderbuffers(1, &mut rbo);
            gl::NamedRenderbufferStorage(rbo, gl::DEPTH24_STENCIL8, 512, 512);
            gl::NamedFramebufferRenderbuffer(fbo, gl::DEPTH_STENCIL_ATTACHMENT, gl::RENDERBUFFER, rbo);
            gl::NamedRenderbufferStorageMultisample(rbo, 4, gl::RGBA8, 512, 512);
            let mut rbo_param = 0;
            gl::GetNamedRenderbufferParameteriv(rbo, gl::RENDERBUFFER_WIDTH, &mut rbo_param);
            gl::NamedFramebufferDrawBuffer(fbo, gl::COLOR_ATTACHMENT0);
            let draw_buffers = [gl::COLOR_ATTACHMENT0, gl::COLOR_ATTACHMENT1];
            gl::NamedFramebufferDrawBuffers(fbo, 2, draw_buffers.as_ptr());
            gl::NamedFramebufferReadBuffer(fbo, gl::COLOR_ATTACHMENT0);
            let mut fbo_param = 0;
            gl::GetNamedFramebufferParameteriv(fbo, gl::FRAMEBUFFER_DEFAULT_WIDTH, &mut fbo_param);
            let mut attach_param = 0;
            gl::GetNamedFramebufferAttachmentParameteriv(fbo, gl::COLOR_ATTACHMENT0, gl::FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE, &mut attach_param);
            let status = gl::CheckNamedFramebufferStatus(fbo, gl::FRAMEBUFFER);
            gl::ClearNamedFramebufferiv(fbo, gl::COLOR, 0, [0i32, 0, 0, 255].as_ptr());
            gl::ClearNamedFramebufferuiv(fbo, gl::COLOR, 0, [0u32, 0, 0, 255].as_ptr());
            gl::ClearNamedFramebufferfv(fbo, gl::COLOR, 0, [0.0f32, 0.0, 0.0, 1.0].as_ptr());
            gl::ClearNamedFramebufferfi(fbo, gl::DEPTH_STENCIL, 0, 1.0, 0);
            gl::BlitNamedFramebuffer(
                fbo, 0,
                0, 0, 512, 512,
                0, 0, 512, 512,
                gl::COLOR_BUFFER_BIT,
                gl::NEAREST,
            );
            gl::InvalidateNamedFramebufferData(fbo, 1, [gl::COLOR_ATTACHMENT0].as_ptr());
            gl::InvalidateNamedFramebufferSubData(fbo, 1, [gl::COLOR_ATTACHMENT0].as_ptr(), 0, 0, 256, 256);
            let mut texture1d = 0;
            gl::CreateTextures(gl::TEXTURE_1D, 1, &mut texture1d);
            gl::TextureStorage1D(texture1d, 4, gl::RGBA8, 256);
            let tex_data: Vec<u8> = vec![128; 128 * 4];
            gl::TextureSubImage1D(texture1d, 0, 0, 128, gl::RGBA, gl::UNSIGNED_BYTE, tex_data.as_ptr() as *const _);
            let comp_data: Vec<u8> = vec![0; 256];
            gl::CompressedTextureSubImage1D(texture1d, 0, 0, 64, gl::COMPRESSED_RGBA, 256, comp_data.as_ptr() as *const _);
            gl::CopyTextureSubImage1D(texture1d, 0, 0, 0, 0, 64);
            let mut texture2d = 0;
            gl::CreateTextures(gl::TEXTURE_2D, 1, &mut texture2d);
            gl::TextureStorage2D(texture2d, 4, gl::RGBA8, 256, 256);
            let tex_data_2d: Vec<u8> = vec![128; 128 * 128 * 4];
            gl::TextureSubImage2D(texture2d, 0, 0, 0, 128, 128, gl::RGBA, gl::UNSIGNED_BYTE, tex_data_2d.as_ptr() as *const _);
            let comp_data_2d: Vec<u8> = vec![0; 1024];
            gl::CompressedTextureSubImage2D(texture2d, 0, 0, 0, 64, 64, gl::COMPRESSED_RGBA, 1024, comp_data_2d.as_ptr() as *const _);
            gl::CopyTextureSubImage2D(texture2d, 0, 0, 0, 0, 0, 64, 64);
            let mut texture3d = 0;
            gl::CreateTextures(gl::TEXTURE_3D, 1, &mut texture3d);
            gl::TextureStorage3D(texture3d, 4, gl::RGBA8, 128, 128, 128);
            let tex_data_3d: Vec<u8> = vec![128; 64 * 64 * 64 * 4];
            gl::TextureSubImage3D(texture3d, 0, 0, 0, 0, 64, 64, 64, gl::RGBA, gl::UNSIGNED_BYTE, tex_data_3d.as_ptr() as *const _);
            let comp_data_3d: Vec<u8> = vec![0; 4096];
            gl::CompressedTextureSubImage3D(texture3d, 0, 0, 0, 0, 32, 32, 32, gl::COMPRESSED_RGBA, 4096, comp_data_3d.as_ptr() as *const _);
            gl::CopyTextureSubImage3D(texture3d, 0, 0, 0, 0, 0, 0, 32, 32);
            gl::TextureParameterf(texture2d, gl::TEXTURE_MIN_FILTER, gl::LINEAR as f32);
            gl::TextureParameterfv(texture2d, gl::TEXTURE_BORDER_COLOR, [0.0f32, 0.0, 0.0, 1.0].as_ptr());
            gl::TextureParameteri(texture2d, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);
            gl::TextureParameteriv(texture2d, gl::TEXTURE_SWIZZLE_RGBA, [gl::RED as i32, gl::GREEN as i32, gl::BLUE as i32, gl::ALPHA as i32].as_ptr());
            gl::TextureParameterIiv(texture2d, gl::TEXTURE_BORDER_COLOR, [0i32, 0, 0, 255].as_ptr());
            gl::TextureParameterIuiv(texture2d, gl::TEXTURE_BORDER_COLOR, [0u32, 0, 0, 255].as_ptr());
            let mut tex_param_f = 0.0f32;
            gl::GetTextureParameterfv(texture2d, gl::TEXTURE_MIN_FILTER, &mut tex_param_f);
            let mut tex_param_i = 0i32;
            gl::GetTextureParameteriv(texture2d, gl::TEXTURE_MAG_FILTER, &mut tex_param_i);
            let mut tex_param_ii: [i32; 4] = [0; 4];
            gl::GetTextureParameterIiv(texture2d, gl::TEXTURE_BORDER_COLOR, tex_param_ii.as_mut_ptr());
            let mut tex_param_iui: [u32; 4] = [0; 4];
            gl::GetTextureParameterIuiv(texture2d, gl::TEXTURE_BORDER_COLOR, tex_param_iui.as_mut_ptr());
            let mut level_param = 0;
            gl::GetTextureLevelParameterfv(texture2d, 0, gl::TEXTURE_WIDTH, &mut tex_param_f);
            gl::GetTextureLevelParameteriv(texture2d, 0, gl::TEXTURE_WIDTH, &mut level_param);
            let mut image_data: Vec<u8> = vec![0; 256 * 256 * 4];
            gl::GetTextureImage(texture2d, 0, gl::RGBA, gl::UNSIGNED_BYTE, (image_data.len()) as i32, image_data.as_mut_ptr() as *mut _);
            gl::GetCompressedTextureImage(texture2d, 0, 65536, image_data.as_mut_ptr() as *mut _);
            gl::GenerateTextureMipmap(texture2d);
            gl::BindTextureUnit(0, texture2d);
            let mut vao = 0;
            gl::CreateVertexArrays(1, &mut vao);
            gl::EnableVertexArrayAttrib(vao, 0);
            gl::DisableVertexArrayAttrib(vao, 1);
            gl::VertexArrayElementBuffer(vao, buffer);
            gl::VertexArrayVertexBuffer(vao, 0, buffer, 0, 12);
            let buffers = [buffer, buffer2];
            let offsets: [isize; 2] = [0, 0];
            let strides: [i32; 2] = [12, 12];
            gl::VertexArrayVertexBuffers(vao, 0, 2, buffers.as_ptr(), offsets.as_ptr(), strides.as_ptr());
            gl::VertexArrayAttribFormat(vao, 0, 3, gl::FLOAT, gl::FALSE, 0);
            gl::VertexArrayAttribIFormat(vao, 1, 3, gl::INT, 0);
            gl::VertexArrayAttribLFormat(vao, 2, 3, gl::DOUBLE, 0);
            gl::VertexArrayAttribBinding(vao, 0, 0);
            gl::VertexArrayBindingDivisor(vao, 0, 1);
            let mut vao_param = 0;
            gl::GetVertexArrayiv(vao, gl::ELEMENT_ARRAY_BUFFER_BINDING, &mut vao_param);
            gl::GetVertexArrayIndexediv(vao, 0, gl::VERTEX_ATTRIB_ARRAY_ENABLED, &mut vao_param);
            let mut vao_param64 = 0i64;
            gl::GetVertexArrayIndexed64iv(vao, 0, gl::VERTEX_BINDING_OFFSET, &mut vao_param64);
            let mut sampler = 0;
            gl::CreateSamplers(1, &mut sampler);
            gl::SamplerParameterf(sampler, gl::TEXTURE_MIN_FILTER, gl::LINEAR as f32);
            gl::SamplerParameterfv(sampler, gl::TEXTURE_BORDER_COLOR, [0.0f32, 0.0, 0.0, 1.0].as_ptr());
            gl::SamplerParameteri(sampler, gl::TEXTURE_MAG_FILTER, gl::LINEAR as i32);
            gl::SamplerParameteriv(sampler, gl::TEXTURE_SWIZZLE_RGBA, [gl::RED as i32, gl::GREEN as i32, gl::BLUE as i32, gl::ALPHA as i32].as_ptr());
            gl::SamplerParameterIiv(sampler, gl::TEXTURE_BORDER_COLOR, [0i32, 0, 0, 255].as_ptr());
            gl::SamplerParameterIuiv(sampler, gl::TEXTURE_BORDER_COLOR, [0u32, 0, 0, 255].as_ptr());
            let mut queries: [u32; 2] = [0; 2];
            gl::CreateQueries(gl::SAMPLES_PASSED, 2, queries.as_mut_ptr());
            gl::GetQueryBufferObjecti64v(queries[0], buffer, gl::QUERY_RESULT, 0);
            gl::GetQueryBufferObjectiv(queries[0], buffer, gl::QUERY_RESULT, 0);
            gl::GetQueryBufferObjectui64v(queries[0], buffer, gl::QUERY_RESULT, 0);
            gl::GetQueryBufferObjectuiv(queries[0], buffer, gl::QUERY_RESULT, 0);
            gl::MemoryBarrierByRegion(gl::ALL_BARRIER_BITS);
            gl::TextureBarrier();
            gl::GetGraphicsResetStatus();
            gl::GetnCompressedTexImage(gl::TEXTURE_2D, 0, 4096, image_data.as_mut_ptr() as *mut _);
            gl::GetnTexImage(gl::TEXTURE_2D, 0, gl::RGBA, gl::UNSIGNED_BYTE, (image_data.len()) as i32, image_data.as_mut_ptr() as *mut _);
            let mut uniform_val: [f32; 4] = [0.0; 4];
            gl::GetnUniformfv(0, 0, 16, uniform_val.as_mut_ptr());
            let mut uniform_ival: [i32; 4] = [0; 4];
            gl::GetnUniformiv(0, 0, 16, uniform_ival.as_mut_ptr());
            let mut uniform_uval: [u32; 4] = [0; 4];
            gl::GetnUniformuiv(0, 0, 16, uniform_uval.as_mut_ptr());
            gl::ReadnPixels(0, 0, 256, 256, gl::RGBA, gl::UNSIGNED_BYTE, (image_data.len()) as i32, image_data.as_mut_ptr() as *mut _);
            let mut tfs: [u32; 2] = [0; 2];
            gl::CreateTransformFeedbacks(2, tfs.as_mut_ptr());
            gl::TransformFeedbackBufferBase(tfs[0], 0, buffer);
            gl::TransformFeedbackBufferRange(tfs[0], 0, buffer, 0, 512);
            let mut tf_param = 0i32;
            gl::GetTransformFeedbackiv(tfs[0], gl::TRANSFORM_FEEDBACK_BUFFER_BINDING, &mut tf_param);
            gl::GetTransformFeedbacki_v(tfs[0], gl::TRANSFORM_FEEDBACK_BUFFER_BINDING, 0, &mut tf_param);
            let mut tf_param64 = 0i64;
            gl::GetTransformFeedbacki64_v(tfs[0], gl::TRANSFORM_FEEDBACK_BUFFER_START, 0, &mut tf_param64);
            gl::DeleteTransformFeedbacks(2, tfs.as_ptr());
            let mut sub_image: Vec<u8> = vec![0; 32 * 32 * 4];
            gl::GetTextureSubImage(texture2d, 0, 0, 0, 0, 32, 32, 1, gl::RGBA, gl::UNSIGNED_BYTE, sub_image.len() as i32, sub_image.as_mut_ptr() as *mut _);
            gl::GetCompressedTextureSubImage(texture2d, 0, 0, 0, 0, 32, 32, 1, sub_image.len() as i32, sub_image.as_mut_ptr() as *mut _);
            let mut buffer_ptr: *mut std::ffi::c_void = std::ptr::null_mut();
            gl::GetNamedBufferPointerv(buffer, gl::BUFFER_MAP_POINTER, &mut buffer_ptr);
            gl::NamedFramebufferParameteri(fbo, gl::FRAMEBUFFER_DEFAULT_WIDTH, 512);
            gl::TextureBuffer(texture, gl::RGBA8, buffer);
            gl::TextureBufferRange(texture, gl::RGBA8, buffer, 0, 512);
            let mut texture2d_ms = 0;
            gl::CreateTextures(gl::TEXTURE_2D_MULTISAMPLE, 1, &mut texture2d_ms);
            gl::TextureStorage2DMultisample(texture2d_ms, 4, gl::RGBA8, 256, 256, gl::TRUE);
            let mut texture3d_ms = 0;
            gl::CreateTextures(gl::TEXTURE_2D_MULTISAMPLE_ARRAY, 1, &mut texture3d_ms);
            gl::TextureStorage3DMultisample(texture3d_ms, 4, gl::RGBA8, 256, 256, 4, gl::TRUE);
            let mut getsn_data: [u8; 256] = [0; 256];
            gl::GetnUniformdv(0, 0, 256, getsn_data.as_mut_ptr() as *mut f64);
            gl::GetnColorTable(COLOR_TABLE, gl::RGBA, gl::UNSIGNED_BYTE, 256, getsn_data.as_mut_ptr() as *mut _);
            gl::GetnConvolutionFilter(CONVOLUTION_1D, gl::RGBA, gl::UNSIGNED_BYTE, 256, getsn_data.as_mut_ptr() as *mut _);
            gl::GetnSeparableFilter(SEPARABLE_2D, gl::RGBA, gl::UNSIGNED_BYTE, 256, getsn_data.as_mut_ptr() as *mut _, 256, getsn_data.as_mut_ptr() as *mut _, std::ptr::null_mut());
            gl::GetnHistogram(HISTOGRAM, gl::FALSE, gl::RGBA, gl::UNSIGNED_BYTE, 256, getsn_data.as_mut_ptr() as *mut _);
            gl::GetnMinmax(MINMAX, gl::FALSE, gl::RGBA, gl::UNSIGNED_BYTE, 256, getsn_data.as_mut_ptr() as *mut _);
            let mut map_data: [f32; 64] = [0.0; 64];
            gl::GetnMapfv(MAP1_VERTEX_3, COEFF, 256, map_data.as_mut_ptr());
            let mut map_data_d: [f64; 64] = [0.0; 64];
            gl::GetnMapdv(MAP1_VERTEX_3, COEFF, 512, map_data_d.as_mut_ptr());
            let mut map_data_i: [i32; 64] = [0; 64];
            gl::GetnMapiv(MAP1_VERTEX_3, COEFF, 256, map_data_i.as_mut_ptr());
            let mut pixel_map: [f32; 64] = [0.0; 64];
            gl::GetnPixelMapfv(PIXEL_MAP_I_TO_R, 256, pixel_map.as_mut_ptr());
            let mut pixel_map_ui: [u32; 64] = [0; 64];
            gl::GetnPixelMapuiv(PIXEL_MAP_I_TO_R, 256, pixel_map_ui.as_mut_ptr());
            let mut pixel_map_us: [u16; 64] = [0; 64];
            gl::GetnPixelMapusv(PIXEL_MAP_I_TO_R, 128, pixel_map_us.as_mut_ptr());
            let mut polygon_stipple: [u8; 128] = [0; 128];
            gl::GetnPolygonStipple(128, polygon_stipple.as_mut_ptr());
            gl::DeleteTextures(1, &texture2d_ms);
            gl::DeleteTextures(1, &texture3d_ms);
            gl::DeleteQueries(2, queries.as_ptr());
            gl::DeleteSamplers(1, &sampler);
            gl::DeleteVertexArrays(1, &vao);
            gl::DeleteTextures(1, &texture);
            gl::DeleteTextures(1, &texture1d);
            gl::DeleteTextures(1, &texture2d);
            gl::DeleteTextures(1, &texture3d);
            gl::DeleteRenderbuffers(1, &rbo);
            gl::DeleteFramebuffers(1, &fbo);
            gl::DeleteBuffers(1, &buffer);
            gl::DeleteBuffers(1, &buffer2);
            Ok("GL 4.5 DSA extended functions tested successfully".to_string())
        }
    }
}
