#!/bin/bash

PENDRIVE_DIR="/home/lucas/tmp/matrizes"

generate_random_name() {
  cat /dev/urandom | tr -dc 'a-z' | fold -w 24 | head -n 1
}

rename_file() {
  filename="$1"
  filepath="$PENDRIVE_DIR/$filename"
  
  if [ -f "$filepath" ] && [[ "$filename" == *.pes ]]; then
    echo "File: $filename"
    
    new_filename=$(generate_random_name).pes
    new_filepath="$PENDRIVE_DIR/$new_filename"
    
    while [ -e "$new_filepath" ]; do
      new_filename=$(generate_random_name).pes
      new_filepath="$PENDRIVE_DIR/$new_filename"
    done
    
    mv "$filepath" "$new_filepath"
    echo "Arquivo renomeado com sucesso: $filename -> $new_filename"
  fi
}

process_file() {
  filename=$(basename "$1")
  rename_file "$filename"
}

main() {
  echo "Starting Shell script"
  
  while true; do
    inotifywait -e create -q "$PENDRIVE_DIR" --format "%w%f" |
    while read -r file; do
      process_file "$file"
    done
  done
}

main
