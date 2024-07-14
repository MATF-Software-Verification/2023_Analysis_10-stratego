# Izveštaj analize projekta


## 1. Clang-Tidy
**Clang** je kompajler za programske jezike C, C++, Objective-C i Objective-C++. Clang analizira izvorni kod, stvarajući sintaksno stablo i proveravajući ispravnost tipova i deklaracija. Koristi LLVM za optimizaciju i generisanje konačnog mašinskog koda.

**Clang-tidy** nadograđuje Clang dodavanjem dodatnih funkcionalnosti za analizu statičkog koda, detekciju grešaka, stilskih nedostataka i performansi, kao i mogućnost automatskog popravljanja identifikovanih problema. Ova integracija omogućava programerima da unaprede kvalitet i čitljivost svog koda tokom razvojnog procesa.

ClangTidy koristila sam u kombinaciji sa CMake kako bih refaktorisala i modernizovala projekat.
Projekat sam pokrenula pomocu cmake alata i dodala flag -DCMAKE_EXPORT_COMPILE_COMMANDS=ON kako bi se generisao fajl compile_commands.json, koji je neophodan za primenu ovog alata.

![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/clang-tidy1.png)

Pozicionirala sam se u build direktorijum i odatle pozvala komandu `run-clang-tidy game.cpp -checks='modernize-' > clanglog.txt`.
Flag -checks='modernize-' nalaže da se vrše provere koje se koriste za modernizaciju koda kako bi se koristili savremeniji C++ standardi i prakse.
Alat clang-tidy primenila sam na fajlu game.cpp koji izlaz preusmerava u datoteku clanglog.txt. U ovoj datoteci čuvaju se predložene izmene.

[clanglog.txt](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/clanglog.txt)


Nakon analize, izvršila sam komandu `run-clang-tidy game.cpp -checks='modernize-*' -fix` kako bih primenila predložene sugestije i ispravila kod.
Neke od izmena:

![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/diff1.png)

![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/diff2.png)

Nakon toga, ponovo sam pozvala clang-tidy, ali sada sa uključenim flegom readability. Ovaj fleg vrši provere koje pomažu da kod postane čitljiviji, održiviji i razumljiviji.

![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/readability.png)

U narednom fajlu nalaze se sve izmene koje je clang-tidy predlozio:

[log1.txt](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/log1.txt)

Prihvatila sam sve i komandom `run-clang-tidy game.cpp -checks='readability-*' -fix` izvršila predlozene izmene.

Primeri nekih od izmena:
![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/readability_diff.png)

Kako biste izvršili navedenu analizu, pokrenite skriptu **run_clang_tidy.sh** iz Stratego direktorijuma komandom `bash run_clang_tidy.sh`:
[run_clang_tidy.sh](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-tidy/run_clang_tidy.sh)


## 2. Clang-Format
Clang-format je alat za automatsko formatiranje koda koji pripada LLVM projektu. Njegova svrha je da dosledno primeni stil kodiranja na C, C++, Java, JavaScript i Objective-C kod, čime se poboljšava čitljivost i održavanje koda. Korisnici mogu prilagoditi pravila formatiranja prema svojim potrebama, a alat automatski preuređuje kod u skladu sa zadatim stilskim pravilima. Nudi više različitih stilova programiranja kao što su : Google, Chromium, LLVM, Mozilla..

Izabrala sam da se moj format zasniva na ClangFormat stilu Google i na njega zatim primenila male izmene.

Prvo sam generisala fajl .clang-format sa Google opcijom za stil: 

![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-format/format1.png)


Izmene koje sam primenila uz pomoc vim: 
TabWidth: 8 -> 4
IndentWidth: 2 -> 4
BreakBeforeBraces: Attach -> Allman
PointerAlignment: Left -> Right

.clang-format pre izmena: [.clang-format](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-format/.clang-format-pre)
.clang-format nakon izmena: [.clang-format](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-format/.clang-format)

Zatim sam primenila izmene na sve header i source fajlove komandom: **clang-format -i -style=file Headers/* Sources/***

Kako biste izvršili navedenu analizu, pokrenite skriptu **run-format.sh** iz Stratego direktorijuma komandom `bash run-format.sh`:
[run-format.sh](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-format/run-format.sh)



