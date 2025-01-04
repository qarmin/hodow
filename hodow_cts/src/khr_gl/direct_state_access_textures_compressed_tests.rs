//! `Textures::CompressedSubImageTest` of `gl4cDirectStateAccessTexturesTests.cpp`. The reference data tables are copied from the upstream source by script.

use std::ffi::c_void;

use super::direct_state_access_tests::{check_dsa_support, clean_errors, dsa_outcome};
use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::{TestError, TestOutcome};

static DATA_0X8DBB_2D_8: [glw::GLubyte; 8] = [34, 237, 94, 207, 252, 29, 75, 25];

static DATA_0X8DBB_3D_32: [glw::GLubyte; 32] = [
    34, 237, 94, 207, 252, 29, 75, 25, 34, 237, 44, 173, 101, 230, 139, 254, 34, 237, 176, 88, 174, 127, 248, 206, 34,
    237, 127, 209, 211, 203, 100, 150,
];

static DATA_0X8DBC_2D_8: [glw::GLubyte; 8] = [127, 0, 233, 64, 0, 42, 71, 231];

static DATA_0X8DBC_3D_32: [glw::GLubyte; 32] = [
    127, 0, 233, 64, 0, 42, 71, 231, 127, 0, 20, 227, 162, 33, 246, 1, 127, 0, 143, 57, 86, 0, 136, 53, 127, 0, 192,
    62, 48, 69, 29, 138,
];

static DATA_0X8DBD_2D_16: [glw::GLubyte; 16] = [34, 237, 94, 207, 252, 29, 75, 25, 28, 242, 94, 111, 44, 101, 35, 145];

static DATA_0X8DBD_3D_64: [glw::GLubyte; 64] = [
    34, 237, 94, 207, 252, 29, 75, 25, 28, 242, 94, 111, 44, 101, 35, 145, 34, 237, 44, 173, 101, 230, 139, 254, 28,
    242, 170, 45, 98, 236, 202, 228, 34, 237, 176, 88, 174, 127, 248, 206, 28, 242, 164, 148, 178, 25, 252, 206, 34,
    237, 127, 209, 211, 203, 100, 150, 28, 242, 79, 216, 149, 3, 101, 87,
];

static DATA_0X8DBE_2D_16: [glw::GLubyte; 16] = [127, 0, 233, 64, 0, 42, 71, 231, 127, 0, 233, 144, 23, 163, 100, 115];

static DATA_0X8DBE_3D_64: [glw::GLubyte; 64] = [
    127, 0, 233, 64, 0, 42, 71, 231, 127, 0, 233, 144, 23, 163, 100, 115, 127, 0, 20, 227, 162, 33, 246, 1, 127, 0, 94,
    98, 190, 84, 55, 1, 127, 0, 143, 57, 86, 0, 136, 53, 127, 0, 163, 45, 113, 232, 131, 53, 127, 0, 192, 62, 48, 69,
    29, 138, 127, 0, 128, 182, 138, 61, 157, 204,
];

static DATA_0X8E8C_2D_16: [glw::GLubyte; 16] = [
    144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 89, 143, 140, 166, 183, 113,
];

static DATA_0X8E8C_3D_64: [glw::GLubyte; 64] = [
    144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 89, 143, 140, 166, 183, 113, 144, 43, 143, 15, 254, 15, 152, 153,
    153, 153, 55, 48, 102, 244, 186, 241, 144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 231, 54, 211, 92, 240, 14,
    144, 121, 253, 241, 193, 15, 152, 153, 153, 153, 25, 41, 102, 244, 248, 135,
];

static DATA_0X8E8D_2D_16: [glw::GLubyte; 16] = [
    144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 89, 143, 140, 166, 183, 113,
];

static DATA_0X8E8D_3D_64: [glw::GLubyte; 64] = [
    144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 89, 143, 140, 166, 183, 113, 144, 43, 143, 15, 254, 15, 152, 153,
    153, 153, 55, 48, 102, 244, 186, 241, 144, 43, 143, 15, 254, 15, 152, 153, 153, 153, 231, 54, 211, 92, 240, 14,
    144, 121, 253, 241, 193, 15, 152, 153, 153, 153, 25, 41, 102, 244, 248, 135,
];

static DATA_0X8E8E_2D_16: [glw::GLubyte; 16] = [
    67, 155, 82, 120, 142, 7, 31, 124, 224, 255, 165, 221, 239, 223, 122, 223,
];

