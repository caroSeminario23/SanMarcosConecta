
CREATE TABLE Administrativo
(
  id_administrativo integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_persona        integer NOT NULL,
  id_cargo          integer NOT NULL,
  activo            boolean NOT NULL DEFAULT true,
  PRIMARY KEY (id_administrativo)
);

CREATE TABLE Asistencia_admin
(
  id_asistencia_admin integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_jornada          integer   NOT NULL,
  fecha_marcado       timestamp NOT NULL,
  marcada             bool      NOT NULL DEFAULT false,
  PRIMARY KEY (id_asistencia_admin)
);

CREATE TABLE Asistencia_doc
(
  id_asistencia_doc integer   NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_seccion        integer   NOT NULL,
  fecha_marcado     timestamp NOT NULL,
  marcada           boolean   NOT NULL DEFAULT false,
  PRIMARY KEY (id_asistencia_doc)
);

CREATE TABLE Asistencia_est
(
  id_asistencia_est integer   NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_seccion        integer   NOT NULL,
  id_estudiante     integer   NOT NULL,
  fecha_marcado     timestamp NOT NULL,
  marcada           boolean   NOT NULL DEFAULT false,
  PRIMARY KEY (id_asistencia_est)
);

CREATE TABLE Aula
(
  id_aula      integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre       varchar(50) NOT NULL UNIQUE,
  id_pabellon  integer     NOT NULL,
  n_piso       integer     NOT NULL,
  id_tipo_aula integer     NOT NULL,
  coordenadas  point       NOT NULL,
  capacidad    integer     NOT NULL,
  aforo_actual integer     NOT NULL DEFAULT 0,
  PRIMARY KEY (id_aula)
);

CREATE TABLE Cargo
(
  id_cargo integer      NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre   varchar(150) NOT NULL UNIQUE,
  PRIMARY KEY (id_cargo)
);

CREATE TABLE Curso
(
  id_curso integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre   varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (id_curso)
);

CREATE TABLE Dia
(
  id_dia integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (id_dia)
);

CREATE TABLE Docente
(
  id_docente integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_persona integer NOT NULL,
  activo     boolean NOT NULL DEFAULT true,
  PRIMARY KEY (id_docente)
);

CREATE TABLE Estudiante
(
  id_estudiante integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_persona    integer NOT NULL UNIQUE,
  n_ciclo       integer NOT NULL,
  egresado      boolean NOT NULL DEFAULT false,
  PRIMARY KEY (id_estudiante)
);

CREATE TABLE Jornada
(
  id_jornada        integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_administrativo integer NOT NULL,
  id_dia            integer NOT NULL,
  hora_inicio       time    NOT NULL,
  hora_fin          time    NOT NULL,
  PRIMARY KEY (id_jornada)
);

CREATE TABLE Pabellon
(
  id_pabellon integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre      varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (id_pabellon)
);

CREATE TABLE Persona
(
  id_persona         integer      NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_usuario         integer      NOT NULL,
  cod_identificacion varchar(8)   NOT NULL,
  doc_identificacion varchar(9)   NOT NULL,
  nombres            varchar(100) NOT NULL,
  apellidos          varchar(150) NOT NULL,
  fec_nacimiento     date         NOT NULL,
  n_celular          varchar(12)  NOT NULL,
  genero             char(1)      NOT NULL,
  PRIMARY KEY (id_persona)
);

COMMENT ON COLUMN Persona.doc_identificacion IS 'dni o carnet de extranjería';

COMMENT ON COLUMN Persona.genero IS 'M o F';

CREATE TABLE Reserva
(
  id_reserva  integer NOT NULL GENERATED ALWAYS AS IDENTITY,
  id_aula     integer NOT NULL,
  id_persona  integer NOT NULL,
  id_dia      integer NOT NULL,
  hora_inicio time    NOT NULL,
  hora_fin    time   ,
  PRIMARY KEY (id_reserva)
);

COMMENT ON COLUMN Reserva.hora_fin IS 'salida del aula';

CREATE TABLE Seccion
(
  id_seccion  integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre      varchar(20) NOT NULL UNIQUE,
  id_curso    integer     NOT NULL,
  id_aula     integer     NOT NULL,
  id_docente  integer     NOT NULL,
  id_dia      integer     NOT NULL,
  hora_inicio time        NOT NULL,
  hora_fin    time        NOT NULL,
  PRIMARY KEY (id_seccion)
);

