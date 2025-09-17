 --drop DATABASE t01_library;
 --CREATE DATABASE t01_library;
 
 create table public.author (
 author_key serial primary key,
 surname varchar (30) not null, 
 name varchar (30) not null
 );
 
 
  create table public.reader (
 library_card serial primary key,
 surname varchar (30) not null, 
 name varchar (30) not null,
 date_born date not null,
 gender char (1) check (gender in ('m','f')) not null,
 registration_date date not null
 );
 
 create table public.publishing_house ( 
 house_key serial primary key, 
 title varchar(100) not null,
 city varchar (50) not null
 );
 
 create table public.book (
book_key serial primary key, 
title varchar(100) not null,
author_key INT not null, 
foreign key (author_key) references public.author(author_key),
city varchar (50) not null,
code_pub_h INT not null,
version VARCHAR(50) not null,
year INT NOT NULL,
circulation INT not null,
foreign key (code_pub_h) references public.publishing_house (house_key)
 );
 

 
 
 create type state_type as enum ('excellent', 'good', 'satisfactory', 'dilapidated', 'lost');
 create type where_type as enum ('in stock', 'issued', 'reversed');
 
 
 create table public.book_instance (
 internal_inventory_number serial primary key,
 book_information int not null,
 foreign key (book_information) references public.book(book_key),
 state state_type not null, 
 status where_type, --если утеряна
 location varchar (300) CHECK (location ~ '^/\d+/\d+/\d+$')
 -- ^ - начало строки, $ - конец строки, ~ - реглуярное выражение
 -- \d - digital, \d+ - больше 1 цифры
 );
 
 
 create table public.issuance (
 date_issuance timestamp not null,
 expected_date_return date not null,
 actual_date_return date NULL,
 reader_ticket_id INT not null,
 book_instance_id INT not null,
  foreign key (reader_ticket_id) references public.reader(library_card),
  foreign key (book_instance_id) references public.book_instance(internal_inventory_number),
  primary key (reader_ticket_id, book_instance_id)
 );
 
 
 create table public.booking (
 number_reservation serial primary key,
 id_reader_number int,
 foreign (id_reader_number) references public.reader (library_card),
 information_of_book serial,
 foreign (information_of_book) references public.book (book_key),
 min_condition state_type not null,
 date_reservation date not null,
 time_reservation time not null
 );
 
 
 
 
 
 
 
