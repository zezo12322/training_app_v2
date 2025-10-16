#!/usr/bin/env python3
"""
Compare app_ar.arb and app_en.arb to find missing keys.
"""
import json
from pathlib import Path
from collections import OrderedDict

def load_arb(filepath):
    """Load ARB file and return keys (excluding metadata)."""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f, object_pairs_hook=OrderedDict)
        
        # Filter out @ metadata keys
        keys = {k: v for k, v in data.items() if not k.startswith('@')}
        metadata = {k: v for k, v in data.items() if k.startswith('@')}
        
        return keys, metadata
    except FileNotFoundError:
        print(f"❌ File not found: {filepath}")
        return {}, {}
    except json.JSONDecodeError as e:
        print(f"❌ JSON decode error in {filepath}: {e}")
        return {}, {}

def check_for_duplicates(keys, filename):
    """Check for duplicate values in ARB file."""
    value_to_keys = {}
    duplicates = []
    
    for key, value in keys.items():
        if value in value_to_keys:
            value_to_keys[value].append(key)
        else:
            value_to_keys[value] = [key]
    
    for value, key_list in value_to_keys.items():
        if len(key_list) > 1:
            duplicates.append((value, key_list))
    
    return duplicates

def suggest_missing_keys(ar_keys, en_keys):
    """Suggest which keys might be missing based on common patterns."""
    suggestions = []
    
    # Common key patterns that should exist in pairs
    patterns = [
        ('Title', 'Description'),
        ('Error', 'Success'),
        ('Label', 'Hint'),
        ('Button', 'Action'),
    ]
    
    all_keys = set(ar_keys.keys()) | set(en_keys.keys())
    
    for key in all_keys:
        for pattern1, pattern2 in patterns:
            if pattern1.lower() in key.lower():
                expected_key = key.replace(pattern1, pattern2).replace(pattern1.lower(), pattern2.lower())
                if expected_key not in all_keys:
                    suggestions.append((key, expected_key, f"Expected paired key"))
    
    return suggestions

def main():
    ar_file = Path('lib/l10n/app_ar.arb')
    en_file = Path('lib/l10n/app_en.arb')
    
    if not ar_file.exists() or not en_file.exists():
        print("❌ ARB files not found. Run this script from project root.")
        return
    
    print("🔍 Comparing ARB files...\n")
    print("=" * 80)
    
    ar_keys, ar_metadata = load_arb(ar_file)
    en_keys, en_metadata = load_arb(en_file)
    
    ar_set = set(ar_keys.keys())
    en_set = set(en_keys.keys())
    
    missing_in_en = ar_set - en_set
    missing_in_ar = en_set - ar_set
    
    # Print missing keys
    if missing_in_en:
        print(f"\n❌ MISSING IN ENGLISH ({len(missing_in_en)} keys)")
        print("-" * 80)
        for key in sorted(missing_in_en):
            print(f"  {key:40s} | AR: {ar_keys[key][:50]}")
    
    if missing_in_ar:
        print(f"\n❌ MISSING IN ARABIC ({len(missing_in_ar)} keys)")
        print("-" * 80)
        for key in sorted(missing_in_ar):
            print(f"  {key:40s} | EN: {en_keys[key][:50]}")
    
    if not missing_in_en and not missing_in_ar:
        print("\n✅ All keys are present in both files!")
    
    # Check for duplicates
    print(f"\n🔍 CHECKING FOR DUPLICATES")
    print("-" * 80)
    
    ar_duplicates = check_for_duplicates(ar_keys, 'app_ar.arb')
    en_duplicates = check_for_duplicates(en_keys, 'app_en.arb')
    
    if ar_duplicates:
        print(f"\n⚠️  Arabic duplicates ({len(ar_duplicates)}):")
        for value, keys in ar_duplicates:
            print(f"  Value: {value[:50]}")
            print(f"  Keys:  {', '.join(keys)}")
            print()
    
    if en_duplicates:
        print(f"\n⚠️  English duplicates ({len(en_duplicates)}):")
        for value, keys in en_duplicates:
            print(f"  Value: {value[:50]}")
            print(f"  Keys:  {', '.join(keys)}")
            print()
    
    if not ar_duplicates and not en_duplicates:
        print("✅ No duplicate values found")
    
    # Check for missing metadata
    print(f"\n🔍 METADATA CHECK")
    print("-" * 80)
    
    keys_without_metadata = []
    for key in ar_keys.keys():
        metadata_key = f"@{key}"
        if metadata_key not in ar_metadata:
            keys_without_metadata.append(key)
    
    if keys_without_metadata:
        print(f"⚠️  Keys without @metadata ({len(keys_without_metadata)}):")
        for key in keys_without_metadata[:10]:  # Show first 10
            print(f"  - {key}")
        if len(keys_without_metadata) > 10:
            print(f"  ... and {len(keys_without_metadata) - 10} more")
    else:
        print("✅ All keys have metadata")
    
    # Suggest potentially missing keys
    suggestions = suggest_missing_keys(ar_keys, en_keys)
    if suggestions:
        print(f"\n💡 SUGGESTIONS")
        print("-" * 80)
        print("You might want to add these paired keys:")
        for existing, suggested, reason in suggestions[:5]:  # Show first 5
            print(f"  {existing} → {suggested}")
            print(f"    Reason: {reason}")
        if len(suggestions) > 5:
            print(f"  ... and {len(suggestions) - 5} more suggestions")
    
    # Statistics
    print(f"\n📊 STATISTICS")
    print("-" * 80)
    print(f"Arabic strings:     {len(ar_keys)}")
    print(f"English strings:    {len(en_keys)}")
    print(f"Common keys:        {len(ar_set & en_set)}")
    print(f"Total unique keys:  {len(ar_set | en_set)}")
    print("-" * 80)
    
    # Overall status
    print(f"\n📋 STATUS")
    print("-" * 80)
    if not missing_in_en and not missing_in_ar and not ar_duplicates and not en_duplicates:
        print("✅ ARB files are in sync and ready to use!")
    else:
        issues = []
        if missing_in_en or missing_in_ar:
            issues.append(f"{len(missing_in_en) + len(missing_in_ar)} missing keys")
        if ar_duplicates or en_duplicates:
            issues.append(f"{len(ar_duplicates) + len(en_duplicates)} duplicate values")
        
        print(f"⚠️  Issues found: {', '.join(issues)}")
        print("   Fix these issues before proceeding with migration.")
    
    print("\n" + "=" * 80)

if __name__ == '__main__':
    main()
