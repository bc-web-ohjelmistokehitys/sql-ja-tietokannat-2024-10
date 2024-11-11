/* example */

SELECT student.id AS student_id,
course.name, student.last_name, student.first_name,
grade.grade
FROM grade
JOIN student ON (grade.student_id = student.id)
JOIN course ON (grade.course_id = course.id)
WHERE grade.grade = 'S+';

/* example 2 */

SELECT student.last_name, student.first_name, course.name, grade.grade
FROM studentgroup
JOIN student ON (student.studentgroup_id = studentgroup.id)
JOIN course ON (course.studentgroup_id = studentgroup.id)
LEFT JOIN grade ON (grade.course_id = course.id
     AND grade.student_id = student.id)
WHERE studentgroup.name = 'Testiryhmä'
    AND course.name = 'SQL ja tietokannat'
ORDER BY student.last_name, student.first_name
;