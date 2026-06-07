-- SQL script to create EventRegistrations table for KBEC_DB
CREATE TABLE EventRegistrations(
    Id INT PRIMARY KEY IDENTITY(1,1),
    EventId INT NOT NULL,
    FullName NVARCHAR(100),
    StudentId NVARCHAR(50),
    Department NVARCHAR(100),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),

    WhyAttend NVARCHAR(500),      -- Why participant wants to attend
    Expectations NVARCHAR(500),   -- What participant expects from event

    RegistrationDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_EventRegistrations_Events FOREIGN KEY (EventId) REFERENCES Events(Id),
    CONSTRAINT UQ_EventRegistration_Event_Student UNIQUE (EventId, StudentId),
    CONSTRAINT UQ_EventRegistration_Event_Email UNIQUE (EventId, Email)
);
