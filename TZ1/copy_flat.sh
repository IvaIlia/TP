input_dir=$1
output_dir=$2

mkdir -p "$output_dir"

find "$input_dir" -type f -print0 | while IFS= read -r -d '' file; do
    base_name=$(basename -- "$file")
    unique_hash=$(echo "$file" | md5sum | cut -d' ' -f1)
    new_filename="${base_name%.*}_$unique_hash.${base_name##*.}"
    cp "$file" "$output_dir/$new_filename"
done
