-- SQL script to create EventRegistrations table for KBEC_DB
CREATE TABLE EventRegistrations(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100),
    StudentId NVARCHAR(50),
    Department NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    EventName NVARCHAR(150),

    WhyAttend NVARCHAR(500),      -- Why participant wants to attend
    Expectations NVARCHAR(500),   -- What participant expects from event

    RegistrationDate DATETIME DEFAULT GETDATE()
);

-- Run this script in the KBEC_DB database (SQL Server).