static DATA_0X8E8E_3D_64: [glw::GLubyte; 64] = [
    67, 155, 82, 120, 142, 7, 31, 124, 224, 255, 165, 221, 239, 223, 122, 223, 35, 30, 124, 240, 209, 166, 20, 158, 11,
    250, 24, 21, 0, 2, 34, 2, 35, 30, 124, 240, 209, 166, 20, 158, 5, 88, 2, 1, 34, 165, 0, 241, 35, 30, 124, 240, 209,
    166, 20, 158, 33, 34, 32, 0, 81, 129, 175, 80,
];

static DATA_0X8E8F_2D_16: [glw::GLubyte; 16] = [
    131, 54, 165, 148, 26, 47, 62, 248, 176, 254, 149, 203, 222, 206, 187, 173,
];

static DATA_0X8E8F_3D_64: [glw::GLubyte; 64] = [
    131, 54, 165, 148, 26, 47, 62, 248, 176, 254, 149, 203, 222, 206, 187, 173, 99, 188, 248, 224, 163, 77, 41, 165,
    24, 250, 36, 70, 18, 20, 53, 3, 99, 188, 248, 224, 163, 77, 41, 165, 42, 68, 19, 18, 67, 166, 16, 244, 99, 188,
    248, 224, 163, 77, 41, 165, 48, 83, 65, 33, 100, 66, 175, 65,
];

static DATA_GL_COMPRESSED_R11_EAC_2D_8: [glw::GLubyte; 8] = [146, 253, 99, 81, 202, 222, 63, 243];

static DATA_GL_COMPRESSED_R11_EAC_3D_32: [glw::GLubyte; 32] = [
    146, 253, 99, 81, 202, 222, 63, 243, 146, 253, 169, 188, 102, 31, 246, 55, 146, 253, 123, 247, 62, 71, 139, 131,
    146, 253, 248, 63, 248, 208, 230, 213,
];

static DATA_GL_COMPRESSED_RG11_EAC_2D_16: [glw::GLubyte; 16] = [
    146, 253, 99, 81, 202, 222, 63, 243, 140, 254, 110, 0, 160, 130, 207, 180,
];

static DATA_GL_COMPRESSED_RG11_EAC_3D_64: [glw::GLubyte; 64] = [
    146, 253, 99, 81, 202, 222, 63, 243, 140, 254, 110, 0, 160, 130, 207, 180, 146, 253, 169, 188, 102, 31, 246, 55,
    140, 254, 2, 73, 46, 104, 102, 39, 146, 253, 123, 247, 62, 71, 139, 131, 140, 254, 155, 121, 68, 17, 1, 27, 146,
    253, 248, 63, 248, 208, 230, 213, 140, 254, 240, 60, 19, 214, 73, 0,
];

static DATA_GL_COMPRESSED_RGB8_ETC2_2D_8: [glw::GLubyte; 8] = [168, 122, 150, 252, 234, 35, 0, 0];

static DATA_GL_COMPRESSED_RGB8_ETC2_3D_32: [glw::GLubyte; 32] = [
    168, 122, 150, 252, 234, 35, 0, 0, 168, 122, 150, 253, 31, 140, 0, 0, 138, 167, 105, 252, 196, 87, 0, 0, 138, 167,
    105, 253, 49, 248, 0, 0,
];

static DATA_GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2_2D_8: [glw::GLubyte; 8] = [83, 83, 75, 252, 240, 240, 15, 4];

static DATA_GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2_3D_32: [glw::GLubyte; 32] = [
    83, 83, 75, 252, 240, 240, 15, 4, 107, 99, 99, 253, 240, 240, 14, 15, 135, 135, 135, 252, 240, 240, 15, 15, 108,
    108, 108, 253, 240, 248, 11, 11,
];

static DATA_GL_COMPRESSED_RGBA8_ETC2_EAC_2D_16: [glw::GLubyte; 16] = [
    127, 245, 255, 244, 146, 255, 244, 146, 168, 122, 150, 252, 234, 35, 0, 0,
];

static DATA_GL_COMPRESSED_RGBA8_ETC2_EAC_3D_64: [glw::GLubyte; 64] = [
    127, 245, 255, 244, 146, 255, 244, 146, 168, 122, 150, 252, 234, 35, 0, 0, 127, 245, 255, 244, 146, 255, 244, 146,
    168, 122, 150, 253, 31, 140, 0, 0, 127, 245, 255, 244, 146, 255, 244, 146, 138, 167, 105, 252, 196, 87, 0, 0, 127,
    245, 255, 244, 146, 255, 244, 146, 138, 167, 105, 253, 49, 248, 0, 0,
];

