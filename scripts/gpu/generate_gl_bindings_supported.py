#!/usr/bin/env python3
"""
Skrypt do ekstrakcji funkcji OpenGL z wygenerowanego pliku gl_bindings.rs
i zapisania ich do CSV w formacie podobnym do gl_functions.csv
"""

import re
import argparse
from pathlib import Path


def find_bindings_file(search_path: Path) -> Path:
    """
    Znajduje plik gl_bindings.rs w podanej ścieżce lub jej podkatalogach.
    Najpierw szuka w target/debug/build/gl-*/out/bindings.rs
    """
    # Jeśli podano bezpośrednio plik
    if search_path.is_file() and search_path.name in ['bindings.rs', 'gl_bindings.rs']:
        return search_path

    # Szukaj w standardowej lokalizacji dla projektu Rust
    if search_path.is_dir():
        # Szukaj wszystkich bindings.rs w target/debug/build/gl-*/out/
        pattern = 'target/debug/build/gl-*/out/bindings.rs'
        matches = list(search_path.glob(pattern))
        if matches:
            # Jeśli jest więcej niż jeden, wybierz najnowszy
            newest = max(matches, key=lambda p: p.stat().st_mtime)
            return newest

        # Fallback - szukaj rekurencyjnie
        for candidate in search_path.rglob('bindings.rs'):
            if 'gl' in str(candidate):
                return candidate

    raise FileNotFoundError(f"Nie znaleziono pliku bindings.rs w {search_path}")


def parse_rust_type(rust_type: str) -> str:
    """
    Konwertuje typ Rust (types::GLuint) na prosty typ GL (GLuint).
    """
    # Usuń types:: prefix
    rust_type = rust_type.replace('types::', '')
    # Konwertuj __gl_imports::raw::c_void na GLvoid
    rust_type = rust_type.replace('__gl_imports::raw::c_void', 'GLvoid')
    # Usuń inne pozostałości z __gl_imports
    rust_type = re.sub(r'__gl_imports::raw::c_\w+', lambda m: 'GL' + m.group(0).split('c_')[-1], rust_type)
    return rust_type.strip()


def parse_function_signature(line: str) -> dict | None:
    """
    Parsuje linię z definicją funkcji i zwraca słownik z informacjami.

    Format wejściowy:
    pub unsafe fn ActiveShaderProgram(pipeline: types::GLuint, program: types::GLuint) -> ()

    Format wyjściowy:
    {
        'name': 'glActiveShaderProgram',
        'params': [('pipeline', 'GLuint', False), ('program', 'GLuint', False)],
        'return_type': 'void'
    }
    gdzie trzeci element tuple to True jeśli parametr jest wskaźnikiem
    """
    # Regex do wyłapania funkcji
    # pub unsafe fn NazwaFunkcji(parametry) -> TypZwracany
    pattern = r'pub\s+unsafe\s+fn\s+(\w+)\s*\((.*?)\)\s*->\s*([^{]+)'

    match = re.search(pattern, line)
    if not match:
        return None

    func_name = match.group(1)
    params_str = match.group(2).strip()
    return_type = match.group(3).strip()

    # Dodaj prefix 'gl' jeśli nie ma
    if not func_name.startswith('gl'):
        func_name = 'gl' + func_name

    # Parsuj parametry
    params = []
    if params_str:
        # Split po przecinkach, ale nie wewnątrz < >
        param_parts = []
        current = []
        depth = 0

        for char in params_str + ',':
            if char == '<':
                depth += 1
            elif char == '>':
                depth -= 1
            elif char == ',' and depth == 0:
                if current:
                    param_parts.append(''.join(current).strip())
                    current = []
                continue
            current.append(char)

        for param in param_parts:
            if ':' in param:
                # Format: name: type lub name: *const type lub name: *mut type
                name, typ = param.split(':', 1)
                name = name.strip()
                typ = typ.strip()

                # Sprawdź czy jest wskaźnik
                is_const_ptr = '*const' in typ
                is_mut_ptr = '*mut' in typ
                is_pointer = is_const_ptr or is_mut_ptr

                # Usuń *const i *mut
                typ = typ.replace('*const', '').replace('*mut', '').strip()
                # Usuń types:: prefix
                typ = parse_rust_type(typ)

                # Zapisz informację o const/mut
                const_qualifier = 'const' if is_const_ptr else ''

                params.append((name, typ, is_pointer, const_qualifier))

    # Parsuj typ zwracany
    return_type = parse_rust_type(return_type)
    # () w Rust to void
    if return_type == '()' or return_type == '':
        return_type = 'void'

    return {
        'name': func_name,
        'params': params,
        'return_type': return_type
    }