CREATE TABLE Tipo_aula
(
  id_tipo_aula integer     NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre       varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (id_tipo_aula)
);

CREATE TABLE Tipo_usuario
(
  id_tipo_usuario integer      NOT NULL GENERATED ALWAYS AS IDENTITY,
  nombre          varchar(100) NOT NULL UNIQUE,
  PRIMARY KEY (id_tipo_usuario)
);

CREATE TABLE Usuario
(
  id_usuario      integer      NOT NULL GENERATED ALWAYS AS IDENTITY,
  email           varchar(100) NOT NULL,
  contrasenia     varchar(255) NOT NULL,
  id_tipo_usuario integer      NOT NULL,
  PRIMARY KEY (id_usuario)
);

ALTER TABLE Usuario
  ADD CONSTRAINT FK_Tipo_usuario_TO_Usuario
    FOREIGN KEY (id_tipo_usuario)
    REFERENCES Tipo_usuario (id_tipo_usuario);

ALTER TABLE Persona
  ADD CONSTRAINT FK_Usuario_TO_Persona
    FOREIGN KEY (id_usuario)
    REFERENCES Usuario (id_usuario);

ALTER TABLE Estudiante
  ADD CONSTRAINT FK_Persona_TO_Estudiante
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona);

ALTER TABLE Seccion
  ADD CONSTRAINT FK_Curso_TO_Seccion
    FOREIGN KEY (id_curso)
    REFERENCES Curso (id_curso);

ALTER TABLE Seccion
  ADD CONSTRAINT FK_Aula_TO_Seccion
    FOREIGN KEY (id_aula)
    REFERENCES Aula (id_aula);

ALTER TABLE Asistencia_est
  ADD CONSTRAINT FK_Seccion_TO_Asistencia_est
    FOREIGN KEY (id_seccion)
    REFERENCES Seccion (id_seccion);

ALTER TABLE Docente
  ADD CONSTRAINT FK_Persona_TO_Docente
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona);

ALTER TABLE Seccion
  ADD CONSTRAINT FK_Dia_TO_Seccion
    FOREIGN KEY (id_dia)
    REFERENCES Dia (id_dia);

ALTER TABLE Seccion
  ADD CONSTRAINT FK_Docente_TO_Seccion
    FOREIGN KEY (id_docente)
    REFERENCES Docente (id_docente);

ALTER TABLE Aula
  ADD CONSTRAINT FK_Pabellon_TO_Aula
    FOREIGN KEY (id_pabellon)
    REFERENCES Pabellon (id_pabellon);

ALTER TABLE Aula
  ADD CONSTRAINT FK_Tipo_aula_TO_Aula
    FOREIGN KEY (id_tipo_aula)
    REFERENCES Tipo_aula (id_tipo_aula);

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Aula_TO_Reserva
    FOREIGN KEY (id_aula)
    REFERENCES Aula (id_aula);

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Persona_TO_Reserva
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona);

ALTER TABLE Administrativo
  ADD CONSTRAINT FK_Cargo_TO_Administrativo
    FOREIGN KEY (id_cargo)
    REFERENCES Cargo (id_cargo);

ALTER TABLE Jornada
  ADD CONSTRAINT FK_Dia_TO_Jornada
    FOREIGN KEY (id_dia)
    REFERENCES Dia (id_dia);

ALTER TABLE Asistencia_admin
  ADD CONSTRAINT FK_Jornada_TO_Asistencia_admin
    FOREIGN KEY (id_jornada)
    REFERENCES Jornada (id_jornada);

ALTER TABLE Jornada
  ADD CONSTRAINT FK_Administrativo_TO_Jornada
    FOREIGN KEY (id_administrativo)
    REFERENCES Administrativo (id_administrativo);

ALTER TABLE Administrativo
  ADD CONSTRAINT FK_Persona_TO_Administrativo
    FOREIGN KEY (id_persona)
    REFERENCES Persona (id_persona);

ALTER TABLE Asistencia_est
  ADD CONSTRAINT FK_Estudiante_TO_Asistencia_est
    FOREIGN KEY (id_estudiante)
    REFERENCES Estudiante (id_estudiante);

ALTER TABLE Asistencia_doc
  ADD CONSTRAINT FK_Seccion_TO_Asistencia_doc
    FOREIGN KEY (id_seccion)
    REFERENCES Seccion (id_seccion);

ALTER TABLE Reserva
  ADD CONSTRAINT FK_Dia_TO_Reserva
    FOREIGN KEY (id_dia)
    REFERENCES Dia (id_dia);
