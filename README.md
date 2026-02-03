# WorkTester - CPU Feature Testing Tool

WorkTester to narzędzie do testowania instrukcji SIMD procesora x86/x86_64. Program automatycznie wykrywa dostępne rozszerzenia procesora i uruchamia dla nich testy, weryfikując poprawność działania różnych instrukcji.

## Architektura

Projekt wykorzystuje trait `ExtensionTest`, który zapewnia wspólny interfejs dla wszystkich modułów testujących:
- `get_name()` - zwraca nazwę rozszerzenia
- `get_tests()` - zwraca listę funkcji testujących
- `test()` - uruchamia wszystkie testy dla danego rozszerzenia

## Zaimplementowane Rozszerzenia

### ✅ SSE (Streaming SIMD Extensions)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/sse1.rs`

Testowane instrukcje (26 testów):
- Ustawianie wartości: `_mm_set_ps`, `_mm_set1_ps`, `_mm_setzero_ps`
- Operacje arytmetyczne: `_mm_add_ps`, `_mm_sub_ps`, `_mm_div_ps`
- Ładowanie/zapisywanie: `_mm_load_ps`, `_mm_loadu_ps`, `_mm_store_ps`
- Funkcje matematyczne: `_mm_sqrt_ps`, `_mm_rsqrt_ps`
- Operacje logiczne: `_mm_and_ps`, `_mm_andnot_ps`, `_mm_or_ps`, `_mm_xor_ps`
- Min/Max: `_mm_min_ps`, `_mm_max_ps`
- Porównania: `_mm_cmpeq_ps`, `_mm_cmpgt_ps`, `_mm_cmplt_ps`, `_mm_cmpge_ps`, `_mm_cmple_ps`
- Konwersje: `_mm_cvtss_f32`, `_mm_cvtss_si32`, `_mm_cvtsi32_ss`
- Inne: `_mm_movemask_ps`

### ✅ SSE2 (Streaming SIMD Extensions 2)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/sse2.rs`

Testowane instrukcje (21 testów):
- Operacje double precision: `_mm_set_pd`, `_mm_set1_pd`, `_mm_setzero_pd`, `_mm_add_pd`, `_mm_sub_pd`, `_mm_mul_pd`
- Ładowanie/zapisywanie double: `_mm_load_pd`, `_mm_loadu_pd`, `_mm_store_pd`
- Konwersje double: `_mm_cvtsd_f64`
- Operacje całkowite 128-bit: `_mm_set_epi32`, `_mm_set1_epi32`, `_mm_setzero_si128`
- Arytmetyka całkowita: `_mm_add_epi32`, `_mm_sub_epi32`
- Logika całkowita: `_mm_and_si128`, `_mm_or_si128`, `_mm_xor_si128`
- Porównania całkowite: `_mm_cmpeq_epi32`
- Konwersje całkowite: `_mm_cvtsi32_si128`, `_mm_cvtsi128_si32`

### ✅ SSE3 (Streaming SIMD Extensions 3)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/sse3.rs`

Testowane instrukcje (8 testów):
- Horizontal operations (float): `_mm_hadd_ps`, `_mm_hsub_ps`, `_mm_addsub_ps`
- Move duplicate: `_mm_movehdup_ps`, `_mm_moveldup_ps`
- Horizontal operations (double): `_mm_hadd_pd`, `_mm_hsub_pd`, `_mm_addsub_pd`

### ✅ AVX (Advanced Vector Extensions)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/avx.rs`

Testowane instrukcje (20 testów):
- Ustawianie wartości 256-bit: `_mm256_set_ps`, `_mm256_set1_ps`, `_mm256_setzero_ps`
- Operacje arytmetyczne 256-bit: `_mm256_add_ps`, `_mm256_sub_ps`, `_mm256_mul_ps`, `_mm256_div_ps`
- Ładowanie/zapisywanie 256-bit: `_mm256_load_ps`, `_mm256_loadu_ps`, `_mm256_store_ps`
- Min/Max 256-bit: `_mm256_max_ps`, `_mm256_min_ps`
- Funkcje matematyczne: `_mm256_sqrt_ps`
- Operacje logiczne: `_mm256_and_ps`, `_mm256_or_ps`, `_mm256_xor_ps`
- Double precision 256-bit: `_mm256_set_pd`, `_mm256_add_pd`, `_mm256_sub_pd`, `_mm256_mul_pd`