static DATA_GL_COMPRESSED_SIGNED_R11_EAC_2D_8: [glw::GLubyte; 8] = [73, 221, 99, 81, 201, 222, 63, 241];

static DATA_GL_COMPRESSED_SIGNED_R11_EAC_3D_32: [glw::GLubyte; 32] = [
    73, 221, 99, 81, 201, 222, 63, 241, 73, 221, 165, 156, 102, 31, 246, 55, 73, 221, 59, 247, 62, 39, 139, 131, 73,
    221, 248, 63, 248, 208, 226, 205,
];

static DATA_GL_COMPRESSED_SIGNED_RG11_EAC_2D_16: [glw::GLubyte; 16] =
    [73, 221, 99, 81, 201, 222, 63, 241, 66, 191, 110, 0, 96, 131, 77, 180];

static DATA_GL_COMPRESSED_SIGNED_RG11_EAC_3D_64: [glw::GLubyte; 64] = [
    73, 221, 99, 81, 201, 222, 63, 241, 66, 191, 110, 0, 96, 131, 77, 180, 73, 221, 165, 156, 102, 31, 246, 55, 66,
    191, 2, 73, 54, 100, 102, 38, 73, 221, 59, 247, 62, 39, 139, 131, 66, 191, 155, 105, 132, 16, 129, 27, 73, 221,
    248, 63, 248, 208, 226, 205, 66, 191, 208, 60, 11, 218, 73, 0,
];

static DATA_GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC_2D_16: [glw::GLubyte; 16] = [
    127, 245, 255, 244, 146, 255, 244, 146, 150, 122, 168, 252, 234, 35, 0, 0,
];

static DATA_GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC_3D_64: [glw::GLubyte; 64] = [
    127, 245, 255, 244, 146, 255, 244, 146, 150, 122, 168, 252, 234, 35, 0, 0, 127, 245, 255, 244, 146, 255, 244, 146,
    150, 122, 168, 253, 31, 140, 0, 0, 127, 245, 255, 244, 146, 255, 244, 146, 105, 167, 138, 252, 196, 87, 0, 0, 127,
    245, 255, 244, 146, 255, 244, 146, 105, 167, 138, 253, 49, 248, 0, 0,
];

static DATA_GL_COMPRESSED_SRGB8_ETC2_2D_8: [glw::GLubyte; 8] = [168, 122, 150, 252, 234, 35, 0, 0];

static DATA_GL_COMPRESSED_SRGB8_ETC2_3D_32: [glw::GLubyte; 32] = [
    168, 122, 150, 252, 234, 35, 0, 0, 168, 122, 150, 253, 31, 140, 0, 0, 138, 167, 105, 252, 196, 87, 0, 0, 138, 167,
    105, 253, 49, 248, 0, 0,
];

static DATA_GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2_2D_8: [glw::GLubyte; 8] = [75, 83, 83, 252, 240, 240, 15, 4];

static DATA_GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2_3D_32: [glw::GLubyte; 32] = [
    75, 83, 83, 252, 240, 240, 15, 4, 99, 99, 107, 253, 240, 240, 14, 15, 135, 135, 135, 252, 240, 240, 15, 15, 108,
    108, 108, 253, 240, 248, 11, 11,
];

struct CompressedData {
    iformat: glw::GLenum,
    data: &'static [glw::GLubyte],
    dimensions: u32,
}

