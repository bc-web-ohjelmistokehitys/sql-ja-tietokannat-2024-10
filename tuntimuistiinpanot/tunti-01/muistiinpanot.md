# Tunti 1

Tervetuloa "tietokannat ja SQL" kurssille. Esittelimme itsemme ja kerroimme, mitä tiedämme alasta ja erityisesti tietokannoista ja SQL:stä etukäteen ennen kurssia. Melkein kaikille lähes kaikki oli uutta, mikä on hyvä lähtökohta. Olemme tyhjiä tauluja (sanaleikki tarkoituksillen).

## Orientaatioluento

- https://docs.google.com/presentation/d/1bnWLilaa1lrljGqaAX07fv62745hXlzKO7lT8Zzz_jA/
- https://en.wikipedia.org/wiki/Client%E2%80%93server_model
- https://www.postgresql.org/
- https://en.wikipedia.org/wiki/SQL
- https://en.wikipedia.org/wiki/SQLite

Käytämme kurssilla PostgreSQL-tietokantaa, koska se on paras, ilmainen ja de facto standardi.

## Kurssin discord-palvelin ja Github

Kurssin materiaalit asuvat Githubissa:

- https://github.com/bc-web-ohjelmistokehitys/sql-ja-tietokannat-2024-10

Kurssillamme on Discord-palvelin. Liity sinne allaolevalla linkille. Käymme siellä keskustelua digitaalisesti / asynkronisesti / tarpeen vaatiessa tuntien ulkopuolellakin, ja jaan siellä olennaisia linkkejä / matskuja.

- https://discord.gg/nzNMHQrudw

On enemmän kuin toivottavaa, että olet läsnä, mutta jos satut tulemaan kipeäksi tai estyneeksi, ja haluat silti kuunnella / katsella, saan Discordista etäyhteyden tarpeen tullen auki. Se ei ole paras mahdollinen ratkaisu, mutta parempi kuin ei mitään.

### Tärkeä opetus

Jos et tiedä / osaa keksiä erityistä syytä valita minkä tahansa web-hankkeen tietovarastoksi jotakin muuta kuin PostgreSQL:n, valitse aina PostgreSQL.

## Tietokantojen suunnittelua visuaalisesti

- https://drawsql.app/

Kun ymmärrät "yhtä tasoa alemmalla tasolla", mitä olet tekemässä, on OK käyttää mitä tahansa hyväksi kokemaansa työkalua. Olennaista on kuitenkin ymmärtää, mitä työkalun takana tapahtuu.

Käytimme DrawSQL-sovellusta piirrelläksemme kuviteltua omaa versiota Wilmasta. Pohdiskelimme, millaisia tietoja Wilmassa (malliesimerkki sovelluksesta, jonka takana on relaatiotietokanta) on, ja miten niitä voitaisiin mallintaa tietokantaan. Millaisia tauluja, millaisia kolumneja niistä syntyisi?

### Tietotyyppejä

Käsittelimme tietokantataulujen kolumnien (sarakkeiden) perustietotyyppejä.

- https://www.postgresql.org/docs/17/datatype.html

Puhuimme id (tunniste)-sarakkeista ja taulujen primary keystä (pääavain?). Totesimme, että se on usein juokseva numero.

Puhuimme lukutyyppien (integer, bigint, smallint) välisistä eroista. Puhuimme charista ja varcharista ja näiden eroista. Puhuimme aika- ja päivämäärätyypeistä, ja siitä, kuinka niiden kanssa pelaaminen on usein vaikeaa.

### Taulujen välinen yhteys

Puhuimme lyhyesti taulujen välisistä yhteyksistä.

- 1-n
- n-m

Mallinsimme yksinkertaisimman yhteyden, ns. "1-n" suhteen opiskelijaryhmän ja opiskelijan välillä. Kukin opiskelija kuuluu yhteen ryhmään, yhdessä ryhmässä voi olla monta opiskelijaa.

- https://en.wikipedia.org/wiki/One-to-many_(data_model)

## Exporttaus

Exporttasimme paria taulua mallinnettuamme ohjelmasta ulos raakaa SQL:ään, ja avasimme sen VSCodessa.

Oman esimerkkitiedostoni löydät tästä: [example.sql](./example.sql)

## Terminaali

Puhuin tunnin mittaan useaan otteeseen terminaalista, ja siitä, kuinka **terminaali on yksi ohjelmistokehittäjän olennaisimmista ja tärkeimmistä työkaluista**. Opettaja kehotti opiskelijoita erittäin painokkaaseen sävyyn olemaan pelkäämättä terminaalia, ja sukeltamaan sinne rohkeasti.

Tulemme käyttämään terminaalia TOSI PALJON tällä kurssilla, joten opimme kyllä väkisinkin. Ei siis hätää.

- Opetelkaa ymmärtämään terminaalin konteksti (olenko "perus" shellissä? olenko tietokannassa? olenko etäpalvelimella?)
- Opetelkaa pitämään useampaa terminaalia (täbiä / ikkunaa) samaan aikaan auki monessa kontekstissa, ja ymmärtämään, missä kulloinkin olette.
- Opetelkaa toimimaan omalla koneella terminaalissa, vähintään yhtä hyvin kuin graafisessa käyttöliittymässä. Pyrkikää ymmärtämään, mikä graafisessa ympäristössä vastaa terminaalia ja päin vastoin.
- Opetelkaa, miten terminaalikäskyt toimivat (käsky vs. käskyjen optiot vs käskyjen parametrit)

### Käskyjä terminaaliin

- `.` tarkoittaa tämänhetkistä kansiota. `./komento.sh` <- ajaa komento.sh nimisen tiedoston kansiosta, jossa olet.
- `..` tarkoittaa "yksi hakemisto ylöspäin nykyisestä". `cd ..` <- yksi kansio "ylöspäin" kohti juurta.
- `~` tarkoittaa tämänhetkisen käyttäjän kotihakemistoa.

Tässä joitakin peruskäskyjä, joita tarvitaan usein:

- `cd` vaihtaa hakemistoa. `cd ~` <- mene kotikansioon
- `ls` tiedostolistaus. `ls -lah` on tämän muoto, jota käytän itse eniten.
- `pwd` missä hakemistossa olen tällä hetkellä?
- `cat` näyttää tiedostojen sisällön
- `whoami` kuka käyttäjä olen tällä hetkellä?
- `nano` on helppo tekstieditori. Itse käytän sitä. `vim` on vaikea, "kunnon" koodarit osaavat usein käyttää vimiä. Vimistä pitää opetella ainakin pakenemaan, koska sinne joutuu joskus vahingossa.
- `git` käskyä tulette tarvitsemaan usein. Opitte siitä varmasti paljon jo lähiviikkoina.
- `brew` käskyä tulemme tarvitsemaan, mutta meillä ei ole sitä vielä. Kotitehtävämme on pitää huoli siitä, että meillä on se ensi perjantaina (joku "vakiompi" opettaja opettaa meidät laittamaan itsellemme sen aivan varmasti)

### Lisää käskyjä

Rehellisyyden nimissä, en itsekään osaa näitä kaikkia. Ainakaan ulkoa. Unixissa ja Linuxissa on paljon käskyjä, koska käskyt tekevät yleensä vain yhden asian. Siksi niitä voi ja tulee _putkittaa_, josta tulemme oppimaan myöhemmin tälläkin kurssilla!

- https://www.geeksforgeeks.org/essential-linuxunix-commands/
