#!/bin/bash

# Prelazak u odgovarajući direktorijum
cd build

# Pokretanje cmake sa odgovarajućim opcijama
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

# Pokretanje clang-tidy za modernizaciju, rezultate upiši u clanglog.txt
run-clang-tidy game.cpp -checks='modernize-' > clanglog.txt

# Popravi modernizacije direktno u kodu
run-clang-tidy game.cpp -checks='modernize-*' -fix

# Pokretanje clang-tidy za čitljivost, rezultate upiši u log1.txt
run-clang-tidy game.cpp -checks='readability-' > log1.txt

# Popravi čitljivost direktno u kodu
run-clang-tidy game.cpp -checks='readability-*' -fix

