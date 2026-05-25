-- SQL script to add PhotoPath column to Members table in KBEC_DB

-- Check if column already exists, if not add it
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Members' AND COLUMN_NAME = 'PhotoPath')
BEGIN
    ALTER TABLE Members
    ADD PhotoPath NVARCHAR(255) DEFAULT 'images/default-member.png';
END
