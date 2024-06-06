

create database "g82_clase_20240109";




--Revisa el tipo de relación y crea el modelo correspondiente. Respeta las claves primarias, foráneas y tipos de datos.


CREATE TABLE "Peliculas" (
"id" Integer,
"nombre" Varchar(255),
"anno" Integer,
PRIMARY KEY ("id")
);

CREATE TABLE "Tags" (
"id" Integer,
"tag" Varchar(32),
PRIMARY KEY ("id")
);

CREATE TABLE "Peliculas/Tags" (
"id_pelicula" Integer,
"id_tag" Integer,
foreign key ("id_pelicula" )
references "Peliculas"("id"),
foreign key ("id_tag" )
references "Tags"("id")
);

--Inserta 5 películas y 5 tags; la primera película debe tener 3 tags asociados, la segunda película debe tener 2 tags asociados.

insert into "Peliculas"
values 
('1','Titanic','1997'),
('2','El Padrino', '1972'),
('3','Avatar', '2009'),
('4','Forrest Gump', '1994'),
('5','La La Land', '2016');

insert into "Tags"
values 
('1','CineClásico'),
('2','Estrenos2016'),
('3','PelículasDeAventuras'),
('4','CineIndie'),
('5','MejoresDocumentales');


insert into "Peliculas/Tags"
values 
('1','1'),
('1','2'),
('1','3'),
('2','4'),
('2','5');

--Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.

select 
a.nombre,
coalesce ( count (b.id_tag),0)


from  "Peliculas" a
left join "Peliculas/Tags" b on a.id = b.id_pelicula

group by (a.nombre)


--Crea las tablas correspondientes respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.


CREATE TABLE "Preguntas" (
"id" Integer,
"pregunta" Varchar(255),
"respuesta_correcta" Varchar,
PRIMARY KEY ("id")
);



CREATE TABLE "Usuarios" (
"id" Integer,
"nombre" Varchar(255),
"edad" Integer,
PRIMARY KEY ("id")
);


CREATE TABLE "Respuestas" (
"id" Integer,
"respuesta" Varchar(255),
"usuario_id" Integer,
"pregunta_id" Integer,

PRIMARY KEY ("id"),
foreign key ("usuario_id" )
references "Usuarios"("id"),
foreign key ("pregunta_id" )
references "Preguntas"("id")
);


--Agrega 5 usuarios y 5 preguntas.


insert into "Preguntas"
values 
('1','¿Cuál es la capital de Francia?','Paris'),
('2','¿Cuántos planetas hay en nuestro sistema solar?', 'Ocho'),
('3','¿Quién escribió "Cien años de soledad"?', 'Gabriel García Márquez'),
('4','¿Cuál es el símbolo químico del agua?', 'clienete'),
('5','¿En qué año se descubrió América?', '1492');


insert into "Usuarios"
values 
('1','Juan','15'),
('2','Pedro', '13'),
('3','Lucas', '12'),
('4','Josefa', '14'),
('5','Andrea', '16');

insert into "Respuestas"
values 
('1','Paris','1', '1'),
('2','Paris', '2', '1'),
('3','Ocho', '3', '2'),
('4','Pablo Neruda', '4', '3'),
('5','NH3', '5', '4');


--Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta).

select
c.nombre,
count(a.id) as Respuestas_Correctas

from "Respuestas" a
left join "Preguntas" b on b.id = a.pregunta_id
left join "Usuarios" c on c.id = a.usuario_id
where b.respuesta_correcta=a.respuesta

group by c.nombre


--Opcion 2

select
c.nombre,

sum(case 
when b.respuesta_correcta=a.respuesta then 1
else 0
end) as Respuestas_Correctas



from "Respuestas" a
left join "Preguntas" b on b.id = a.pregunta_id
left join "Usuarios" c on c.id = a.usuario_id


group by c.nombre


--Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios respondieron correctamente.


select
a.pregunta,
count(c.id) as Usuarios_Respuestas_Correctas

from "Preguntas" a
left join "Respuestas" b on a.id = b.pregunta_id
left join "Usuarios" c on c.id = b.usuario_id
where a.respuesta_correcta=b.respuesta

group by a.pregunta


--Opcion 2

select
a.pregunta,

sum(
case when a.respuesta_correcta=b.respuesta then 1
else 0
end) as Usuario_Respuestas_Correctas

from "Preguntas" a
left join "Respuestas" b on a.id = b.pregunta_id
left join "Usuarios" c on c.id = b.usuario_id

group by a.pregunta

--Implementa un borrado en cascada de las respuestas al borrar un usuario. Prueba la implementación borrando el primer usuario.


alter table "Respuestas" 
drop CONSTRAINT "Respuestas_usuario_id_fkey" ;

alter table "Respuestas" 
add foreign key ("usuario_id" ) references "Usuarios"("id") on delete cascade;

delete from "Usuarios" where id= 1;


select*
from "Usuarios" u 

select*
from "Respuestas"

--Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.

alter table "Usuarios"
add check (edad  >= 18 );

alter table "Usuarios"
drop constraint "Usuarios_edad_check3";



select*
from "Usuarios" u 

update "Usuarios" 
set edad = edad+10


insert into "Usuarios"
values 
('6','Aroldo','15');



--Altera la tabla existente de usuarios agregando el campo email. Debe tener la
restricción de ser único.


alter table "Usuarios"
ADD column "email" varchar(255),  
add unique("email");


select*
from "Usuarios" u 

update "Usuarios" 
set email = 'pedro@ds.cl'
where id=2

update "Usuarios" 
set email = 'pedro@ds.cl'
where id=3















create table usuariosp1 (
id int primary key,
nombre varchar(32),
edad integer
);


drop table usuariosp1 






insert into usuariosp1 
values 
('1','Consuelo','27'),
('2','Consuelo', '32'),
('3','Francisco', '27');


delete from usuariosp1 

select*
from usuariosp1 


insert into usuariosp1 
values 
('Consuelo', '1'),
('Consuelo', '2'),
('Francisco', '3');




update usuariosp1 

set edad = 29

where edad = 27

select*
from usuariosp1 u 



alter table usuariosp1 

add column  id  integer;

delete from usuariosp1
where nombre is null


update usuariosp1 

set id= 1

create table pagos 
(
id int primary key,
monto integer,
usuario_id integer

);

INSERT INTO pagos
VALUES (1, 1500, 1), (2, 2000, 3)

INSERT INTO pagos
VALUES (3, 1500, 2)


alter table pagos add 
foreign key (usuario_id)
references usuariosp1 (id); 



select*
from pagos 

select*
from usuariosp1 u 

INSERT INTO pagos
VALUES
(3, 2000, 2)

CREATE TABLE posts (
"id" Integer,
"title" Varchar(255),
"content" text,
PRIMARY KEY ("id")
);


CREATE TABLE comments (
"id" Integer,
"content" Varchar(255),
"post_id" Integer,
PRIMARY KEY ("id"),
FOREIGN KEY ("post_id")
REFERENCES posts ("id")
ON DELETE cascade );

INSERT INTO posts VALUES (1, 'Post1', 'Lorem Ipsum');


INSERT INTO comments VALUES (1, 'Comentario 1', 1),
(2, 'Comentario 2' ,1),
(3, 'Comentario 3', 1);


DELETE FROM posts WHERE id = 1

select*
from comments


\d nombre_tabla




_







 