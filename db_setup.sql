
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'KBEC_DB')
BEGIN
    CREATE DATABASE KBEC_DB;
END
GO

USE KBEC_DB;
GO

IF OBJECT_ID('Admins', 'U') IS NULL
BEGIN
    CREATE TABLE Admins (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(255) NOT NULL, 
        CreatedAt DATETIME DEFAULT GETDATE()
    );
END
GO

-- 3. Create Table: Members
IF OBJECT_ID('Members', 'U') IS NULL
BEGIN
    CREATE TABLE Members (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Role NVARCHAR(100) NOT NULL,
        Department NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL,
        Bio NVARCHAR(500) NULL,
        LinkedInUrl NVARCHAR(250) NULL,
        Category NVARCHAR(50) NOT NULL 
END
GO

-- 4. Create Table: Events
IF OBJECT_ID('Events', 'U') IS NULL
BEGIN
    CREATE TABLE Events (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        EventName NVARCHAR(150) NOT NULL,
        EventDate DATE NOT NULL,
        Location NVARCHAR(150) NOT NULL,
        Status NVARCHAR(50) NOT NULL,
        FacebookUrl NVARCHAR(250) NULL,
        ImageGradient NVARCHAR(200) NULL,
        MaxSeats INT NULL
    );
END
GO

-- 5. Create Table: Programs
IF OBJECT_ID('Programs', 'U') IS NULL
BEGIN
    CREATE TABLE Programs (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        ProgramName NVARCHAR(150) NOT NULL,
        Description NVARCHAR(500) NOT NULL,
        ProgramType NVARCHAR(100) NOT NULL, 
        Status NVARCHAR(50) NOT NULL -- 'Active', 'Inactive'
    );
END
GO

-- 6. Seed Initial Data
-- Seed default admin (Plaintext credentials: admin@kbcofficial.com / KBC@2024)
IF NOT EXISTS (SELECT * FROM Admins WHERE Email = 'admin@kbcofficial.com')
BEGIN
    INSERT INTO Admins (Name, Email, PasswordHash) 
    VALUES ('KBC Administrator', 'admin@kbcofficial.com', 'KBC@2024');
END
GO

-- Seed members
IF (SELECT COUNT(*) FROM Members) = 0
BEGIN
    INSERT INTO Members (Name, Role, Department, Email, Bio, LinkedInUrl, Category) VALUES
    ('Ahmed Hassan', 'President', 'CSE', 'ahmed@kbc.com', 'Visionary leader with a passion for entrepreneurship and student development. Ahmed has successfully organized 20+ seminars and mentored 100+ students in career planning.', '#', 'leadership'),
    ('Fatima Rahman', 'Vice President', 'EEE', 'fatima@kbc.com', 'Strategic thinker dedicated to organizing impactful career seminars and workshops. Fatima brings excellent organizational skills and industry connections.', '#', 'leadership'),
    ('Karim Khan', 'Events Manager', 'ME', 'karim@kbc.com', 'Creative organizer bringing professional speakers and mentors to our community. Karim has coordinated partnerships with 30+ industry experts.', '#', 'coordinators'),
    ('Nusrat Jahan', 'Workshop Coordinator', 'Civil', 'nusrat@kbc.com', 'Passionate educator focused on skill development and student empowerment. Nusrat designs and delivers engaging workshops on communication and leadership.', '#', 'coordinators'),
    ('Rashid Ahmed', 'Treasurer', 'IPE', 'rashid@kbc.com', 'Financial steward ensuring resources support our mission and growth. Rashid manages budgets and sponsorships for all KBC activities.', '#', 'coordinators'),
    ('Zara Malik', 'Social Media Lead', 'CSE', 'zara@kbc.com', 'Digital communicator connecting KBC with the broader student community. Zara manages all social media channels with engaging content.', '#', 'volunteers'),
    ('Imran Hossain', 'Content Coordinator', 'EEE', 'imran@kbc.com', 'Creative storyteller documenting KBC''s journey. Imran produces videos, blogs, and promotional materials for our events and programs.', '#', 'volunteers'),
    ('Sabrina Begum', 'Volunteer Lead', 'Architecture', 'sabrina@kbc.com', 'Energetic team builder coordinating volunteer activities and team initiatives. Sabrina ensures smooth execution of all KBC events and activities.', '#', 'volunteers');
END
GO

-- Seed events
IF (SELECT COUNT(*) FROM Events) = 0
BEGIN
    INSERT INTO Events (EventName, EventDate, Location, Status, FacebookUrl, ImageGradient) VALUES
    ('TEDxKUET', '2024-05-10', 'KUET', 'Completed', 'https://www.facebook.com/events/2439190826531758/', 'linear-gradient(135deg, var(--primary), var(--primary-dark))'),
    ('KBEC NEXUS Season 2', '2024-06-01', 'KUET', 'Ongoing', 'https://www.facebook.com/events/2269980206835320/', 'linear-gradient(135deg, var(--accent), #d97706)'),
    ('Mavericks Assemble 4.0', '2024-06-25', 'KUET Campus', 'Completed', 'https://www.facebook.com/events/1222915079885802/', 'linear-gradient(135deg, #475569, #1e293b)');
END
GO

-- Seed programs
IF (SELECT COUNT(*) FROM Programs) = 0
BEGIN
    INSERT INTO Programs (ProgramName, Description, ProgramType, Status) VALUES
    ('Career Seminars', 'Expert career preparation sessions.', 'Seminar', 'Active'),
    ('Skill Workshops', 'Leadership and communication training.', 'Workshop', 'Active'),
    ('Idea Labs', 'Entrepreneurship ideation sessions.', 'Lab', 'Active');
END
GO
