# Szegedi Tudományegyetem – Juhász Gyula Pedagógusképző Kar
**Szak:** Programtervező informatikus  
**Típus:** Projektfeladat – Felhasználói dokumentáció  

---

# QVÍZ – Biológiai Kvízjáték

**Készítette:** Bíró Linda, Daroczi Attila

---

## Specifikáció

A projekt célja egy Android/iOS mobilalkalmazás fejlesztése, amely egy biológiai témájú kvízjátékot valósít meg. Az alkalmazás segítségével a játékos különböző nehézségű és témájú biológiai kérdésekre válaszolhat.

* **Kérdésbank és válaszok:** A kérdések egy kérdésbankból kerülnek kiválasztásra véletlenszerűen. Minden kérdéshez három válaszlehetőség tartozik, amelyek közül pontosan egy helyes.
* **Csillagok és segítség:** A játékos a helyes válaszokért csillagokat kap, amelyeket a játék során segítségek vásárlására használhat fel. Egy segítség egy rossz válaszlehetőséget zár ki az adott kérdésnél. A csillagok csak az adott játékmenet alatt használhatók fel.

### Játékmenet

A játék indulásakor a felhasználó kiválaszthatja a kívánt játékmódot. A játék során az alkalmazás a kérdésbankból véletlenszerűen kiválaszt egy kérdést. A kérdés egy külön kérdésdobozban jelenik meg, alatta pedig három válaszkártya található. 

A játékos a három válaszlehetőség közül kiválasztja az általa helyesnek gondoltat. Ennek kettőféle kimenetele lehet:

* **Helyes válasz esetén:**
  * A játékos csillagokat kap.
  * A következő kérdés jelenik meg, a játék folytatódik.
* **Helytelen válasz esetén:**
  * Az alkalmazás jelzi, hogy a válasz helytelen.
  * **Életes játékmódban** a játékos egy életet veszít.
  * **Időre menő játékmódban** a játék folytatódik, a következő kérdés jelenik meg.

---

## Játékmódok

Az alkalmazás két különböző játékmódot biztosít:

### 1. Életes játékmód
* Ebben a játékmódban a játékos **5 élettel** kezdi a játékot.
* A képernyőn folyamatosan látható az aktuális életek száma.
* Helyes válasz esetén a játékos nem veszít életet, helytelen válasz esetén egy élet levonásra kerül.
* Ha a játékos mind az 5 életét elveszíti, a játék véget ér.
* **Eredményképernyő:** A játék végén megjelenik egy összesítő, amely tartalmazza a helyesen megválaszolt kérdések számát, a hibás válaszok számát, a megszerzett csillagok számát és az összes megválaszolt kérdés számát.

### 2. Időre menő játékmód
* Ebben a játékmódban a játékosnak egy előre meghatározott idő áll rendelkezésére (például **5 percig** válaszolhat a kérdésekre).
* A képernyőn egy visszaszámláló jelenik meg.
* A játékos célja, hogy az idő lejárta előtt minél több kérdésre helyes választ adjon.
* Ha a visszaszámláló eléri a nullát, a játék automatikusan véget ér.
* **Eredményképernyő:** A végeredmény tartalmazza a helyes válaszok számát, a helytelen válaszok számát, az összes megválaszolt kérdés számát és a megszerzett csillagok számát.

---

## Célcsoport

Az alkalmazás elsősorban olyan felhasználóknak készült, akik szeretnék játékos formában gyakorolni és bővíteni biológiai ismereteiket. A játék használható:
* tanulásra,
* gyakorlásra,
* tudásfelmérésre,
* szórakozásra.
