# Do not check manually for equality of elements
Use one of this methods from mod.rs:
```
fn check_int_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
fn check_f32_array_equality(a: &[f32], b: &[f32]) -> Result<(), String> { 
pub fn check_int_equality(a: i32, b: i32) -> Result<(), String> { 
pub fn check_int_equality_with_error(a: i32, b: i32, error: i32) -> Result<(), String> {
```

Bad
```
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        assert_eq!(result[0], 0); // 20 > 30? no
        assert_eq!(result[1], -1); // 10 > 5? yes
    }
```
Good
```
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, -1];
        check_int_array_equality(&result, &expected)?;
    }
```

# Do not ignore result, if this is not fuzzer check
Bad
```
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let _result = std::mem::transmute::<__m128i, [i64; 2]>(result);
    }
```
Good
```
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, -1];
        check_int_array_equality(&result, &expected)?;
    }
```
# Include fuzzer for each extension test
Bad
```
fn test_mm_cmpgt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, -1];
        check_int_array_equality(&result, &expected)?;
    }

    Ok(())
}
```
Good 
```
fn test_mm_cmpgt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, -1];
        check_int_array_equality(&result, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let b = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_cmpgt_epi64(a, b);
            }
        }
    }

    Ok(())
}
```