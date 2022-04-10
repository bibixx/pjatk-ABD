-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-04-18 12:32:32.201

-- foreign keys
ALTER TABLE Account
    DROP CONSTRAINT Account_Student;

ALTER TABLE Classes
    DROP CONSTRAINT Classes_Subject;

ALTER TABLE Classes
    DROP CONSTRAINT Classes_Teacher;

ALTER TABLE Grade
    DROP CONSTRAINT Grade_Classes;

ALTER TABLE Grade
    DROP CONSTRAINT Grade_Student;

ALTER TABLE Payment
    DROP CONSTRAINT Payment_Account;

ALTER TABLE SemesterEntry
    DROP CONSTRAINT SemesterEntry_Semester1;

ALTER TABLE SemesterEntry
    DROP CONSTRAINT SemesterEntry_Semester2;

ALTER TABLE SemesterEntry
    DROP CONSTRAINT SemesterEntry_Student;

ALTER TABLE SemesterEntry
    DROP CONSTRAINT SemesterEntry_Studies;

ALTER TABLE Student
    DROP CONSTRAINT Student_Person;

ALTER TABLE Subject
    DROP CONSTRAINT Subject_Studies;

ALTER TABLE Student_Classes
    DROP CONSTRAINT Table_13_Classes;

ALTER TABLE Student_Classes
    DROP CONSTRAINT Table_13_Student;

ALTER TABLE Teacher
    DROP CONSTRAINT Teacher_Person;

-- tables
DROP TABLE Account;

DROP TABLE Classes;

DROP TABLE Grade;

DROP TABLE Payment;

DROP TABLE Person;

DROP TABLE Semester;

DROP TABLE SemesterEntry;

DROP TABLE Student;

DROP TABLE Student_Classes;

DROP TABLE Studies;

DROP TABLE Subject;

DROP TABLE Teacher;

-- End of file.

