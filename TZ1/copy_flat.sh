#!/bin/bash

# Принимаем входной и выходной каталоги из аргументов командной строки
input_dir="$1"
output_dir="$2"

# Создаем выходной каталог, если он не существует
mkdir -p "$output_dir"

# Находим все файлы внутри входного каталога (включая подкаталоги) и обрабатываем их
find "$input_dir" -type f -print0 | while IFS= read -r -d '' file; do
    # Извлекаем имя файла без пути
    base_name=$(basename -- "$file")
    # Извлекаем расширение файла
    extension="${base_name##*.}"
    # Извлекаем имя файла без расширения
    filename="${base_name%.*}"
    # Вычисляем уникальный хеш MD5 для содержимого файла
    unique_hash=$(md5sum <<< "$file" | cut -d' ' -f1)
    # Создаем новое имя файла, добавляя уникальный хеш к оригинальному имени
    new_filename="${filename}_$unique_hash.$extension"
    # Копируем файл в выходной каталог с новым именем
    cp "$file" "$output_dir/$new_filename"
done
