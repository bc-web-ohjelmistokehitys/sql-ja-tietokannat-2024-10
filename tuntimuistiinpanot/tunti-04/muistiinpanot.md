# Tunti 4

Tunnin agenda oli opettajan etäpalvelimella sijaitseva 3.000.000 henkilötiedon kuvitteellinen tietokanta.

Tosielämässä "oikea" tuotannossa oleva tietokanta ei koskaan asu kotikoneella, ja tehtävänämme on paljon useammin käsitellä olemassaolevaa / toisten tekemää kantaa

kuin kirjoittaa kokonaan uusia tietokantoja / tauluja / kolumneja. SELECT on paljon yleisempi SQL-lause kuin UPDATE tai INSERT tai ALTER TABLE jne.

- `cd ~` - menemme kotikansioon
- `pwd` - missä olen juuri nyt?
- `brew service stop postgresql@17` - emme tarvitse omaa palvelinta juuri nyt, joten voimme sulkea sen, jos haluamme olla varmoja, ettemme ota yhteyttä siihen.

## Etäpalvelin

Opettaja oli asentanut meille turvallisen palvelimen, jota voimme tutkia. Huomaa, että et voi mennä nmappaamaan tuntemattomia satunnaisia palvelimia. Se voi jo itsessään olla tulkittavissa tietomurron yritykseksi.

```console
opiskelija@bar:~$ curl --verbose https://hunajapurkki.pekkis.eu
```

```console
opiskelija@bar:~$ nmap hunajapurkki.pekkis.eu
```

Havaitsimme, että portteja on auki. Yksi porteista oli postgresql:n portti, mikä oli meille tietysti erityisen kiintoisaa.

## URL

Juttelimme URLista.

- https://en.wikipedia.org/wiki/URL

PostgreSQL:n asiakasohjelma syö tietokannan nimen lisäksi URLin. Sillä saamme kätevästi yhteyden mihin vain tietokantaan.

```console
opiskelija@bar:~$ psql postgres://<tunnus>:<salasana>@hunajapurkki.pekkis.eu/<tietokannannimi>
psql (17.0)
Type "help" for help.

tietokanta=#
```

## Tietoturvasta

Opimme myöhemmin, että tietokannan pitäminen auki maailmalle on iso soosoo tietoturvasyistä. Suljimme lounalla, ja opettelimme ottamaan yhteyden SSH:lla.

- `ssh oppilas@pekkis.hunajapurkki.eu`

ja päästyämme onnistuneesti sisälle,

- `psql suomioy`

## SSH

Opettelimme SSH:ta ja siihen liittyviä asioita.

- https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding

Selitin asian yksinkertaisesti. Github puhuu asiasta tosi yksityiskohtaisesti. Githubin ohjeet kannattaa lukea, mutta niitä ei kannata pelästyä.

Pekkiksen yksinkertaiset ohjeet (googleta aiheet)

- `ls -la ~/.ssh` - katsotaan onko avaimia olemassa. Ei ollut.
- `ssh-keygen` - luodaan SSH-avain. Hakkaamme entteriä kunnes valmis (tulee randomart-kuvio)
- `ls -la ~/.ssh` - katsotaan onko olemassa. On. ÄLÄ KOSKAAN JAA KENELLEKÄÄN MUUTA KUIN .pub päätteistä JULKISTA osaa.
- `ssh-add` - otetaan identiteetti käyttöön.
- `ssh-copy-id <tunnus>@<palvelin>` - ssh-copy-id:llä identiteetti voidaan kopioida palvelimelle niin ettei ssh sen jälkeen enää kysele salasanaa.

Kuten aikaisemmin totesin, onnistuimme lanaamaan tietokannan! Hyvä, me! Lounaan jälkeen palautimme sen, pienten kommervenkkien jälkeen, backupeista.

- `dropdb suomioy`
- `createdb suomioy`
- `psql suomioy < suomioy.sql` - huh!

Otimme tuoreemman backupin. Latasimme sen omalle koneelle, jotta meillä on taas jokaisella oma versio mahtitietokannasta.

- `pg_dump suomioy > suomioy.sql` (palvelimella)
- `scp hakkeri@hunajapurkki.pekkis.eu:~/suomioy.sql .` (omalla koneella)
- `createdb suomioy` (omalla koneella)
- `psql suomioy < suomioy.sql` (omalla koneella - pekkis-virheet odottamattomia mutta OK!)