static COMPRESSED_IMAGES: [CompressedData; 36] = [
    CompressedData {
        iformat: glw::GL_COMPRESSED_RED_RGTC1,
        data: &DATA_0X8DBB_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
        data: &DATA_0X8DBC_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RG_RGTC2,
        data: &DATA_0X8DBD_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RG_RGTC2,
        data: &DATA_0X8DBE_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGBA_BPTC_UNORM,
        data: &DATA_0X8E8C_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM,
        data: &DATA_0X8E8D_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT,
        data: &DATA_0X8E8E_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT,
        data: &DATA_0X8E8F_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB8_ETC2,
        data: &DATA_GL_COMPRESSED_RGB8_ETC2_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_ETC2,
        data: &DATA_GL_COMPRESSED_SRGB8_ETC2_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        data: &DATA_GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        data: &DATA_GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        data: &DATA_GL_COMPRESSED_RGBA8_ETC2_EAC_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
        data: &DATA_GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_R11_EAC,
        data: &DATA_GL_COMPRESSED_R11_EAC_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_R11_EAC,
        data: &DATA_GL_COMPRESSED_SIGNED_R11_EAC_2D_8,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RG11_EAC,
        data: &DATA_GL_COMPRESSED_RG11_EAC_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RG11_EAC,
        data: &DATA_GL_COMPRESSED_SIGNED_RG11_EAC_2D_16,
        dimensions: 2,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RED_RGTC1,
        data: &DATA_0X8DBB_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
        data: &DATA_0X8DBC_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RG_RGTC2,
        data: &DATA_0X8DBD_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RG_RGTC2,
        data: &DATA_0X8DBE_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGBA_BPTC_UNORM,
        data: &DATA_0X8E8C_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM,
        data: &DATA_0X8E8D_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT,
        data: &DATA_0X8E8E_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT,
        data: &DATA_0X8E8F_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB8_ETC2,
        data: &DATA_GL_COMPRESSED_RGB8_ETC2_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_ETC2,
        data: &DATA_GL_COMPRESSED_SRGB8_ETC2_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        data: &DATA_GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        data: &DATA_GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_R11_EAC,
        data: &DATA_GL_COMPRESSED_R11_EAC_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_R11_EAC,
        data: &DATA_GL_COMPRESSED_SIGNED_R11_EAC_3D_32,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        data: &DATA_GL_COMPRESSED_RGBA8_ETC2_EAC_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
        data: &DATA_GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_RG11_EAC,
        data: &DATA_GL_COMPRESSED_RG11_EAC_3D_64,
        dimensions: 3,
    },
    CompressedData {
        iformat: glw::GL_COMPRESSED_SIGNED_RG11_EAC,
        data: &DATA_GL_COMPRESSED_SIGNED_RG11_EAC_3D_64,
        dimensions: 3,
    },
];

static TEXTURE_DATA: [glw::GLubyte; 256] = [
    0x00, 0x00, 0x00, 0xff, 0x7f, 0x7f, 0x7f, 0x00, 0xc3, 0xc3, 0xc3, 0xff, 0xff, 0xff, 0xff, 0x00, 0x88, 0x00, 0x15,
    0xff, 0xed, 0x1c, 0x24, 0x00, 0xff, 0x7f, 0x27, 0xff, 0xff, 0xf2, 0x00, 0x00, 0xc8, 0xbf, 0xe7, 0xff, 0x70, 0x92,
    0xbe, 0x00, 0x99, 0xd9, 0xea, 0xff, 0xb5, 0xe6, 0x1d, 0x00, 0xa3, 0x49, 0xa4, 0xff, 0x3f, 0x48, 0xcc, 0x00, 0x00,
    0xa2, 0xe8, 0xff, 0x22, 0xb1, 0x4c, 0x00, 0xa3, 0x49, 0xa4, 0xff, 0xc8, 0xbf, 0xe7, 0x00, 0x88, 0x00, 0x15, 0xff,
    0x00, 0x00, 0x00, 0x00, 0x3f, 0x48, 0xcc, 0xff, 0x70, 0x92, 0xbe, 0x00, 0xed, 0x1c, 0x24, 0xff, 0x7f, 0x7f, 0x7f,
    0x00, 0x00, 0xa2, 0xe8, 0xff, 0x99, 0xd9, 0xea, 0x00, 0xff, 0x7f, 0x27, 0xff, 0xc3, 0xc3, 0xc3, 0x00, 0x22, 0xb1,
    0x4c, 0xff, 0xb5, 0xe6, 0x1d, 0x00, 0xff, 0xf2, 0x00, 0xff, 0xff, 0xff, 0xff, 0x00, 0x22, 0xb1, 0x4c, 0xff, 0x00,
    0xa2, 0xe8, 0x00, 0x3f, 0x48, 0xcc, 0xff, 0xa3, 0x49, 0xa4, 0x00, 0xb5, 0xe6, 0x1d, 0xff, 0x99, 0xd9, 0xea, 0x00,
    0x70, 0x92, 0xbe, 0xff, 0xc8, 0xbf, 0xe7, 0x00, 0xff, 0xf2, 0x00, 0xff, 0xff, 0x7f, 0x27, 0x00, 0xed, 0x1c, 0x24,
    0xff, 0x88, 0x00, 0x15, 0x00, 0xff, 0xff, 0xff, 0xff, 0xc3, 0xc3, 0xc3, 0x00, 0x7f, 0x7f, 0x7f, 0xff, 0x00, 0x00,
    0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xf2, 0x00, 0x00, 0xb5, 0xe6, 0x1d, 0xff, 0x22, 0xb1, 0x4c, 0x00, 0xc3,
    0xc3, 0xc3, 0xff, 0xff, 0x7f, 0x27, 0x00, 0x99, 0xd9, 0xea, 0xff, 0x00, 0xa2, 0xe8, 0x00, 0x7f, 0x7f, 0x7f, 0xff,
    0xed, 0x1c, 0x24, 0x00, 0x70, 0x92, 0xbe, 0xff, 0x3f, 0x48, 0xcc, 0x00, 0x00, 0x00, 0x00, 0xff, 0x88, 0x00, 0x15,
    0x00, 0xc8, 0xbf, 0xe7, 0xff, 0xa3, 0x49, 0xa4, 0x00,
];

