// BOILERPLATE. Nothing in this file is specific to any bug - read `main.rs` and the
// `.comp`/`.vert`/`.frag` beside it, which is all there is to a finding. This is only an
// OpenGL ES 3.1 context and the handful of calls a reproducer needs - a compute dispatch,
// a draw of one full-screen quad, a compile - with no dependencies at all: every entry
// point is a `dlopen`/`dlsym` away.
//
// Copied verbatim into each finding rather than shared from somewhere. That is the point
// of these directories - one of them can be mailed to a driver vendor, or opened in six
// months on a machine that has never seen this repository, and `cargo build` is the whole
// of what it needs. A shared crate would make them all depend on something that has to
// be shipped alongside, and then they are not reproducers, they are a project.
//
// Finding a display is the one part that is not boilerplate. The board this targets has a
// Wayland-only driver: it refuses the default display and has no device platform, while a
// headless container has no compositor and needs one of the EXT platforms. All four are
// tried, in the order that gets each machine there fastest.

#![allow(dead_code)]

use std::ffi::{CString, c_char, c_int, c_uint, c_void};
use std::io::Write;

pub type EGLDisplay = *mut c_void;
pub type EGLConfig = *mut c_void;
pub type EGLContext = *mut c_void;
pub type EGLSurface = *mut c_void;
pub type EGLint = i32;
pub type GLuint = c_uint;
pub type GLint = c_int;
pub type GLenum = c_uint;
pub type GLsizeiptr = isize;

const EGL_NO_DISPLAY: EGLDisplay = std::ptr::null_mut();
const EGL_NO_SURFACE: EGLSurface = std::ptr::null_mut();
const EGL_NO_CONTEXT: EGLContext = std::ptr::null_mut();
const EGL_OPENGL_ES_API: c_uint = 0x30A0;
const EGL_OPENGL_ES2_BIT: EGLint = 0x0004;
const EGL_OPENGL_ES3_BIT: EGLint = 0x0040;
const EGL_RENDERABLE_TYPE: EGLint = 0x3040;
const EGL_SURFACE_TYPE: EGLint = 0x3033;
const EGL_PBUFFER_BIT: EGLint = 0x0001;
const EGL_NONE: EGLint = 0x3038;
const EGL_CONTEXT_CLIENT_VERSION: EGLint = 0x3098;
const EGL_CONTEXT_MINOR_VERSION: EGLint = 0x30FB;
const EGL_PLATFORM_DEVICE_EXT: c_uint = 0x313F;
const EGL_PLATFORM_SURFACELESS_MESA: c_uint = 0x31DD;
const EGL_PLATFORM_WAYLAND_KHR: c_uint = 0x31D8;
const EGL_WIDTH: EGLint = 0x3057;
const EGL_HEIGHT: EGLint = 0x3056;
const EGL_RED_SIZE: EGLint = 0x3024;
const EGL_GREEN_SIZE: EGLint = 0x3023;
const EGL_BLUE_SIZE: EGLint = 0x3022;
const EGL_ALPHA_SIZE: EGLint = 0x3021;
const EGL_DEPTH_SIZE: EGLint = 0x3025;
const EGL_STENCIL_SIZE: EGLint = 0x3026;

/// The conformance suite renders into a 256x256 target and asks for depth and stencil.
/// Reproducing on a real surface rather than surfacelessly is not a detail: the first
/// version of this harness was surfaceless, and the case that takes the GPU down through
/// `hodow_cts` ran clean through it. Same shader, same dispatch, different driver path.
const TARGET_WIDTH: EGLint = 256;
const TARGET_HEIGHT: EGLint = 256;

pub const GL_COMPUTE_SHADER: GLenum = 0x91B9;
pub const GL_VERTEX_SHADER: GLenum = 0x8B31;
pub const GL_FRAGMENT_SHADER: GLenum = 0x8B30;
pub const GL_COMPILE_STATUS: GLenum = 0x8B81;
pub const GL_LINK_STATUS: GLenum = 0x8B82;
pub const GL_INFO_LOG_LENGTH: GLenum = 0x8B84;
pub const GL_SHADER_STORAGE_BUFFER: GLenum = 0x90D2;
pub const GL_DISPATCH_INDIRECT_BUFFER: GLenum = 0x90EE;
pub const GL_STATIC_DRAW: GLenum = 0x88E4;
pub const GL_MAP_READ_BIT: GLenum = 0x0001;
pub const GL_MAP_WRITE_BIT: GLenum = 0x0002;
pub const GL_BUFFER_UPDATE_BARRIER_BIT: GLenum = 0x0000_0200;
pub const GL_SHADER_STORAGE_BARRIER_BIT: GLenum = 0x0000_2000;
pub const GL_COMMAND_BARRIER_BIT: GLenum = 0x0000_0040;
pub const GL_ALL_BARRIER_BITS: GLenum = 0xFFFF_FFFF;
pub const GL_TEXTURE_2D: GLenum = 0x0DE1;
pub const GL_TEXTURE_3D: GLenum = 0x806F;
pub const GL_TEXTURE_CUBE_MAP: GLenum = 0x8513;
pub const GL_TEXTURE_MIN_FILTER: GLenum = 0x2801;
pub const GL_TEXTURE_MAG_FILTER: GLenum = 0x2800;
pub const GL_NEAREST: GLint = 0x2600;
pub const GL_R32F: GLenum = 0x822E;
pub const GL_R32I: GLenum = 0x8235;
pub const GL_R32UI: GLenum = 0x8236;
pub const GL_RED: GLenum = 0x1903;
pub const GL_RED_INTEGER: GLenum = 0x8D94;
pub const GL_FLOAT: GLenum = 0x1406;
pub const GL_INT: GLenum = 0x1404;
pub const GL_UNSIGNED_INT: GLenum = 0x1405;
pub const GL_READ_ONLY: GLenum = 0x88B8;
pub const GL_WRITE_ONLY: GLenum = 0x88B9;
pub const GL_READ_WRITE: GLenum = 0x88BA;
pub const GL_FALSE: u8 = 0;
pub const GL_TRUE: u8 = 1;
pub const GL_FRAMEBUFFER: GLenum = 0x8D40;
pub const GL_COLOR_ATTACHMENT0: GLenum = 0x8CE0;
pub const GL_DEPTH_ATTACHMENT: GLenum = 0x8D00;
pub const GL_STENCIL_ATTACHMENT: GLenum = 0x8D20;
pub const GL_RENDERBUFFER: GLenum = 0x8D41;
pub const GL_RGBA4: GLenum = 0x8056;
pub const GL_DEPTH_COMPONENT16: GLenum = 0x81A5;
pub const GL_STENCIL_INDEX8: GLenum = 0x8D48;
pub const GL_FRAMEBUFFER_COMPLETE: GLenum = 0x8CD5;
pub const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT: GLenum = 0x8CD6;
pub const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT: GLenum = 0x8CD7;
pub const GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS: GLenum = 0x8CD9;
pub const GL_FRAMEBUFFER_UNSUPPORTED: GLenum = 0x8CDD;
pub const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE: GLenum = 0x8D56;
pub const GL_ARRAY_BUFFER: GLenum = 0x8892;
pub const GL_TRIANGLE_STRIP: GLenum = 0x0005;
pub const GL_COLOR_BUFFER_BIT: GLenum = 0x0000_4000;
pub const GL_READ_FRAMEBUFFER: GLenum = 0x8CA8;
pub const GL_DRAW_FRAMEBUFFER: GLenum = 0x8CA9;
pub const GL_RGBA: GLenum = 0x1908;
pub const GL_UNSIGNED_BYTE: GLenum = 0x1401;
pub const GL_TRIANGLES: GLenum = 0x0004;
pub const GL_DEPTH_TEST: GLenum = 0x0B71;
pub const GL_ALWAYS: GLenum = 0x0207;
pub const GL_EQUAL: GLenum = 0x0202;
pub const GL_DEPTH_BUFFER_BIT: GLenum = 0x0000_0100;
pub const GL_MAX_VERTEX_UNIFORM_BLOCKS: GLenum = 0x8A2B;
pub const GL_MAX_FRAGMENT_UNIFORM_BLOCKS: GLenum = 0x8A2D;
pub const GL_MAX_COMBINED_UNIFORM_BLOCKS: GLenum = 0x8A2E;
pub const GL_MAX_UNIFORM_BLOCK_SIZE: GLenum = 0x8A30;
pub const GL_NO_ERROR: GLenum = 0;
pub const GL_RENDERER: GLenum = 0x1F01;
pub const GL_VERSION: GLenum = 0x1F02;
pub const GL_EXTENSIONS: GLenum = 0x1F03;
pub const GL_INVALID_ENUM: GLenum = 0x0500;
pub const GL_INVALID_VALUE: GLenum = 0x0501;
pub const GL_INVALID_OPERATION: GLenum = 0x0502;
pub const GL_BUFFER_VARIABLE: GLenum = 0x92E5;
pub const GL_OFFSET: GLenum = 0x92FC;
pub const GL_ARRAY_STRIDE: GLenum = 0x92FE;
pub const GL_MATRIX_STRIDE: GLenum = 0x92FF;
pub const GL_IS_ROW_MAJOR: GLenum = 0x9300;
pub const GL_TOP_LEVEL_ARRAY_STRIDE: GLenum = 0x9302;
pub const GL_INVALID_INDEX: GLuint = 0xFFFF_FFFF;
pub const GL_LINES: GLenum = 0x0001;
pub const GL_INTERLEAVED_ATTRIBS: GLenum = 0x8C8C;
pub const GL_SEPARATE_ATTRIBS: GLenum = 0x8C8D;
pub const GL_TRANSFORM_FEEDBACK: GLenum = 0x8E22;
pub const GL_TRANSFORM_FEEDBACK_BUFFER: GLenum = 0x8C8E;
pub const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN: GLenum = 0x8C88;
pub const GL_QUERY_RESULT: GLenum = 0x8866;
pub const GL_DYNAMIC_READ: GLenum = 0x88E9;

