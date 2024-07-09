#!/bin/bash

# Directory to go through
dir_path=$1
target_dir='ui/uikit'

# Check if directory path is not empty
if [ -z "$dir_path" ]; then
    echo "Error: No source directory path provided."
    echo "Usage: $0 <directory path>"
    exit 1
fi

rm -rf $target_dir
mkdir -p $target_dir

mkdir -p "$target_dir/values"
cp "$dir_path/en/general/strings.xml" "$target_dir/values/strings.xml"

for locale_dir in "$dir_path"/*; do
    # Check if it is a directory
    echo locale $locale_dir
    if [ -d "$locale_dir" ]; then
        locale=$(basename "$locale_dir") # Get the locale name from the directory name
        
        if [ -f "$locale_dir/general/strings.xml" ]; then
            # Make value-<locale> directory if it does not exist
            mkdir -p "$target_dir/values-$locale"
            
            # Move file to new location
            cp "$locale_dir/general/strings.xml" "$target_dir/values-$locale/strings.xml"
        fi
    fi
done