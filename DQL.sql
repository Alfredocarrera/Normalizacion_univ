
--1. Muestra estudiantes y sus cursos asignados

SELECT e.nombre_estudiante, c.nombre_curso, c.horario_curso
FROM Estudiantes e
INNER JOIN Estudiantes_has_Cursos ehc ON e.id_estudiante = ehc.id_estudiante
INNER JOIN cursos c ON ehc.id_curso = c.id_curso
ORDER BY e.nombre_estudiante;