#[link(name = "dl")]
unsafe extern "C" {
    fn dlopen(file: *const c_char, mode: c_int) -> *mut c_void;
    fn dlsym(handle: *mut c_void, name: *const c_char) -> *mut c_void;
}
const RTLD_NOW: c_int = 2;

fn open_lib(names: &[&str]) -> Option<*mut c_void> {
    names.iter().find_map(|name| {
        let c = CString::new(*name).ok()?;
        let handle = unsafe { dlopen(c.as_ptr(), RTLD_NOW) };
        (!handle.is_null()).then_some(handle)
    })
}

fn sym(handle: *mut c_void, name: &str) -> *mut c_void {
    let c = CString::new(name).expect("symbol name");
    unsafe { dlsym(handle, c.as_ptr()) }
}

/// Prints a step and flushes, so a hang is attributable to the last line printed.
pub fn step(what: &str) {
    eprintln!("... {what}");
    let _ = std::io::stderr().flush();
}

/// Exit codes these reproducers agree on, so a `justfile` can turn one into a verdict.
pub const EXIT_PASS: i32 = 0;
pub const EXIT_FAIL: i32 = 1;
pub const EXIT_NO_DRIVER: i32 = 2;

pub fn die(code: i32, why: &str) -> ! {
    // stdout is block-buffered down a pipe and `exit` does not flush it, so without this
    // everything the reproducer printed on its way here is lost over ssh - which is
    // exactly the run whose output matters.
    let _ = std::io::stdout().flush();
    eprintln!("{why}");
    std::process::exit(code);
}

struct Loader {
    gles: *mut c_void,
    get_proc: unsafe extern "C" fn(*const c_char) -> *mut c_void,
}

impl Loader {
    /// `dlsym` first, then `eglGetProcAddress`: a Vivante libGLESv2 exports the ES 3.1
    /// entry points directly, Mesa sometimes only answers the EGL query.
    fn get(&self, name: &str) -> *mut c_void {
        let p = sym(self.gles, name);
        if !p.is_null() {
            return p;
        }
        let c = CString::new(name).expect("symbol name");
        unsafe { (self.get_proc)(c.as_ptr()) }
    }
}

macro_rules! load {
    ($loader:expr, $name:literal) => {{
        let p = $loader.get($name);
        if p.is_null() {
            die(EXIT_NO_DRIVER, concat!("the driver does not export ", $name));
        }
        unsafe { std::mem::transmute(p) }
    }};
}

/// Everything loaded, with a context current on this thread. One line per entry
/// point: the struct and the dlsym that fills it cannot drift apart if they are the
/// same list.
macro_rules! gl_api {
    ($($field:ident = $name:literal : fn($($arg:ty),*) $(-> $ret:ty)?;)*) => {
        pub struct Gl { $(pub $field: unsafe extern "C" fn($($arg),*) $(-> $ret)?,)* }
        impl Gl {
            fn load(loader: &Loader) -> Self {
                Self { $($field: load!(loader, $name),)* }
            }
        }
    };
}

