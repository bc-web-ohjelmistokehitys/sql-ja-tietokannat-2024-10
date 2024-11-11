# Tunti 3

## "Lopputyö"

Kerroin aluksi, mitä odotan kurssin "lopputyönä", jonka jälkeen saatte suoritusmerkinnän.

- Laitan Itslearningiin lähiviikkoina kotitehtävän "Lopputyö"-nimellä. Palautus tapahtuu sitä kautta, kirjanpidollisista syistä.
- Odotan palautuksena linkkiä Github-repositorioon. Repo voi olla julkinen (mieluiten) tai käyttäjäni (pekkis) voi kutsua sinne kollaboraattoriksi.
- Repositorio pitää sisällään tietokantaprojektin, tavalla tai toisella.
  - Readme, joka kertoo minulle, mistä on kysymys.
  - SQL:ää. Tietokantaschema, tiedon lisäykset, esimerkkikyselyitä.
  - Voi sisältää myös koodia / toimivaa softaa. Olen avoin formaatille!
  - Kaikkea, mitä tarvitsette / haluatte käyttää, ette vielä välttämättä osaa, mutta avatkaa aivonne tälle.

## Käteviä psql-shell työkaluja

Työelämässä joutuu, ainakin uusiin projekteihin mennessään, tekemisiin uusien ja tuntemattomien tietokantojen kanssa. Muuten tietokannan sisältämien asioiden (taulut jne) tietojen tutkailu on hyödyllistä. `\d` käsky eri variaatioineen auttaa!

- https://www.postgresql.org/docs/8.3/app-psql.html

- `\d` näyttää kaikki taulut, viewit (TODO) ja sekvenssit (juoksevat id:t, pääasiassa!)
- `\d taulunnimi` sukeltaa syvemmälle, näyttää taulun kolumnit.

## Tietokannan suunnittelun jatkoa

Suunnittelimme ja kirjoitimme jatkoa koulutietokannallemme. Asiakas toivoo, että saitti on linjalla kuukauden päästä, jotta Wilma voidaan korvata meidän tekemällämme prototyypillä.

[Kirjoitimme SQL:llä rakenteen seuraaville tauluille](./school.sql):

- opettaja
- kurssi
- arvostelu

Lisäsimme dataa (opettaja, kurssi kummallekin ryhmälle, ja arvosanoja).

Olemme nyt mallintaneet ainakin kahdenlaisia relaatioita: 1-N (yksi-moneen) ja N-M (moni-moneen, **välitaulun** avulla). Olen puhunut 1-1 (yksi-yhteen) relaatiosta, ja luvannut keksiä jonkun todellisen elämän esimerkin. Muita relaatiota ei relaatiotietokannassa ole, ainoastaan näiden kolmen variaatioita.

Kun olimme saaneet rakenteemme ja muutaman testirivin kirjoitettua, kirjoitimme ensimmäisen monesta taulusta tietoa hakevan kyselyn käyttämällä JOINia. [Siitä tuli aika monimutkainen](./example-queries.sql), mutta ei huolta, harjoitus tekee mestarin.

- https://en.wikipedia.org/wiki/Join_(SQL)

Jos haluaa pohdiskella eri joineja (meille tärkeitä perustasolla ovat "normaali" JOIN eli INNER JOIN ja LEFT JOIN sekä RIGHT JOIN) visuaalisesti, kollegani neuvoivat minua [venn-diagrammien](https://www.lucidchart.com/pages/tutorial/venn-diagram) pariin. Tässä venn-diagrammi JOINeista.

https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/

## Rakenteen suunnittelun säännöistä

Puhuin _tietokannan normalisoinnista_, joka on tarkkaan määritelty määrämuotoinen tapa taulujen rakenteen parantamiseksi. Se vähentää toistoa. Käytännössä vai muutamalla ensimmäisellä ns. normaalimuodolla (about boyce-coddiin asti) on merkitystä, ja useimmiten taulujen suunnittelu on aika intuitiivista ja käytännönläheistä vs. teoreettista.

- https://fi.wikipedia.org/wiki/Tietokannan_normalisointi

## Koodista visuaaliseen editoriin

Ensimmäisellä tunnilla exporttasimme visuaalisesta [DrawSQL](https://drawsql.app/) appiksesta ulos SQL:ään. Nyt kokeilimme importtaa käsin kirjoittamamme SQL:n visuaaliseksi diagrammiksi. Se toimi!

Itse valitsemiemme työkalujen käyttö on aina enemmän OK, kunhan ymmärtää tehtävän asian syvemmältä niin, ettei ole työkalun varassa! Joten valitkaa työkalunne aina vapaasti sen jälkeen kun ymmärrätte tehtävn asian riittävän hyvin "raa'alla" tasolla!
