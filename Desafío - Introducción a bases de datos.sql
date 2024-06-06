--Crear una base de datos llamada desafio-tuNombre-tuApellido-3digitos.

create database "desafio_Raul_Araneda_123";

--Crear una tabla llamada clientes:

create table cliente (
email varchar(50),
nombre varchar,
telefono varchar (16),
empresa varchar(50),
prioridad smallint check (prioridad between '1' and '10')

);

--Ingresar 5 clientes distintos con distintas prioridades, el resto de los valores los
puedes inventar.

insert into cliente
values ('luis@ds.cl','Luis','951068521', 'Sonda', '10'),
('juan@ds.cl','Juan','951068522', 'Suzuki', '9'),
('jorge@ds.cl','Jorge','951068523', 'Ford', '6'),
('pedro@ds.cl','Pedro','951068524', 'Mazda', '3'),
('paco@ds.cl','Paco','951068525', 'Entel', '5');


select*
from cliente

--Selecciona los tres clientes de mayor prioridad.

select*
from cliente
order by prioridad desc 
limit 3

--Selecciona, de la tabla clientes, una prioridad o una empresa, de forma que el
resultado devuelva 2 registros.

select*
from cliente
where prioridad = '9' or empresa = 'Sonda'
limit 2


































