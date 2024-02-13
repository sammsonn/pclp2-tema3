**Nume: SAMSON Alexandru-Valentin**
**Grupă: 312CC**


## Tema 3 – Checkered flag


### Descriere:

## Task 1

* Funcția reverse_vowels inversează ordinea vocalelor din acel șir, menținând
consoanele nemodificate. Modificarea se face direct în locația de memorie a
șirului, în loc să se creeze un șir nou. Pentru a realiza aceasta, funcția
parcurge șirul și identifică vocalele utilizând funcția strchr, care caută un
caracter dat într-un alt șir. După identificarea vocalelor, funcția le
inversează utilizând operații aritmetice pe adresele de memorie corespunzătoare.
Pentru a realiza inversarea, funcția utilizează registrii și salvează temporar
adresele de memorie pe stivă pentru a le folosi ulterior.

## Task 2

* Funcția pwd construiește calea finală rezultată din parcurgerea celor n
foldere și a o stoca în șirul output. Funcția utilizează registrii și stiva
pentru a salva și manipula valorile temporare și adresele de memorie necesare în
procesul de construire a căii. Aceasta utilizează funcțiile externe strcmp,
strcat și strcpy pentru a compara și concatena șiruri de caractere.
Funcția parcurge vectorul de foldere și pentru fiecare folder, verifică dacă
acesta este "." sau "..". Dacă folderul este ".", se continuă cu următorul
folder fără a face modificări. Dacă folderul este "..", se revine la directorul
părinte prin scăderea contorului de foldere finale și eliminarea ultimului
folder adăugat la cale. După parcurgerea folderelelor, se construiește calea
finală concatenând folderele în ordine și adăugând caracterele '/' între ele.
Se utilizează funcția strcat pentru a concatena fiecare folder la calea finală.

## Bonus 1

* Funcția intertwine împletește elementele din cei doi vectori într-un singur
vector rezultat. Funcția utilizează o buclă intertwine_loop pentru a parcurge
cei doi vectori. În fiecare iterație, se preia un element din v1 și se adaugă în
vectorul rezultat, apoi se preia un element din`v2 și se adaugă în vectorul
rezultat. Contorul r13 este actualizat cu 4 pentru a avansa la următoarea
poziție în vectorul rezultat. După parcurgerea primului vector, se verifică dacă
și al doilea vector a fost parcurs complet. Dacă nu, se preiau elementele rămase
din v2 și se adaugă în vectorul rezultat. Dacă și al doilea vector a fost
parcurs complet, se finalizează construirea vectorului rezultat. 

### Comentarii asupra temei:

* Implementarea mi se pare destul de bună, dar sigur era posibil să fie și mai
eficientă sau mai scurtă. Totuși sunt mulțumit cu această rezolvare.

### Punctajul obținut la teste local:

* Total: 55.0/100