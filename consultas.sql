-- Consultas con la BBDD de academia (ejercicio09)
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1
-- TOCAMOS/ AÑADIMOS ESTA LINEA EN RAMA 1

-- Mostrar PROVINCIAS, ALUMNOS, CURSOS, ALUMNOS_CURSOS
select * from alumnos;
select * from cursos;
select * from provincias;
select * from alumnos_cursos;


-- Cuantos registros hay de cada tabla?
select count(*) from alumnos;
select count(*) from cursos;
select count(*) from provincias;
select count(*) from alumnos_cursos;


-- Cuantos registros hay "CON UN TITULO"
select count(*) as "CUANTOS ALUMNOS HAY" from alumnos;
select count(*) as "CUANTOS CURSOS HAY" from cursos;
select count(*) as "CUANTAS PROVINCIAS HAY" from provincias;
select count(*) as "CUANTOS ALUMNOS_CURSOS HAY" from alumnos_cursos;


-- order by
-- LISTA DE ALUMNOS "ORDENADA" POR APELLIDO Y NOMBRE
-- PEDIMOS LOS CAMPOS "APELLIDO, NOMBRE, IDALUMNO"

select apellido, nombre, idalumno
from alumnos
order by apellido ASC, nombre ASC;


-- JOIN
-- Listado de alumnos
-- Todos los campos de Alumnos y Provincias

select *
from alumnos inner join provincias
on alumnos.idprovincia = provincias.idprovincia;

-- JOIN pero solo con NOMBRE, APELLIDO y PROVINCIA

select 	alumnos.nombre,
		alumnos.apellido,
		provincias.provincia
from provincias inner join alumnos
on provincias.idprovincia = alumnosa.idprovincia;



-- LEFT JOIN pero solo con NOMBRE, APELLIDO y PROVINCIA
-- Para detectar SOLO las provincias SIN ALUMNOS

select 	alumnos.nombre,
		alumnos.apellido,
		provincias.provincia
from provincias left join alumnos
on provincias.idprovincia = alumnos.idprovincia
where apellido is null;


-- RIGHT JOIN pero solo con NOMBRE, APELLIDO y PROVINCIA
-- Para detectar LOS ALUMNOS HUERFANOS
-- En nuestro caso sale VACIO (EMPTY) porque no hay huérfanos

select 'ALUMNOS HUERFANOS' from dual;

select 	alumnos.nombre,
		alumnos.apellido,
		provincias.provincia
from provincias right join alumnos
on provincias.idprovincia = alumnos.idprovincia
where provincia is null;


-- AGRUPACION DE RESULTADOS CON GROUP BY
-- Permite agrupar los resultados por CATEGORIAS

-- Vamos a buscar los apellidos repetidos de los alumnos
-- Mostrar cuantos alumnos hay por cada apellido

select		apellido, count(*)
from		alumnos
group by	apellido;


-- Vamos a obtener el numero de alumnos de Cada Provincia
-- Agrupamos por IDPROVINCIA

select   idprovincia, count(*)
from	 alumnos
group by idprovincia;

-- Queremos obtener el numero de alumnos de cada provincia
-- Pero la Provincia en LETRAS 
--  Salida:       PROVINCIA    NUMERO_DE_ALUMNOS

-- alumnos   provincia
-- Sacamos cuantos alumnos hay en cada provincia

select provincia, count(*)
from alumnos inner join provincias
on provincias.idprovincia = alumnos.idprovincia
group by provincia
order by provincia;



-- Vamos a completar/join la tabla 
-- ALUMNOS_CURSOS con CURSOS

select *
from cursos inner join alumnos_cursos
on cursos.idcurso= alumnos_cursos.idcurso;

-- Vamos a completar/join la tabla alumnos_cursos
-- con ALUMNOS


-- FINALMENTE HACEMOS JOIN DE LAS TRES TABLAS
-- CURSOS ALUMNOS_CURSOS y ALUMNOS

select *
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno;



-- INFORME FINAL COMPACTO con CURSO, ALUMNO y NOTA





-- INFORME FINAL COMPACTO con CURSO, ALUMNO y NOTA
-- Ordenado por curso, apellido, nombre


-- INFORME FINAL con los 4 JOINS
select *
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno
			inner join provincias     on alumnos.idprovincia = provincias.idprovincia;


-- a PARTIR DEL join DE 4, PODEMOS RESPONDER CUALQUIER PREGUNTA

-- Nombre y apellido de los alumnos que han sacado un 10

select nombre, apellido
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno
			inner join provincias     on alumnos.idprovincia = provincias.idprovincia
where nota=10;

-- Dime NOMBRE, APELLIDO alumnos de Guadalajara que han sacado más de un 7 de NOTA
select nombre, apellido, nota, provincia
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno
			inner join provincias     on alumnos.idprovincia = provincias.idprovincia
where provincia= 'Guadalajara' AND nota>7;

-- Informe de los alumnos de "Redes sociales" ordenados de MAS a menos NOTA
select nombre, apellido, nom_curso, nota
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno
			inner join provincias     on alumnos.idprovincia = provincias.idprovincia
where nom_curso= 'redes sociales'
order by nota DESC;


-- Listado de alumnos de Madrid o Guadalajara 
-- que hayan hecho cursos de MAS DE 100 horas, 
-- ordenados por NOMBRE DESCENDENTE

select distinct(nombre, apellido), provincia, horas
from cursos inner join alumnos_cursos on cursos.idcurso = alumnos_cursos.idcurso
			inner join alumnos        on alumnos_cursos.idalumno = alumnos.idalumno
			inner join provincias     on alumnos.idprovincia = provincias.idprovincia
where provincia in ('madrid','guadalajara')
and horas>100
order by nombre DESC;

