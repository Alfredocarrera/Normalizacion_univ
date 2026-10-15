# Sistema de Gestión de Cursos Universitarios 🎓

**Autores / Diseñadores:** Alfredo Carrera y Mario Villatoro  
**Motor de Base de Datos:** MySQL  
**Estatus del Proyecto:** Implementado y Normalizado (hasta 3FN)

---

## 1. Descripción del Problema Resuelto

El sistema de gestión académica previo de la universidad presentaba serias deficiencias operativas y desorganización al intentar administrar la oferta de cursos, la asignación de docentes, los horarios de impartición y el uso eficiente de las aulas físicas. Esta falta de estructura generaba redundancia de datos, inconsistencias en los registros e imposibilitaba la generación de reportes precisos para la administración escolar.

Para solucionar esta problemática, desarrollamos una arquitectura relacional sólida mediante un proceso formal de **normalización de base de datos hasta la Tercera Forma Normal (3FN)**:

* **Primera Forma Normal (1FN):** Eliminamos grupos repetidos y nos aseguramos de que cada campo contenga valores atómicos (como nombres de estudiantes, asignaturas y salones).
* **Segunda Forma Normal (2FN):** Garantizamos que todos los atributos que no forman parte de una clave primaria dependan de manera funcional y completa de la clave primaria de la tabla.
* **Tercera Forma Normal (3FN):** Eliminamos las dependencias transitivas entre atributos que no sean claves, separando entidades independientes como docentes, aulas y cursos.

Como resultado, la universidad cuenta ahora con un sistema optimizado que evita la duplicidad de datos, facilita la inscripción de estudiantes sin conflictos de información y garantiza la integridad referencial en todo momento.

---

## 2. Modelado de Datos: Tablas, Atributos y Relaciones

El esquema relacional está compuesto por entidades principales y tablas intermedias para la resolución de relaciones complejas. A continuación se detalla la estructura lógica:

### 2.1. Tablas Entidad Principales

1. **`aulas`**: Representa las instalaciones físicas de la institución.
   * **Primary Key:** `id_aula` (INT, Autoincremental).
   * **Atributos:** `nombre_aula` (VARCHAR 100).
2. **`docentes`**: Almacena el personal académico habilitado.
   * **Primary Key:** `id_docente` (INT, Autoincremental).
   * **Atributos:** `nombre_docente` (VARCHAR 200).
3. **`Estudiantes`**: Contiene la información general del alumnado.
   * **Primary Key:** `id_estudiante` (INT, Autoincremental).
   * **Atributos:** `nombre_estudiante` (VARCHAR 200).
4. **`cursos`**: Mantiene la oferta académica actual de la universidad.
   * **Primary Key:** `id_curso` (INT, Autoincremental).
   * **Atributos:** `nombre_curso` (VARCHAR 200), `horario_curso` (VARCHAR 200).
   * **Foreign Key:** `id_aula` (conecta con `aulas.id_aula`).

### 2.2. Tablas Intermedias (Relaciones N:M)

Para resolver las relaciones de **Muchos a Muchos (N:M)** propias del entorno universitario, se crearon dos tablas asociativas:

1. **`Estudiantes_has_Cursos`**:
   * **Primary Key:** `id_estudiante_has_curso` (INT, Autoincremental).
   * **Foreign Keys:** `id_estudiante` (apunta a `Estudiantes`), `id_curso` (apunta a `cursos`).
2. **`cursos_has_docentes`**:
   * **Primary Key:** `id_curso_has_docente` (INT, Autoincremental).
   * **Foreign Keys:** `id_curso` (apunta a `cursos`), `id_docente` (apunta a `docentes`).

### 2.3. Cardinalidad y Diagrama Lógico

* **`aulas` ↔ `cursos` (1:N):** Un aula puede ser asignada a uno o varios cursos en distintos horarios; sin embargo, en este modelo básico cada curso se vincula a una única aula asignada (`1:N`).
* **`Estudiantes` ↔ `cursos` (N:M):** Un estudiante puede inscribirse en múltiples cursos y un curso cuenta con la presencia de múltiples estudiantes. Se resuelve mediante `Estudiantes_has_Cursos`.
* **`docentes` ↔ `cursos` (N:M):** Un docente puede impartir múltiples materias y una materia puede contar con varios docentes asignados en distintas secciones o módulos. Se resuelve mediante `cursos_has_docentes`.

---

## 3. Scripts DDL y DML

### 3.1. Documento DDL (`DDL.sql`)
El archivo DDL (**Data Definition Language**) es el encargado de definir la estructura lógica del sistema en el SGBD MySQL. Ejecuta los siguientes pasos:
1. **Instrucciones de Entorno:** Limpia y crea la base de datos `universidad` si esta existe o no.
2. **Creación de Tablas con Tipos de Datos:** Define tipos de datos como `INT` para identificadores y `VARCHAR` para cadenas de texto, añadiendo restricciones de obligatoriedad (`NOT NULL`).
3. **Restricciones de Integridad:** Define explícitamente las claves primarias (`PRIMARY KEY`) con secuencias autoincrementables y configura las claves foráneas (`FOREIGN KEY`) vinculando correctamente las tablas hijas con las tablas padres.

```sql
-- Ejemplo de código DDL utilizado para la tabla 'cursos'
CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nombre_curso VARCHAR(200) NOT NULL,
    horario_curso VARCHAR(200) NOT NULL,
    id_aula INT,
    FOREIGN KEY (id_aula) REFERENCES aulas(id_aula)
);
```

