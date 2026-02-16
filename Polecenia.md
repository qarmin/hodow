Mając na uwadze plik Polecenia.md, popraw kod, zaimplemetuj brakujące funkcje etc. zgodnie z poniższymi wskazówkami:

- Celem jest zrobienie, by `just check` nie wyświetlał żadnych błędów ani warningów - nie przez ich ignorowanie, lecz zaimplementowanie odpowiedniego kodu, testów, fuzzingu etc. - bierz przyłkad np. z pliku `src/cpu/aes.rs` gdzie wszytsko ładnie i poprawnie jest zrobione

- Upewnij się, że każdy test ma uruchomienie fuzzera przez - get_fuzzing
- Przy sprawdzaniu wyników używaj bezpośrednio expected w funkcji zamiast w zmiennej, czyli zamiast `check_array_equality(&result, &expected)?` użyj np. `check_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?` - expected value muszą być zwykłymi liczbami - nie reużywaj żadnych zmiennych typu `check_array_equality(&result, &[a[1], a[2]])?`
- Posprawdzaj dokładnie, że nie ignorujesz rezultatu testów(nie dotyczy fuzzingu) np. `let _result = ...` - każda funkcja test_... musi mieć weryfikację wyniku przy użyciu funkcji z `common.rs`:, 
```
42:pub fn check_float_array_equality_with_error<T: FloatLike + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
65:pub fn check_array_equality<T: PartialEq + Debug>(a: &[T], b: &[T]) -> Result<(), String> {
77:pub fn check_float_equality(a: f32, b: f32, max_diff: f32) -> Result<(), String> {
89:pub fn check_int_equality<T: PartialEq + Debug>(a: T, b: T) -> Result<(), String> {
98:pub fn check_int_equality_with_error(a: i32, b: i32, error: i32) -> Result<(), String> {
```
- Usuń wszystkie komentarze jeśli istnieją
- Zamiast kilku małych bloków unsafe zrób jeden duży na całą funkcję(lecz by funkcja nie była unsafe) Czyli `fn test_mm_cmpgt_epi64() -> Result<(), String> { unsafe { ... } Ok(()) }` zamiast `fn test_mm_cmpgt_epi64() -> Result<(), String> { unsafe { ... } } if ... unsafe {} Ok(()) }`
- Staraj się mieć po max 15 funkcji na plik, jeśli jest ich więcej rozdziel je na kilka plików part1, part2 etc. tak jak to jest zrobione w innych modułach
- Pobieranie losowych danych powinno się odbywać przy pomocy tych funkcji z `common.rs`
```
106:pub fn get_random_float() -> f32 {
116:pub fn get_random_float64() -> f64 {
126:pub fn get_random_float32_array<const N: usize>() -> [f32; N] {
134:pub fn get_random_float64_array<const N: usize>() -> [f64; N] {
142:pub fn get_random_i32_array<const N: usize>() -> [i32; N] {
150:pub fn get_random_i64_array<const N: usize>() -> [i64; N] {
```