gl_api! {
    create_shader = "glCreateShader": fn(GLenum) -> GLuint;
    shader_source = "glShaderSource": fn(GLuint, c_int, *const *const c_char, *const GLint);
    compile_shader = "glCompileShader": fn(GLuint);
    get_shaderiv = "glGetShaderiv": fn(GLuint, GLenum, *mut GLint);
    get_shader_info_log = "glGetShaderInfoLog": fn(GLuint, c_int, *mut c_int, *mut c_char);
    create_program = "glCreateProgram": fn() -> GLuint;
    attach_shader = "glAttachShader": fn(GLuint, GLuint);
    link_program = "glLinkProgram": fn(GLuint);
    get_programiv = "glGetProgramiv": fn(GLuint, GLenum, *mut GLint);
    get_program_info_log = "glGetProgramInfoLog": fn(GLuint, c_int, *mut c_int, *mut c_char);
    use_program = "glUseProgram": fn(GLuint);
    uniform_1ui = "glUniform1ui": fn(GLint, GLuint);
    uniform_1i = "glUniform1i": fn(GLint, GLint);
    get_uniform_location = "glGetUniformLocation": fn(GLuint, *const c_char) -> GLint;
    delete_program = "glDeleteProgram": fn(GLuint);
    delete_shader = "glDeleteShader": fn(GLuint);
    gen_buffers = "glGenBuffers": fn(c_int, *mut GLuint);
    bind_buffer = "glBindBuffer": fn(GLenum, GLuint);
    buffer_data = "glBufferData": fn(GLenum, GLsizeiptr, *const c_void, GLenum);
    bind_buffer_base = "glBindBufferBase": fn(GLenum, GLuint, GLuint);
    bind_buffer_range = "glBindBufferRange": fn(GLenum, GLuint, GLuint, isize, GLsizeiptr);
    delete_buffers = "glDeleteBuffers": fn(c_int, *const GLuint);
    gen_textures = "glGenTextures": fn(c_int, *mut GLuint);
    bind_texture = "glBindTexture": fn(GLenum, GLuint);
    active_texture = "glActiveTexture": fn(GLenum);
    tex_parameterf = "glTexParameterf": fn(GLenum, GLenum, f32);
    bind_sampler = "glBindSampler": fn(GLuint, GLuint);
    tex_image_2d = "glTexImage2D": fn(GLenum, GLint, GLint, GLint, GLint, GLint, GLenum, GLenum, *const c_void);
    tex_image_3d = "glTexImage3D": fn(GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLenum, GLenum, *const c_void);
    tex_storage_2d = "glTexStorage2D": fn(GLenum, GLint, GLenum, GLint, GLint);
    tex_storage_3d = "glTexStorage3D": fn(GLenum, GLint, GLenum, GLint, GLint, GLint);
    tex_sub_image_2d = "glTexSubImage2D": fn(GLenum, GLint, GLint, GLint, GLint, GLint, GLenum, GLenum, *const c_void);
    tex_parameteri = "glTexParameteri": fn(GLenum, GLenum, GLint);
    tex_parameterfv = "glTexParameterfv": fn(GLenum, GLenum, *const f32);
    bind_image_texture = "glBindImageTexture": fn(GLuint, GLuint, GLint, u8, GLint, GLenum, GLenum);
    dispatch_compute = "glDispatchCompute": fn(GLuint, GLuint, GLuint);
    dispatch_compute_indirect = "glDispatchComputeIndirect": fn(isize);
    memory_barrier = "glMemoryBarrier": fn(GLenum);
    map_buffer_range = "glMapBufferRange": fn(GLenum, isize, GLsizeiptr, GLenum) -> *mut c_void;
    unmap_buffer = "glUnmapBuffer": fn(GLenum) -> u8;
    gen_framebuffers = "glGenFramebuffers": fn(c_int, *mut GLuint);
    bind_framebuffer = "glBindFramebuffer": fn(GLenum, GLuint);
    framebuffer_texture_layer = "glFramebufferTextureLayer": fn(GLenum, GLenum, GLuint, GLint, GLint);
    gen_renderbuffers = "glGenRenderbuffers": fn(c_int, *mut GLuint);
    bind_renderbuffer = "glBindRenderbuffer": fn(GLenum, GLuint);
    renderbuffer_storage = "glRenderbufferStorage": fn(GLenum, GLenum, GLint, GLint);
    renderbuffer_storage_multisample = "glRenderbufferStorageMultisample": fn(GLenum, GLint, GLenum, GLint, GLint);
    blit_framebuffer = "glBlitFramebuffer": fn(GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLenum, GLenum);
    framebuffer_renderbuffer = "glFramebufferRenderbuffer": fn(GLenum, GLenum, GLenum, GLuint);
    check_framebuffer_status = "glCheckFramebufferStatus": fn(GLenum) -> GLenum;
    read_pixels = "glReadPixels": fn(GLint, GLint, GLint, GLint, GLenum, GLenum, *mut c_void);
    vertex_attrib_pointer = "glVertexAttribPointer": fn(GLuint, GLint, GLenum, u8, GLint, *const c_void);
    enable_vertex_attrib_array = "glEnableVertexAttribArray": fn(GLuint);
    disable_vertex_attrib_array = "glDisableVertexAttribArray": fn(GLuint);
    get_attrib_location = "glGetAttribLocation": fn(GLuint, *const c_char) -> GLint;
    uniform_4fv = "glUniform4fv": fn(GLint, c_int, *const f32);
    transform_feedback_varyings = "glTransformFeedbackVaryings": fn(GLuint, c_int, *const *const c_char, GLenum);
    gen_transform_feedbacks = "glGenTransformFeedbacks": fn(c_int, *mut GLuint);
    bind_transform_feedback = "glBindTransformFeedback": fn(GLenum, GLuint);
    begin_transform_feedback = "glBeginTransformFeedback": fn(GLenum);
    end_transform_feedback = "glEndTransformFeedback": fn();
    pause_transform_feedback = "glPauseTransformFeedback": fn();
    resume_transform_feedback = "glResumeTransformFeedback": fn();
    gen_queries = "glGenQueries": fn(c_int, *mut GLuint);
    delete_queries = "glDeleteQueries": fn(c_int, *const GLuint);
    begin_query = "glBeginQuery": fn(GLenum, GLuint);
    end_query = "glEndQuery": fn(GLenum);
    get_query_objectuiv = "glGetQueryObjectuiv": fn(GLuint, GLenum, *mut GLuint);
    draw_arrays = "glDrawArrays": fn(GLenum, GLint, GLint);
    viewport = "glViewport": fn(GLint, GLint, GLint, GLint);
    clear_color = "glClearColor": fn(f32, f32, f32, f32);
    clear = "glClear": fn(GLenum);
    clear_depthf = "glClearDepthf": fn(f32);
    enable = "glEnable": fn(GLenum);
    depth_func = "glDepthFunc": fn(GLenum);
    get_program_resource_index = "glGetProgramResourceIndex": fn(GLuint, GLenum, *const c_char) -> GLuint;
    get_program_resourceiv = "glGetProgramResourceiv": fn(GLuint, GLenum, GLuint, c_int, *const GLenum, c_int, *mut c_int, *mut GLint);
    finish = "glFinish": fn();
    get_integerv = "glGetIntegerv": fn(GLenum, *mut GLint);
    get_error = "glGetError": fn() -> GLenum;
    get_string = "glGetString": fn(GLenum) -> *const c_char;
}

/// llvmpipe's JIT resolves the libm calls a shader needs (`tanf`, `sinhf`, ...) against
/// the process, and a Rust binary that never calls them itself does not link them in, so
/// a dispatch jumps to address 0. Calling each once keeps them in.
fn keep_libm_linked() {
    let x = std::hint::black_box(0.5f32);
    std::hint::black_box([
        x.tan(), x.sin(), x.cos(), x.sinh(), x.cosh(), x.tanh(), x.asinh(), x.acosh(), x.atanh(), x.asin(), x.acos(),
        x.atan(), x.atan2(x), x.exp(), x.ln(), x.exp2(), x.log2(), x.powf(x), x.sqrt(),
    ]);
}

