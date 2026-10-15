DROP DATABASE IF EXISTS universidad;
 
CREATE  DATABASE IF NOT EXISTS universidad;

USE universidad;


CREATE TABLE aulas (
    id_aula INT PRIMARY KEY AUTO_INCREMENT,
    nombre_aula VARCHAR(100) NOT NULL
);


CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(200) NOT NULL,
    horario_curso VARCHAR(200) NOT NULL,
    id_aula INT,
    FOREIGN KEY (id_aula) REFERENCES aulas(id_aula)
);


CREATE TABLE docentes (
    id_docente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_docente VARCHAR(200) NOT NULL

);

CREATE TABLE cursos_has_docentes (
    id_curso_has_docente INT PRIMARY KEY AUTO_INCREMENT,
    id_curso INT,
    id_docente INT,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso),
    FOREIGN KEY (id_docente) REFERENCES docentes(id_docente)
);

CREATE TABLE Estudiantes_has_Cursos (
    id_estudiante_has_curso INT PRIMARY KEY AUTO_INCREMENT,
    id_estudiante INT,
    id_curso INT,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE Estudiantes (
    id_estudiante INT PRIMARY KEY AUTO_INCREMENT,
    nombre_estudiante VARCHAR(200) NOT NULL
);

