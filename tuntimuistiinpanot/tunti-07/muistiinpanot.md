# Tunti 7

## Lähdekoodi

Jos olit poissa tai haluat tarkastella minun tekelettäni, [oma versioni päivän koodauksesta](./nodejs-harjoitus/) auttaa.

## Web servicet

Tuntimme teema: SQL:n soveltaminen ihan oikeassa rajapinnassa (as in API).

Selain puhuu HTTP:tä, HTML:ää, CSS:ää, JavaScriptiä ja JSONia HTTP-palvelimen kanssa. Palvelin (toteutettavissa millä tahansa soveltuvalla ohjelmointikielellä, kuten C# tai JavaScript / TypeScript) puhuu SQL:ää tietokannan kanssa, jonkun _kirjaston_ välityksellä.

Rajapinnat, joiden kanssa selain keskustelee, ovat tyypillisesti ns. "Restful"- tai pikemminkin JSON-rajapintoja. Joskus ne voivat olla jotain muutakin, vaikkapa GraphQL-rajapintoja, mutta nämä edistyneet tiedot ja taidot rakentuvat "perus" rajapintojen päälle, joten suosittelen vahvasti sisäistämään ne ensin.

Jos joskus kuulette sanoja "XML" ja / tai "SOAP", tiedätte, että kyseessä on pankki- tai vakuutustoiminta, ja juoksette toiseen suuntaan. Nämä ovat tosi vanhoja juttuja, joihin vielä joskus törmäilee!

Tässä vähän sekalaista luettavaa aiheesta!

- https://en.wikipedia.org/wiki/Web_service
- https://en.wikipedia.org/wiki/REST
- https://jsonapi.org/
- https://graphql.org/
- https://en.wikipedia.org/wiki/SOAP

## HTTP

Jokaisessa ohjelmointikielessä löytyy lähes samanlaisia kirjastoja / frameworkkeja, joiden päälle lähteä rakentamaan rajapintatoteutusta.

Näiden kirjastojen / kehysten tarkoituksena on tehdä eri HTTP-verbien ja URLien vastaanotto ja käsittely helpoksi. Tämä tarve (ota vastaan erilaisia HTTP-pyyntöjä ja vastaa niihin) on webbikehityksen kova ydin. Siihen tiivistyy pohjimmiltaan lopulta se, mitä teemme.

HTTP-protokollan ymmärtäminen on sitä tärkeämpää, mitä pidemmälle etenette. Kannattaa siis lähteä liikkeelle sen kanssa hyvissä ajoin, eli eilen!

- https://en.wikipedia.org/wiki/HTTP
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers
- https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

## JavaScript-framewörkit

JavaScriptissä [Express](https://expressjs.com/)-niminen ohjelmistokehys on ollut de facto standardi viimeisen 15+ vuoden ajan. Siihen törmäätte työelämässä aivan varmasti.

Opetusta helpottaaksemme me käytimme vähän modernimpaa [Fastify](https://fastify.dev/)-ohjelmistokehystä. Se on pienet erot poislukien toiminnalisuudeltaan identtinen Expressin kanssa.

- `npm install fastify`

## Kehitysympäristö

- `package.json` tiedostossa on kohta `scripts`. Sinne esikoodataan JS-hankkeissa erilaisia kehityksessä / julkaisussa / niin edespäin tarvittavia ajettavia scribuloita.

Me koodasimme omaan package.jsoniimme `dev`-komennon, joka tappaa prosessin ja käynnistää http-serverimme uudelleen aina, kun teemme koodiimme (index.js) muutoksia.

## Ihmisrajapinta

Koodasimme rajapinnan isoon 3.000.000 rivin ihmistietokantaamme.

- `GET /` on "hello world" tyylinen kokeilu.
- `GET /person?page=:page` palauttaa _sivutetun_ listan (sivutus LIMIT ja OFFSET avulla)
- `GET /person/:id` palauttaa yksittäisen ihmisen tiedot
- `DELETE /person/:id` tuhoaa yksittäisen ihmisen kannasta.

### Muut kuin GET-verbit

Selaimen osoitepalkkiin kirjoitetuilla osoitteella voi tehdä vain `GET`-pyyntöjä. Muiden pyyntöjen tekemiseksi / testaamiseksi tarvitaan joko koodausta selaimessa tai työkaluja, joilla rajapintakutsuja voi tehdä.

[Postman](https://www.postman.com/) on hyvä työkalu rajapintojen kanssa työskentelyyn. Sen saa monissa muodoissa, joko sovelluksena tai VSCode-lisärinä (mitä en tiennyt!). Asensimme VSCode-lisäosan, ja se toimi kohtuullisesti.

Testasimme Postmanin avulla DELETE-kutsun tekemistä rajapintaamme vasten.

## Migraatiot

Puhuin tietokantamigraatioista, ja tein pienen koodaus-show'n minulle ennestään tuntemattomilla työkaluilla. Koodit löydät alun linkistä.

Migraatiot ovat todellisen ohjelmistokehityksen / projektien toistuva todellinen tarve. Aiheeseen kannattaa perehtyä.

- https://en.wikipedia.org/wiki/Schema_migration
- https://en.wikipedia.org/wiki/Schema_migration