/// Brings a context up and loads everything. Exits with `EXIT_NO_DRIVER` if there is no
/// driver to test, which is not a failure and must not be reported as one.
pub fn init() -> Gl {
    init_es(3, 1)
}

/// The same, on a context of a stated ES version. A case that upstream runs on an ES 2.0
/// context has to be reproduced on one: an API whose answer changed between versions
/// gives a different, and legal, answer on a newer context.
pub fn init_es(es_major: EGLint, es_minor: EGLint) -> Gl {
    keep_libm_linked();
    let egl = open_lib(&["libEGL.so.1", "libEGL.so"]).unwrap_or_else(|| die(EXIT_NO_DRIVER, "no libEGL"));
    let gles = open_lib(&["libGLESv2.so.2", "libGLESv2.so"]).unwrap_or_else(|| die(EXIT_NO_DRIVER, "no libGLESv2"));

    let get_proc: unsafe extern "C" fn(*const c_char) -> *mut c_void = unsafe { std::mem::transmute(sym(egl, "eglGetProcAddress")) };
    let loader = Loader { gles, get_proc };

    let egl_get_display: unsafe extern "C" fn(*mut c_void) -> EGLDisplay = unsafe { std::mem::transmute(sym(egl, "eglGetDisplay")) };
    let egl_initialize: unsafe extern "C" fn(EGLDisplay, *mut EGLint, *mut EGLint) -> c_uint = unsafe { std::mem::transmute(sym(egl, "eglInitialize")) };
    let egl_choose_config: unsafe extern "C" fn(EGLDisplay, *const EGLint, *mut EGLConfig, EGLint, *mut EGLint) -> c_uint =
        unsafe { std::mem::transmute(sym(egl, "eglChooseConfig")) };
    let egl_bind_api: unsafe extern "C" fn(c_uint) -> c_uint = unsafe { std::mem::transmute(sym(egl, "eglBindAPI")) };
    let egl_create_context: unsafe extern "C" fn(EGLDisplay, EGLConfig, EGLContext, *const EGLint) -> EGLContext =
        unsafe { std::mem::transmute(sym(egl, "eglCreateContext")) };
    let egl_make_current: unsafe extern "C" fn(EGLDisplay, EGLSurface, EGLSurface, EGLContext) -> c_uint =
        unsafe { std::mem::transmute(sym(egl, "eglMakeCurrent")) };
    let egl_create_pbuffer: unsafe extern "C" fn(EGLDisplay, EGLConfig, *const EGLint) -> EGLSurface =
        unsafe { std::mem::transmute(sym(egl, "eglCreatePbufferSurface")) };

    step("connecting a display");
    let get_platform_display: Option<unsafe extern "C" fn(c_uint, *mut c_void, *const EGLint) -> EGLDisplay> = {
        let name = CString::new("eglGetPlatformDisplayEXT").expect("literal");
        let p = unsafe { get_proc(name.as_ptr()) };
        (!p.is_null()).then(|| unsafe { std::mem::transmute::<*mut c_void, unsafe extern "C" fn(c_uint, *mut c_void, *const EGLint) -> EGLDisplay>(p) })
    };

    let mut display = EGL_NO_DISPLAY;
    let mut how = "";

    if std::env::var_os("WAYLAND_DISPLAY").is_some() {
        if let Some(wl) = open_lib(&["libwayland-client.so.0", "libwayland-client.so"]) {
            let connect: unsafe extern "C" fn(*const c_char) -> *mut c_void = unsafe { std::mem::transmute(sym(wl, "wl_display_connect")) };
            let wl_display = unsafe { connect(std::ptr::null()) };
            if !wl_display.is_null() {
                display = unsafe { egl_get_display(wl_display) };
                how = "wayland platform";
            }
        }
    }

    if display == EGL_NO_DISPLAY {
        if let Some(get_platform) = get_platform_display {
            let name = CString::new("eglQueryDevicesEXT").expect("literal");
            let query_devices = unsafe { get_proc(name.as_ptr()) };
            if !query_devices.is_null() {
                let query: unsafe extern "C" fn(EGLint, *mut *mut c_void, *mut EGLint) -> c_uint = unsafe { std::mem::transmute(query_devices) };
                let mut devices: [*mut c_void; 4] = [std::ptr::null_mut(); 4];
                let mut found: EGLint = 0;
                if unsafe { query(4, devices.as_mut_ptr(), &mut found) } != 0 && found > 0 {
                    display = unsafe { get_platform(EGL_PLATFORM_DEVICE_EXT, devices[0], std::ptr::null()) };
                    how = "device platform";
                }
            }
            if display == EGL_NO_DISPLAY {
                display = unsafe { get_platform(EGL_PLATFORM_SURFACELESS_MESA, std::ptr::null_mut(), std::ptr::null()) };
                how = "surfaceless platform";
            }
        }
    }

    if display == EGL_NO_DISPLAY {
        display = unsafe { egl_get_display(std::ptr::null_mut()) };
        how = "default display";
    }
    if display == EGL_NO_DISPLAY {
        die(EXIT_NO_DRIVER, "no EGL display - is a compositor running, and are XDG_RUNTIME_DIR/WAYLAND_DISPLAY set?");
    }

    let (mut major, mut minor) = (0, 0);
    if unsafe { egl_initialize(display, &mut major, &mut minor) } == 0 {
        die(EXIT_NO_DRIVER, &format!("eglInitialize failed on the {how}"));
    }
    eprintln!("    EGL {major}.{minor} on the {how}");
    unsafe { egl_bind_api(EGL_OPENGL_ES_API) };

    // Depth and stencil asked for explicitly: EGL sorts configs with *fewer* of them
    // first, so a request for colour alone reliably yields a target with neither.
    let es_bit = if es_major >= 3 { EGL_OPENGL_ES3_BIT } else { EGL_OPENGL_ES2_BIT };
    let full = [
        EGL_RENDERABLE_TYPE, es_bit,
        EGL_SURFACE_TYPE, EGL_PBUFFER_BIT,
        EGL_RED_SIZE, 8, EGL_GREEN_SIZE, 8, EGL_BLUE_SIZE, 8, EGL_ALPHA_SIZE, 8,
        EGL_DEPTH_SIZE, 24, EGL_STENCIL_SIZE, 8,
        EGL_NONE,
    ];
    let colour_only = [EGL_RENDERABLE_TYPE, es_bit, EGL_SURFACE_TYPE, EGL_PBUFFER_BIT, EGL_NONE];
    let mut config: EGLConfig = std::ptr::null_mut();
    let mut num_config: EGLint = 0;
    let mut got = unsafe { egl_choose_config(display, full.as_ptr(), &mut config, 1, &mut num_config) } != 0 && num_config > 0;
    if got {
        eprintln!("    config with depth 24 + stencil 8");
    } else {
        got = unsafe { egl_choose_config(display, colour_only.as_ptr(), &mut config, 1, &mut num_config) } != 0 && num_config > 0;
        if got {
            eprintln!("    no d24s8 config; colour only");
        }
    }
    if !got {
        die(EXIT_NO_DRIVER, &format!("no ES{es_major}-capable EGL config"));
    }

    step(&format!("creating an ES {es_major}.{es_minor} context"));
    // The minor version is only asked for when it is asked for: `EGL_CONTEXT_MINOR_VERSION`
    // next to a major of 2 makes Mesa hand back its newest ES context instead of an ES 2.0
    // one, which silently turns a question about ES 2.0 into a question about ES 3.2.
    let mut ctx_attribs = vec![EGL_CONTEXT_CLIENT_VERSION, es_major];
    if es_minor != 0 {
        ctx_attribs.extend_from_slice(&[EGL_CONTEXT_MINOR_VERSION, es_minor]);
    }
    ctx_attribs.push(EGL_NONE);
    let context = unsafe { egl_create_context(display, config, EGL_NO_CONTEXT, ctx_attribs.as_ptr()) };
    if context == EGL_NO_CONTEXT {
        die(EXIT_NO_DRIVER, &format!("could not create an ES {es_major}.{es_minor} context"));
    }
    // A real 256x256 pbuffer, the way the conformance suite runs these cases, falling
    // back to surfaceless only if the driver has no pbuffer at all. Compute does not need
    // a framebuffer, but which driver path is taken evidently depends on having one: the
    // surfaceless version of this harness did not reproduce a hang that the suite does.
    let pbuffer_attribs = [EGL_WIDTH, TARGET_WIDTH, EGL_HEIGHT, TARGET_HEIGHT, EGL_NONE];
    let surface = unsafe { egl_create_pbuffer(display, config, pbuffer_attribs.as_ptr()) };
    if surface != EGL_NO_SURFACE {
        eprintln!("    {TARGET_WIDTH}x{TARGET_HEIGHT} pbuffer");
    } else {
        eprintln!("    no pbuffer; surfaceless");
    }
    if unsafe { egl_make_current(display, surface, surface, context) } == 0 {
        die(EXIT_NO_DRIVER, "eglMakeCurrent failed");
    }

    let gl = Gl::load(&loader);

    let renderer = unsafe { std::ffi::CStr::from_ptr((gl.get_string)(GL_RENDERER)).to_string_lossy().to_string() };
    let version = unsafe { std::ffi::CStr::from_ptr((gl.get_string)(GL_VERSION)).to_string_lossy().to_string() };
    eprintln!("    {version} - {renderer}");
    gl
}

