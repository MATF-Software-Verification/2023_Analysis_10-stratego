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

Zatim sam primenila izmene na sve header i source fajlove komandom: `clang-format -i -style=file Headers/* Sources/* `

Kako biste izvršili navedenu analizu, pokrenite skriptu **run-format.sh** iz Stratego direktorijuma komandom `bash run-format.sh`:  
[run-format.sh](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/clang-format/run-format.sh)


## 3. Memcheck
**Valgrind** je okruženje za alatke za debagovanje koje uključuje različite alate za analizu i optimizaciju programa, posebno u kontekstu upravljanja memorijom. Koristi se za identifikaciju različitih vrsta grešaka koje mogu uzrokovati neispravan rad programa, kao što su curenja memorije, neinicijalizovana memorija, pristup van granica memorije i drugo. Neke od ključnih funkcionalnosti Valgrinda: Memcheck, Cachegrind, Callgrind, Helgrind, Massif..

Valgrind radi tako što prati izvršavanje programa na niskom nivou, što može dovesti do usporavanja programa, ali pruža detaljne informacije koje su korisne za debagovanje i optimizaciju.

Memcheck je jedan od alata unutar Valgrind paketa. Specijalizovan je za detekciju grešaka u korišćenju memorije i najčešće se koristi za otkrivanje problema kao što su curenja memorije, pristupi neinicijalizovanoj memoriji i pristupi van granica alocirane memorije.

Šta Memcheck radi?
- Memcheck prati sve alokacije i dealokacije memorije u programu. Ako program alocira memoriju, ali je nikada ne oslobodi, Memcheck će prijaviti takvo curenje memorije.
- Kada se memorija koristi pre nego što je inicijalizovana, može dovesti do nepredvidivog ponašanja programa. Memcheck pomaže u identifikaciji takvih pristupa.
- Memcheck može prepoznati kada program pokušava da pristupi memoriji izvan granica koje su mu dodeljene. Ovo uključuje slučajeve kada se pokušava pristupiti neregistrovanoj memoriji ili memoriji koja je već oslobođena.
- Ako različiti delovi programa pogrešno koriste istu memoriju, Memcheck može pomoći u identifikaciji tih problema.

Memcheck se koristi iz komandne linije i obično se pokreće uz pomoć Valgrind alata sa opcijama koje omogućavaju detaljno praćenje i analizu izvršavanja programa. Iako može usporiti izvršavanje programa, informacije koje pruža su veoma korisne za otkrivanje i ispravljanje problema sa memorijom.

Koristila sam alat memcheck upravo za otkrivanje grešaka u memoriji kao što su: curenje memorije, nevažeći pristup memoriji ili pristup neinizijalizovanoj memoriji.

Program sam pokrenula komandom `valgrind --tool=memcheck --log-file=basic_memcheck_result.txt ./Desktop-Debug/Stratego` iz build direktorijuma. Generisan je fajl **basic_memcheck_result.txt** koji sadrži izveštaj o rezultatima analize. 
[basic_memcheck_result.txt](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/memcheck/basic_memcheck_result.txt)

Analizom ovog fajla uočeni su sledeći problemi: invalidno čitanje veličine 4 bajta, što ukazuje na pristup već oslobodjenoj memoriji, kao i greške u radu sa pthread mutex-ima koje se odnose na oslobadjanje resursa. Ove greške, koje se javljaju prilikom destrukcije objekata klase QWaylandDisplay i QWaylandIntegration iz QtWaylandClient biblioteke, sugerišu da bi moglo doći do problema u sinhronizaciji ili u načinu na koji se resursi oslobađaju pri zatvaranju aplikacije. Iako je ukupna količina memorije koja se još uvek koristi na kraju izvršavanja visoka, određeni blokovi memorije su identifikovani kao izgubljeni, što dodatno ukazuje na potrebu za detaljnijom analizom i eventualnim refaktoringom koda kako bi se obezbedila stabilnost aplikacije i prevencija budućih problema u radu sa memorijom. 
Preporučuje mi da se fokusiram na deo koda vezan za destruktore u QtWaylandClient biblioteci, proveravajući kako se resursi oslobađaju. Zatim da proverim da li su objekti pravilno inicijalizovani i da li se oslobađaju u ispravnom redosledu.  Takođe, potrebno je obratiti pažnju na upotrebu mutexa u kodu i osigurati da se svaki lock na mutexu odgovarajuće odblokira (unlock) i da se ne koristi nakon što je oslobođen.

Alat je sugerisao i upotrebu **--leak-check=full** flega kako bih dobila detaljnije informacije o neslobodjenoj memoriji i kao izlaz komande `valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --log-file="detailed_memcheck_result.txt" Desktop-Debug/Stratego` dobila sam fajl **detailed_memcheck_result.txt** koji sadrži izveštaj o rezultatima detaljnije analize:
[detailed_memcheck_result.txt](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/memcheck/detailed_memcheck_result.txt)

Kako biste izvršili navedenu analizu, pokrenite skriptu **run-memcheck.sh** iz build direktorijuma komandom `bash run-memcheck.sh`:  
[run-memcheck.sh](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/memcheck/run_memcheck.sh)

## 4. Callgrind
Callgrind je alat za analizu performansi koji je deo Valgrind suite. On je specijalizovan za profilisanje programa, fokusirajući se na praćenje i merenje potrošnje CPU vremena tokom izvršavanja. Kada se koristi, Callgrind beleži informacije o pozivima funkcija, uključujući koliko često su funkcije pozivane i koliko CPU vremena su potrošile. Ovi podaci pomažu u identifikaciji potencijalnih uskih grla i neefikasnosti u kodu. 

Komandom `valgrind --tool=callgrind Desktop-Debug/Stratego` pokrenula sam program:
![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/callgrind/callgrind1.png)

Kada se izvrši ova komanda, Callgrind prikuplja detaljne informacije o tome koliko često se funkcije pozivaju i koliko CPU vremena troše. Rezultati ove analize se čuvaju u fajlu (na primer, callgrind.out.xxxx) i sadrzi detaljan pregled ponašanja programa(izvršene instrukcije, alokacija i dealokacija memorije, caller/callee odnos izmedju funkcija, broj pogodaka i promašaja keša...). 

Rezultate analize sam analizirala uz pomoć grafičkog alata **KCachegrind**, koji pruža vizuelni prikaz prikupljenih informacija, omogućavajući korisnicima da bolje razumeju kako se resursi koriste i da optimizuju performanse programa. Korišćenje Callgrinda i KCachegrinda zajedno omogućava duboku analizu i poboljšanje efikasnosti aplikacija.

Pokrenula sam ga komandom: `kcachegrind callgrind.out.17112`

Vizuelizacija: 
![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/callgrind/callgrind2.png)


Ono što nas interesuje su funkcije se najviše pozivaju. S leve strane nalazimo informacije o broju poziva svake funkcije i o broju instrukcija koje je izvršavanje funkcije zahtevalo, kako samostalno, tako i uključujući instrukcije koje su potekle iz drugih funkcija koje je ta funkcija pozivala. Na desnoj strani možemo izabrati opciju "All Callers" da bismo videli sve funkcije koje su pozivale funkciju od interesa. Takođe, na dnu desne strane, možemo pregledati graf poziva funkcije izborom opcije "Call Graph".

Graf poziva:
![](https://github.com/MATF-Software-Verification/2023_Analysis_10-stratego/blob/main/valgrind/callgrind/graph.png)