## Rozszerzenia Do Zaimplementowania

### ✅ SSSE3 (Supplemental Streaming SIMD Extensions 3)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/ssse3.rs`

Testowane instrukcje (13 testów):
- `_mm_shuffle_epi8` - shuffle bajtów
- `_mm_abs_epi8/16/32` - wartość bezwzględna
- `_mm_sign_epi8/16/32` - znak liczby
- `_mm_hadd_epi16/32`, `_mm_hsub_epi16/32` - horizontal add/sub dla integerów
- `_mm_maddubs_epi16` - multiply and add
- `_mm_alignr_epi8` - concatenate and shift

### ✅ SSE4.1 (Streaming SIMD Extensions 4.1)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/sse4_1.rs`

Testowane instrukcje (16 testów):
- `_mm_blend_ps/pd` - blending
- `_mm_blendv_ps/pd/epi8` - variable blending
- `_mm_dp_ps/pd` - dot product
- `_mm_max_epi8/32`, `_mm_min_epi8/32` - min/max dla integerów
- `_mm_mul_epi32` - mnożenie 32-bit
- `_mm_mullo_epi32` - multiply low
- `_mm_round_ps/pd` - zaokrąglanie
- `_mm_ceil_ps`, `_mm_floor_ps` - zaokrąglanie w górę/w dół
- `_mm_extract_ps`, `_mm_insert_ps` - extract/insert pojedynczych wartości
- `_mm_testz_si128`, `_mm_testc_si128` - test bits

### ⏳ SSE4.2 (Streaming SIMD Extensions 4.2)
**Status: NIE ZAIMPLEMENTOWANE**

Potencjalne instrukcje do przetestowania:
- `_mm_cmpgt_epi64` - porównanie 64-bit
- `_mm_crc32_u8/16/32/64` - CRC32
- `_mm_cmpistrm`, `_mm_cmpistri` - string compare
- `_mm_cmpestrm`, `_mm_cmpestri` - explicit length string compare

### ⏳ AVX2 (Advanced Vector Extensions 2)
**Status: NIE ZAIMPLEMENTOWANE**

Potencjalne instrukcje do przetestowania:
- `_mm256_add_epi8/16/32/64` - dodawanie 256-bit integer
- `_mm256_sub_epi8/16/32/64` - odejmowanie 256-bit integer
- `_mm256_mul_epi32`, `_mm256_mullo_epi16/32` - mnożenie integer
- `_mm256_sll_epi16/32/64`, `_mm256_srl_epi16/32/64` - shift left/right
- `_mm256_and_si256`, `_mm256_or_si256`, `_mm256_xor_si256` - logika 256-bit
- `_mm256_permute2x128_si256` - permutacja 128-bit lanes
- `_mm256_shuffle_epi8/32` - shuffle
- `_mm256_broadcast` - broadcast wartości
- `_mm256_gather` - gather loads

### ✅ FMA (Fused Multiply-Add)
**Status: ZAIMPLEMENTOWANE**

Plik: `src/cpu/fma.rs`

Testowane instrukcje (10 testów):
- `_mm_fmadd_ps`, `_mm256_fmadd_ps` - a*b+c
- `_mm_fmsub_ps`, `_mm256_fmsub_ps` - a*b-c
- `_mm_fnmadd_ps`, `_mm256_fnmadd_ps` - -(a*b)+c
- `_mm_fnmsub_ps`, `_mm256_fnmsub_ps` - -(a*b)-c
- `_mm_fmaddsub_ps`, `_mm256_fmaddsub_ps` - alternating add/sub

