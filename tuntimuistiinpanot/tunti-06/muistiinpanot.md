# Tunti 6

Opettajalla oli ongelma. Oppilaat ovat koulussa ensimmäisellä jaksolla, ja ovat opetelleet koodaamista vain ja ainoastaan C#-kielellä. JavaScript / TypeScript on vasta tuloillaan.

Opettaja itse taas koodaa päivittäin JavaScriptillä / TypeScriptillä, eikä osaa C#:tä.

Opettaja tahtoi laajentaa pienokaisten tajuntaa sen suhteen, miten kaikki palaset liittyvät toisiinsa. Hän ei halunnut jatkaa SQL:n kirjoittamista "siilossa", tekstitiedostoissa ja PostgreSQL-shellissä. Hän halusi opettaa SQL:n _koodaamista_, koska se on taso, jossa oikeassa elämässä useimmiten työskennellään.

## Historia-luento

Raahasimme oppimiamme sanoja järjestykseen (ylhäältä alas) taululla. Sen jälkeen opettaja piti paasaavan luennon webin historiasta, siitä miten nykytilanteeseen on tultu, ja miksi asiat ovat niin kuin ovat.

Minun on mahdotonta kirjoittaa luentoa auki muistiinpanoihin, koska pidin sen ad hoc. Pidin lopulta osin aika samanlaisen luennon LUTissa aiemmin tänä vuonna, ja se nauhoitettiin, voitte katsoa sen.

- https://www.youtube.com/watch?v=Yf2wQ74t8BA

Lupasin linkkejä muihin tallennettuihin presiksiin, joita olen pitänyt. Tässä niitä:

- https://youtu.be/Mk5sAUc0EB8
- https://youtu.be/OguXQ0zDOko
- https://youtu.be/QKE8Eusvp0I
- https://youtu.be/0Kl7NIE0Eb8
- https://youtu.be/2skRbq4lkl8
- https://youtu.be/Imjqd9JiG_M
- https://youtu.be/ug2jB8SVDCY
- https://www.youtube.com/watch?v=NIpOBV0qvSE

## C#-harjoitus

Opettaja opetteli käyttämään C#:aa sen verran, että saimme yhteyden tietokantaan. Nyt oppilaat olivat opettajia, ja he auttoivat opettajaa pystyttämään C#-ympäristön.

Koodasimme [harjoitusprojektia C#:llä](./csharp-harjoitus/).

- Asensimme [Npgsl](https://www.npgsql.org/)-kirjaston [nuget](https://www.nuget.org/)-paketinhallintatyökalulla.
- Otimme yhteyden isoon tietokantaan omalla koneellamme, ja haimme sieltä dataa.
- Opettaja demonstroi SQL-injektion
- Parametrisoitu API ja vahva tyypitys muodostivat opettajalle lähes ylitsepääsemättömän esteen.

### SQL-injektio

Aina kun konkatenoimme käyttäjän syötteitä suoraan SQL:ään, luomme tietoturva-aukon, jonka avulla osaava pahantekijä saa mahdollisesti täyden pääsyn tietokantaamme.

Tyypillisesti injektiohyökkäykset syntyvät URLin kautta.

Tässä kiltti URL ja tuhma URL peräkkäin.

- http://127.0.0.1:5678/person?page=2&sortBy=last_name
- http://127.0.0.1:5678/person?page=2&sortBy=last_name LIMIT 1; DROP TABLE person CASCADE;--

Tarinan opetus: emme **koskaan**, **koskaan** laita mitään suoraan käyttäjän syötteestä sen enempää SQL:ään kuin mihinkään muuhunkaan. Emme luota mihinkään käyttäjän syötteeseen. Validoimme, filtteröimme, escapoimme ja / tai sanitoimme kaikki, mitä saamme suoraan käyttäjältä.

- https://security.stackexchange.com/questions/143923/whats-the-difference-between-escaping-filtering-validating-and-sanitizing

- filtteröinti: otetaan tuhmat merkit pois syötteistä
- escapointi: korvataan erikoismerkit niin että ne eivät ole enää erikoismerkkejä kohdejärjestelmässä
- validointi: tarkistetaan, että käyttäjän syöte on sellaista, kuin sen tulisi olla.
- sanitointi: kaikki edelliset tai osa niistä yhdessä, pidetään huolta siitä ettei käyttäjän syöte saa aikaan mitään odottamatonta!

Tietoturva on tosi tärkeää. Itse olen koodannut urani alkuvaiheessa kuuluisan "SDP-aukon" ison puolueen kotisivulle. Tästä uutisoitiin valtamedioissa. En itse enää silloin ollut samassa paikassa töissä, mutta olin paria vuotta aikaisemmin koodannut tämän röörin. Se oli rehellinen SQL-injektio, kuten teimme tänään.

- https://www.is.fi/digitoday/tietoturva/art-2000001529207.html

Jos et halua olla kuin minä, OWASPin TOP 10 auttaa. Tätä kannattaa seurata aina muutaman vuoden välein, ja koittaa tavata huolellisesti.

- https://owasp.org/www-project-top-ten/

### Käytämme AINA parametrisoituja tietokantakutsuja

Tietokantojen suhteen injektion välttäminen on onneksi tosi helppoa. Käytämme vain ja ainoastaan ns "parametrisoituja" rajapintoja.

Nämä rajapinnat ovat aina vähän erilaisia riippuen ohjelmointikielistä ja käytetyistä kirjastoista, mutta periaate on sama. Kirjasto pitää huolen siitä, että parametrit escapoidaan asianmukaisesti. Luotamme siihen.

- https://cheatsheetseries.owasp.org/cheatsheets/Query_Parameterization_Cheat_Sheet.html

```js
// NAUGHTY NAUGHTY!
const ret = executeSQL(
  `SELECT foo, bar FROM xoo WHERE id = ${olenSqlInjektio}`
);

// YES SIR! I CAN BOOGIE!
const ret = executeSQL(`SELECT foo, bar FROM xoo WHERE id = ?`, [
  injektioEiSatutaMinua,
]);
```

### Node.js-harjoitus

Toteutimme [idun samasta harjoituksesta Node.js:llä](./nodejs-harjoitus/).

- Asensimme Noden [nvm:llä](https://github.com/nvm-sh/nvm).
- Asensimme [pg](https://node-postgres.com/)-kirjaston [npm](https://www.npmjs.com/)-asiakasohjelmalla. Opimme, että "npm" voi tarkoittaa sekä paikkaa, jossa paketit asuvat, että asiakasohjelmaa, jolla paketteja käsiteltiin. [pnpm](https://pnpm.io/) ja [yarn](https://yarnpkg.com/) tekevät saman asian, mutta pnpm tekee sen parhaiten tosielämän hankkeita ajatellen.

Opettaja totesi, että koska [TypeScript](https://www.typescriptlang.org/) on vallannut koko JS-maailman, ei ole mitään syytä olla käyttämättä TypeScriptiä opiskelussa alusta alkaen. Palaamme tähän ensi tunnilla.
