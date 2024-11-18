/*

Kuvat löytyvät tästä 

https://hunajapurkki.pekkis.eu/<polku>.jpg
*/

/*

Haluan tietää oman syntymäpäiväni. Nimeni on "Mikko Forsström" !

Haluan tietää, miltä näytän. Minulla on järjestelmässä passi, ja passilla on passikuva.

Haluan tietää syntymäpäivät ja nimet 10 vanhimmasta Forsström-nimisestä tyypistä tietokannassa, järjestettynä syntymäpäivän mukaan vanhin ensin. Extra: Haluan myös tietää 10 vanhimman mahdollisen passien numerot myös!

Haluan tietää 10 vanhinta vielä elossa olevaa ihmistä kannasta!

*/

SELECT person.last_name, person.first_name, person.birthday,
passport.passport_image_id, image.url
FROM person
JOIN passport ON (person.id = passport.person_id)
JOIN image ON (passport.passport_image_id = image.id)
WHERE person.last_name = 'Forsström' AND person.first_name = 'Mikko';


SELECT id, last_name, first_name, birthday
FROM person
WHERE last_name = 'Forsström'
AND first_name = 'Mikko';

SELECT * FROM passport
WHERE person_id = ?;

SELECT * FROM image
WHERE id = ?;

/*
kolmella erillisellä kyselyllä saatavan tuloksen voi tehdä yhdellä joinilla
 */

SELECT person.last_name, person.first_name, person.birthday, passport.passport_image_id, image.url
FROM person
JOIN passport ON (person.id = passport.person_id)
JOIN image ON (passport.passport_image_id = image.id)
WHERE person.last_name = 'Forsström' AND person.first_name = 'Mikko';


/* null elää ihan omassa ulottuvuudessaan */

SELECT last_name, first_name, birthday, deathday FROM person WHERE deathday IS NULL ORDER BY birthday LIMIT 10;
SELECT last_name, first_name, birthday, deathday FROM person WHERE deathday IS NOT NULL ORDER BY birthday LIMIT 10;



