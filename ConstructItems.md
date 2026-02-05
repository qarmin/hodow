# To check for broken items use this commands

## Finds all places where result array elements are accessed directly, instead comparing entire array at once
```
rg "result\["
```
## Finds individual element comparisons, should be replaced with array equality check functions
```
rg "result !="
```
I will think that is fixed if above command returns no results.


# Do not check manually for equality of elements
Use one of this methods from mod.rs:
```
fn check_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
fn check_float_array_equality_with_error(a: &[f32], b: &[f32]) -> Result<(), String> { 
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
Also Bad
```
check_int_equality(result[0] as i32, 99)?; // Checking only one element
```
Good
```
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, -1];
        check_array_equality(&result, &expected)?; // It must check always entire array - without match etc - just one function with ?
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
Also bad(ignoring result after check)
```
if check_array_equality(&result, &a_bytes).is_ok() {
    return Err(format!("AES key gen assist produced same as input"));
}
```
Also bad(ignoring result after check) - Always check... result must be used, never anything else
```
match check_array_equality(&result, &a_bytes).is_ok() {
    Ok() => Ok(()),
    Err(_) => return Err(format!("AES key gen assist produced same as input")),
}
```
Also bad(checking multiple times instead of once)
```
    unsafe {
        let mut arr: [i64; 2] = [0; 2];
        let mask = _mm_set_epi64x(-1, 0);
        let a = _mm_set_epi64x(20, 10);
        _mm_maskstore_epi64(arr.as_mut_ptr(), mask, a);
        check_int_equality(arr[0], 0)?; // BAD needs to check entire array at once
        check_int_equality(arr[1], 20)?;
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
        check_array_equality(&result, &expected)?;
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
        check_array_equality(&result, &expected)?;
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
        check_array_equality(&result, &expected)?;
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
# Invalid target feature placement
It should be outside function - e.g. on entire file, not inside function or block
Bad
```
fn test_mm_aesimc_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES inverse mix columns produced same as input"));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}
```
Good 
```
// Cfg at file level or patching - so remove everything from this functions and 
fn test_mm_aesimc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_array_equality(&result, &a_bytes)?;
        Ok(())
    }
}
// And add to e.g.
#[cfg(any(target_arch = "x86", target_arch = "x86_64"))]
mod aes;

another cfg which checks for aes feature enabled - to avoid checking every single fucking function
```