/// Context creation the way `hodow_cts` does it on a Wayland display: for each version,
/// newest first, a fresh `wl_display` and `eglGetPlatformDisplay`, a d24s8 config and a
/// 256x256 pbuffer, then the context. A version the driver refuses keeps its display
/// initialised - only the pbuffer is destroyed - exactly as the suite leaves it, which
/// is not a detail: a GPU hang the suite reproduces did not reproduce without it.
/// Without `WAYLAND_DISPLAY` this is `init_es` with the last version.
pub fn init_es_like_suite(versions: &[(EGLint, EGLint)]) -> Gl {
    keep_libm_linked();
    let &(last_major, last_minor) = versions.last().expect("at least one version");
    let wl = open_lib(&["libwayland-client.so.0", "libwayland-client.so"]);
    let (Some(wl), true) = (wl, std::env::var_os("WAYLAND_DISPLAY").is_some()) else {
        return init_es(last_major, last_minor);
    };
    let egl = open_lib(&["libEGL.so.1", "libEGL.so"]).unwrap_or_else(|| die(EXIT_NO_DRIVER, "no libEGL"));
    let gles = open_lib(&["libGLESv2.so.2", "libGLESv2.so"]).unwrap_or_else(|| die(EXIT_NO_DRIVER, "no libGLESv2"));
    let get_proc: unsafe extern "C" fn(*const c_char) -> *mut c_void = unsafe { std::mem::transmute(sym(egl, "eglGetProcAddress")) };
    let loader = Loader { gles, get_proc };
    let connect: unsafe extern "C" fn(*const c_char) -> *mut c_void = unsafe { std::mem::transmute(sym(wl, "wl_display_connect")) };
    let get_platform_display = loader.get("eglGetPlatformDisplay");
    if get_platform_display.is_null() {
        die(EXIT_NO_DRIVER, "no eglGetPlatformDisplay");
    }
    let get_platform_display: unsafe extern "C" fn(c_uint, *mut c_void, *const isize) -> EGLDisplay = unsafe { std::mem::transmute(get_platform_display) };
    let egl_initialize: unsafe extern "C" fn(EGLDisplay, *mut EGLint, *mut EGLint) -> c_uint = unsafe { std::mem::transmute(sym(egl, "eglInitialize")) };
    let egl_choose_config: unsafe extern "C" fn(EGLDisplay, *const EGLint, *mut EGLConfig, EGLint, *mut EGLint) -> c_uint =
        unsafe { std::mem::transmute(sym(egl, "eglChooseConfig")) };
    let egl_bind_api: unsafe extern "C" fn(c_uint) -> c_uint = unsafe { std::mem::transmute(sym(egl, "eglBindAPI")) };
    let egl_create_context: unsafe extern "C" fn(EGLDisplay, EGLConfig, EGLContext, *const EGLint) -> EGLContext =
        unsafe { std::mem::transmute(sym(egl, "eglCreateContext")) };
    let egl_make_current: unsafe extern "C" fn(EGLDisplay, EGLSurface, EGLSurface, EGLContext) -> c_uint =
        unsafe { std::mem::transmute(sym(egl, "eglMakeCurrent")) };
    let egl_create_pbuffer: unsafe extern "C" fn(EGLDisplay, EGLConfig, *const EGLint) -> EGLSurface =
        unsafe { std::mem::transmute(sym(egl, "eglCreatePbufferSurface")) };
    let egl_destroy_surface: unsafe extern "C" fn(EGLDisplay, EGLSurface) -> c_uint = unsafe { std::mem::transmute(sym(egl, "eglDestroySurface")) };
    let egl_get_error: unsafe extern "C" fn() -> EGLint = unsafe { std::mem::transmute(sym(egl, "eglGetError")) };

    for &(es_major, es_minor) in versions {
        step(&format!("ES {es_major}.{es_minor}: new wl_display, EGL display, d24s8 config, 256x256 pbuffer, context"));
        let wl_display = unsafe { connect(std::ptr::null()) };
        if wl_display.is_null() {
            die(EXIT_NO_DRIVER, "wl_display_connect failed - is a compositor running, and is XDG_RUNTIME_DIR set?");
        }
        let display = unsafe { get_platform_display(EGL_PLATFORM_WAYLAND_KHR, wl_display, std::ptr::null()) };
        let (mut major, mut minor) = (0, 0);
        if display == EGL_NO_DISPLAY || unsafe { egl_initialize(display, &mut major, &mut minor) } == 0 {
            die(EXIT_NO_DRIVER, "no EGL display on the wayland platform");
        }
        unsafe { egl_bind_api(EGL_OPENGL_ES_API) };
        let es_bit = if es_major >= 3 { EGL_OPENGL_ES3_BIT } else { EGL_OPENGL_ES2_BIT };
        let attribs = [
            EGL_RENDERABLE_TYPE, es_bit,
            EGL_SURFACE_TYPE, EGL_PBUFFER_BIT,
            EGL_RED_SIZE, 8, EGL_GREEN_SIZE, 8, EGL_BLUE_SIZE, 8, EGL_ALPHA_SIZE, 8,
            EGL_DEPTH_SIZE, 24, EGL_STENCIL_SIZE, 8,
            EGL_NONE,
        ];
        let mut config: EGLConfig = std::ptr::null_mut();
        let mut num_config: EGLint = 0;
        if unsafe { egl_choose_config(display, attribs.as_ptr(), &mut config, 1, &mut num_config) } == 0 || num_config == 0 {
            die(EXIT_NO_DRIVER, "no d24s8 pbuffer config");
        }
        let pbuffer_attribs = [EGL_WIDTH, TARGET_WIDTH, EGL_HEIGHT, TARGET_HEIGHT, EGL_NONE];
        let surface = unsafe { egl_create_pbuffer(display, config, pbuffer_attribs.as_ptr()) };
        if surface == EGL_NO_SURFACE {
            die(EXIT_NO_DRIVER, "no pbuffer");
        }
        let ctx_attribs = [EGL_CONTEXT_CLIENT_VERSION, es_major, EGL_CONTEXT_MINOR_VERSION, es_minor, EGL_NONE];
        let context = unsafe { egl_create_context(display, config, EGL_NO_CONTEXT, ctx_attribs.as_ptr()) };
        if context == EGL_NO_CONTEXT {
            let error = unsafe { egl_get_error() };
            unsafe { egl_destroy_surface(display, surface) };
            eprintln!("    refused (EGL error {error:#x}); pbuffer destroyed, display left initialised");
            continue;
        }
        if unsafe { egl_make_current(display, surface, surface, context) } == 0 {
            die(EXIT_NO_DRIVER, "eglMakeCurrent failed");
        }
        let gl = Gl::load(&loader);
        eprintln!("    {} - {}", gl.version(), unsafe { std::ffi::CStr::from_ptr((gl.get_string)(GL_RENDERER)).to_string_lossy() });
        return gl;
    }
    die(EXIT_NO_DRIVER, "every ES version was refused")
}