`<` ja `>` merkeistä käskyjen yhteydessä voit lukea seuraavasta linkistä. Niiden lisäksi on `|`. Kutsun itse näitä kaikkia yhdessä ylätermillä "putkitus", mutta se ei ole niiden oikea virallinen nimi.

https://www.tutorialspoint.com/unix/unix-io-redirections.htm

### Avaimen lisääminen Githubiin

Tekemämme ssh-avain omalla ajalla lisätä Githubiin! Samoin kaikkiin SSH-aiheisiin kannattaa perehtyä tositarkoituksella, ja niitä kannattaa harjoitella. Ne ovat kaikki tosi olennaisia taitoja työelämässä.

- ![Copy-pastoroi pubkey leikepöydälle](<Screenshot 2024-11-15 at 18.29.20.png>)
- ![Navigoi Githubin SSH-avain osioon ja pasteta avain](<Screenshot 2024-11-15 at 18.30.07.png>)
- ![Helppoa kuin tikkarin varastaminen lapselta!](<Screenshot 2024-11-15 at 18.30.35.png>)

## Varmuuskopiointi

Sen jälkeen, kun rohkea "hakkeri" pyynnöstä tuhosi kaiken datan, opettaja demonstroi varmuuskopion palauttamista. Hän oli aiemmin kertonut, että varmuuskopioita pitää ottaa, ja niiden onnistunutta palauttamista pitää harjoitella. Rikkinäisistä varmuuskopioista ei ole apua.

Opettaja oli karvaasti epäonnistunut omissa opetuksissaan. Hänen varmuuskopionsa ei toiminut, eikä hän saanut sitä palautettua. Vanhempi varmuuskopio onneksi suostui palautumaan 15 minuutin räveltämisen ja sekoilun jälkeen. Tämä ei ollut tarkoituksellista, mutta oli hyvä ja tarpeellinen opetus kaikille. Myös opettajalle itselleen!

### Varmuuskopion ottaminen

Varmuuskopiota sanotaan "tietokantadumpiksi". Se on useimmiten ihan tavallinen tekstimuotoinen SQL-tiedosto.

Yksinkertaisimmillaan näin, mutta pg_dump-komennolla on totta kai paljon erilaisia optioita, jotka selviävät katsomalla. `--help` auttaa, ja `man` myös, kuten aina.

```console
opiskelija@bar:~$ pg_dump tietokannannimi > dump.sql
```

### Varmuuskopion palauttaminen

Varmuuskopion palauttaminen tapahtuu ajamalla dumppi sisään tietokantaan. Se on päinvastainen operaatio kuin dumpin ottaminen. Huomaa, että tietokannan tulee olla tyhjä; dumppi ei, ellei sitä erikseen niin käske tekemään, lanaa olemassolevaa kantaa tyhjäksi.

```console
opiskelija@bar:~$ psql tietokannannimi < dump.sql
```

## Tietokantakyselyitä

Otimme yhteyden etäpalvelimen tietokantaan "suomioy", jossa on 3.000.000 puolirealistista satunnaista "henkilötietoa". Ilman massiivista datamäärää emme pysty ymmärtämään, miten tosielämän tietokanta käyttäytyy.

[ajoimme SQL-kyselyitä](./examples.sql) yhdessä samalla palvelimella, harjoittelimme tiedon hakemista. Lopulta sopivassa kohtaa rohkaisin vapaaehtoisia oppilaita tuhoamaan puolestani kaiken tiedon!

- `DELETE FROM person;`
- `DROP TABLE person CASCADE;`

### Aggregaattifunktiot

Käytimme lyhyesti `COUNT()` aggregaattifunktiota. Näitä on muitakin, ja palaamme niihin myöhemmin.

`SELECT COUNT(id) FROM person;`

### NULL-arvot

Opimme, että NULL elää omassa maailmassaan. Sillä on oma operaattori, `IS NULL`, sekä sen vastakohta, `IS NOT NULL`. Mitä vähemmän null-arvoja tietokannassa on, sitä helpompi sen kanssa on nyrkkisääntönä rationalisoida.

## Ison tietokannan hakeminen omalle koneelle

Uploadasin tietokannan Google Driveen. Tosi isoja binääritiedostoja ei voi säilöä Githubiin, ja yhteinen palvelimemme ei ole ikuisesti pystyssä.

Latasimme kannan omalle koneelle, mutta jos et ollut tunnilla, tai tarvitset sitä joskus uudelleen, voit ladata kannan unzipata sen ja palauttaa omalle paikalliselle serverillesi.

`https://drive.google.com/file/d/1ffawFMhvVinBlLcG8pX1vsjAzYCFlSTk/view`
