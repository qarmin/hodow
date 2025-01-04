//! A `glGet*` that returns several values written into a pointer to one variable overruns the
//! stack, and only on drivers that really write them all (GL41_ProgramUniforms segfaulted on
//! radeonsi and passed on llvmpipe). Rust cannot see that contract, so this reads the test
//! sources: every query whose output is a bare `&mut scalar` must name a value on the
//! single-valued list below. A new one fails here until someone decides which it is.

use std::path::{Path, PathBuf};

/// Queries that return exactly one value. Anything returning more must use an array.
const SINGLE_VALUED: &[&str] = &[
    "ACTIVE_ATOMIC_COUNTER_BUFFERS",
    "ACTIVE_ATTRIBUTES",
    "ACTIVE_RESOURCES",
    "ACTIVE_SUBROUTINES",
    "ACTIVE_UNIFORMS",
    "ATTACHED_SHADERS",
    "BLEND",
    "BLEND_SRC_RGB",
    "BUFFER_SIZE",
    "COMPILE_STATUS",
    "CONTEXT_FLAGS",
    "CURRENT_QUERY",
    "DEPTH_TEST",
    "ELEMENT_ARRAY_BUFFER_BINDING",
    "FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE",
    "FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE",
    "FRAMEBUFFER_DEFAULT_WIDTH",
    "HIGH_FLOAT",
    "INFO_LOG_LENGTH",
    "LINE_WIDTH",
    "LINK_STATUS",
    "MAJOR_VERSION",
    "MAX_COMPUTE_WORK_GROUP_COUNT",
    "MAX_SHADER_STORAGE_BLOCK_SIZE",
    "MEDIUM_INT",
    "MINOR_VERSION",
    "NUM_COMPATIBLE_SUBROUTINES",
    "NUM_EXTENSIONS",
    "NUM_PROGRAM_BINARY_FORMATS",
    "NUM_SHADER_BINARY_FORMATS",
    "PROGRAM_BINARY_LENGTH",
    "QUERY_RESULT",
    "QUERY_RESULT_AVAILABLE",
    "RENDERBUFFER_WIDTH",
    "SAMPLES",
    "SHADER_SOURCE_LENGTH",
    "TEXTURE_BINDING_2D",
    "TEXTURE_COMPRESSED",
    "TEXTURE_COMPRESSED_IMAGE_SIZE",
    "TEXTURE_HEIGHT",
    "TEXTURE_MAG_FILTER",
    "TEXTURE_MIN_FILTER",
    "TEXTURE_WIDTH",
    "TEXTURE_WRAP_S",
    "TEXTURE_WRAP_T",
    "TRANSFORM_FEEDBACK_ACTIVE",
    "TRANSFORM_FEEDBACK_BUFFER_BINDING",
    "TRANSFORM_FEEDBACK_BUFFER_START",
    "UNIFORM_BLOCK_ACTIVE_UNIFORMS",
    "UNIFORM_BLOCK_DATA_SIZE",
    "UNIFORM_BLOCK_NAME_LENGTH",
    "VALIDATE_STATUS",
    "VERTEX_ATTRIB_ARRAY_ENABLED",
    "VERTEX_ATTRIB_ARRAY_POINTER",
    "VERTEX_BINDING_OFFSET",
    // NVX_gpu_memory_info: GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX
    "0x9049",
];

/// Functions that take the number of values they may write, so the buffer size is the caller's explicit choice.
const SIZED_FUNCTIONS: &[&str] = &["GetBufferSubData", "GetSynciv"];

/// (file, variable) pairs where the queried value is not a constant: `glGetUniform*` on a uniform the
/// same test declared and set as a scalar.
const SCALAR_UNIFORM_READS: &[(&str, &str)] = &[
    ("gl20_uniforms.rs", "value"),
    ("gl30_advanced.rs", "uint_val"),
    ("gl40_transform_feedback.rs", "uniform_d"),
];

const SCANNED_DIRS: &[&str] = &["src/opengl", "../hodow_bench/src/bench"];

fn rust_files(dir: &Path, out: &mut Vec<PathBuf>) {
    for entry in std::fs::read_dir(dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())) {
        let path = entry.unwrap().path();
        if path.is_dir() {
            rust_files(&path, out);
        } else if path.extension().is_some_and(|e| e == "rs")
            && !path.ends_with("generated_requirements.rs")
            && !path.ends_with("query_size_lint.rs")
        {
            out.push(path);
        }
    }
}

fn is_ident_char(c: char) -> bool {
    c.is_ascii_alphanumeric() || c == '_'
}

