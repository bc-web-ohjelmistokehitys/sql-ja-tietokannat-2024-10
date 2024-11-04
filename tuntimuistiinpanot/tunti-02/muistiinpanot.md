# Tunti 2

Tervetuloa tunnille 2.

[Homebrew](https://brew.sh/) oli - kuten toivoimme ensimmäisellä tunnilla - onnistuneesti asennettu viikon aiempia päivinä, ja niillä opiskelija-mussukoilla, jotka olivat olleet poissa, oli siihen ohjeet.

## Brew

Homebrew on Macin paketinhallinta, sama kuin Linuxin [Apt](<https://en.wikipedia.org/wiki/APT_(software)>) tai Yum], distrosta riippuen.

```console
opiskelija@bar:~$ brew --help
foo
```

Suosittelen, että luette aiheesta, ja harjoittelette brewin käyttöä kaikessa rauhassa ja huolellisesti.

### PostgreSQL:n asennus brewistä.

Asensimme PostgreSQL:n brewistä. **Huom! Lue ohjeet huolellisesti**, noudata niitä loppuun asti, ja koita ymmärtää, mitä tapahtuu.

```console
opiskelija@bar:~$ brew install postgresql@17
```

Haluamme asentaa nimenomaan _kiinteän_ version PostgreSQL:stä, niin ettei se päivity itsestään. Tietokantaohjelmistot menevät helposti rikki tai vaaditaan ihmisen toimenpiteitä, jos niistä tulee major-päivitys (ensimmäinen numero versionumerosta).

## PostgreSQL:n asennuksen jälkeen

Kun asennus on onnistuneesti suoritettu, meillä on omalla koneellamme tietokantapalvelinohjelmisto, mutta se ei ole päällä.

Brewistä asennettuja palveluja hallinnoidaan Brewin kautta.

```console
opiskelija@bar:~$ brew services list
Name              Status  User   File
postgresql@17     none
```

Käynnistämme palvelun.

```console
opiskelija@bar:~$ brew services start postgresql@17
==> Successfully started `postgresql@17` (label: homebrew.mxcl.postgresql@17)

```

## Tietokannan luonti + yhteydenotto tietokantaan.

`psql` komennon pitäisi asennus-show'n jälkeen antaa virheilmoitus luokkaa `database name XXXXXX not found`.

```console
opiskelija@bar:~$ psql
psql: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: FATAL:  database "opiskelija" does not exist
```

`createdb school` luo school-nimisen tietokannan wilma 2 - projektillemme. Jos virhettä ei tule, luonti on onnistunut.

```console
opiskelija@bar:~$ createdb school
opiskelija@bar:~$
```

- `psql school` ottaa shell-yhteyden example-nimiseen tietokantaan. **Huomaa, että terminaali-ikkuna muuttuu eri näköiseksi. Opi tunnistamaan, milloin ollaan tietokannassa, ja milloin "perus"-shellissä.**

```console
opiskelija@bar:~$ psql school
psql (17.0 (Homebrew))
Type "help" for help.

school=#
```

## Tietokannassa sisällä

Tietokanta puhuu SQL:ää. Voimme copy-pastettaa VSCodesta SQL:ää suoraan tietokannassa kiinni olevaan terminaali-ikkunaan. Huomaa, että näiden kahden välillä ei ole mitään suoraa yhteyttä, vain manuaalista copy-pastorointia!

Voimme avata näkymät olemaan auki vierekkäin, niin copy-pastorointi on tosi helppoa.

![Sisällä tietokannassa](<Screenshot 2024-11-04 at 12.09.52.png>)

## SQL-harjoituksia

Kertasimme tietokannan rakenteen muokkausta (`CREATE TABLE`, `DROP TABLE`). Harjoittelimme tiedon syöttöä (`INSERT`), poistoa (`UPDATE`) ja hakemista (`SELECT`).

```sql
SELECT * FROM student;
SELECT id, last_name, first_name FROM student ORDER BY last_name, first_name;
SELECT id, birthday, first_name, last_name FROM student WHERE id = 1;

UPDATE student SET birthday = '3000-02-01 BC' WHERE id = 1;

DELETE FROM student WHERE id = 3;
```

### Dokumentaatio

Älä pelästy isoa dokumentaatiota. Kaikilla kyselyillä voi tehdä tosi paljon ja monimutkaisia asioita, joten dokumentaatiossakin on paljon edistyneitä juttuja.

- https://www.postgresql.org/docs/current/sql-select.html
- https://www.postgresql.org/docs/current/sql-delete.html
- https://www.postgresql.org/docs/current/sql-update.html

## Transaktio

Transaktio on yksi tietokantojen tärkeimmistä, ellei tärkein ominaisuus.

Kun kirjoitamme SQL-käskyn ilman transaktiota, se tapahtuu heti. Transaktion sisällä, aloitettuamme sen käskyllä `BEGIN;` voimme tehdä (kärjistettynä) mitä tahansa, eivätkä muut näe sitä ennen kuin _commitoimme_ transaktion. Jos emme ole tyytyväisiä, tai jos tapahtuu virhe (kaikki yksittäisen transaktion sisällä tapahtuvat asiat joko onnistuvat tai epäonnistuvat yhdessä), voimme _rollbäckätä_ transaktion.

- https://en.wikipedia.org/wiki/ACID

- `BEGIN` aloittaa transaktion.
- Joko `COMMIT` (muutokset ok) tai `ROLLBACK` (komento takaisin!) lopettavat transaktion.
- Aina kannattaa mahdollisuuksien mukaan tehdä transaktio, jos on ajatuksissa tehdä jotain "tuhoisaa".

```sql
BEGIN;
DELETE FROM student;
/* whoops tuotantopalvelin vahingossa tyhjäksi, pare rollbäkkää ja äkkiä! */
ROLLBACK;

BEGIN TRANSACTION;
DELETE FROM student WHERE id = 1;
/* halusimmekin delliä vain yhden opiskelijan, kaikki ok, commitoidaan! */
COMMIT;
```
