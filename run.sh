#!/bin/bash

# input_folder="./tests/laconversion/input"
# output_folder="./tests/laconversion/output"
# liquid_script="./liquid/ConsumptionToStandardAcceleratorSiemens.liquid"

# # Ensure the output folder exists
# mkdir -p "$output_folder"

# # Iterate over each JSON file in the input folder
# for input_file in "$input_folder"/*.json; do
#     # Check if the file exists
#     if [ -e "$input_file" ]; then
#         # Generate the output file path
#         output_file="$output_folder/$(basename "$input_file")"

#         # Run the dotnet command for each file
#         dotnet run "$input_file" "$liquid_script" "$output_file"

#         # Print a message indicating completion
#         echo "Processed $input_file => $output_file"
#     fi
# done

input_folder="./tests/laconversion/$1"
output_base_folder="./tests/$1"
temp_output_file="./tests/laconversion/temp.json"
liquid_script="./liquid/ConsumptionToStandardAcceleratorSiemens.liquid"
output_json="./tests/$1/parameters.json"
output_settings="./tests/$1/appSettings.tmpl"
# Ensure the output base folder exists
mkdir -p "$output_base_folder"
echo "{" > "$output_json"
unique_captured_text=()

# Iterate over each JSON file in the input folder
for input_file in "$input_folder"/*.json; do
    # Check if the file exists
    if [ -e "$input_file" ]; then
        # Extract the file name without extension
        file_name=$(basename "$input_file")
        file_name_no_extension="${file_name%.json}"

        # Create an output folder for this input file
        output_folder="$output_base_folder/$file_name_no_extension"
        mkdir -p "$output_folder"

        # Generate the output file path
        output_file="$output_folder/workflow.json"

        # Run the dotnet command for each file
        dotnet run "$input_file" "$liquid_script" "$temp_output_file"
        cat "$temp_output_file" | jq > "$output_file"
        sed 's/\${\([^}]*\)}/parameters('\''\1'\'')/g; t; d' $output_file
        sed -i 's/\${\([^}]*\)}/parameters('\''\1'\'')/g' $output_file

        # Process the input file
        while IFS= read -r line; do
        # Use grep to extract 'captured text' between parameters('')
  captured_text=$(echo "$line" | grep -o "parameters('\([^']*\)')" | sed "s/parameters('\([^']*\)')/\\1/")
  # If captured text is not empty and not in the list, write it to the output JSON and add it to the list
  if [ -n "$captured_text" ] && [[ ! " ${unique_captured_text[*]} " =~ " $captured_text " ]]; then
    unique_captured_text+=("$captured_text")
    echo "  \"$captured_text\": {\"value\": \"@appsetting('$captured_text')\", \"type\": \"string\"}," >> "$output_json"
    echo "  {\"name\":\"$captured_text\", \"value\": \"\${$captured_text}\"}," >> "$output_settings"
  fi
        done < "$output_file"

        # Print a message indicating completion
        echo "Processed $input_file => $output_file"
    fi
done
 # Add the closing brace to complete the JSON object
        echo "}" >> "$output_json"