-- CREACION DE LAS TABLAS DE LA BASE DE DATOS ACADEMIA
-- por Manel Montero.
-- para Oracle 19c


-- Creación del usuario
create user usu_academia identified by usu_academia;
grant all privileges to usu_academia;
connect usu_academia/usu_academia;
-- Cuidado que estamos poniendo la contraseña aqui escrita !!!!


-- DESTRUCCION DE TABLAS
-- Para destruir, primero las hijas y luego las madres
drop table alumnos_cursos;
drop table cursos;
drop table alumnos;
drop table provincias;

-- CREACION DE TABLAS
-- Para crear, primero las madres y luego las hijas

-- Voy a crear la tabla de provincias 
create table provincias(
   idprovincia integer NOT NULL,
   provincia varchar2(30) NOT NULL, 
   PRIMARY KEY (idprovincia)
 );
 
-- Voy a crear la tabla de alumnos

create table alumnos(
   idalumno integer NOT NULL,
   nombre varchar2(30) NOT NULL,
   apellido varchar2(30) NOT NULL,
   idprovincia integer NOT NULL,
   PRIMARY KEY (idalumno),
   CONSTRAINT FK_PROVINCIA FOREIGN KEY (idprovincia) REFERENCES provincias (idprovincia)
 );


-- Voy a crear la tabla de cursos
create table cursos(
   idcurso integer NOT NULL,
   nomcurso varchar2(30) NOT NULL,
   horas number(3) NOT NULL,
   PRIMARY KEY (idcurso)
 );


-- Creo la tabla hija alumnos-cursos
create table alumnos_cursos(
   idalumno integer NOT NULL,
   idcurso integer NOT NULL,
   nota number(4,2),
   PRIMARY KEY (idalumno, idcurso),
   CONSTRAINT FK_ALUMNO FOREIGN KEY (idalumno) REFERENCES alumnos (idalumno),
   CONSTRAINT FK_CURSO  FOREIGN KEY (idcurso)  REFERENCES cursos (idcurso)
 );
