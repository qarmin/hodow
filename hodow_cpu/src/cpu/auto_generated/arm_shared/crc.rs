mod crc32b;
mod crc32cb;
mod crc32cd;
mod crc32ch;
mod crc32cw;
mod crc32d;
mod crc32h;
mod crc32w;

use crate::cpu::auto_generated::arm_shared::crc::crc32b::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32cb::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32cd::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32ch::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32cw::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32d::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32h::*;
use crate::cpu::auto_generated::arm_shared::crc::crc32w::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct CRC;

impl ExtensionTest for CRC {
    fn get_name() -> &'static str {
        "arm_shared::CRC"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_arm_shared_crc_crc32b, "test_arm_shared_crc_crc32b"),
            (test_arm_shared_crc_crc32cb, "test_arm_shared_crc_crc32cb"),
            #[cfg(target_arch = "arm")]
            (test_arm_shared_crc_crc32cd, "test_arm_shared_crc_crc32cd"),
            (test_arm_shared_crc_crc32ch, "test_arm_shared_crc_crc32ch"),
            (test_arm_shared_crc_crc32cw, "test_arm_shared_crc_crc32cw"),
            #[cfg(target_arch = "arm")]
            (test_arm_shared_crc_crc32d, "test_arm_shared_crc_crc32d"),
            (test_arm_shared_crc_crc32h, "test_arm_shared_crc_crc32h"),
            (test_arm_shared_crc_crc32w, "test_arm_shared_crc_crc32w"),
        ]
    }
}
