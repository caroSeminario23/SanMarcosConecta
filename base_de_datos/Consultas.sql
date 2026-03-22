select * from administrativo;
select * from asistencia_admin;
select * from aula;
select * from cargo;
select * from curso;
select * from dia;
select * from docente;
select * from estudiante;
select * from jornada;
select * from pabellon;
select * from persona;
select * from tipo_aula;
select * from tipo_usuario;
select * from usuario;






-- Insertar estudiantes
INSERT INTO Estudiante (id_persona, n_ciclo, egresado)
VALUES
    (4, 7, false),
    (5, 7, false);
	
select * from asistencia_admin;	
select * from jornada;

-- Insertar datos en la tabla Asistencia_admin
INSERT INTO Asistencia_admin (id_jornada, fecha_marcado, marcada)
VALUES
    (1, '2024-07-04 07:30:00', true),
    (2, '2024-07-05 13:50:00', true),
    (3, '2024-07-08 08:30:00', true),
    (4, '2024-07-08 13:23:00', true);


select * from persona;

-- Insertar docentes
INSERT INTO Docente (id_persona, activo)
VALUES
    (6, true),
    (7, true);
	

-- Insertar datos en la tabla Administrativo
INSERT INTO Administrativo (id_persona, id_cargo, activo)
VALUES
    (5, 1, true),
    (6, 2, true);
	
	
-- Insertar cargos
INSERT INTO Cargo (nombre)
VALUES
    ('Soporte'),
    ('Secretaría');
	
	
-- Insertar días de la semana
INSERT INTO Dia (nombre)
VALUES
    ('Lunes'),
    ('Martes'),
    ('Miércoles'),
    ('Jueves'),
    ('Viernes'),
    ('Sábado'),
    ('Domingo');


-- Insertar cursos
INSERT INTO Curso (nombre)
VALUES
    ('Inteligencia artificial'),
    ('Internet de las cosas'),
    ('Interacción hombre-computador'),
    ('Formulación y evaluación de proyectos'),
    ('Programación paralela'),
    ('Inteligencia de negocios'),
    ('Desarrollo de sistemas web');


select * from curso;

select * from usuario;


-- Insertar pabellones
INSERT INTO Pabellon (nombre)
VALUES
    ('AP (antiguo pabellón)'),
    ('NP (nuevo pabellón)');


select * from jornada;


-- Insertar datos en la tabla Jornada
INSERT INTO Jornada (id_administrativo, id_dia, hora_inicio, hora_fin)
VALUES
    (5, 4, '08:00:00', '12:00:00'),
    (6, 5, '14:00:00', '18:00:00'),
    (5, 1, '09:00:00', '13:00:00'),
    (6, 1, '14:00:00', '18:00:00');


select * from dia;

select * from administrativo;

select * from persona;

-- Insertar datos en la tabla Administrativo
INSERT INTO Administrativo (id_persona, id_cargo, activo)
VALUES
    (8, 1, true),
    (9, 2, true);
	
	
select * from cargo;
select * from pabellon;
select * from tipo_aula;

-- Insertar datos en la tabla Aula
INSERT INTO Aula (nombre, id_pabellon, n_piso, id_tipo_aula, coordenadas, capacidad, aforo_actual)
VALUES
    ('Aula Magna', 1, 2, 1, '(12.345, -67.890)', 30, 0),
    ('Laboratorio 1', 2, 1, 2, '(12.395, -68.890)', 25, 0),
    ('Aula 109', 1, 1, 1, '(12.360, -70.890)', 33, 0),
    ('Aula 205', 1, 2, 1, '(10.300, -50.890)', 24, 0),
    ('Laboratorio 2', 2, 3, 2, '(11.345, -67.100)', 20, 0);

-- Insertar tipos de aula
INSERT INTO Tipo_aula (nombre)
VALUES
    ('Salón'),
    ('Laboratorio');

