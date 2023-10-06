drop database users_student;

create database users_student;

use users_student;

create table users(
id int primary key auto_increment comment "ID de cada estudiante" ,
name varchar(200) comment "Nombre del estudiante ",
last_name varchar(200) comment "Apellido del estudiante ",
enrollment varchar(200) comment "matricula del estudiante ",
email varchar(200) unique key comment "email del estudiante ",
password varchar(200) comment "password del estudiante ")