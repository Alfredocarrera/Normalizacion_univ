INSERT INTO docentes (nombre_docente) VALUES 
('Carlos Gómez'), 
('María Martínez'), 
('José Rodríguez');

INSERT INTO aulas (nombre_aula) VALUES 
('Aula 101'), 
('Aula 102'), 
('Aula 103');

INSERT INTO cursos (nombre_curso, horario_curso, id_aula) VALUES 
('Algoritmos', 'martes 10-12', 1 ),
('Redes', 'martes 14-16', 2 ),
('Bases de Datos', 'martes 8-10', 3);

INSERT INTO estudiantes (id_estudiante, nombre_estudiante) VALUES 
(1, 'Juan Pérez'),
(2, 'María Gómez'),
(3, 'Luis Ramírez'),
(4, 'Ana Morales'),
(5, 'Laura Rodríguez'),
(6, 'Daniel Hernández'),
(7, 'Carolina Sánchez'),
(8, 'Mario López');

INSERT INTO estudiantes_has_curso (id_estudiante, id_curso) VALUES 
(1, 1), 
(2, 1),
(3, 2),
(4, 2), 
(5, 3), 
(6, 1),
(7, 2), 
(8, 3);

INSERT INTO cursos_has_docentes (id_docente, id_curso) VALUES 
(1, 1), 
(1, 1),
(2, 2),
(2, 2), 
(3, 3), 
(1, 1),
(2, 2), 
(3, 3);