def format_signature(func_info: dict) -> str:
    """
    Formatuje sygnaturę funkcji w stylu gl_functions.csv

    Format: glFunctionName(param1: Type1; *param2: const Type2) -> ReturnType
    """
    name = func_info['name']
    params = func_info['params']
    return_type = func_info['return_type']

    # Formatuj parametry
    if params:
        formatted_params = []
        for param in params:
            param_name = param[0]
            param_type = param[1]
            is_pointer = param[2]
            const_qualifier = param[3]

            if is_pointer:
                # Format: *name: const Type lub *name: Type
                if const_qualifier:
                    formatted_params.append(f"*{param_name}: {const_qualifier} {param_type}")
                else:
                    formatted_params.append(f"*{param_name}: {param_type}")
            else:
                # Format: name: Type
                formatted_params.append(f"{param_name}: {param_type}")

        params_str = '; '.join(formatted_params)
    else:
        params_str = ''

    return f"{name}({params_str}) -> {return_type}"


def extract_functions(bindings_file: Path) -> list[str]:
    """
    Ekstraktuje wszystkie funkcje z pliku bindings.rs i zwraca listę sygnatur.
    """
    signatures = []

    with open(bindings_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()

            # Szukaj linii z pub unsafe fn
            if 'pub unsafe fn' in line:
                func_info = parse_function_signature(line)
                if func_info:
                    signature = format_signature(func_info)
                    signatures.append(signature)

    return sorted(signatures)


def write_csv(signatures: list[str], output_file: Path):
    """
    Zapisuje sygnatury do pliku CSV.
    """
    with open(output_file, 'w', encoding='utf-8') as f:
        # Nagłówek
        f.write('signature,core_version,extensions\n')

        # Funkcje
        for sig in signatures:
            # Puste wartości dla core_version i extensions
            # (bindings.rs nie zawiera tych informacji)
            f.write(f'{sig},,\n')


def main():
    parser = argparse.ArgumentParser(
        description='Ekstraktuje funkcje OpenGL z gl_bindings.rs do CSV'
    )
    parser.add_argument(
        'path',
        nargs='?',
        default='.',
        help='Ścieżka do katalogu projektu lub pliku bindings.rs (domyślnie: bieżący katalog)'
    )
    parser.add_argument(
        '-o', '--output',
        default='gl_glutin_supported_functions.csv',
        help='Plik wyjściowy CSV (domyślnie: gl_glutin_supported_functions.csv)'
    )

    args = parser.parse_args()

    # Znajdź plik bindings.rs
    search_path = Path(args.path).resolve()
    print(f"Szukam pliku bindings.rs w: {search_path}")

    try:
        bindings_file = find_bindings_file(search_path)
        print(f"Znaleziono: {bindings_file}")
    except FileNotFoundError as e:
        print(f"Błąd: {e}")
        return 1

    # Ekstraktuj funkcje
    print("Ekstrakcja funkcji...")
    signatures = extract_functions(bindings_file)
    print(f"Znaleziono {len(signatures)} funkcji")

    # Zapisz do CSV
    output_path = Path(args.output)
    print(f"Zapisywanie do: {output_path}")
    write_csv(signatures, output_path)

    print("Gotowe!")
    return 0


if __name__ == '__main__':
    exit(main())
