# hodow_gui

Graficzny interfejs użytkownika (GUI) dla testera instrukcji SIMD/OpenGL, zbudowany w Slint.

## Funkcje

- 🖥️ **Wybór trybu testowania**: CPU (SIMD) lub GPU (OpenGL)
- ⚙️ **Pełna konfiguracja opcji**:
  - CPU: iterations, wybór konkretnych testów, pomijanie testów
  - GPU: headless mode, time limit, frame limit, display API, GL API
- 📊 **Real-time progress tracking**:
  - Overall progress (wszystkie feature'y)
  - Feature progress (testy w obecnym feature)
  - Current test name z informacją o fuzzing iterations
- ⏹️ **Kontrola wykonania**: Start/Stop testy w dowolnym momencie
- 📈 **Szczegółowe wyniki**: Tabela ze statystykami dla każdego feature'a

## Uruchomienie

```bash
# Podstawowe uruchomienie
cargo run -p hodow_gui

# Build release (szybszy)
cargo build -p hodow_gui --release
./target/release/hodow_gui
```

## Użycie

### CPU Tests

1. Wybierz "CPU Tests" w sekcji Mode Selection
2. Ustaw opcje:
   - **Iterations**: Liczba iteracji na test (domyślnie 1000)
   - **Test functions**: Opcjonalnie podaj nazwy konkretnych funkcji do testowania (oddzielone przecinkami)
   - **Skip tests**: Opcjonalnie podaj nazwy testów do pominięcia (oddzielone przecinkami)
   - **List available modes**: Zaznacz aby wyświetlić dostępne tryby CPU
   - **List all functions**: Zaznacz aby wyświetlić wszystkie dostępne funkcje testowe
3. Kliknij "Start Tests"
4. Obserwuj progress w czasie rzeczywistym
5. Po zakończeniu sprawdź wyniki w sekcji "Results"

### GPU Tests

1. Wybierz "GPU Tests" w sekcji Mode Selection
2. Ustaw opcje:
   - **Headless mode**: Uruchom bez widocznego okna
   - **Time limit (ms)**: Limit czasu na test (domyślnie 1000ms)
   - **Frame limit**: Maksymalna liczba klatek na test
   - **Display API**: Wybierz backend (egl, glx, egl-then-glx, glx-then-egl)
   - **GL API**: Wersja OpenGL (np. "auto", "opengl:4.6", "gles:3.0")
   - **Force software rendering**: Wymuś renderowanie programowe
3. Kliknij "Start Tests"
4. Obserwuj status
5. Po zakończeniu sprawdź wyniki

### Zatrzymanie testów

W dowolnym momencie podczas wykonywania testów możesz kliknąć "Stop Tests" aby gracefully przerwać testy. Otrzymasz partial wyniki dla testów które zdążyły się wykonać.

## Architektura

- **UI**: Zbudowany w Slint (deklaratywny UI framework)
- **Threading**: Testy wykonywane w background threads (nie blokują UI)
- **Progress updates**: Przez channel z callbackiem
- **Core logic**: Używa `hodow_core` API (ten sam co CLI)

## Pliki

- `src/main.rs` - Entry point, setup UI i callbacks
- `src/app_logic.rs` - Logika aplikacji (uruchamianie testów, progress updates)
- `ui/appwindow.slint` - Definicja UI w języku Slint
- `build.rs` - Kompilacja plików .slint

## Różnice względem CLI

- GUI nie wymaga znajomości flag CLI - wszystko dostępne przez UI
- Real-time progress zamiast progress bars w terminalu
- Wizualna tabela wyników zamiast log output
- Możliwość łatwego przełączania między CPU i GPU mode
- Bardziej user-friendly dla osób nieobeznanych z CLI

## Features

- `default = ["gpu"]` - Domyślnie włączona obsługa GPU
- `gpu` - Włącza testy OpenGL (forward do `hodow_core/gpu`)

## Dependencies

- `slint = "1.9"` - GUI framework
- `hodow_core` - Core testing logic
- `tokio` - Async runtime dla background tasks
- `log` + `handsome_logger` - Logging
