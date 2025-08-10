--Zohaib Ali
--August-09-2025
--these are procedures created 


go
CREATE PROCEDURE stp_AddPatient
    @PatientName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    
    IF (@PatientName IS NULL OR LTRIM(RTRIM(@PatientName)) = '')
    BEGIN
        RAISERROR('Patient name cannot be empty.', 16, 1);
        RETURN;
    END

    
    INSERT INTO Patient (PatientName)
    VALUES (@PatientName);

    PRINT 'Patient added successfully.';
END;

go

CREATE PROCEDURE stp_DeletePatient
    @PatientID INT
AS
BEGIN
    SET NOCOUNT ON;

 
    IF NOT EXISTS (SELECT 1 FROM Patient WHERE PatientID = @PatientID)
    BEGIN
        RAISERROR('Patient with this ID was not found.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Patient
        WHERE PatientID = @PatientID;

        COMMIT TRANSACTION;

       
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('An error occurred while deleting the patient.', 16, 1);
    END CATCH
END;

go
CREATE PROCEDURE stp_GetPatientById
    @PatientID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF (@PatientID IS NULL OR @PatientID <= 0)
        BEGIN
            RAISERROR('Invalid PatientID.', 16, 1);
            RETURN;
        END

        SELECT PatientID, PatientName
        FROM Patient
        WHERE PatientID = @PatientID;

    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('An error occurred while fetching the patient: %s', 16, 1, @ErrMsg);
    END CATCH
END

go



CREATE PROCEDURE stp_UpdatePatient
    @PatientID INT,
    @PatientName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF (@PatientID IS NULL OR @PatientID <= 0)
        BEGIN
            RAISERROR('Invalid PatientID.', 16, 1);
            RETURN;
        END

        IF (@PatientName IS NULL OR LTRIM(RTRIM(@PatientName)) = '')
        BEGIN
            RAISERROR('Patient name cannot be null or empty.', 16, 1);
            RETURN;
        END

        UPDATE Patient
        SET PatientName = @PatientName
        WHERE PatientID = @PatientID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No patient found with the given ID.', 16, 1);
        END
        ELSE
        BEGIN
            PRINT 'Patient updated successfully.';
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('An error occurred while updating the patient: %s', 16, 1, @ErrMsg);
    END CATCH
END
GO


--Doctor 


CREATE PROCEDURE stp_AddDoctor
    @DoctorName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    
    IF @DoctorName IS NULL OR LTRIM(RTRIM(@DoctorName)) = ''
    BEGIN
        RAISERROR('Doctor name cannot be empty.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        INSERT INTO Doctor (DoctorName)
        VALUES (@DoctorName);

        PRINT 'Doctor added successfully.';
    END TRY
    BEGIN CATCH
        RAISERROR('An error occurred while adding the doctor.', 16, 1);
    END CATCH
END

go

CREATE PROCEDURE stp_GetDoctor
    @DoctorID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @DoctorID IS NULL
        BEGIN
            SELECT * FROM Doctor;
        END
        ELSE
        BEGIN
            SELECT * FROM Doctor WHERE DoctorID = @DoctorID;
        END
    END TRY
    BEGIN CATCH
        RAISERROR('An error occurred while retrieving doctor(s).', 16, 1);
    END CATCH
END

go

CREATE PROCEDURE stp_UpdateDoctor
    @DoctorID INT,
    @DoctorName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    
    IF @DoctorID IS NULL OR @DoctorID <= 0
    BEGIN
        RAISERROR('Invalid Doctor ID.', 16, 1);
        RETURN;
    END

    IF @DoctorName IS NULL OR LTRIM(RTRIM(@DoctorName)) = ''
    BEGIN
        RAISERROR('Doctor name cannot be empty.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        UPDATE Doctor
        SET DoctorName = @DoctorName
        WHERE DoctorID = @DoctorID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Doctor not found.', 16, 1);
        END
        ELSE
        BEGIN
            PRINT 'Doctor updated successfully.';
        END
    END TRY
    BEGIN CATCH
        RAISERROR('An error occurred while updating the doctor.', 16, 1);
    END CATCH
END

go

CREATE PROCEDURE stp_DeleteDoctor
    @DoctorID INT
AS
BEGIN
    SET NOCOUNT ON;

  
    IF @DoctorID IS NULL OR @DoctorID <= 0
    BEGIN
        RAISERROR('Invalid Doctor ID.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        DELETE FROM Doctor
        WHERE DoctorID = @DoctorID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('Doctor not found.', 16, 1);
        END
        ELSE
        BEGIN
            PRINT 'Doctor deleted successfully.';
        END
    END TRY
    BEGIN CATCH
        RAISERROR('An error occurred while deleting the doctor.', 16, 1);
    END CATCH
END

go



create procedure stp_addVisitType
    @TypeName varchar(50)
as
begin
    set nocount on;
    if @TypeName is null or ltrim(rtrim(@TypeName)) = ''
    begin
        raiserror('TypeName cannot be null or empty.', 16, 1);
        return;
    end
    begin try
        insert into VisitType (TypeName)
        values (@TypeName);
    end try
    begin catch
        declare @ErrorMessage nvarchar(4000) = error_message();
        raiserror(@ErrorMessage, 16, 1);
    end catch
end
go

create procedure stp_getVisitType
    @VisitTypeID int
as
begin
    set nocount on;
    if @VisitTypeID is null or @VisitTypeID <= 0
    begin
        raiserror('Invalid VisitTypeID.', 16, 1);
        return;
    end
    begin try
        select * from VisitType where VisitTypeID = @VisitTypeID;
    end try
    begin catch
        declare @ErrorMessage nvarchar(4000) = error_message();
        raiserror(@ErrorMessage, 16, 1);
    end catch
end
go

create procedure stp_updateVisitType
    @VisitTypeID int,
    @TypeName varchar(50)
as
begin
    set nocount on;
    if @VisitTypeID is null or @VisitTypeID <= 0
    begin
        raiserror('Invalid VisitTypeID.', 16, 1);
        return;
    end
    if @TypeName is null or ltrim(rtrim(@TypeName)) = ''
    begin
        raiserror('TypeName cannot be null or empty.', 16, 1);
        return;
    end
    begin try
        update VisitType
        set TypeName = @TypeName
        where VisitTypeID = @VisitTypeID;
    end try
    begin catch
        declare @ErrorMessage nvarchar(4000) = error_message();
        raiserror(@ErrorMessage, 16, 1);
    end catch
end
go

create procedure stp_deleteVisitType
    @VisitTypeID int
as
begin
    set nocount on;
    if @VisitTypeID is null or @VisitTypeID <= 0
    begin
        raiserror('Invalid VisitTypeID.', 16, 1);
        return;
    end
    begin try
        delete from VisitType where VisitTypeID = @VisitTypeID;
    end try
    begin catch
        declare @ErrorMessage nvarchar(4000) = error_message();
        raiserror(@ErrorMessage, 16, 1);
    end catch
end
go




--PatientVisit


create procedure stp_addpatientvisit
    @patientid int,
    @doctorid int,
    @visittypeid int,
    @visitdate date,
    @description varchar(100)
as
begin
    set nocount on;

    begin try
        if @patientid is null or @doctorid is null or @visittypeid is null or @visitdate is null
        begin
            raiserror('All required fields must be provided.', 16, 1);
            return;
        end

        insert into PatientVisit (PatientID, DoctorID, VisitTypeID, VisitDate, Description)
        values (@patientid, @doctorid, @visittypeid, @visitdate, @description);
    end try
    begin catch
        select error_message() as ErrorMessage;
    end catch
end
go


create procedure stp_getpatientvisit
    @visitid int
as
begin
    set nocount on;

    begin try
        if @visitid is null
        begin
            raiserror('VisitID must be provided.', 16, 1);
            return;
        end

        select * 
        from PatientVisit
        where VisitID = @visitid;
    end try
    begin catch
        select error_message() as ErrorMessage;
    end catch
end
go


create procedure stp_updatepatientvisit
    @visitid int,
    @patientid int,
    @doctorid int,
    @visittypeid int,
    @visitdate date,
    @description varchar(100)
as
begin
    set nocount on;

    begin try
        if @visitid is null or @patientid is null or @doctorid is null or @visittypeid is null or @visitdate is null
        begin
            raiserror('All required fields must be provided.', 16, 1);
            return;
        end

        update PatientVisit
        set PatientID = @patientid,
            DoctorID = @doctorid,
            VisitTypeID = @visittypeid,
            VisitDate = @visitdate,
            Description = @description
        where VisitID = @visitid;
    end try
    begin catch
        select error_message() as ErrorMessage;
    end catch
end
go

create procedure stp_deletepatientvisit
    @visitid int
as
begin
    set nocount on;

    begin try
        if @visitid is null
        begin
            raiserror('VisitID must be provided.', 16, 1);
            return;
        end

        delete from PatientVisit
        where VisitID = @visitid;
    end try
    begin catch
        select error_message() as ErrorMessage;
    end catch
end
go


--UserRole


create procedure stp_add_userrole
    @rolename varchar(50)
as
begin
    set nocount on;
    begin try
        if (@rolename is null or ltrim(rtrim(@rolename)) = '')
        begin
            raiserror('role name cannot be null or empty', 16, 1);
            return;
        end

        insert into userrole (rolename)
        values (@rolename);

        print 'role added successfully';
    end try
    begin catch
        print 'error adding role: ' + error_message();
    end catch
end
go


create procedure stp_get_userrole
    @roleid int
as
begin
    set nocount on;
    begin try
        if (@roleid is null or @roleid <= 0)
        begin
            raiserror('invalid role id', 16, 1);
            return;
        end

        select roleid, rolename
        from userrole
        where roleid = @roleid;
    end try
    begin catch
        print 'error retrieving role: ' + error_message();
    end catch
end
go


create procedure stp_update_userrole
    @roleid int,
    @rolename varchar(50)
as
begin
    set nocount on;
    begin try
        if (@roleid is null or @roleid <= 0)
        begin
            raiserror('invalid role id', 16, 1);
            return;
        end
        if (@rolename is null or ltrim(rtrim(@rolename)) = '')
        begin
            raiserror('role name cannot be null or empty', 16, 1);
            return;
        end

        update userrole
        set rolename = @rolename
        where roleid = @roleid;

        if @@rowcount = 0
            print 'no role found with the given id';
        else
            print 'role updated successfully';
    end try
    begin catch
        print 'error updating role: ' + error_message();
    end catch
end
go


create procedure stp_delete_userrole
    @roleid int
as
begin
    set nocount on;
    begin try
        if (@roleid is null or @roleid <= 0)
        begin
            raiserror('invalid role id', 16, 1);
            return;
        end

        delete from userrole
        where roleid = @roleid;

        if @@rowcount = 0
            print 'no role found with the given id';
        else
            print 'role deleted successfully';
    end try
    begin catch
        print 'error deleting role: ' + error_message();
    end catch
end
go



--Fee Schedule 

CREATE PROCEDURE stp_CreateFeeSchedule
    @VisitTypeID INT,
    @Fee DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        
        IF @VisitTypeID IS NULL OR NOT EXISTS (SELECT 1 FROM VisitType WHERE VisitTypeID = @VisitTypeID)
        BEGIN
            RAISERROR('Invalid VisitTypeID provided.', 16, 1);
            RETURN;
        END

        IF @Fee IS NULL OR @Fee <= 0
        BEGIN
            RAISERROR('Fee must be greater than zero.', 16, 1);
            RETURN;
        END

        INSERT INTO FeeSchedule (VisitTypeID, Fee)
        VALUES (@VisitTypeID, @Fee);

        PRINT 'FeeSchedule record created successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
go
CREATE PROCEDURE stp_GetFeeScheduleByID
    @FeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @FeeID IS NULL OR NOT EXISTS (SELECT 1 FROM FeeSchedule WHERE FeeID = @FeeID)
        BEGIN
            RAISERROR('Invalid FeeID provided.', 16, 1);
            RETURN;
        END

        SELECT FeeID, VisitTypeID, Fee
        FROM FeeSchedule
        WHERE FeeID = @FeeID;
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END

go

CREATE PROCEDURE stp_UpdateFeeSchedule
    @FeeID INT,
    @VisitTypeID INT,
    @Fee DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        
        IF @FeeID IS NULL OR NOT EXISTS (SELECT 1 FROM FeeSchedule WHERE FeeID = @FeeID)
        BEGIN
            RAISERROR('Invalid FeeID provided.', 16, 1);
            RETURN;
        END

        
        IF @VisitTypeID IS NULL OR NOT EXISTS (SELECT 1 FROM VisitType WHERE VisitTypeID = @VisitTypeID)
        BEGIN
            RAISERROR('Invalid VisitTypeID provided.', 16, 1);
            RETURN;
        END

        
        IF @Fee IS NULL OR @Fee <= 0
        BEGIN
            RAISERROR('Fee must be greater than zero.', 16, 1);
            RETURN;
        END

        UPDATE FeeSchedule
        SET VisitTypeID = @VisitTypeID,
            Fee = @Fee
        WHERE FeeID = @FeeID;

        PRINT 'FeeSchedule updated successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END

go

CREATE PROCEDURE stp_DeleteFeeSchedule
    @FeeID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @FeeID IS NULL OR NOT EXISTS (SELECT 1 FROM FeeSchedule WHERE FeeID = @FeeID)
        BEGIN
            RAISERROR('Invalid FeeID provided.', 16, 1);
            RETURN;
        END

        DELETE FROM FeeSchedule
        WHERE FeeID = @FeeID;

        PRINT 'FeeSchedule deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END

go



CREATE PROCEDURE stp_AddActivityLog
    @RoleID INT,
    @LogMessage VARCHAR(200),
    @LogDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
         IF @RoleID IS NULL OR @RoleID <= 0
        BEGIN
            RAISERROR('RoleID must be a positive integer.', 16, 1);
            RETURN;
        END

        IF @LogMessage IS NULL OR LTRIM(RTRIM(@LogMessage)) = ''
        BEGIN
            RAISERROR('LogMessage cannot be empty.', 16, 1);
            RETURN;
        END

        IF @LogDate IS NULL
        BEGIN
            RAISERROR('LogDate cannot be null.', 16, 1);
            RETURN;
        END

        BEGIN TRANSACTION;
        INSERT INTO ActivityLog (RoleID, LogMessage, LogDate)
        VALUES (@RoleID, @LogMessage, @LogDate);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO


CREATE PROCEDURE stp_GetActivityLog
    @LogID INT = NULL 
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @LogID IS NULL
        BEGIN
            SELECT LogID, RoleID, LogMessage, LogDate
            FROM ActivityLog;
        END
        ELSE
        BEGIN
            SELECT LogID, RoleID, LogMessage, LogDate
            FROM ActivityLog
            WHERE LogID = @LogID;
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO


CREATE PROCEDURE stp_UpdateActivityLog
    @LogID INT,
    @RoleID INT,
    @LogMessage VARCHAR(200),
    @LogDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validation
        IF @LogID IS NULL OR @LogID <= 0
        BEGIN
            RAISERROR('LogID must be a positive integer.', 16, 1);
            RETURN;
        END

        IF @RoleID IS NULL OR @RoleID <= 0
        BEGIN
            RAISERROR('RoleID must be a positive integer.', 16, 1);
            RETURN;
        END

        IF @LogMessage IS NULL OR LTRIM(RTRIM(@LogMessage)) = ''
        BEGIN
            RAISERROR('LogMessage cannot be empty.', 16, 1);
            RETURN;
        END

        IF @LogDate IS NULL
        BEGIN
            RAISERROR('LogDate cannot be null.', 16, 1);
            RETURN;
        END

        BEGIN TRANSACTION;
        UPDATE ActivityLog
        SET RoleID = @RoleID,
            LogMessage = @LogMessage,
            LogDate = @LogDate
        WHERE LogID = @LogID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No record found with the given LogID.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO


CREATE PROCEDURE stp_DeleteActivityLog
    @LogID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF @LogID IS NULL OR @LogID <= 0
        BEGIN
            RAISERROR('LogID must be a positive integer.', 16, 1);
            RETURN;
        END

        BEGIN TRANSACTION;
        DELETE FROM ActivityLog
        WHERE LogID = @LogID;

        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No record found with the given LogID.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrMsg, 16, 1);
    END CATCH
END
GO































