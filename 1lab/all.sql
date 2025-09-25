 --drop DATABASE t01_library;
 --CREATE DATABASE t01_library;
 
 create type state_type as enum ('excellent', 'good', 'satisfactory', 'dilapidated', 'lost');
 create type where_type as enum ('in stock', 'issued', 'reserved');
 

 create table if not exists public.author (
 author_id serial primary key,
 surname varchar (30) not null, 
 name varchar (30) not null
 );
 
 
  create table if not exists public.publishing_house ( 
 publishing_house_key serial primary key, 
 name varchar(100) not null,
 city varchar (50) not null
 );
 
  
   create table if not exists public.book (
book_id serial primary key, 
title varchar(100) not null,
author_id INT not null, 
FOREIGN KEY (author_id) REFERENCES public.author(author_id),
publishing_house_id INT not null,
foreign key (publishing_house_id) references public.publishing_house (publishing_house_key),
version VARCHAR(50) NOT NULL, --
publication_year INT NOT NULL, --
circulation INT NOT NULL --

 );
 
   
  create table if not exists public.reader (
 reader_id serial primary key,
 surname varchar (30) not null, 
 name varchar (30) not null,
 birth_date date not null,
 gender char (1) check (gender in ('m','f')) not null,
 registration_date date not null
 );
 


 
 create table if not exists public.book_instance (
 instance_id serial primary key,
 book_id int not null,
 foreign key (book_id) references public.book(book_id),
 state state_type not null, 
 status where_type, --если утеряна
location varchar (300) CHECK (location ~ '^/\d+/\d+/\d+$') 
-- ^ - начало строки, $ - конец строки, ~ - реглуярное выражение
 -- \d - digital, \d+ - больше 1 цифры
 );
 
 
 create table if not exists public.issuance (
 issue_date timestamp not NULL,
 expected_return_date date not NULL,
 actual_return_date date NULL,
 reader_id INT NOT NULL,
 instance_id int not null,
  FOREIGN KEY (reader_id) REFERENCES public.reader(reader_id),
  FOREIGN KEY (instance_id) REFERENCES public.book_instance(instance_id),
  primary key (reader_id, instance_id)
 );
 
 
 create table if not exists public.booking (
 booking_id serial primary key,
 reader_id int,
 foreign key (reader_id) references public.reader (reader_id),
 book_id int,
 foreign key (book_id) references public.book (book_id),
 min_condition state_type not null,
 date_reservation date not null,
 time_reservation timestamp(0) not null -- (0) точность, у нас до секунд
 );
 
 
 
  
  
 
 
 
 
