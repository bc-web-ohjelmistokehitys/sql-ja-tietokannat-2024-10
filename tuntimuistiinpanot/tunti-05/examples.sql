/* etsintäkuulutukset */

SELECT
    person.last_name,
    person.first_name,
    image.url,
    apb.issue_date,
    apb.status
FROM person
JOIN
    apb ON(person.id = apb.person_id)
LEFT JOIN 
    passport ON(person.id = passport.person_id)
JOIN
    image ON (passport.passport_image_id = image.id)
WHERE
    apb.status = 'open'
ORDER BY
    issue_date ASC
LIMIT 10;

/* vanhimmat elossaolevat */

SELECT
    last_name,
    first_name,
    birthday
FROM
    person
WHERE
    deathday IS NULL
ORDER BY
    birthday ASC
LIMIT 10
;


/* onko kaikilla etsintäkuulutettavilla passi? */

SELECT COUNT(apb.id)
FROM apb
JOIN person ON (apb.person_id = person.id)
LEFT JOIN passport ON (person.id = passport.person_id)
WHERE passport.id IS NULL;


/* passittomien aakkosjärjestys */

SELECT
    person.id,
    person.last_name,
    person.first_name,
    person.gender,
    person.sex
FROM person
LEFT JOIN
    passport ON (person.id = passport.person_id)
WHERE
    passport.id IS NULL
ORDER BY
    last_name, first_name
LIMIT 50
OFFSET 0
;
