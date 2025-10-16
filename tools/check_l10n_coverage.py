#!/usr/bin/env python3
"""
Check l10n coverage across Dart files.
Finds hard-coded strings and suggests l10n keys.
"""
import re
import os
from pathlib import Path

def find_hardcoded_strings(dart_file):
    """Scan Dart file for hard-coded Arabic/English strings."""
    try:
        with open(dart_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"❌ Error reading {dart_file}: {e}")
        return []
    
    hardcoded = []
    
    # Pattern 1: Text('...') or Text("...")
    pattern1 = r"Text\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
    matches1 = re.finditer(pattern1, content)
    for match in matches1:
        string = match.group(1)
        # Skip if it's using l10n (l. or context.l)
        if not string.startswith('l.') and not string.startswith('context.l'):
            # Skip variable names
            if not re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', string):
                hardcoded.append((match.start(), string, 'Text widget'))
    
    # Pattern 2: const Text('...') or const Text("...")
    pattern2 = r"const\s+Text\s*\(\s*['\"]([^'\"]+)['\"]\s*\)"
    matches2 = re.finditer(pattern2, content)
    for match in matches2:
        string = match.group(1)
        if not string.startswith('l.') and not string.startswith('context.l'):
            if not re.match(r'^[a-zA-Z_][a-zA-Z0-9_]*$', string):
                hardcoded.append((match.start(), string, 'const Text widget'))
    
    # Pattern 3: errorMessage = '...'
    pattern3 = r"errorMessage\s*=\s*['\"]([^'\"]+)['\"]"
    matches3 = re.finditer(pattern3, content)
    for match in matches3:
        string = match.group(1)
        if not string.startswith('l.'):
            hardcoded.append((match.start(), string, 'Error message'))
    
    # Pattern 4: labelText: '...'
    pattern4 = r"labelText:\s*['\"]([^'\"]+)['\"]"
    matches4 = re.finditer(pattern4, content)
    for match in matches4:
        string = match.group(1)
        if not string.startswith('l.'):
            hardcoded.append((match.start(), string, 'Label text'))
    
    # Pattern 5: hintText: '...'
    pattern5 = r"hintText:\s*['\"]([^'\"]+)['\"]"
    matches5 = re.finditer(pattern5, content)
    for match in matches5:
        string = match.group(1)
        if not string.startswith('l.'):
            hardcoded.append((match.start(), string, 'Hint text'))
    
    # Remove duplicates
    seen = set()
    unique = []
    for pos, string, context in hardcoded:
        if string not in seen:
            seen.add(string)
            unique.append((pos, string, context))
    
    return unique

def get_line_number(filepath, position):
    """Get line number from character position."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        return content[:position].count('\n') + 1
    except:
        return -1

def is_arabic(text):
    """Check if text contains Arabic characters."""
    arabic_pattern = re.compile(r'[\u0600-\u06FF]')
    return bool(arabic_pattern.search(text))

def main():
    lib_path = Path('lib')
    
    if not lib_path.exists():
        print("❌ 'lib' directory not found. Run this script from project root.")
        return
    
    print("🔍 Scanning for hard-coded strings...\n")
    print("=" * 80)
    
    total_hardcoded = 0
    files_with_issues = 0
    arabic_strings = 0
    english_strings = 0
    
    results = []
    
    for dart_file in lib_path.rglob('*.dart'):
        # Skip generated files
        if '.g.dart' in str(dart_file) or '.freezed.dart' in str(dart_file):
            continue
        
        # Skip l10n generated files
        if 'l10n/gen' in str(dart_file):
            continue
        
        hardcoded = find_hardcoded_strings(dart_file)
        if hardcoded:
            files_with_issues += 1
            try:
                relative_path = dart_file.relative_to(Path.cwd())
            except ValueError:
                relative_path = dart_file
            results.append((relative_path, hardcoded))
            
            for pos, string, context in hardcoded:
                total_hardcoded += 1
                if is_arabic(string):
                    arabic_strings += 1
                else:
                    english_strings += 1
    
    # Sort by priority (screens first, then widgets)
    results.sort(key=lambda x: (
        0 if 'screens' in str(x[0]) else 1,
        str(x[0])
    ))
    
    # Print results
    for filepath, hardcoded in results:
        print(f"\n📄 {filepath}")
        print("-" * 80)
        
        for pos, string, context in hardcoded:
            line_num = get_line_number(filepath, pos)
            lang_flag = "🇸🇦 AR" if is_arabic(string) else "🇺🇸 EN"
            
            # Truncate long strings
            display_string = string if len(string) <= 50 else string[:47] + "..."
            
            print(f"  Line {line_num:4d} | {lang_flag} | {context:20s} | {display_string}")
    
    # Summary
    print("\n" + "=" * 80)
    print("\n📊 SUMMARY")
    print("-" * 80)
    print(f"Files with hard-coded strings: {files_with_issues}")
    print(f"Total hard-coded strings:      {total_hardcoded}")
    print(f"  🇸🇦 Arabic strings:           {arabic_strings}")
    print(f"  🇺🇸 English strings:          {english_strings}")
    print("-" * 80)
    
    if total_hardcoded > 0:
        print(f"\n⚠️  Found {total_hardcoded} hard-coded strings that need localization!")
        print("   Next steps:")
        print("   1. Add missing keys to app_ar.arb and app_en.arb")
        print("   2. Run: flutter gen-l10n")
        print("   3. Replace hard-coded strings with l.keyName")
    else:
        print("\n✅ No hard-coded strings found! Great job!")
    
    print("\n" + "=" * 80)

if __name__ == '__main__':
    main()