/// Arguments of the call whose `(` is at `open`, split on top-level commas.
fn call_args(src: &str, open: usize) -> Vec<String> {
    let mut depth = 0usize;
    let mut args = vec![String::new()];
    for c in src[open..].chars() {
        match c {
            '(' | '[' | '{' => {
                depth += 1;
                if depth == 1 {
                    continue;
                }
            }
            ')' | ']' | '}' => {
                depth -= 1;
                if depth == 0 {
                    break;
                }
            }
            ',' if depth == 1 => {
                args.push(String::new());
                continue;
            }
            _ => {}
        }
        args.last_mut().unwrap().push(c);
    }
    args.into_iter()
        .map(|a| a.trim().to_string())
        .filter(|a| !a.is_empty())
        .collect()
}

/// `x` for an argument written `&mut x` (optionally `as *mut _`), None for anything else.
fn bare_scalar_out(arg: &str) -> Option<&str> {
    let name = arg.strip_prefix("&mut ")?;
    let ident_end = name.find(|c: char| !is_ident_char(c)).unwrap_or(name.len());
    let (ident, rest) = name.split_at(ident_end);
    (!ident.is_empty() && (rest.is_empty() || rest.trim_start().starts_with("as "))).then_some(ident)
}

/// The queried value: the last `gl::CONSTANT` among the arguments (targets and attachments come first).
fn queried_constant(args: &[String]) -> Option<&str> {
    args.iter().rev().find_map(|a| {
        if a.starts_with("0x") {
            return Some(a.as_str());
        }
        let name = a.strip_prefix("gl::")?;
        name.chars()
            .all(|c| c.is_ascii_uppercase() || c.is_ascii_digit() || c == '_')
            .then_some(name)
    })
}

fn violations(file: &str, src: &str) -> Vec<String> {
    let mut found = Vec::new();
    for (at, _) in src.match_indices("gl::Get") {
        if src[..at].ends_with(is_ident_char) {
            continue;
        }
        let line_start = src[..at].rfind('\n').map_or(0, |i| i + 1);
        if src[line_start..at].contains("//") {
            continue;
        }
        let rest = &src[at + "gl::".len()..];
        let name_len = rest.find(|c: char| !is_ident_char(c)).unwrap_or(rest.len());
        if !rest[name_len..].starts_with('(') {
            continue;
        }
        let args = call_args(src, at + "gl::".len() + name_len);
        let Some(variable) = args.last().and_then(|a| bare_scalar_out(a)) else {
            continue;
        };
        let function = &rest[..name_len];
        if SIZED_FUNCTIONS.contains(&function) {
            continue;
        }
        let line = src[..at].matches('\n').count() + 1;
        match queried_constant(&args[..args.len() - 1]) {
            Some(constant) if SINGLE_VALUED.contains(&constant) => {}
            Some(constant) => found.push(format!("{file}:{line}: gl::{function}(gl::{constant}) writes into the single value `{variable}`")),
            None if SCALAR_UNIFORM_READS.iter().any(|(f, v)| file.ends_with(f) && *v == variable) => {}
            None => found.push(format!("{file}:{line}: gl::{function} writes into the single value `{variable}` and the queried value is not a constant")),
        }
    }
    found
}

#[test]
fn glget_outputs_are_big_enough() {
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let mut files = Vec::new();
    for dir in SCANNED_DIRS {
        rust_files(&root.join(dir), &mut files);
    }
    assert!(
        files.len() > 20,
        "scanned only {} files, the directories moved?",
        files.len()
    );
    let mut found = Vec::new();
    for file in &files {
        let src = std::fs::read_to_string(file).unwrap();
        found.extend(violations(
            &file.strip_prefix(root).unwrap().display().to_string(),
            &src,
        ));
    }
    assert!(
        found.is_empty(),
        "glGet* output buffers that may be too small. If the query returns exactly one value add it to SINGLE_VALUED, otherwise pass an array:\n{}",
        found.join("\n")
    );
}

#[test]
fn lint_flags_the_known_bad_shapes() {
    let bad = "gl::GetFloati_v(gl::VIEWPORT, 0, &mut v);\ngl::GetIntegerv(\n    gl::VIEWPORT,\n    &mut w,\n);\ngl::GetMultisamplefv(gl::SAMPLE_POSITION, 0, &mut s);";
    assert_eq!(violations("x.rs", bad).len(), 3);
    let fine = "gl::GetIntegerv(gl::VIEWPORT, a.as_mut_ptr());\n// gl::GetIntegerv(gl::VIEWPORT, &mut v);\ngl::GetProgramInfoLog(p, n, &mut len, buf.as_mut_ptr());";
    assert!(violations("x.rs", fine).is_empty());
}
