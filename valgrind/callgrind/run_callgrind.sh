#!/bin/bash

# Pokreće Valgrind sa Callgrind alatkom
valgrind --tool=callgrind Desktop-Debug/Stratego

# Traži poslednji callgrind izlazni fajl
callgrind_file=$(ls -t callgrind.out.* | head -n 1)

# Otvara KCachegrind koristeći poslednji callgrind fajl
kcachegrind "$callgrind_file"