### 3.2. Documento DML (`DML.sql`)
El archivo DML (**Data Manipulation Language**) contiene las sentencias encargadas de popular la base de datos con información inicial válida. 
* Registra docentes (ej. *Carlos Gómez*, *María Martínez*).
* Registra aulas de clases (ej. *Aula 101*, *Aula 102*).
* Vincula materias con sus horarios y aulas correspondientes (*Algoritmos*, *Redes*, *Bases de Datos*).
* Puebla la lista de estudiantes inscritos y genera las relaciones correspondientes en las tablas asociativas (`Estudiantes_has_Cursos` y `cursos_has_docentes`).

```sql
-- Ejemplo de inserción de datos en DML
INSERT INTO cursos (nombre_curso, horario_curso, id_aula) VALUES 
('Algoritmos', 'martes 10-12', 1),
('Redes', 'martes 14-16', 2),
('Bases de Datos', 'martes 8-10', 3);
```

---

## 4. Explicación Detallada del Script DQL (`DQL.sql`)

El archivo DQL (**Data Query Language**) contiene las consultas requeridas por la administración para extraer información clave. A continuación se explica el funcionamiento paso a paso de cada una:

### Consulta 1: Estudiantes y sus Cursos Asignados
```sql
SELECT e.nombre_estudiante, c.nombre_curso, c.horario_curso
FROM Estudiantes e
INNER JOIN Estudiantes_has_Cursos ehc ON e.id_estudiante = ehc.id_estudiante
INNER JOIN cursos c ON ehc.id_curso = c.id_curso
ORDER BY e.nombre_estudiante;
```
* **Explicación:** Conecta la tabla `Estudiantes` con `cursos` cruzando la tabla intermedia `Estudiantes_has_Cursos`. Retorna el listado alfabético de estudiantes junto a las materias a las que están inscritos y sus respectivos horarios.

### Consulta 2: Horarios de Cursos asignados a cada Aula
```sql
SELECT a.nombre_aula, c.nombre_curso, c.horario_curso
FROM aulas a
LEFT JOIN cursos c ON a.id_aula = c.id_aula
ORDER BY a.nombre_aula;
```
* **Explicación:** Muestra el listado de aulas y la materia asignada. Utiliza un `LEFT JOIN` para asegurar que incluso si un aula no tiene ningún curso asignado, aparezca en el reporte.

### Consulta 3: Relación de Docentes y Cursos Impartidos
```sql
SELECT d.nombre_docente, c.nombre_curso
FROM docentes d
INNER JOIN cursos_has_docentes chd ON d.id_docente = chd.id_docente
INNER JOIN cursos c ON chd.id_curso = c.id_curso;
```
* **Explicación:** Cruza la tabla de `docentes` con `cursos` mediante la tabla de enlace `cursos_has_docentes` para conocer con exactitud qué materia está asignada a cada catedrático.

### Consulta 4: Total de Estudiantes Inscritos por Curso
```sql
SELECT c.nombre_curso, COUNT(ehc.id_estudiante) AS total_estudiantes
FROM cursos c
LEFT JOIN Estudiantes_has_Cursos ehc ON c.id_curso = ehc.id_curso
GROUP BY c.id_curso, c.nombre_curso;
```
* **Explicación:** Emplea la función de agregación `COUNT()` agrupada mediante `GROUP BY` por cada curso. Sirve para calcular la cantidad exacta de alumnos matriculados por materia, identificando clases con alta o baja demanda.

### Consulta 5: Reporte Consolidado Académico
```sql
SELECT e.nombre_estudiante, c.nombre_curso, d.nombre_docente, a.nombre_aula, c.horario_curso
FROM Estudiantes e
INNER JOIN Estudiantes_has_Cursos ehc ON e.id_estudiante = ehc.id_estudiante
INNER JOIN cursos c ON ehc.id_curso = c.id_curso
INNER JOIN aulas a ON c.id_aula = a.id_aula
INNER JOIN cursos_has_docentes chd ON c.id_curso = chd.id_curso
INNER JOIN docentes d ON chd.id_docente = d.id_docente;
```
* **Explicación:** Es la consulta más compleja del sistema. Realiza una combinación múltiple de 6 tablas (`INNER JOIN`) para consolidar en una sola vista toda la información operativa: qué alumno está recibiendo qué materia, quién es el docente a cargo, en qué aula física están ubicados y en qué horario se imparte.

---

## 5. Estructura del Proyecto y Conclusiones

### Estructura de Archivos del Repositorio
```
├── README.md               # Documentación general del proyecto
├── base_universidad.png    # Diagrama Entidad-Relación de la base de datos
├── DDL.sql                 # Script de definición de base de datos y tablas
├── DML.sql                 # Script de inserción de datos de prueba
└── DQL.sql                 # Script con las consultas de información
```

### Conclusión y Mejoras Alcanzadas
La implementación de este nuevo diseño de base de datos relacional representa un avance significativo para la administración de la universidad:

1. **Estructura escalable:** El modelo en 3FN permite añadir en el futuro funcionalidades adicionales como notas, asistencias o semestres sin romper la arquitectura existente.
2. **Eliminación de Redundancia:** Al separar correctamente las aulas, profesores y cursos, se evitan discrepancias en nombres y datos duplicados.
3. **Agilidad en la Toma de Decisiones:** Gracias a los scripts DQL elaborados, las autoridades universitarias pueden obtener estadísticas clave en tiempo real, mejorando la distribución de salones y la carga académica de los docentes.

Desarrollado con éxito por **Alfredo Carrera** y **Mario Villatoro**.