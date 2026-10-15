
--1. Muestra estudiantes y sus cursos asignados

SELECT e.nombre_estudiante, c.nombre_curso, c.horario_curso
FROM Estudiantes e
INNER JOIN Estudiantes_has_Cursos ehc ON e.id_estudiante = ehc.id_estudiante
INNER JOIN cursos c ON ehc.id_curso = c.id_curso
ORDER BY e.nombre_estudiante;

--2. muestra que curso y en que horario se imparten en las aulas
SELECT  a.nombre_aula, c.nombre_curso, c.horario_curso
FROM aulas a
LEFT JOIN cursos c ON a.id_aula = c.id_aula
ORDER BY a.nombre_aula;

--3. Muestra a los docentes y los cursos que imparten
SELECT d.nombre_docente, c.nombre_curso
FROM docentes d
INNER JOIN cursos_has_docentes chd ON d.id_docente = chd.id_docente
INNER JOIN cursos c ON chd.id_curso = c.id_curso;

--4. Estudiantes inscritos por curso
SELECT c.nombre_curso, COUNT(ehc.id_estudiante) AS total_estudiantes
FROM cursos c
LEFT JOIN Estudiantes_has_Cursos ehc ON c.id_curso = ehc.id_curso
GROUP BY c.id_curso, c.nombre_curso;

--5. Muestra el resultado como en la tabla del inciso, todos los estudiantes con sus cursos, profesores, aula y horario
SELECT e.nombre_estudiante, c.nombre_curso, d.nombre_docente, a.nombre_aula, c.horario_curso
FROM Estudiantes e
INNER JOIN Estudiantes_has_Cursos ehc ON e.id_estudiante = ehc.id_estudiante
INNER JOIN cursos c ON ehc.id_curso = c.id_curso
INNER JOIN aulas a ON c.id_aula = a.id_aula
INNER JOIN cursos_has_docentes chd ON c.id_curso = chd.id_curso
INNER JOIN docentes d ON chd.id_docente = d.id_docente