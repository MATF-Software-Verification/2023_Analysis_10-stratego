# 2023_Analysis_10-stratego

# :memo: O projektu:
- Stratego je strateška društvena igra za dva igrača na tabli od 10×10 polja. Svaki igrač kontroliše 40 figura koje predstavljaju pojedinačne činove oficira i vojnika u vojsci. Cilj igre je pronaći i zarobiti protivničku zastavu. 
- Izvorni kod projekta i detaljnije informacije o njemu mogu se naći na sledećem [linku](https://gitlab.com/matf-bg-ac-rs/course-rs/projects-2020-2021/10-stratego)
- Analizirana je master grana, heš kod commita: ed808189d9be7d4d8a41cd9b652810b70c85b884


# :wrench: Alati koji su korišćeni:
* Clang
  - Clang-Tidy
  - Clang-Format
* Cppcheck
* Flawfinder
* Valgrind
  - Memcheck
  - Callgrind
  
Za svaki od pomenutih alata postoji odgovarajući direktorijum. Detaljne informacije o rezultatima i načinu pokretanja ovih alata možete pronaći u ProjectAnalysisReport.md izveštaju smeštenom u repozitorijumu.
  

# :memo: Zaključak:
Na osnovu analize projekta Stratego korišćenjem različitih alata, preporučuje se:
- Fokusirati se na destruktore u QtWaylandClient biblioteci: Proveriti kako se resursi oslobađaju prilikom destrukcije objekata.
- Proveriti inicijalizaciju i oslobađanje objekata: Osigurati da su objekti pravilno inicijalizovani i da se oslobađaju u ispravnom redosledu.
- Obratiti pažnju na upotrebu mutexa: Osigurati da se svaki lock na mutexu pravilno odblokira i da se ne koristi nakon oslobađanja.
- Zameniti funkciju srand: Funkcija srand nije pogodna za bezbednosne svrhe i treba je zameniti.
- Koristiti kriptografski bezbedne metode generisanja slučajnih brojeva: Preporučuje se upotreba funkcija poput std::random_device u C++ za poboljšanje bezbednosti.
- Razmotriti nivo 3 ranjivosti: Identifikovani problemi su ozbiljni, ali ne kritični, i trebaju biti tretirani sa pažnjom.

# Autor:
Katarina Milošević, 1019/2023
