#!/bin/bash

# Generiši .clang-format konfiguracioni fajl sa Google stilom
clang-format -style=Google -dump-config > .clang-format

# Promeni potrebne parametre u .clang-format fajlu
sed -i 's/TabWidth: 8/TabWidth: 4/' .clang-format
sed -i 's/IndentWidth: 2/IndentWidth: 4/' .clang-format
sed -i 's/BreakBeforeBraces: Attach/BreakBeforeBraces: Allman/' .clang-format
sed -i 's/PointerAlignment: Left/PointerAlignment: Right/' .clang-format

# Primeni clang-format na sve fajlove u direktorijumima Headers i Sources
clang-format -i -style=file Headers/* Sources/*

