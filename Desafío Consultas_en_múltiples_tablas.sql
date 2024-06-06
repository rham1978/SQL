--1.-Crea y agrega al entregable las consultas para completar el setup de acuerdo a lo pedido.

create database "desafio3_Raul_Araneda_123";

create table Usuarios (id SERIAL, email varchar(30), nombre varchar, apellido varchar (50), rol varchar);

insert into Usuarios (email, nombre, apellido, rol)
values
('luis@ds.cl','Luis','Torres', 'Administrador'),
('juan@ds.cl', 'Juan','Perez', 'Usuario'),    
('pedro@ds.cl','Pedro','Perez', 'Usuario'),   
('paco@ds.cl', 'Paco','Soto', 'Usuario'),   
('diego@ds.cl','Diego','Landauro', 'Usuario');


create table Posts (id serial, titulo varchar, contenido text, fecha_creacion timestamp, fecha_actualizacion  timestamp,destacado boolean, usuario_id bigint default NULL);

insert into Posts (titulo, contenido, fecha_creacion, fecha_actualizacion, destacado, usuario_id)
values
('Cómo mejorar tus habilidades de programación en Python','[Contenido detallado sobre mejorar habilidades en Python]','2023-03-15 08:59:59', '2023-03-16 08:59:59','1','1'),
('Consejos para una dieta saludable','[Consejos nutricionales y recetas saludables]','2023-02-15 09:59:59', '2023-03-16 11:59:59','0', '1'),
('Los mejores destinos para vacaciones de aventura','[Recomendaciones de destinos y actividades emocionantes]','2023-07-07 15:59:59', '2023-07-20 12:59:59','1', '5'),
('Cómo cultivar un jardín orgánico en casa','[Guía paso a paso para cultivar alimentos orgánicos]','2023-04-07 15:59:59', '2023-05-20 12:59:59','1', '4'),
('Consejos para mejorar la productividad laboral','[Estrategias y herramientas para ser más productivo en el trabajo]','2023-01-20 15:59:59', '2023-01-21 12:59:59','1', NULL );


create table Comentarios (id serial, contenido text, fecha_creacion timestamp, usuario_id bigint default null, post_id bigint );



insert into Comentarios (contenido, fecha_creacion, usuario_id, post_id)
values
('Interesante posts', '2023-04-15 08:59:59','1','1'),
('Nada nuevo bajo el sol', '2023-04-16 08:59:59','2','1'),
('Ya lo habia leido', '2023-04-17 08:59:59','3','1'),
('Excelente', '2023-04-17 08:59:59','1','2'),
('/-/', '2023-05-17 08:59:59','2','2');

--2.-Cruza los datos de la tabla usuarios y posts, mostrando las siguientes columnas: nombre y email del usuario junto al título y contenido del post.


select
a.nombre,
a.email,
b.titulo,
b.contenido

from usuarios a, Posts b 
where a.id = b.usuario_id;


--3.-Muestra el id, título y contenido de los posts de los administradores. El administrador puede ser cualquier id.

select
a.id,
a.titulo,
a.contenido

from Posts a, Usuarios b  
where b.id = a.usuario_id  and  b.rol = 'Administrador';


--4.-Cuenta la cantidad de posts de cada usuario. La tabla resultante debe mostrar el id e email del usuario junto con la cantidad de posts de cada usuario.


select
a.usuario_id,
b.email,
count(a.id) as Numero_Post

from posts a
inner join usuarios b on a.usuario_id = b.id 

group by 
a.usuario_id,
b.email;

--5.- Muestra el email del usuario que ha creado más posts. Aquí la tabla resultante tiene un único registro y muestra solo el email.

select
b.email

from posts a
left join usuarios b on a.usuario_id = b.id 

group by 
a.usuario_id,
b.email

order by count(a.id) desc
limit 1;


--6.-Muestra la fecha del último post de cada usuario.


select
a.usuario_id, 
b.nombre,
b.apellido,
max(a.fecha_creacion) as Fecha_Maxima

from posts a
inner join usuarios b on a.usuario_id = b.id 

group by 
a.usuario_id, 
b.nombre,
b.apellido;

--7.- Muestra el título y contenido del post (artículo) con más comentarios.

select
a.titulo,
a.contenido


from posts a
left join comentarios b on  a.id=b.post_id


group by 
a.titulo,
a.contenido

order by count(b.id) desc
limit 1;


--8.-Muestra en una tabla el título de cada post, el contenido de cada post y el contenido de cada comentario asociado a los posts mostrados, junto con el email del usuario que lo escribió.


--Opción 1

select
a.titulo,
a.contenido as Contenido_Posts,
b.contenido  as Contenido_Comentario,
c.email

from posts a
inner join comentarios b on  a.id=b.post_id inner join usuarios c on a.usuario_id = c.id 

where c.email is not null and b.contenido is not null

--Segunda Opción


select
a.titulo,
a.contenido as Contenido_Posts,
b.contenido  as Contenido_Comentario,
c.email

from posts a, comentarios b, usuarios c 

where a.id=b.post_id and a.usuario_id = c.id; 


--9.- Muestra el contenido del último comentario de cada usuario.

with  aux as (
SELECT 
id,
contenido,
fecha_creacion,
usuario_id,
post_id,
ROW_NUMBER() OVER(PARTITION BY usuario_id ORDER BY fecha_creacion desc) as N_Col

 
FROM comentarios

)


select
b.usuario_id,
a.nombre,
a.apellido,
b.contenido


from usuarios a, aux b

where a.id = b.usuario_id and N_Col = 1;



-- 10. Muestra los emails de los usuarios que no han escrito ningún comentario.



select 
a. email
from usuarios a

left join comentarios b on a.id = b.usuario_id 

where b.usuario_id  is null














































