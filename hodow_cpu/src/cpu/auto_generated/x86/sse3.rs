mod addsub;
mod hadd;
mod hsub;
mod lddqu;
mod loaddup;
mod movedup;
mod movehdup;
mod moveldup;

use crate::cpu::auto_generated::x86::sse3::addsub::*;
use crate::cpu::auto_generated::x86::sse3::hadd::*;
use crate::cpu::auto_generated::x86::sse3::hsub::*;
use crate::cpu::auto_generated::x86::sse3::lddqu::*;
use crate::cpu::auto_generated::x86::sse3::loaddup::*;
use crate::cpu::auto_generated::x86::sse3::movedup::*;
use crate::cpu::auto_generated::x86::sse3::movehdup::*;
use crate::cpu::auto_generated::x86::sse3::moveldup::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct SSE3;

impl ExtensionTest for SSE3 {
    fn get_name() -> &'static str {
        "x86::SSE3"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_x86_sse3_mm_addsub_ps, "test_x86_sse3_mm_addsub_ps"),
            (test_x86_sse3_mm_addsub_ps_normal2, "test_x86_sse3_mm_addsub_ps_normal2"),
            (test_x86_sse3_mm_addsub_ps_normal3, "test_x86_sse3_mm_addsub_ps_normal3"),
            (test_x86_sse3_mm_addsub_ps_boundary_min, "test_x86_sse3_mm_addsub_ps_boundary_min"),
            (test_x86_sse3_mm_addsub_ps_boundary_max, "test_x86_sse3_mm_addsub_ps_boundary_max"),
            (test_x86_sse3_mm_addsub_ps_boundary_zero, "test_x86_sse3_mm_addsub_ps_boundary_zero"),
            (test_x86_sse3_mm_addsub_ps_boundary_allones, "test_x86_sse3_mm_addsub_ps_boundary_allones"),
            (test_x86_sse3_mm_addsub_ps_boundary_mixed, "test_x86_sse3_mm_addsub_ps_boundary_mixed"),
            (test_x86_sse3_mm_addsub_ps_asym_min_max, "test_x86_sse3_mm_addsub_ps_asym_min_max"),
            (test_x86_sse3_mm_addsub_ps_asym_max_min, "test_x86_sse3_mm_addsub_ps_asym_max_min"),
            (test_x86_sse3_mm_addsub_pd, "test_x86_sse3_mm_addsub_pd"),
            (test_x86_sse3_mm_addsub_pd_normal2, "test_x86_sse3_mm_addsub_pd_normal2"),
            (test_x86_sse3_mm_addsub_pd_normal3, "test_x86_sse3_mm_addsub_pd_normal3"),
            (test_x86_sse3_mm_addsub_pd_boundary_min, "test_x86_sse3_mm_addsub_pd_boundary_min"),
            (test_x86_sse3_mm_addsub_pd_boundary_max, "test_x86_sse3_mm_addsub_pd_boundary_max"),
            (test_x86_sse3_mm_addsub_pd_boundary_zero, "test_x86_sse3_mm_addsub_pd_boundary_zero"),
            (test_x86_sse3_mm_addsub_pd_boundary_allones, "test_x86_sse3_mm_addsub_pd_boundary_allones"),
            (test_x86_sse3_mm_addsub_pd_boundary_mixed, "test_x86_sse3_mm_addsub_pd_boundary_mixed"),
            (test_x86_sse3_mm_addsub_pd_asym_min_max, "test_x86_sse3_mm_addsub_pd_asym_min_max"),
            (test_x86_sse3_mm_addsub_pd_asym_max_min, "test_x86_sse3_mm_addsub_pd_asym_max_min"),
            (test_x86_sse3_mm_hadd_pd, "test_x86_sse3_mm_hadd_pd"),
            (test_x86_sse3_mm_hadd_pd_normal2, "test_x86_sse3_mm_hadd_pd_normal2"),
            (test_x86_sse3_mm_hadd_pd_normal3, "test_x86_sse3_mm_hadd_pd_normal3"),
            (test_x86_sse3_mm_hadd_pd_boundary_min, "test_x86_sse3_mm_hadd_pd_boundary_min"),
            (test_x86_sse3_mm_hadd_pd_boundary_max, "test_x86_sse3_mm_hadd_pd_boundary_max"),
            (test_x86_sse3_mm_hadd_pd_boundary_zero, "test_x86_sse3_mm_hadd_pd_boundary_zero"),
            (test_x86_sse3_mm_hadd_pd_boundary_allones, "test_x86_sse3_mm_hadd_pd_boundary_allones"),
            (test_x86_sse3_mm_hadd_pd_boundary_mixed, "test_x86_sse3_mm_hadd_pd_boundary_mixed"),
            (test_x86_sse3_mm_hadd_pd_asym_min_max, "test_x86_sse3_mm_hadd_pd_asym_min_max"),
            (test_x86_sse3_mm_hadd_pd_asym_max_min, "test_x86_sse3_mm_hadd_pd_asym_max_min"),
            (test_x86_sse3_mm_hadd_ps, "test_x86_sse3_mm_hadd_ps"),
            (test_x86_sse3_mm_hadd_ps_normal2, "test_x86_sse3_mm_hadd_ps_normal2"),
            (test_x86_sse3_mm_hadd_ps_normal3, "test_x86_sse3_mm_hadd_ps_normal3"),
            (test_x86_sse3_mm_hadd_ps_boundary_min, "test_x86_sse3_mm_hadd_ps_boundary_min"),
            (test_x86_sse3_mm_hadd_ps_boundary_max, "test_x86_sse3_mm_hadd_ps_boundary_max"),
            (test_x86_sse3_mm_hadd_ps_boundary_zero, "test_x86_sse3_mm_hadd_ps_boundary_zero"),
            (test_x86_sse3_mm_hadd_ps_boundary_allones, "test_x86_sse3_mm_hadd_ps_boundary_allones"),
            (test_x86_sse3_mm_hadd_ps_boundary_mixed, "test_x86_sse3_mm_hadd_ps_boundary_mixed"),
            (test_x86_sse3_mm_hadd_ps_asym_min_max, "test_x86_sse3_mm_hadd_ps_asym_min_max"),
            (test_x86_sse3_mm_hadd_ps_asym_max_min, "test_x86_sse3_mm_hadd_ps_asym_max_min"),
            (test_x86_sse3_mm_hsub_pd, "test_x86_sse3_mm_hsub_pd"),
            (test_x86_sse3_mm_hsub_pd_normal2, "test_x86_sse3_mm_hsub_pd_normal2"),
            (test_x86_sse3_mm_hsub_pd_normal3, "test_x86_sse3_mm_hsub_pd_normal3"),
            (test_x86_sse3_mm_hsub_pd_boundary_min, "test_x86_sse3_mm_hsub_pd_boundary_min"),
            (test_x86_sse3_mm_hsub_pd_boundary_max, "test_x86_sse3_mm_hsub_pd_boundary_max"),
            (test_x86_sse3_mm_hsub_pd_boundary_zero, "test_x86_sse3_mm_hsub_pd_boundary_zero"),
            (test_x86_sse3_mm_hsub_pd_boundary_allones, "test_x86_sse3_mm_hsub_pd_boundary_allones"),
            (test_x86_sse3_mm_hsub_pd_boundary_mixed, "test_x86_sse3_mm_hsub_pd_boundary_mixed"),
            (test_x86_sse3_mm_hsub_pd_asym_min_max, "test_x86_sse3_mm_hsub_pd_asym_min_max"),
            (test_x86_sse3_mm_hsub_pd_asym_max_min, "test_x86_sse3_mm_hsub_pd_asym_max_min"),
            (test_x86_sse3_mm_hsub_ps, "test_x86_sse3_mm_hsub_ps"),
            (test_x86_sse3_mm_hsub_ps_normal2, "test_x86_sse3_mm_hsub_ps_normal2"),
            (test_x86_sse3_mm_hsub_ps_normal3, "test_x86_sse3_mm_hsub_ps_normal3"),
            (test_x86_sse3_mm_hsub_ps_boundary_min, "test_x86_sse3_mm_hsub_ps_boundary_min"),
            (test_x86_sse3_mm_hsub_ps_boundary_max, "test_x86_sse3_mm_hsub_ps_boundary_max"),
            (test_x86_sse3_mm_hsub_ps_boundary_zero, "test_x86_sse3_mm_hsub_ps_boundary_zero"),
            (test_x86_sse3_mm_hsub_ps_boundary_allones, "test_x86_sse3_mm_hsub_ps_boundary_allones"),
            (test_x86_sse3_mm_hsub_ps_boundary_mixed, "test_x86_sse3_mm_hsub_ps_boundary_mixed"),
            (test_x86_sse3_mm_hsub_ps_asym_min_max, "test_x86_sse3_mm_hsub_ps_asym_min_max"),
            (test_x86_sse3_mm_hsub_ps_asym_max_min, "test_x86_sse3_mm_hsub_ps_asym_max_min"),
            (test_x86_sse3_mm_lddqu_si128, "test_x86_sse3_mm_lddqu_si128"),
            (test_x86_sse3_mm_movedup_pd, "test_x86_sse3_mm_movedup_pd"),
            (test_x86_sse3_mm_movedup_pd_normal2, "test_x86_sse3_mm_movedup_pd_normal2"),
            (test_x86_sse3_mm_movedup_pd_normal3, "test_x86_sse3_mm_movedup_pd_normal3"),
            (test_x86_sse3_mm_movedup_pd_boundary_min, "test_x86_sse3_mm_movedup_pd_boundary_min"),
            (test_x86_sse3_mm_movedup_pd_boundary_max, "test_x86_sse3_mm_movedup_pd_boundary_max"),
            (test_x86_sse3_mm_movedup_pd_boundary_zero, "test_x86_sse3_mm_movedup_pd_boundary_zero"),
            (test_x86_sse3_mm_movedup_pd_boundary_allones, "test_x86_sse3_mm_movedup_pd_boundary_allones"),
            (test_x86_sse3_mm_movedup_pd_boundary_mixed, "test_x86_sse3_mm_movedup_pd_boundary_mixed"),
            (test_x86_sse3_mm_loaddup_pd, "test_x86_sse3_mm_loaddup_pd"),
            (test_x86_sse3_mm_movehdup_ps, "test_x86_sse3_mm_movehdup_ps"),
            (test_x86_sse3_mm_movehdup_ps_normal2, "test_x86_sse3_mm_movehdup_ps_normal2"),
            (test_x86_sse3_mm_movehdup_ps_normal3, "test_x86_sse3_mm_movehdup_ps_normal3"),
            (test_x86_sse3_mm_movehdup_ps_boundary_min, "test_x86_sse3_mm_movehdup_ps_boundary_min"),
            (test_x86_sse3_mm_movehdup_ps_boundary_max, "test_x86_sse3_mm_movehdup_ps_boundary_max"),
            (test_x86_sse3_mm_movehdup_ps_boundary_zero, "test_x86_sse3_mm_movehdup_ps_boundary_zero"),
            (test_x86_sse3_mm_movehdup_ps_boundary_allones, "test_x86_sse3_mm_movehdup_ps_boundary_allones"),
            (test_x86_sse3_mm_movehdup_ps_boundary_mixed, "test_x86_sse3_mm_movehdup_ps_boundary_mixed"),
            (test_x86_sse3_mm_moveldup_ps, "test_x86_sse3_mm_moveldup_ps"),
            (test_x86_sse3_mm_moveldup_ps_normal2, "test_x86_sse3_mm_moveldup_ps_normal2"),
            (test_x86_sse3_mm_moveldup_ps_normal3, "test_x86_sse3_mm_moveldup_ps_normal3"),
            (test_x86_sse3_mm_moveldup_ps_boundary_min, "test_x86_sse3_mm_moveldup_ps_boundary_min"),
            (test_x86_sse3_mm_moveldup_ps_boundary_max, "test_x86_sse3_mm_moveldup_ps_boundary_max"),
            (test_x86_sse3_mm_moveldup_ps_boundary_zero, "test_x86_sse3_mm_moveldup_ps_boundary_zero"),
            (test_x86_sse3_mm_moveldup_ps_boundary_allones, "test_x86_sse3_mm_moveldup_ps_boundary_allones"),
            (test_x86_sse3_mm_moveldup_ps_boundary_mixed, "test_x86_sse3_mm_moveldup_ps_boundary_mixed"),
        ]
    }
}
