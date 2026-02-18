/// Macro to generate SIMD test functions with fuzzing support
///
/// Usage:
/// ```
/// test_simd!(test_mm256_add_epi32,
///     // Normal test block
///     {
///         let result = unpack__m256i_to_i32_array(_mm256_add_epi32(
///             create__m256i_from_i32_array([8, 7, 6, 5, 4, 3, 2, 1]),
///             create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]),
///         ));
///         check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;
///     },
///     // Fuzzer expression
///     _mm256_add_epi32(create_random__m256i(), create_random__m256i())
/// );
/// ```
#[macro_export]
macro_rules! test_simd {
    ($test_name:ident, $test_block:block, $fuzzer_expr:expr) => {
        pub(super) fn $test_name() -> Result<(), String> {
            unsafe {
                $test_block

                if $crate::get_fuzzing() {
                    log::info!("Starting fuzzing");
                    for _ in 0..$crate::cpu::get_iterations() {
                        let _ = $fuzzer_expr;
                    }
                }
            }

            Ok(())
        }
    };
}