### ⏳ AVX-512 (różne warianty)
**Status: NIE ZAIMPLEMENTOWANE**

Wymaga procesorów z obsługą AVX-512. Potencjalne warianty:
- **AVX-512F** (Foundation) - podstawowe operacje 512-bit
- **AVX-512CD** (Conflict Detection)
- **AVX-512ER** (Exponential and Reciprocal)
- **AVX-512PF** (Prefetch)
- **AVX-512BW** (Byte and Word)
- **AVX-512DQ** (Doubleword and Quadword)
- **AVX-512VL** (Vector Length Extensions)
- **AVX-512IFMA** (Integer Fused Multiply-Add)
- **AVX-512VBMI** (Vector Bit Manipulation Instructions)

### ⏳ Inne Rozszerzenia

- **AES-NI** - instrukcje AES
- **PCLMULQDQ** - carry-less multiplication
- **RDRAND** - hardware random number generator
- **RDSEED** - random seed generator
- **SHA** - SHA hashing instructions
- **BMI1/BMI2** - Bit Manipulation Instructions
- **POPCNT** - population count
- **LZCNT** - leading zero count
- **F16C** - half-precision float conversion

## Metodologia Testowania

Każdy test składa się z dwóch części:

1. **Testy deterministyczne** - sprawdzają poprawność na znaných wartościach wejściowych
2. **Fuzzing** - wykonuje operacje na losowych wartościach (100 iteracji), testując stabilność

Testy obsługują wartości specjalne:
- `f32::INFINITY` / `f32::NEG_INFINITY`
- `f32::NAN`
- Wartości ekstremalne (`f32::MAX`, `f32::MIN`)

## Kompilacja i Uruchomienie

```bash
# Kompilacja
cargo build --release

# Uruchomienie
cargo run --release

# Testy jednostkowe
cargo test
```

## Wymagania

- Rust 1.70+
- Architektura x86 lub x86_64
- System operacyjny: Linux, Windows, macOS

## Zależności

```toml
[dependencies]
log = "*"
handsome_logger = "*"
once_cell = "*"
rand = "*"
```

## Statystyki Implementacji

| Rozszerzenie | Status | Liczba testów | Plik |
|-------------|--------|---------------|------|
| SSE | ✅ Gotowe | 26 | `src/cpu/sse1.rs` |
| SSE2 | ✅ Gotowe | 21 | `src/cpu/sse2.rs` |
| SSE3 | ✅ Gotowe | 8 | `src/cpu/sse3.rs` |
| SSSE3 | ✅ Gotowe | 13 | `src/cpu/ssse3.rs` |
| SSE4.1 | ✅ Gotowe | 16 | `src/cpu/sse4_1.rs` |
| SSE4.2 | ✅ Gotowe | 4 | `src/cpu/sse4_2.rs` |
| AVX | ✅ Gotowe | 20 | `src/cpu/avx.rs` |
| AVX2 | ✅ Gotowe | 16 | `src/cpu/avx2.rs` |
| FMA | ✅ Gotowe | 10 | `src/cpu/fma.rs` |
| AVX-512 | ⏳ Do zrobienia | 0 | - |
| **RAZEM** | **9/10** | **134** | |

## Struktura Projektu

```
WorkTester/
├── src/
│   ├── main.rs           # Główny plik, funkcje pomocnicze
│   └── cpu/
│       ├── mod.rs        # Trait ExtensionTest, test_all_extensions()
│       ├── sse1.rs       # ✅ Testy SSE
│       ├── sse2.rs       # ✅ Testy SSE2
│       ├── sse3.rs       # ✅ Testy SSE3
│       ├── avx.rs        # ✅ Testy AVX
│       └── sse4_1.rs     # ⏳ Pusty plik
├── Cargo.toml
└── README.md
```

## Autor

Projekt testowy do weryfikacji instrukcji SIMD procesorów x86/x86_64.

## Licencja

Do ustalenia.
