mod part1;

use crate::cpu::auto_generated::x86_64::amx::part1::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct AMX;

impl ExtensionTest for AMX {
    fn get_name() -> &'static str {
        "x86_64::AMX"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_tile_loadconfig, "test_tile_loadconfig"),
            (&test_tile_storeconfig, "test_tile_storeconfig"),
            (&test_tile_loadd, "test_tile_loadd"),
            (&test_tile_release, "test_tile_release"),
            (&test_tile_stored, "test_tile_stored"),
            (&test_tile_stream_loadd, "test_tile_stream_loadd"),
            (&test_tile_zero, "test_tile_zero"),
            (&test_tile_dpbf16ps, "test_tile_dpbf16ps"),
            (&test_tile_dpbssd, "test_tile_dpbssd"),
            (&test_tile_dpbsud, "test_tile_dpbsud"),
            (&test_tile_dpbusd, "test_tile_dpbusd"),
            (&test_tile_dpbuud, "test_tile_dpbuud"),
            (&test_tile_dpfp16ps, "test_tile_dpfp16ps"),
            (&test_tile_cmmimfp16ps, "test_tile_cmmimfp16ps"),
            (&test_tile_cmmrlfp16ps, "test_tile_cmmrlfp16ps"),
            (&test_tile_dpbf8ps, "test_tile_dpbf8ps"),
            (&test_tile_dpbhf8ps, "test_tile_dpbhf8ps"),
            (&test_tile_dphbf8ps, "test_tile_dphbf8ps"),
            (&test_tile_dphf8ps, "test_tile_dphf8ps"),
            (&test_tile_loaddrs, "test_tile_loaddrs"),
            (&test_tile_stream_loaddrs, "test_tile_stream_loaddrs"),
            (&test_tile_mmultf32ps, "test_tile_mmultf32ps"),
            (&test_tile_cvtrowd2ps, "test_tile_cvtrowd2ps"),
            (&test_tile_movrow, "test_tile_movrow"),
        ]
    }
}