const TEXTURE_WIDTH: glw::GLsizei = 4;
const TEXTURE_HEIGHT: glw::GLsizei = 4;
const TEXTURE_DEPTH: glw::GLsizei = 4;
const BLOCK_COUNT: usize = 8;
const BLOCK_2D_SIZE_X: glw::GLsizei = 4;
const BLOCK_2D_SIZE_Y: glw::GLsizei = 2;
const BLOCK_3D_SIZE: glw::GLsizei = 2;

/// `Textures::CompressedSubImageTest`
struct TexturesCompressedSubImageTest;

#[derive(Default)]
struct CompressedSubImageObjects {
    to: glw::GLuint,
    to_aux: glw::GLuint,
    compressed_texture_data: Vec<glw::GLubyte>,
    reference: Vec<glw::GLubyte>,
    reference_internalformat: glw::GLenum,
}

impl TexturesCompressedSubImageTest {
    fn texture_target(dimensions: u32) -> glw::GLenum {
        match dimensions {
            1 => glw::GL_TEXTURE_1D,
            2 => glw::GL_TEXTURE_2D,
            _ => glw::GL_TEXTURE_2D_ARRAY,
        }
    }

    fn create_textures(
        gl: &glw::Functions,
        o: &mut CompressedSubImageObjects,
        target: glw::GLenum,
    ) -> Result<(), TestError> {
        // SAFETY: names are written to live fields and then bound.
        unsafe {
            gl.gen_textures(1, &mut o.to_aux);
            glu::expect_no_error(gl, "glGenTextures has failed")?;
            gl.bind_texture(target, o.to_aux);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
            gl.gen_textures(1, &mut o.to);
            glu::expect_no_error(gl, "glGenTextures has failed")?;
            gl.bind_texture(target, o.to);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
        }
        Ok(())
    }

