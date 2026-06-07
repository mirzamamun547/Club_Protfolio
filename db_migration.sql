USE KBEC_DB;
GO

-- 1) Add MaxSeats to Events (NULL = unlimited)
IF COL_LENGTH('dbo.Events','MaxSeats') IS NULL
BEGIN
	ALTER TABLE dbo.Events ADD MaxSeats INT NULL;
	PRINT 'Added column Events.MaxSeats (NULL = unlimited).';
END
ELSE
	PRINT 'Events.MaxSeats already exists.';
GO

-- 2) Add EventId to EventRegistrations to reference Events
IF COL_LENGTH('dbo.EventRegistrations','EventId') IS NULL
BEGIN
	ALTER TABLE dbo.EventRegistrations ADD EventId INT NULL;
	PRINT 'Added column EventRegistrations.EventId (temporarily NULL).';
END
ELSE
	PRINT 'EventRegistrations.EventId already exists.';
GO

-- 3) Populate EventId by joining on EventName (best-effort)
UPDATE ER
SET ER.EventId = E.Id
FROM dbo.EventRegistrations ER
INNER JOIN dbo.Events E ON ER.EventName = E.EventName
WHERE ER.EventId IS NULL;
PRINT 'Populated EventId for registrations where EventName matched an Events.EventName.';
GO

-- 4) Report any registrations that still have NULL EventId
DECLARE @RemainingNulls INT = (SELECT COUNT(*) FROM dbo.EventRegistrations WHERE EventId IS NULL);
IF @RemainingNulls > 0
BEGIN
	PRINT 'WARNING: ' + CAST(@RemainingNulls AS VARCHAR(10)) + ' EventRegistrations rows still have NULL EventId. Please inspect these rows and set EventId manually before enforcing NOT NULL.';
	SELECT Id, FullName, StudentId, Email, EventName FROM dbo.EventRegistrations WHERE EventId IS NULL;
END
ELSE
BEGIN
	-- 5) Make EventId NOT NULL now that all rows are populated
	ALTER TABLE dbo.EventRegistrations ALTER COLUMN EventId INT NOT NULL;
	PRINT 'EventRegistrations.EventId set to NOT NULL.';
END
GO

-- 6) Add FK constraint if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE parent_object_id = OBJECT_ID('dbo.EventRegistrations') AND name = 'FK_EventRegistrations_Events')
BEGIN
	ALTER TABLE dbo.EventRegistrations ADD CONSTRAINT FK_EventRegistrations_Events FOREIGN KEY(EventId) REFERENCES dbo.Events(Id);
	PRINT 'Added FK constraint FK_EventRegistrations_Events.';
END
ELSE
	PRINT 'FK_EventRegistrations_Events already exists.';
GO

-- 7) Add UNIQUE constraints for duplicate-prevention if no duplicates exist
-- EventId + StudentId
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_EventRegistration_Event_Student')
BEGIN
	IF NOT EXISTS (SELECT EventId, StudentId FROM dbo.EventRegistrations WHERE StudentId IS NOT NULL GROUP BY EventId, StudentId HAVING COUNT(*) > 1)
	BEGIN
		ALTER TABLE dbo.EventRegistrations ADD CONSTRAINT UQ_EventRegistration_Event_Student UNIQUE (EventId, StudentId);
		PRINT 'Added unique constraint UQ_EventRegistration_Event_Student.';
	END
	ELSE
	BEGIN
		PRINT 'Cannot add UQ_EventRegistration_Event_Student: duplicates found. Resolve duplicates first.';
		SELECT EventId, StudentId, COUNT(*) AS CNT FROM dbo.EventRegistrations WHERE StudentId IS NOT NULL GROUP BY EventId, StudentId HAVING COUNT(*) > 1;
	END
END
ELSE
	PRINT 'UQ_EventRegistration_Event_Student already exists.';
GO

-- EventId + Email
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_EventRegistration_Event_Email')
BEGIN
	IF NOT EXISTS (SELECT EventId, Email FROM dbo.EventRegistrations WHERE Email IS NOT NULL GROUP BY EventId, Email HAVING COUNT(*) > 1)
	BEGIN
		ALTER TABLE dbo.EventRegistrations ADD CONSTRAINT UQ_EventRegistration_Event_Email UNIQUE (EventId, Email);
		PRINT 'Added unique constraint UQ_EventRegistration_Event_Email.';
	END
	ELSE
	BEGIN
		PRINT 'Cannot add UQ_EventRegistration_Event_Email: duplicates found. Resolve duplicates first.';
		SELECT EventId, Email, COUNT(*) AS CNT FROM dbo.EventRegistrations WHERE Email IS NOT NULL GROUP BY EventId, Email HAVING COUNT(*) > 1;
	END
END
ELSE
	PRINT 'UQ_EventRegistration_Event_Email already exists.';
GO

-- 8) Safety note: EventName column is still present for reference. Drop it only after you verify migration.
IF COL_LENGTH('dbo.EventRegistrations','EventName') IS NOT NULL
BEGIN
	PRINT 'Note: EventRegistrations.EventName still exists. You may drop this column after verification.';
	-- To drop: ALTER TABLE dbo.EventRegistrations DROP COLUMN EventName;
END
GO

PRINT 'Migration script finished. Review output and resolve any warnings before proceeding.';

