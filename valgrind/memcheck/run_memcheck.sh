#!/bin/bash

# Postavi naziv izlaznog fajla za osnovni Valgrind
BASIC_LOG_FILE="basic_memcheck_result.txt"
# Postavi naziv izlaznog fajla za detaljan Valgrind
DETAILED_LOG_FILE="detailed_memcheck_result.txt"

# Definiši putanju do izvršnog fajla
EXECUTABLE_PATH="Desktop-Debug/Stratego"

# Izvrši osnovni Valgrind sa memcheck
echo "Pokrećem osnovni Valgrind..."
valgrind --tool=memcheck --log-file="$BASIC_LOG_FILE" "$EXECUTABLE_PATH"

# Izvrši detaljan Valgrind sa opcijama za curenje memorije
echo "Pokrećem detaljan Valgrind..."
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --log-file="$DETAILED_LOG_FILE" "$EXECUTABLE_PATH"

