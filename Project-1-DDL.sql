--Zohaib Ali
--August-09-2025
--DDL Commands

create table Patient(
PatientID int Primary Key identity(1,1),
PatientName varchar(100)not null
)


go

create table Doctor(
DoctorID int Primary Key identity(1,1),
DoctorName varchar(100)
)

go
create table VisitType(
VisitTypeID int primary key identity(1,1),
TypeName varchar(50)
)
go

create table PatientVisit(
VisitID int primary key identity(1,1),
PatientID int foreign key references Patient(PatientID),
DoctorID int foreign key references Doctor(DoctorID),
VisitTypeID int foreign key references VisitType(VisitTypeID),
VisitDate date not null,
Description varchar(100)
)

go

create table UserRole(
RoleID int primary key identity(1,1),
RoleName varchar(50) not null,
)

go

create table FeeSchedule(
FeeID int primary key identity(1,1) ,
VisitTypeID int foreign key references VisitType(VisitTypeID),
Fee decimal(10,2)
)
go
create table ActivityLog(
LogID int primary key identity(1,1) ,
RoleID int foreign key references UserRole(RoleID),
LogMessage varchar(200) not null,
LogDate date not null
)
go


