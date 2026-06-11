USE KBEC_DB;
GO

-- Create Advisors Table
IF OBJECT_ID('Advisors', 'U') IS NULL
BEGIN
	CREATE TABLE Advisors (
		Id INT IDENTITY(1,1) PRIMARY KEY,
		Name NVARCHAR(100) NOT NULL,
		Role NVARCHAR(100) NOT NULL,
		Expertise NVARCHAR(200) NOT NULL,
		Department NVARCHAR(100) NOT NULL,
		Email NVARCHAR(100) NOT NULL,
		Bio NVARCHAR(500) NULL,
		PhotoPath NVARCHAR(250) NULL DEFAULT 'images/default-advisor.png',
		CreatedAt DATETIME DEFAULT GETDATE()
	);
END
GO

-- Seed sample advisors
IF (SELECT COUNT(*) FROM Advisors) = 0
BEGIN
	INSERT INTO Advisors (Name, Role, Expertise, Department, Email, Bio, PhotoPath) VALUES
	('Dr. Mohammad Hassan', 'Faculty Advisor', 'Entrepreneurship, Business Management', 'CSE', 'hassan@kuet.ac.bd', 'Dr. Hassan has over 15 years of experience in business development and entrepreneurship. He has mentored numerous startups and serves as an advisor to several tech companies.', 'images/default-advisor.png'),
	('Prof. Fatima Akhter', 'Faculty Advisor', 'Innovation, Technology & Strategy', 'EEE', 'fatima@kuet.ac.bd', 'Prof. Akhter specializes in technology innovation and strategic planning. She has published extensively on entrepreneurial management and digital transformation.', 'images/default-advisor.png'),
	('Mr. Karim Uddin', 'Industry Mentor', 'Finance, Investment & Startups', 'N/A', 'karim.uddin@company.com', 'An experienced investment banker with expertise in startup financing and venture capital. Mr. Uddin provides valuable insights into funding and business strategy.', 'images/default-advisor.png');
END
GO
