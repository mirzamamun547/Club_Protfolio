USE KBEC_DB;
GO

-- Create Sponsors Table
IF OBJECT_ID('Sponsors', 'U') IS NULL
BEGIN
	CREATE TABLE Sponsors (
		Id INT IDENTITY(1,1) PRIMARY KEY,
		Name NVARCHAR(100) NOT NULL,
		Description NVARCHAR(500) NULL,
		PhotoPath NVARCHAR(250) NULL DEFAULT 'images/default-sponsor.png',
		CreatedAt DATETIME DEFAULT GETDATE()
	);
END
GO

-- Seed sample sponsors
IF (SELECT COUNT(*) FROM Sponsors) = 0
BEGIN
	INSERT INTO Sponsors (Name, Description, PhotoPath) VALUES
	('TechCorp Solutions', 'Leading software development partner supporting our coding bootcamps.', 'images/default-sponsor.png'),
	('Global Finance Bank', 'Official banking partner providing financial literacy workshops.', 'images/default-sponsor.png');
END
GO
