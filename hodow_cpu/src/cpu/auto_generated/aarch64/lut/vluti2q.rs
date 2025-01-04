use std::arch::aarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::sve::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_float_equality, check_int_equality};
#[allow(unused_imports)]
use crate::cpu::Verdict;

pub(super) fn test_aarch64_lut_vluti2q_lane_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_lane_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_u8::<0>(create_random_uint8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_u8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_lane_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_u8::<1>(create_random_uint8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_lane_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_u16::<0>(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_lane_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_u16::<1>(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_lane_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_u16::<3>(create_random_uint16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_lane_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_p8::<0>(create_random_poly8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_p8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_lane_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_p8::<1>(create_random_poly8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_lane_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_p16::<0>(create_random_poly16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_lane_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_p16::<1>(create_random_poly16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_p16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_lane_p16::<3>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_p16::<3>(create_random_poly16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_lane_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_s8::<0>(create_random_int8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_s8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_lane_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x8_t_from([17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_s8::<1>(create_random_int8x16_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_lane_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_s16::<0>(create_random_int16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_lane_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_s16::<1>(create_random_int16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_lane_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_lane_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x8_t_from([9, 10, 11, 12, 13, 14, 15, 16])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_lane_s16::<3>(create_random_int16x8_t(), create_random_uint8x8_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_laneq_u8::<0>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u8::<0>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_laneq_u8::<1>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u8::<1>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint8x16_t_to_u8_array(vluti2q_laneq_u8::<3>(create_uint8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u8::<3>(create_random_uint8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_laneq_u16::<0>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u16::<0>(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_laneq_u16::<1>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u16::<1>(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_laneq_u16::<7>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u16::<7>(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_u16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_uint16x8_t_to_u16_array(vluti2q_laneq_u16::<3>(create_uint16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_u16::<3>(create_random_uint16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_laneq_p8::<0>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p8::<0>(create_random_poly8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_laneq_p8::<1>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p8::<1>(create_random_poly8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly8x16_t_to_u8_array(vluti2q_laneq_p8::<3>(create_poly8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p8::<3>(create_random_poly8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_laneq_p16::<0>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p16::<0>(create_random_poly16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_laneq_p16::<1>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p16::<1>(create_random_poly16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_laneq_p16::<7>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p16::<7>(create_random_poly16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_p16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_poly16x8_t_to_u16_array(vluti2q_laneq_p16::<3>(create_poly16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_p16::<3>(create_random_poly16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s8() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_laneq_s8::<0>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s8::<0>(create_random_int8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s8_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_laneq_s8::<1>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s8::<1>(create_random_int8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s8_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int8x16_t_to_i8_array(vluti2q_laneq_s8::<3>(create_int8x16_t_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create_uint8x16_t_from([17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s8::<3>(create_random_int8x16_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s16() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_laneq_s16::<0>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s16::<0>(create_random_int16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s16_imm_1() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_laneq_s16::<1>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s16::<1>(create_random_int16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s16_imm_7() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_laneq_s16::<7>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s16::<7>(create_random_int16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}

pub(super) fn test_aarch64_lut_vluti2q_laneq_s16_imm_3() -> Result<Verdict, String> {
    unsafe {
        let result = unpack_int16x8_t_to_i16_array(vluti2q_laneq_s16::<3>(create_int16x8_t_from([1, 2, 3, 4, 5, 6, 7, 8]), create_uint8x16_t_from([9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24])));

        crate::cpu::fuzz(&mut || {
            let _ = vluti2q_laneq_s16::<3>(create_random_int16x8_t(), create_random_uint8x16_t());
        });
        Ok(Verdict::Unverified(Some(format!("{result:?}"))))
    }
}
