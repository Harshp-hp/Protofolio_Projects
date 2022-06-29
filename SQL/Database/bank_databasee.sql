-- Create database
drop database bms_db;
create database bms_db;
use bms_db;

-- Customer Personal_info

create table  Cust_personal_info
(
cust_id varchar(5),
cust_name varchar(30),
DOB date,
Guardian_name varchar(30),
Address varchar(50),
Contact_no int(10),
Mail_id varchar(30),
Gender Char(1),
Martial_Status varchar(20),
Indentification_Doc_Type varchar(20),
ID_Doc_no varchar(20),
Citizenship varchar(10),
constraint Cust_pres_info_pk primary key(cust_id)
);


-- Customer Reference Info 

Create table Cust_Reference_info
(
	cust_id varchar(5),
    Reference_acc_name varchar(20),
    Reference_acc_no int(10),
    Reference_acc_add varchar(50),
    Relation varchar(25),
    constraint Cust_ref_info_pk primary key(cust_id),
    constraint Cust_ref_info_fk foreign key(cust_id) references Cust_personal_info(cust_id)
);

-- Bank Account 

create table Bank_info
(
	IFSC_Code varchar(15),
    Bank_Name varchar(25),
    Branch_Name varchar(25),
    Constraint Bank_info_PK primary key(IFSC_Code)
);

-- Account Info
create table Account_Info
(
	Account_No Int(16),
    cust_id varchar(5),
    Account_Type varchar(10),
    Registration_Date Date,
    Activation_Date date,
    IFSC_Code  varchar(10),
    Interest Decimal(7,2),
    Initial_Deposit int(10),
    constraint Acc_Info_PK primary key(cust_id),
    constraint Acc_Info_Pers_FK foreign key(cust_id) References Cust_personal_info(cust_id),
    constraint Acc_Info_Bank_FK foreign key(IFSC_Code) references Bank_info(IFSC_Code)
);

-- Insert Values in Bank_info table

Insert into Bank_info(IFSC_Code,Bank_Name,Branch_Name) Values('HDV0012', 'HDFC', 'Ganeshpeth');
Insert into Bank_info(IFSC_Code,Bank_Name,Branch_Name) Values('SBI01267','SBI','Mahal');
Insert into Bank_info(IFSC_Code,Bank_Name,Branch_Name) Values('ICICI123','ICICI','RajNagar');
Insert into Bank_info(IFSC_Code,Bank_Name,Branch_Name) Values('HDFC456','HDFC','PratapNagar');
Insert into Bank_info(IFSC_Code,Bank_Name,Branch_Name) Values('SBI05678','SBI','Tilka Nagar');

select * from Bank_info;

-- Insert Values in Custsomer Personal Detail 

Insert into Cust_personal_info(cust_id,cust_name,DOB,Guardian_name,Address,Contact_No,Mail_id,Gender,Martial_Status,Indentification_Doc_Type,ID_Doc_no,Citizenship) values('1234','Harsh','1998-12-06','Pushpa','Ganeshpeth','789456123','hpimpak@gamil.com','M','Unmariied','Star','234','Indian');
select * from Cust_personal_info;