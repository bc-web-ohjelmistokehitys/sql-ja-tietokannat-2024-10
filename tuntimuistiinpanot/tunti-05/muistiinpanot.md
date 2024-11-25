# Tunti 5

Otimme yhteyden viime tunnilla palvelimelta haettuun potraan `suomioy` tietokantaan _omalla koneella_.

[Edellisen tunnin muistiinpanoista](../tunti-04/muistiinpanot.md) löydät ohjeet kannan pystyttämiseksi omalle koneelle, jos sinulla ei sitä tässä kohtaa onnistuneesti ole.

```console
opiskelija@bar:~$ psql suomioy
psql (17.0)
Type "help" for help.

suomioy=#
```

## Indeksit

### Mikä on indeksi?

Indeksi on sisällysluettelo / pikahaku kolumneihin. Indeksi kohdistuu aina yhden taulun 1-n kolumniin.

`SELECT last_name, first_name, birthday from person ORDER BY birthday, last_name, first_name ASC LIMIT 30;`

Indeksien kannalta mielenkiintoisimmat kohdat ovat kentät, joihin kohdistuu hakuja `WHERE`-ehdolla tai joita järjestellään. Ilman indeksejä tietokanta joutuu mahdollisesti käymään läpi _koko taulun_, mikä on totta kai sitä raskaampaa ja hitaampaa, mitä enemmän rivejä ja kolumneja taulussa on.

- `CREATE INDEX person_name_idx ON person(last_name, first_name);`
- `CREATE INDEX person_birthday_idx ON person(birthday);`

### Kyselyjen analysointi

Kyselyjen kestoa voi aika usein arvioida mutu-tuntumalla, silmämääräisesti, mutta havaintojen tueksi saa myös dataa. Tietokannat osaavat kysymällä kertoa, mitä aikovat kunkin kyselyn kanssa tehdä.

- https://www.postgresql.org/docs/current/sql-explain.html

- `EXPLAIN SELECT last_name, first_name, birthday from person ORDER BY birthday, last_name, first_name ASC LIMIT 30;`
- `EXPLAIN VERBOSE SELECT last_name, first_name, birthday from person ORDER BY birthday, last_name, first_name ASC LIMIT 30;`
- `EXPLAIN ANALYZE VERBOSE SELECT last_name, first_name, birthday from person ORDER BY birthday, last_name, first_name ASC LIMIT 30;`

Explain-kyselyiden ajaminen ja tulkitseminen (vaatii kokemusta, opettelua ja yritys-erehdys meininkiä) ENNEN JA JÄLKEEN INDEKSIEN LISÄÄMISTÄ kertoo, saavutettiinko tuloksia.

### Indeksien hallinta

Indeksejä hallitaan niiden omilla SQL-käskyillä.

- https://www.postgresql.org/docs/current/sql-createindex.html
- https://www.postgresql.org/docs/current/sql-dropindex.html
- https://www.postgresql.org/docs/current/sql-alterindex.html

### Jotkut kentät ovat indeksejä itsekseen

Primary keyt, foreign keyt ja uniquet (esimerkiksi) ovat jo valmiiksi implisiittisiä indeksejä, joten näihin kolumneihin indeksejä ei tarvitse yleensä lisätä.

### Indeksit: TLDR

- Onko kysely hidas?
  - Ei ole!
    - Kaikki hyvin, jatka matkaa!
  - Kyllä on!
    - Onko where / order by kentissä indeksi?
      - Kyllä on!
        - Tarvitsemme lisäkäsiä.
      - Ei ole
        - Analysoi kyselyt
        - Lisää indeksit (tänne päädytään 99% tapauksista)

## Hakutehtäviä

- Haluan sivutetun listan henkilöiden perustiedoista aakkosjärjestyksessä, 50 ihmistä per sivu.
- Haluan sivutetun listan henkilöiden perustiedoista aakkosjärjestyksessä, 50 ihmistä per sivu, ihmisistä kenellä _ei ole passia_.
- Haluan nämä (ja myöhemmät kyselyt) NOPEASTI, indeksoituna!
- Haluan nähdä 20 vanhimman yhä elossa olevan ihmisen perustiedot.
  - yksinkertainen select riittää, ei toisia tauluja mukana
  - `WHERE deathday IS NULL` saa vielä elossa olevat
- Tietokannassa on `apb` niminen taulu, joka sisältää etsintäkuulutuksia. Haluamme printata "10 etsityintä pahista" julisteen, johon tulee kymmenen vanhinta edelleen voimassa olevaa etsintäkuulutusta. Tarvitsemme julisteeseen ainakin henkilöiden nimet, syntymäajat, etsintäkuulutuksen kuvauksen ja mielellään myös kuvat!
- Onko kaikilla etsintäkuulutetuilla henkilöillä passi vai ei? Jos ei, kuinka monella on / ei ole?

[Esimerkkejä näiden tehtävien ratkaisusta](./examples.sql)

## Ryhmittely

- Haluan listan 20 harvinaisimmasta / yleisimmästä sukunimestä / etunimestä, mukana lukumäärätieto siitä kuinka monta kertaa nimi esiintyy.

Tietokannat osaavat ns. aggregaattifuntioita, jotka kasaavat monista rivistä yhden rivin (`COUNT`, `AVERAGE`). Countilla saamme rivien lukumäärät.

Kun käytämme aggregaattifunktioita yhdessä "tavallisten" kolumnien aknssa, meidän täytyy _groupata_ `GROUP BY`-lausekkeella niin, että normit ja aggregaatit ovat omilla puolillaan.

`AS` nimeää kolumnin uudelleen tuloksia ajatellen. Se tekee usein aggregaattien käytöstä mukavampaa.

- `SELECT last_name, COUNT(last_name) AS amount FROM person GROUP BY last_name ORDER BY amount DESC;`
- `SELECT first_name, COUNT(first_name) AS amount FROM person WHERE sex = 'f' GROUP BY first_name ORDER BY amount DESC;`

## Elokuvatietokanta

Opettajalta loppui materiaali kesken, hän oli aliarvioinut oppilaansa. Niinpä siirryimme täysin sulavasti seuraavaan aiheeseen, suunnittelemaan parempaa elokuvatietokantaa IMDB:n ja TheMovieDB:n tilalle.

Käytimme 45 minuuttia pohdiskellen [TheMovieDB](https://www.themoviedb.org/):tä surffaten, minkälaisia tauluja ja kolumneja meillä voisi olla.

[Saavutimme joitakin tuloksia](./movies.sql), ja jatkamme tästä ensi tunnilla!
