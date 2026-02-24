#[cfg(target_arch = "aarch64")]
pub mod aarch64;

#[cfg(target_arch = "arm")]
pub mod arm;

#[cfg(any(target_arch = "arm", target_arch = "aarch64"))]
pub mod arm_shared;

#[cfg(target_arch = "mips")]
pub mod mips;

#[cfg(all() /* nvptx not supported */)]
pub mod nvptx;

#[cfg(target_arch = "powerpc")]
pub mod powerpc;

#[cfg(target_arch = "powerpc64")]
pub mod powerpc64;

#[cfg(target_arch = "riscv32")]
pub mod riscv32;

#[cfg(target_arch = "riscv64")]
pub mod riscv64;

#[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
pub mod riscv_shared;

#[cfg(target_arch = "s390x")]
pub mod s390x;

#[cfg(target_arch = "wasm32")]
pub mod wasm32;

#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
pub mod x86;

#[cfg(target_arch = "x86_64")]
pub mod x86_64;

pub mod registry;