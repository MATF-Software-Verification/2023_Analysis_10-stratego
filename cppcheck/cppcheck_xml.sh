#!/usr/bin/bash

set -e

echo "Pokrećem statičku analizu koda pomoću cppcheck..."

if cppcheck --quiet --enable=all --suppress=missingInclude --force --output-file=output.xml --xml -ibuild/ -iForms/ .; then
    echo "Analiza cppcheck-a je uspešno završena!"
    echo "Sada se generiše HTML izveštaj..."

    if cppcheck-htmlreport --file=output.xml --report-dir=report; then
        echo "HTML izveštaj je uspešno generisan. Otvaram fajl report/index.html..."
        firefox report/index.html
    else
        echo "Došlo je do greške prilikom generisanja HTML izveštaja."
    fi
else
    echo "Došlo je do greške tokom statičke analize koda."
fi

