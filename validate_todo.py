import re
import sys
from pathlib import Path
from dataclasses import dataclass
from typing import List, Dict, Set
from collections import defaultdict


@dataclass
class Instruction:
    name: str
    source_file: str
    line_number: int

    def __hash__(self):
        return hash(self.name)

    def __eq__(self, other):
        if isinstance(other, Instruction):
            return self.name == other.name
        return False


class TODOValidator:

    def __init__(self, project_root: Path):
        self.project_root = project_root
        self.todo_files = ['TODO.txt', 'TODO_AVX.txt']
        self.src_dir = project_root / 'src' / 'cpu'

        self.todo_instructions: Dict[str, List[Instruction]] = {}

        self.implemented_tests: Set[str] = set()

        self.stats = {
            'total_instructions': 0,
            'implemented': 0,
            'not_implemented': 0,
            'by_category': defaultdict(lambda: {'total': 0, 'implemented': 0})
        }

    def parse_todo_file(self, todo_path: Path) -> List[Instruction]:
        instructions = []
        current_source = None

        if not todo_path.exists():
            print(f"⚠️  Plik {todo_path.name} nie istnieje")
            return instructions

        with open(todo_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f, 1):
                line = line.strip()

                if line.startswith('src/rust/library/stdarch'):
                    current_source = line
                    continue

                match = re.match(r'^\d+:pub\s+(?:unsafe\s+)?fn\s+(_mm\w+)', line)
                if match:
                    func_name = match.group(1)
                    instructions.append(Instruction(
                        name=func_name,
                        source_file=current_source or 'unknown',
                        line_number=line_num
                    ))

        return instructions

    def scan_rust_tests(self) -> Set[str]:
        implemented = set()

        if not self.src_dir.exists():
            print(f"⚠️  Katalog źródłowy {self.src_dir} nie istnieje")
            return implemented

        for rs_file in self.src_dir.rglob('*.rs'):
            try:
                with open(rs_file, 'r', encoding='utf-8') as f:
                    content = f.read()
            except Exception:
                continue

            test_pattern = r'fn\s+(test_mm\w+)\s*\('
            for match in re.finditer(test_pattern, content):
                test_name = match.group(1)
                if test_name.startswith('test_mm'):
                    instr_name = '_' + test_name.replace('test_', '')
                    implemented.add(instr_name)

        return implemented

    def categorize_instruction(self, instr: Instruction) -> str:
        name = instr.name
        source = instr.source_file

        if 'avx512fp16' in source:
            return 'AVX-512 FP16'
        elif 'avx512bf16' in source:
            return 'AVX-512 BF16'
        elif 'avx512bitalg' in source:
            return 'AVX-512 BITALG'
        elif 'avx512cd' in source:
            return 'AVX-512 CD'
        elif 'avx512ifma' in source:
            return 'AVX-512 IFMA'
        elif 'avx512' in source:
            return 'AVX-512 F/DQ/BW/VL'
        elif 'avx2' in source:
            return 'AVX2'
        elif 'avx' in source:
            return 'AVX'
        elif 'fma' in source:
            return 'FMA'
        elif 'sse4' in source or 'sse4_' in name:
            if 'sse4.2' in source or 'sse42' in source:
                return 'SSE4.2'
            return 'SSE4.1'
        elif 'ssse3' in source:
            return 'SSSE3'
        elif 'sse3' in source:
            return 'SSE3'
        elif 'sse2' in source:
            return 'SSE2'
        elif 'sse' in source:
            return 'SSE'

        if name.startswith('_mm512_'):
            return 'AVX-512'
        elif name.startswith('_mm256_'):
            return 'AVX/AVX2'
        elif name.startswith('_mm_'):
            return 'SSE/SSE2/SSE3/SSE4'

        return 'Inne'

    def analyze(self):
        print("🔍 Analizuję pliki TODO...")

        for todo_file in self.todo_files:
            todo_path = self.project_root / todo_file
            instructions = self.parse_todo_file(todo_path)
            self.todo_instructions[todo_file] = instructions
            print(f"   Znaleziono {len(instructions)} instrukcji w {todo_file}")

        print("\n🔍 Skanuję pliki źródłowe...")
        self.implemented_tests = self.scan_rust_tests()
        print(f"   Znaleziono {len(self.implemented_tests)} zaimplementowanych testów")

        print("\n📊 Analizuję implementacje...")

        all_instructions = []
        for instructions in self.todo_instructions.values():
            all_instructions.extend(instructions)

        self.stats['total_instructions'] = len(all_instructions)

        for instr in all_instructions:
            category = self.categorize_instruction(instr)
            self.stats['by_category'][category]['total'] += 1

            if instr.name in self.implemented_tests:
                self.stats['implemented'] += 1
                self.stats['by_category'][category]['implemented'] += 1

        self.stats['not_implemented'] = (
            self.stats['total_instructions'] - self.stats['implemented']
        )

    def print_report(self):
        print("\n" + "="*80)
        print("📋 RAPORT WALIDACJI TODO")
        print("="*80)

        total = self.stats['total_instructions']
        implemented = self.stats['implemented']
        not_impl = self.stats['not_implemented']

        if total > 0:
            impl_percent = (implemented / total) * 100
        else:
            impl_percent = 0

        print(f"\n📈 PODSUMOWANIE OGÓLNE:")
        print(f"   Całkowita liczba instrukcji:  {total}")
        print(f"   ✅ Zaimplementowane:           {implemented} ({impl_percent:.1f}%)")
        print(f"   ❌ Niezaimplementowane:        {not_impl} ({100-impl_percent:.1f}%)")

        print(f"\n📊 STATYSTYKI WEDŁUG KATEGORII:")
        print(f"{'Kategoria':<30} {'Razem':>8} {'Impl.':>8} {'Procent':>10}")
        print("-" * 60)

        categories = sorted(self.stats['by_category'].items(),
                          key=lambda x: x[1]['total'], reverse=True)

        for category, stats in categories:
            total_cat = stats['total']
            impl_cat = stats['implemented']
            percent = (impl_cat / total_cat * 100) if total_cat > 0 else 0

            status = "✅" if percent == 100 else "🔶" if percent >= 50 else "❌"
            print(f"{status} {category:<27} {total_cat:>8} {impl_cat:>8} {percent:>9.1f}%")

        print(f"\n🔍 PRZYKŁADY NIEZAIMPLEMENTOWANYCH INSTRUKCJI:")

        not_implemented = []
        for instructions in self.todo_instructions.values():
            for instr in instructions:
                if instr.name not in self.implemented_tests:
                    not_implemented.append(instr)

        examples_by_cat = defaultdict(list)
        for instr in not_implemented[:100]:
            cat = self.categorize_instruction(instr)
            if len(examples_by_cat[cat]) < 5:
                examples_by_cat[cat].append(instr)

        for category in sorted(examples_by_cat.keys()):
            print(f"\n   {category}:")
            for instr in examples_by_cat[category]:
                source_short = instr.source_file.split('/')[-1] if instr.source_file else 'unknown'
                print(f"      • {instr.name:<40} ({source_short})")

        if len(not_implemented) > sum(len(v) for v in examples_by_cat.values()):
            remaining = len(not_implemented) - sum(len(v) for v in examples_by_cat.values())
            print(f"\n   ... i {remaining} więcej")

        print("\n" + "="*80)
        if impl_percent == 100:
            print("🎉 GRATULACJE! Wszystkie instrukcje zostały zaimplementowane!")
        elif impl_percent >= 80:
            print(f"👍 Bardzo dobrze! {impl_percent:.1f}% instrukcji zaimplementowane.")
        elif impl_percent >= 50:
            print(f"🔶 W połowie drogi - {impl_percent:.1f}% zaimplementowane.")
        elif impl_percent >= 20:
            print(f"⚠️  Sporo jeszcze do zrobienia - {impl_percent:.1f}% zaimplementowane.")
        else:
            print(f"🚀 Dopiero początek - {impl_percent:.1f}% zaimplementowane.")
        print("="*80 + "\n")

    def export_csv(self, output_path: Path):
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write("Kategoria,Instrukcja,Źródło,Zaimplementowana\n")

            for instructions in self.todo_instructions.values():
                for instr in instructions:
                    if instr.name in self.implemented_tests:
                        continue
                    category = self.categorize_instruction(instr)
                    implemented = "TAK" if instr.name in self.implemented_tests else "NIE"
                    source_short = instr.source_file.split('/')[-1] if instr.source_file else 'unknown'

                    f.write(f'"{category}","{instr.name}","{source_short}","{implemented}"\n')

        print(f"📄 Wyeksportowano szczegóły do: {output_path}")


def main():
    script_dir = Path(__file__).parent
    project_root = script_dir

    if script_dir.name == 'scripts':
        project_root = script_dir.parent

    print("🚀 Walidator TODO - WorkTester")
    print(f"📁 Katalog projektu: {project_root}\n")

    validator = TODOValidator(project_root)
    validator.analyze()
    validator.print_report()

    csv_path = project_root / 'todo_analysis.csv'
    validator.export_csv(csv_path)

    impl_percent = (validator.stats['implemented'] /
                   validator.stats['total_instructions'] * 100
                   if validator.stats['total_instructions'] > 0 else 0)

    if impl_percent == 100:
        return 0
    elif impl_percent >= 80:
        return 0
    else:
        return 1


if __name__ == '__main__':
    sys.exit(main())
