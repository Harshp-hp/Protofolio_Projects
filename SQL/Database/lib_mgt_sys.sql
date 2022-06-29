-- Create Database for Library Management System

create database library_demo_mgt;
use library_demo_mgt;

-- Create table Readers 

create table readers 
(
	reader_id varchar(6),
    fname varchar(30),
    mname varchar(30),
    ltname varchar(30),
    city varchar(15),
    mobileno varchar(10),
    occupation varchar(10),
    dob Date,
    constraint readers_pk primary key(reader_id)
);

insert into readers values ('C001','Ramesh','Chandra','Sharma','Delhi','1234567890','Service','1998-12-06');
insert into readers values('C002','Avinash','Sunder','Minha','Delhi','2345678901','Service','1998-08-13');
insert into readers values('C003','Rahul',null,'Rastogi','Nagpur','1234657809','Student','1887-12,03');
insert into readers values('C004','Vaibhau','Rajesh','Kubde','Nagpur','1234578905','Student','1998-05-16');

select * from readers;

-- create table Books 

create table Book
(
	bookid varchar(6),
    bookname varchar(40),
    bookdomain varchar(30),
    constraint book_bid_pk primary key(bookid)
	);
    
insert into book values('B0001','The Cat in the Hat','Story');
insert into book values('B0002','Charlie and the Chocolate Factory','Story');
insert into book values('B0003','The Very Hungry Caterpillar','Story');

create table active_readers
(
	account_id varchar(6),
    reader_id varchar(6),
    bookid varchar(6),
    atype varchar(10),
    astatus varchar(10),
    constraint activereaders_acnumber_pk primary key(account_id),
    constraint account_readerid_fk foreign key(reader_id) references readers(reader_id),
    constraint account_bid_fk foreign key(bookid) references book(bookid)
);


insert into active_readers values('A001','C001','B0001','Premium','Active');
insert into active_readers values('A002','C002','B0002','Premium','Active');
insert into active_readers values('A003','C003','B0003','Regular','Active');

select * from active_readers;


create table bookissue_details
(
	issuenumber varchar(6),
    account_id varchar(6),
    bookid varchar(20),
    bookname varchar(50),
    numbers_of_book_issued int(7),
    constraint trandetails_tnumber_pk primary key(issuenumber),
    constraint trandetails_acnumber_fk foreign key(account_id) References active_readers(account_id)
);

show tables;

insert into bookissue_details values('T0001','A001','B0001','The Cat in the Hat','5');
insert into bookissue_details values('T0002','A002','B0002','Charlie and the Chocolate Factory','10');

select * from bookissue_details;