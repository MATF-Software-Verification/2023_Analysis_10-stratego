#!/bin/bash

# Definišite putanju do direktorijuma gde želite da pokrenete Cppcheck
SOURCE_DIR="./"

# Definišite putanju do izlaznog fajla
OUTPUT_FILE="cppcheck_results.txt"

# Pokrenite cppcheck komandu
if cppcheck --enable=all --suppress=missingInclude --quiet --output-file="$OUTPUT_FILE" -ibuild/ "$SOURCE_DIR"; then
    echo "CPP analiza je uspešno izvršena. Rezultati su sačuvani u '$OUTPUT_FILE'."
else
    echo "Došlo je do greške tokom izvođenja CPP analize."
fi