impl Gl {
    /// Compiles and links a compute shader, or dies with the driver's own log - which on
    /// an embedded driver is often the interesting part.
    pub fn build_compute(&self, source: &str) -> GLuint {
        let csource = CString::new(source).expect("shader source");
        let shader = unsafe { (self.create_shader)(GL_COMPUTE_SHADER) };
        unsafe {
            let ptr = csource.as_ptr();
            (self.shader_source)(shader, 1, &ptr, std::ptr::null());
            (self.compile_shader)(shader);
        }
        let mut ok: GLint = 0;
        unsafe { (self.get_shaderiv)(shader, GL_COMPILE_STATUS, &mut ok) };
        if ok == 0 {
            die(EXIT_FAIL, &format!("the compute shader did not compile:\n{}", self.shader_log(shader)));
        }

        let program = unsafe { (self.create_program)() };
        unsafe {
            (self.attach_shader)(program, shader);
            (self.link_program)(program);
            (self.get_programiv)(program, GL_LINK_STATUS, &mut ok);
        }
        if ok == 0 {
            die(EXIT_FAIL, "the program did not link");
        }
        unsafe { (self.use_program)(program) };
        program
    }

    pub fn program_log(&self, program: GLuint) -> String {
        let mut len: GLint = 0;
        unsafe { (self.get_programiv)(program, GL_INFO_LOG_LENGTH, &mut len) };
        let mut buf = vec![0u8; len.max(1) as usize];
        unsafe { (self.get_program_info_log)(program, buf.len() as c_int, std::ptr::null_mut(), buf.as_mut_ptr().cast()) };
        String::from_utf8_lossy(&buf).trim_end_matches('\0').to_string()
    }

    pub fn shader_log(&self, shader: GLuint) -> String {
        let mut len: GLint = 0;
        unsafe { (self.get_shaderiv)(shader, GL_INFO_LOG_LENGTH, &mut len) };
        let mut buf = vec![0u8; len.max(1) as usize];
        unsafe { (self.get_shader_info_log)(shader, buf.len() as c_int, std::ptr::null_mut(), buf.as_mut_ptr().cast()) };
        String::from_utf8_lossy(&buf).trim_end_matches('\0').to_string()
    }

    /// Builds a vertex + fragment program, or dies with the driver's own log.
    pub fn build_render(&self, vertex: &str, fragment: &str) -> GLuint {
        self.build_render_with_feedback(vertex, fragment, &[], GL_INTERLEAVED_ATTRIBS)
    }

    /// `build_render`, with `varyings` declared for transform feedback before the link.
    pub fn build_render_with_feedback(&self, vertex: &str, fragment: &str, varyings: &[&str], buffer_mode: GLenum) -> GLuint {
        let program = unsafe { (self.create_program)() };
        for (kind, source, what) in [(GL_VERTEX_SHADER, vertex, "vertex"), (GL_FRAGMENT_SHADER, fragment, "fragment")] {
            let csource = CString::new(source).expect("shader source");
            let shader = unsafe { (self.create_shader)(kind) };
            let mut ok: GLint = 0;
            unsafe {
                let ptr = csource.as_ptr();
                (self.shader_source)(shader, 1, &ptr, std::ptr::null());
                (self.compile_shader)(shader);
                (self.get_shaderiv)(shader, GL_COMPILE_STATUS, &mut ok);
            }
            if ok == 0 {
                die(EXIT_FAIL, &format!("the {what} shader did not compile:\n{}", self.shader_log(shader)));
            }
            unsafe { (self.attach_shader)(program, shader) };
        }
        if !varyings.is_empty() {
            let names: Vec<CString> = varyings.iter().map(|v| CString::new(*v).expect("varying name")).collect();
            let ptrs: Vec<*const c_char> = names.iter().map(|n| n.as_ptr()).collect();
            unsafe { (self.transform_feedback_varyings)(program, ptrs.len() as c_int, ptrs.as_ptr(), buffer_mode) };
        }
        let mut ok: GLint = 0;
        unsafe {
            (self.link_program)(program);
            (self.get_programiv)(program, GL_LINK_STATUS, &mut ok);
        }
        if ok == 0 {
            die(EXIT_FAIL, &format!("the program did not link:\n{}", self.program_log(program)));
        }
        unsafe { (self.use_program)(program) };
        program
    }

