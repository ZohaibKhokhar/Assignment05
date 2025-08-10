--Zohaib Ali
--9-08-2025
--DML commands


-- VisitType
insert into VisitType ( TypeName) values ( 'Consultation')
insert into VisitType ( TypeName) values ( 'Follow-up')
insert into VisitType ( TypeName) values ('Emergency')

go

-- UserRole
insert into UserRole ( RoleName) values ('Admin')
insert into UserRole (RoleName) values ( 'Receptionist')

go

-- FeeSchedule
insert into FeeSchedule ( VisitTypeID, Fee) values ( 1, 1500.00)
insert into FeeSchedule ( VisitTypeID, Fee) values ( 2, 1000.00)
insert into FeeSchedule ( VisitTypeID, Fee) values ( 3, 2500.00)

go

-- Patient
insert into Patient ( PatientName) values ( 'Ali Khan')
insert into Patient ( PatientName) values ( 'Ayesha Bibi')
insert into Patient ( PatientName) values ( 'Usman Ahmed')
insert into Patient ( PatientName) values ( 'Fatima Noor')
insert into Patient ( PatientName) values ( 'Bilal Hassan')

go

-- Doctor
insert into Doctor ( DoctorName) values ( 'Dr. Tayyab Khokhar')
insert into Doctor ( DoctorName) values ( 'Dr. Zohaib Khokhar')
insert into Doctor ( DoctorName) values ( 'Dr. Hamza Tariq')

go

-- PatientVisit
insert into PatientVisit ( PatientID, DoctorID, VisitTypeID, VisitDate, Description) values ( 1, 1, 1, '2025-08-01', 'Routine health check')
insert into PatientVisit ( PatientID, DoctorID, VisitTypeID, VisitDate, Description) values ( 2, 2, 3, '2025-08-02', 'High fever and weakness')
insert into PatientVisit ( PatientID, DoctorID, VisitTypeID, VisitDate, Description) values ( 3, 1, 2, '2025-08-03', 'Follow-up after surgery')
insert into PatientVisit ( PatientID, DoctorID, VisitTypeID, VisitDate, Description) values ( 4, 3, 2, '2025-08-04', 'Tooth pain')
insert into PatientVisit ( PatientID, DoctorID, VisitTypeID, VisitDate, Description) values ( 5, 2, 1, '2025-08-05', 'General checkup before travel')

go

-- ActivityLog
insert into ActivityLog (  LogMessage, LogDate) values (  'Admin created a new patient record ', '2025-08-01')
insert into ActivityLog (  LogMessage, LogDate) values (  'Admin Removed a patient record ', '2025-08-01')
insert into ActivityLog (  LogMessage, LogDate) values (  'Receptionist scheduled an appointment ', '2025-08-02')
insert into ActivityLog (  LogMessage, LogDate) values (  'Admin updated a patient visit ', '2025-08-03')
insert into ActivityLog ( LogMessage,LogDate) values ('Admin added a new visit type ','2025-08-09')
go