    /// `TextureImage<D>`: false when the driver refuses the compressed internal format with INVALID_OPERATION.
    fn texture_image(gl: &glw::Functions, dimensions: u32, internalformat: glw::GLint) -> Result<bool, TestError> {
        let data = TEXTURE_DATA.as_ptr().cast::<c_void>();
        let target = Self::texture_target(dimensions);
        // SAFETY: the data pointer refers to the live static array.
        let error = unsafe {
            match dimensions {
                1 => gl.tex_image_1d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                2 => gl.tex_image_2d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
                _ => gl.tex_image_3d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    TEXTURE_DEPTH,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    data,
                ),
            }
            gl.get_error()
        };
        if error == glw::GL_INVALID_OPERATION {
            return Ok(false);
        }
        if error != glw::GL_NO_ERROR {
            return Err(TestError::Fail(format!(
                "glTexImage has failed with {}",
                glw::error_name(error)
            )));
        }
        Ok(true)
    }

    /// `CompressedTexImage<D>`: uploads the compressed data.
    fn compressed_tex_image(
        gl: &glw::Functions,
        o: &CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        let size = o.compressed_texture_data.len() as glw::GLsizei;
        let data = o.compressed_texture_data.as_ptr().cast::<c_void>();
        // SAFETY: the data pointer and size describe the live vector.
        unsafe {
            match dimensions {
                1 => gl.compressed_tex_image_1d(target, 0, internalformat, TEXTURE_WIDTH, 0, size, data),
                2 => {
                    gl.compressed_tex_image_2d(target, 0, internalformat, TEXTURE_WIDTH, TEXTURE_HEIGHT, 0, size, data)
                }
                _ => gl.compressed_tex_image_3d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH,
                    TEXTURE_HEIGHT,
                    TEXTURE_DEPTH,
                    0,
                    size,
                    data,
                ),
            }
        }
        glu::expect_no_error(gl, "glCompressedTexImage has failed")
    }

    fn prepare_storage(
        gl: &glw::Functions,
        o: &CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        // SAFETY: plain state changes; no pixel data is passed.
        unsafe {
            gl.bind_texture(target, o.to);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
            match dimensions {
                1 => gl.tex_image_1d(
                    target,
                    0,
                    internalformat as glw::GLint,
                    TEXTURE_WIDTH * BLOCK_COUNT as glw::GLsizei,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
                2 => gl.tex_image_2d(
                    target,
                    0,
                    internalformat as glw::GLint,
                    TEXTURE_WIDTH * BLOCK_2D_SIZE_X,
                    TEXTURE_HEIGHT * BLOCK_2D_SIZE_Y,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
                _ => gl.tex_image_3d(
                    target,
                    0,
                    internalformat as glw::GLint,
                    TEXTURE_WIDTH * BLOCK_3D_SIZE,
                    TEXTURE_HEIGHT * BLOCK_3D_SIZE,
                    TEXTURE_DEPTH * BLOCK_3D_SIZE,
                    0,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    std::ptr::null(),
                ),
            }
            glu::expect_no_error(gl, "glTexImage1D has failed")
        }
    }

    fn prepare_compressed_storage(
        gl: &glw::Functions,
        o: &CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> Result<(), TestError> {
        let target = Self::texture_target(dimensions);
        let reference_size = o.reference.len() as glw::GLsizei;
        // SAFETY: plain state changes; no pixel data is passed.
        unsafe {
            gl.bind_texture(target, o.to);
            glu::expect_no_error(gl, "glBindTexture has failed")?;
            match dimensions {
                1 => gl.compressed_tex_image_1d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH * BLOCK_COUNT as glw::GLsizei,
                    0,
                    TEXTURE_WIDTH * BLOCK_COUNT as glw::GLsizei,
                    std::ptr::null(),
                ),
                2 => gl.compressed_tex_image_2d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH * BLOCK_2D_SIZE_X,
                    TEXTURE_HEIGHT * BLOCK_2D_SIZE_Y,
                    0,
                    reference_size * BLOCK_2D_SIZE_X * BLOCK_2D_SIZE_Y,
                    std::ptr::null(),
                ),
                _ => gl.compressed_tex_image_3d(
                    target,
                    0,
                    internalformat,
                    TEXTURE_WIDTH * BLOCK_3D_SIZE,
                    TEXTURE_HEIGHT * BLOCK_3D_SIZE,
                    TEXTURE_DEPTH * BLOCK_3D_SIZE,
                    0,
                    reference_size * BLOCK_3D_SIZE * BLOCK_3D_SIZE * BLOCK_3D_SIZE,
                    std::ptr::null(),
                ),
            }
            glu::expect_no_error(gl, "glCompressedTexImage has failed")
        }
    }

    /// `PrepareReferenceData<D>`: false when the format is unsupported and there is no reference data for it.
    fn prepare_reference_data(
        gl: &glw::Functions,
        o: &mut CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> Result<bool, TestError> {
        let target = Self::texture_target(dimensions);
        // SAFETY: plain state change.
        unsafe { gl.bind_texture(target, o.to_aux) };
        glu::expect_no_error(gl, "glBindTexture has failed")?;

        if !o.reference.is_empty() || !o.compressed_texture_data.is_empty() {
            return Err(TestError::Fail("reference data already prepared".to_string()));
        }

        if !Self::texture_image(gl, dimensions, internalformat as glw::GLint)? {
            let mut is_compressed_texture = false;
            for image in &COMPRESSED_IMAGES {
                if internalformat == image.iformat && dimensions == image.dimensions {
                    is_compressed_texture = true;
                    o.reference_internalformat = image.iformat;
                    o.reference = image.data.to_vec();
                    o.compressed_texture_data = image.data.to_vec();
                }
            }
            if !is_compressed_texture {
                return Ok(false);
            }
            Self::prepare_compressed_storage(gl, o, dimensions, o.reference_internalformat)?;
        } else {
            let mut is_compressed_texture: glw::GLint = 0;
            let mut compressed_texture_size: glw::GLint = 0;
            // SAFETY: each query writes one integer to a live local.
            unsafe {
                gl.get_tex_level_parameteriv(target, 0, glw::GL_TEXTURE_COMPRESSED, &mut is_compressed_texture);
                if is_compressed_texture != 0 {
                    gl.get_tex_level_parameteriv(
                        target,
                        0,
                        glw::GL_TEXTURE_COMPRESSED_IMAGE_SIZE,
                        &mut compressed_texture_size,
                    );
                }
            }
            if is_compressed_texture != 0 && compressed_texture_size != 0 {
                o.compressed_texture_data = vec![0; compressed_texture_size as usize];
                // SAFETY: the vector holds the compressed image size reported by the driver.
                unsafe { gl.get_compressed_tex_image(target, 0, o.compressed_texture_data.as_mut_ptr().cast()) };
                glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
                Self::compressed_tex_image(gl, o, dimensions, internalformat)?;
                o.reference = vec![0; compressed_texture_size as usize];
                // SAFETY: as above.
                unsafe { gl.get_compressed_tex_image(target, 0, o.reference.as_mut_ptr().cast()) };
                glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;
            }
            Self::prepare_storage(gl, o, dimensions, internalformat)?;
        }
        Ok(true)
    }

    fn log_sub_image_error(gl: &glw::Functions, internalformat: glw::GLenum) -> bool {
        // SAFETY: plain state query.
        let error = unsafe { gl.get_error() };
        if error != glw::GL_NO_ERROR {
            log::info!(
                "{} during the test with internal format {internalformat:#x}.",
                glw::error_name(error)
            );
            return false;
        }
        true
    }

    fn compressed_texture_sub_image(
        gl: &glw::Functions,
        o: &CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> bool {
        let size = o.reference.len() as glw::GLsizei;
        let data = o.compressed_texture_data.as_ptr().cast::<c_void>();
        // SAFETY: the data pointer and size describe the live vector.
        unsafe {
            match dimensions {
                1 => {
                    // Only implementation dependent internalformats may provide this functionality; without reference data it cannot be tested.
                    if size == 0 {
                        return true;
                    }
                    for block in 0..BLOCK_COUNT as glw::GLint {
                        gl.compressed_texture_sub_image_1d(
                            o.to,
                            0,
                            TEXTURE_WIDTH * block,
                            TEXTURE_WIDTH,
                            internalformat,
                            size,
                            data,
                        );
                    }
                }
                2 => {
                    for y in 0..BLOCK_2D_SIZE_Y {
                        for x in 0..BLOCK_2D_SIZE_X {
                            gl.compressed_texture_sub_image_2d(
                                o.to,
                                0,
                                TEXTURE_WIDTH * x,
                                TEXTURE_HEIGHT * y,
                                TEXTURE_WIDTH,
                                TEXTURE_HEIGHT,
                                internalformat,
                                size,
                                data,
                            );
                        }
                    }
                }
                _ => {
                    for z in 0..BLOCK_3D_SIZE {
                        for y in 0..BLOCK_3D_SIZE {
                            for x in 0..BLOCK_3D_SIZE {
                                gl.compressed_texture_sub_image_3d(
                                    o.to,
                                    0,
                                    TEXTURE_WIDTH * x,
                                    TEXTURE_HEIGHT * y,
                                    TEXTURE_DEPTH * z,
                                    TEXTURE_WIDTH,
                                    TEXTURE_HEIGHT,
                                    TEXTURE_DEPTH,
                                    internalformat,
                                    size,
                                    data,
                                );
                            }
                        }
                    }
                }
            }
        }
        Self::log_sub_image_error(gl, internalformat)
    }

    fn check_data(
        gl: &glw::Functions,
        o: &CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
    ) -> Result<bool, TestError> {
        let target = Self::texture_target(dimensions);
        let reference_size = o.reference.len();
        let mut result = vec![0 as glw::GLubyte; reference_size * BLOCK_COUNT];
        // SAFETY: the vector holds the compressed data of all blocks.
        unsafe { gl.get_compressed_tex_image(target, 0, result.as_mut_ptr().cast()) };
        glu::expect_no_error(gl, "glGetCompressedTexImage has failed")?;

        if dimensions == 3 {
            let reference_layer_size = reference_size / TEXTURE_DEPTH as usize;
            for (i, value) in result.iter().enumerate() {
                let ref_idx = i % reference_layer_size;
                let ref_layer_idx =
                    (i / (reference_layer_size * (BLOCK_3D_SIZE * BLOCK_3D_SIZE) as usize)) % TEXTURE_DEPTH as usize;
                if o.reference[ref_layer_idx * reference_layer_size + ref_idx] != *value {
                    log::info!(
                        "Compressed data of layer {ref_layer_idx} should be {:?} however texture contains {:?}. Texture target was {target:#x} and internal format was {internalformat:#x}.",
                        &o.reference[ref_layer_idx * reference_layer_size..][..reference_layer_size],
                        &result[i % reference_layer_size..][..reference_layer_size]
                    );
                    return Ok(false);
                }
            }
        } else {
            for block in 0..BLOCK_COUNT {
                for i in 0..reference_size {
                    if o.reference[i] != result[block * reference_size + i] {
                        log::info!(
                            "Compressed data should be {:?} however texture contains {:?}. Texture target was {target:#x} and internal format was {internalformat:#x}.",
                            o.reference,
                            &result[block * reference_size..][..reference_size]
                        );
                        return Ok(false);
                    }
                }
            }
        }
        Ok(true)
    }

    fn clean_all(gl: &glw::Functions, o: &mut CompressedSubImageObjects) {
        // SAFETY: deletes names created by the test.
        unsafe {
            for to in [&mut o.to, &mut o.to_aux] {
                if *to != 0 {
                    gl.delete_textures(1, to);
                    *to = 0;
                }
            }
        }
        o.reference.clear();
        o.compressed_texture_data.clear();
        clean_errors(gl);
    }

    fn test(
        gl: &glw::Functions,
        o: &mut CompressedSubImageObjects,
        dimensions: u32,
        internalformat: glw::GLenum,
        can_be_unsupported: bool,
    ) -> Result<bool, TestError> {
        Self::create_textures(gl, o, Self::texture_target(dimensions))?;

        if !Self::prepare_reference_data(gl, o, dimensions, internalformat)? {
            Self::clean_all(gl, o);
            return Ok(can_be_unsupported);
        }

        if !Self::compressed_texture_sub_image(gl, o, dimensions, internalformat) {
            Self::clean_all(gl, o);
            return Ok(false);
        }

        if !o.reference.is_empty() && !Self::check_data(gl, o, dimensions, internalformat)? {
            Self::clean_all(gl, o);
            return Ok(false);
        }

        Self::clean_all(gl, o);
        Ok(true)
    }
}

impl TestCase for TexturesCompressedSubImageTest {
    fn name(&self) -> &str {
        "textures_compressed_subimage"
    }

    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        check_dsa_support(context)
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let gl = context.gl();
        let mut o = CompressedSubImageObjects::default();

        let outcome = dsa_outcome(|| {
            let mut is_ok = true;
            is_ok &= Self::test(gl, &mut o, 1, glw::GL_COMPRESSED_RGB, false)?;

            // The two lists are upstream's: the RGTC and BPTC formats are required, the ETC2 and EAC ones may be unsupported.
            let required = [
                glw::GL_COMPRESSED_RED_RGTC1,
                glw::GL_COMPRESSED_SIGNED_RED_RGTC1,
                glw::GL_COMPRESSED_RG_RGTC2,
                glw::GL_COMPRESSED_SIGNED_RG_RGTC2,
                glw::GL_COMPRESSED_RGBA_BPTC_UNORM,
                glw::GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM,
                glw::GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT,
                glw::GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT,
            ];
            let optional = [
                glw::GL_COMPRESSED_RGB8_ETC2,
                glw::GL_COMPRESSED_SRGB8_ETC2,
                glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
                glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
                glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
                glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
                glw::GL_COMPRESSED_R11_EAC,
                glw::GL_COMPRESSED_SIGNED_R11_EAC,
                glw::GL_COMPRESSED_RG11_EAC,
                glw::GL_COMPRESSED_SIGNED_RG11_EAC,
            ];
            for dimensions in [2, 3] {
                for internalformat in required {
                    is_ok &= Self::test(gl, &mut o, dimensions, internalformat, false)?;
                }
                for internalformat in optional {
                    is_ok &= Self::test(gl, &mut o, dimensions, internalformat, true)?;
                }
            }
            Ok(is_ok)
        });

        Self::clean_all(gl, &mut o);
        outcome
    }
}

pub(super) fn add_tests(group: &mut TestCaseGroup) {
    group.add_child(Box::new(TexturesCompressedSubImageTest) as Box<dyn TestCase>);
}