    /// Covers the whole target with one triangle strip through attribute 0 and returns the
    /// centre pixel. A fragment-shader reproducer needs a real draw, and this is the whole
    /// of one: the conformance cases these come from answer with a colour, so the verdict
    /// is a colour too.
    pub fn draw_and_read_centre(&self) -> [u8; 4] {
        const CORNERS: [f32; 16] = [-1.0, -1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0];
        let mut pixel = [0u8; 4];
        let mut buf: GLuint = 0;
        unsafe {
            (self.gen_buffers)(1, &mut buf);
            (self.bind_buffer)(GL_ARRAY_BUFFER, buf);
            (self.buffer_data)(GL_ARRAY_BUFFER, size_of_val(&CORNERS) as GLsizeiptr, CORNERS.as_ptr().cast(), GL_STATIC_DRAW);
            (self.vertex_attrib_pointer)(0, 4, GL_FLOAT, GL_FALSE, 0, std::ptr::null());
            (self.enable_vertex_attrib_array)(0);
            (self.viewport)(0, 0, TARGET_WIDTH, TARGET_HEIGHT);
            (self.clear_color)(0.0, 0.0, 0.0, 1.0);
            (self.clear)(GL_COLOR_BUFFER_BIT);
            (self.draw_arrays)(GL_TRIANGLE_STRIP, 0, 4);
            (self.finish)();
            (self.read_pixels)(TARGET_WIDTH / 2, TARGET_HEIGHT / 2, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixel.as_mut_ptr().cast());
        }
        pixel
    }

    /// Uploads `vertices` - four floats each - to attribute 0 and draws them as triangles,
    /// leaving whatever was already in the target alone. Two passes over the same vertices
    /// with two programs is how an invariance case is asked its question.
    pub fn draw_triangles(&self, vertices: &[f32]) {
        let mut buf: GLuint = 0;
        unsafe {
            (self.gen_buffers)(1, &mut buf);
            (self.bind_buffer)(GL_ARRAY_BUFFER, buf);
            (self.buffer_data)(GL_ARRAY_BUFFER, size_of_val(vertices) as GLsizeiptr, vertices.as_ptr().cast(), GL_STATIC_DRAW);
            (self.vertex_attrib_pointer)(0, 4, GL_FLOAT, GL_FALSE, 0, std::ptr::null());
            (self.enable_vertex_attrib_array)(0);
            (self.viewport)(0, 0, TARGET_WIDTH, TARGET_HEIGHT);
            (self.draw_arrays)(GL_TRIANGLES, 0, (vertices.len() / 4) as GLint);
        }
    }

    /// The whole target as RGBA8, one pixel per four bytes.
    pub fn read_target(&self) -> Vec<u8> {
        let mut pixels = vec![0u8; (TARGET_WIDTH * TARGET_HEIGHT * 4) as usize];
        unsafe {
            (self.finish)();
            (self.read_pixels)(0, 0, TARGET_WIDTH, TARGET_HEIGHT, GL_RGBA, GL_UNSIGNED_BYTE, pixels.as_mut_ptr().cast());
        }
        pixels
    }

    /// Compiles one shader and says whether the driver accepted it, with the driver's own
    /// log. Unlike `build_compute` a rejection is not fatal: for a finding about what the
    /// compiler accepts, whether it was right to reject is the question rather than an
    /// obstacle, and both answers have to come back to `main`.
    pub fn compile(&self, kind: GLenum, source: &str) -> Result<(), String> {
        let csource = CString::new(source).expect("shader source");
        let shader = unsafe { (self.create_shader)(kind) };
        let mut ok: GLint = 0;
        unsafe {
            let ptr = csource.as_ptr();
            (self.shader_source)(shader, 1, &ptr, std::ptr::null());
            (self.compile_shader)(shader);
            (self.get_shaderiv)(shader, GL_COMPILE_STATUS, &mut ok);
        }
        if ok == 0 { Err(self.shader_log(shader)) } else { Ok(()) }
    }

    /// An SSBO filled with `values` and bound to `binding`.
    pub fn ssbo_i32(&self, binding: GLuint, values: &[i32]) -> GLuint {
        let mut buf: GLuint = 0;
        unsafe {
            (self.gen_buffers)(1, &mut buf);
            (self.bind_buffer)(GL_SHADER_STORAGE_BUFFER, buf);
            (self.buffer_data)(GL_SHADER_STORAGE_BUFFER, (values.len() * 4) as GLsizeiptr, values.as_ptr().cast(), GL_STATIC_DRAW);
            (self.bind_buffer_base)(GL_SHADER_STORAGE_BUFFER, binding, buf);
        }
        buf
    }

    /// An empty buffer of `bytes`, allocated while bound to `target`. Which target that
    /// is need not be interchangeable: a driver can place the allocation by the first
    /// target it saw the buffer on.
    /// A buffer created *on* `target` holding these values - which is a different thing
    /// from creating it elsewhere and rebinding, since the target a buffer is first bound
    /// to is something a driver is allowed to place it by.
    pub fn upload_i32(&self, target: GLenum, values: &[i32]) -> GLuint {
        let mut buf: GLuint = 0;
        unsafe {
            (self.gen_buffers)(1, &mut buf);
            (self.bind_buffer)(target, buf);
            (self.buffer_data)(target, (values.len() * 4) as GLsizeiptr, values.as_ptr().cast(), GL_STATIC_DRAW);
        }
        buf
    }

    pub fn buffer(&self, target: GLenum, bytes: GLsizeiptr, usage: GLenum) -> GLuint {
        let mut buf: GLuint = 0;
        unsafe {
            (self.gen_buffers)(1, &mut buf);
            (self.bind_buffer)(target, buf);
            (self.buffer_data)(target, bytes, std::ptr::null(), usage);
        }
        buf
    }

    /// Reads an SSBO back. Call after whatever waits for the GPU.
    pub fn read_i32(&self, buf: GLuint, count: usize) -> Vec<i32> {
        let mapped = unsafe {
            (self.bind_buffer)(GL_SHADER_STORAGE_BUFFER, buf);
            (self.map_buffer_range)(GL_SHADER_STORAGE_BUFFER, 0, (count * 4) as GLsizeiptr, GL_MAP_READ_BIT)
        };
        if mapped.is_null() {
            die(EXIT_FAIL, "could not map the buffer to read it back");
        }
        let values = unsafe { std::slice::from_raw_parts(mapped.cast::<i32>(), count) }.to_vec();
        unsafe { (self.unmap_buffer)(GL_SHADER_STORAGE_BUFFER) };
        values
    }

    /// Reads an SSBO back as floats. Call after whatever waits for the GPU.
    pub fn read_f32(&self, buf: GLuint, count: usize) -> Vec<f32> {
        self.read_i32(buf, count).iter().map(|bits| f32::from_bits(*bits as u32)).collect()
    }

    /// Where the driver says it put a buffer variable: one value per requested property
    /// (`GL_OFFSET`, `GL_ARRAY_STRIDE`, `GL_MATRIX_STRIDE`, ...). A reproducer about
    /// layout has to ask rather than assume - a driver is allowed its own packing, and
    /// the only thing it may not do is disagree with the answer it gave here.
    pub fn buffer_variable(&self, program: GLuint, name: &str, props: &[GLenum]) -> Vec<GLint> {
        let cname = CString::new(name).expect("variable name");
        let index = unsafe { (self.get_program_resource_index)(program, GL_BUFFER_VARIABLE, cname.as_ptr()) };
        if index == GL_INVALID_INDEX {
            die(EXIT_FAIL, &format!("the program has no buffer variable called {name}"));
        }
        let mut out = vec![0; props.len()];
        unsafe {
            (self.get_program_resourceiv)(
                program,
                GL_BUFFER_VARIABLE,
                index,
                props.len() as c_int,
                props.as_ptr(),
                out.len() as c_int,
                std::ptr::null_mut(),
                out.as_mut_ptr(),
            );
        }
        out
    }

    /// A single-level 3D texture, ready for `glBindImageTexture` with `layered = GL_TRUE`.
    /// Storage only: every case that uses one writes each texel before reading it.
    pub fn image_3d(&self, internal_format: GLenum, width: GLint, height: GLint, depth: GLint) -> GLuint {
        let mut tex: GLuint = 0;
        unsafe {
            (self.gen_textures)(1, &mut tex);
            (self.bind_texture)(GL_TEXTURE_3D, tex);
            (self.tex_storage_3d)(GL_TEXTURE_3D, 1, internal_format, width, height, depth);
            (self.tex_parameteri)(GL_TEXTURE_3D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            (self.tex_parameteri)(GL_TEXTURE_3D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        }
        tex
    }

    /// A single-level cube map, ready for `glBindImageTexture` with `layered = GL_TRUE`.
    /// Storage only: every case that uses one writes each texel before reading it.
    pub fn image_cube(&self, internal_format: GLenum, size: GLint) -> GLuint {
        let mut tex: GLuint = 0;
        unsafe {
            (self.gen_textures)(1, &mut tex);
            (self.bind_texture)(GL_TEXTURE_CUBE_MAP, tex);
            (self.tex_storage_2d)(GL_TEXTURE_CUBE_MAP, 1, internal_format, size, size);
            (self.tex_parameteri)(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            (self.tex_parameteri)(GL_TEXTURE_CUBE_MAP, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
        }
        tex
    }

    /// A single-level 2D texture, zero-filled, ready for `glBindImageTexture`.
    pub fn image_2d(&self, internal_format: GLenum, format: GLenum, kind: GLenum, width: GLint, height: GLint) -> GLuint {
        let mut tex: GLuint = 0;
        let zeros = vec![0u32; (width * height) as usize];
        unsafe {
            (self.gen_textures)(1, &mut tex);
            (self.bind_texture)(GL_TEXTURE_2D, tex);
            (self.tex_storage_2d)(GL_TEXTURE_2D, 1, internal_format, width, height);
            (self.tex_parameteri)(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
            (self.tex_parameteri)(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
            (self.tex_sub_image_2d)(GL_TEXTURE_2D, 0, 0, 0, width, height, format, kind, zeros.as_ptr().cast());
        }
        tex
    }

    /// One layer of an integer texture, read back through a framebuffer - which is how
    /// the conformance suite verifies an integer image, and not the same path through a
    /// driver as reading it with another compute shader.
    pub fn read_layer_i32(&self, tex: GLuint, layer: GLint, width: GLint, height: GLint) -> Vec<i32> {
        let mut fb: GLuint = 0;
        let mut values = vec![0i32; (width * height) as usize];
        unsafe {
            (self.gen_framebuffers)(1, &mut fb);
            (self.bind_framebuffer)(GL_FRAMEBUFFER, fb);
            (self.framebuffer_texture_layer)(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, tex, 0, layer);
            (self.read_pixels)(0, 0, width, height, GL_RED_INTEGER, GL_INT, values.as_mut_ptr().cast());
            (self.bind_framebuffer)(GL_FRAMEBUFFER, 0);
        }
        values
    }

    /// One integer state value, for a reproducer that has to show it stayed inside a
    /// limit the driver itself advertises.
    pub fn limit(&self, what: GLenum) -> GLint {
        let mut value: GLint = 0;
        unsafe { (self.get_integerv)(what, &mut value) };
        value
    }

    /// A fresh framebuffer with one renderbuffer per `(attachment point, internal format,
    /// width, height)`, and the completeness status the driver answers for it. Left bound.
    pub fn framebuffer_of(&self, attachments: &[(GLenum, GLenum, GLint, GLint)]) -> GLenum {
        let mut fbo: GLuint = 0;
        unsafe {
            (self.gen_framebuffers)(1, &mut fbo);
            (self.bind_framebuffer)(GL_FRAMEBUFFER, fbo);
            for &(point, internal_format, width, height) in attachments {
                let mut rbo: GLuint = 0;
                (self.gen_renderbuffers)(1, &mut rbo);
                (self.bind_renderbuffer)(GL_RENDERBUFFER, rbo);
                (self.renderbuffer_storage)(GL_RENDERBUFFER, internal_format, width, height);
                (self.framebuffer_renderbuffer)(GL_FRAMEBUFFER, point, GL_RENDERBUFFER, rbo);
            }
            (self.check_framebuffer_status)(GL_FRAMEBUFFER)
        }
    }

    /// What the context reports as its version. An ES 3 driver may answer an ES 2.0
    /// context request with an ES 3 context - Mesa does - so a case whose expected answer
    /// changed between versions has to read this rather than what it asked for.
    pub fn version(&self) -> String {
        unsafe { std::ffi::CStr::from_ptr((self.get_string)(GL_VERSION)).to_string_lossy().into_owned() }
    }

    /// Whether `GL_EXTENSIONS` lists `name` - the one string an ES 2.0 context has, so it
    /// works on every context `init_es` can make.
    pub fn has_extension(&self, name: &str) -> bool {
        let all = unsafe { std::ffi::CStr::from_ptr((self.get_string)(GL_EXTENSIONS)).to_string_lossy().into_owned() };
        all.split_whitespace().any(|ext| ext == name)
    }

    pub fn check(&self, what: &str) {
        let err = unsafe { (self.get_error)() };
        if err != GL_NO_ERROR {
            die(EXIT_FAIL, &format!("GL error {err:#x} after {what}"));
        }
    }
}

pub fn error_name(error: GLenum) -> String {
    let name = match error {
        GL_NO_ERROR => "GL_NO_ERROR",
        GL_INVALID_ENUM => "GL_INVALID_ENUM",
        GL_INVALID_VALUE => "GL_INVALID_VALUE",
        GL_INVALID_OPERATION => "GL_INVALID_OPERATION",
        _ => "",
    };
    format!("{error:#x} {name}")
}

pub fn framebuffer_status_name(status: GLenum) -> String {
    let name = match status {
        GL_FRAMEBUFFER_COMPLETE => "GL_FRAMEBUFFER_COMPLETE",
        GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT",
        GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT => "GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT",
        GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS => "GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS",
        GL_FRAMEBUFFER_UNSUPPORTED => "GL_FRAMEBUFFER_UNSUPPORTED",
        GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE => "GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE",
        _ => "",
    };
    format!("{status:#x} {name}")
}
