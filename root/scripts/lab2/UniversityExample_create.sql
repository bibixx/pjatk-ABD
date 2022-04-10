-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2021-04-18 12:32:32.201

-- tables
-- Table: Account
CREATE TABLE Account (
    IdAccount int  NOT NULL,
    Number varchar(100)  NOT NULL,
    CreatedAt date  NOT NULL,
    Student_IdStudent int  NOT NULL,
    CONSTRAINT Account_pk PRIMARY KEY (IdAccount)
);

-- Table: Classes
CREATE TABLE Classes (
    IdClasses int  NOT NULL,
    Date date  NOT NULL,
    Time time  NOT NULL,
    IdTeacher int  NOT NULL,
    IdSubject int  NOT NULL,
    CONSTRAINT Classes_pk PRIMARY KEY (IdClasses)
);

-- Table: Grade
CREATE TABLE Grade (
    IdGrade int  NOT NULL,
    Value decimal(5,2)  NOT NULL,
    CreatedAt date  NOT NULL,
    IdClasses int  NOT NULL,
    IdStudent int  NOT NULL,
    CONSTRAINT Grade_pk PRIMARY KEY (IdGrade)
);

-- Table: Payment
CREATE TABLE Payment (
    IdPayment int  NOT NULL,
    Amount decimal(8,2)  NOT NULL,
    CreatedAt date  NOT NULL,
    IdAccount int  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (IdPayment)
);

-- Table: Person
CREATE TABLE Person (
    IdPerson int  NOT NULL,
    FirstName varchar(100)  NOT NULL,
    LastName varchar(100)  NOT NULL,
    Email varchar(100)  NOT NULL,
    Address varchar(100)  NOT NULL,
    CONSTRAINT Person_pk PRIMARY KEY (IdPerson)
);

-- Table: Semester
CREATE TABLE Semester (
    IdSemester int  NOT NULL,
    Name varchar(100)  NOT NULL,
    CONSTRAINT Semester_pk PRIMARY KEY (IdSemester)
);

-- Table: SemesterEntry
CREATE TABLE SemesterEntry (
    IdSemesterEntry int  NOT NULL,
    IdStudent int  NOT NULL,
    IdStudies int  NOT NULL,
    IdCurrentSemester int  NOT NULL,
    IdStartSemester int  NOT NULL,
    CreatedAt timestamp  NOT NULL,
    CONSTRAINT SemesterEntry_pk PRIMARY KEY (IdSemesterEntry)
);

-- Table: Student
CREATE TABLE Student (
    IdStudent int  NOT NULL,
    IndexNumber varchar(100)  NOT NULL,
    CONSTRAINT Student_pk PRIMARY KEY (IdStudent)
);

-- Table: Student_Classes
CREATE TABLE Student_Classes (
    IdStudent int  NOT NULL,
    IdClasses int  NOT NULL,
    CONSTRAINT Student_Classes_pk PRIMARY KEY (IdClasses,IdStudent)
);

-- Table: Studies
CREATE TABLE Studies (
    IdStudies int  NOT NULL,
    Name varchar(100)  NOT NULL,
    Description varchar(100)  NOT NULL,
    NumberOfSemesters int  NOT NULL,
    CONSTRAINT Studies_pk PRIMARY KEY (IdStudies)
);

-- Table: Subject
CREATE TABLE Subject (
    IdSubject int  NOT NULL,
    Name varchar(100)  NOT NULL,
    IdStudies int  NOT NULL,
    CONSTRAINT Subject_pk PRIMARY KEY (IdSubject)
);

-- Table: Teacher
CREATE TABLE Teacher (
    IdTeacher int  NOT NULL,
    Position varchar(100)  NOT NULL,
    CONSTRAINT Teacher_pk PRIMARY KEY (IdTeacher)
);

-- foreign keys
-- Reference: Account_Student (table: Account)
ALTER TABLE Account ADD CONSTRAINT Account_Student
    FOREIGN KEY (Student_IdStudent)
    REFERENCES Student (IdStudent)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Classes_Subject (table: Classes)
ALTER TABLE Classes ADD CONSTRAINT Classes_Subject
    FOREIGN KEY (IdSubject)
    REFERENCES Subject (IdSubject)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Classes_Teacher (table: Classes)
ALTER TABLE Classes ADD CONSTRAINT Classes_Teacher
    FOREIGN KEY (IdTeacher)
    REFERENCES Teacher (IdTeacher)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Grade_Classes (table: Grade)
ALTER TABLE Grade ADD CONSTRAINT Grade_Classes
    FOREIGN KEY (IdClasses)
    REFERENCES Classes (IdClasses)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Grade_Student (table: Grade)
ALTER TABLE Grade ADD CONSTRAINT Grade_Student
    FOREIGN KEY (IdStudent)
    REFERENCES Student (IdStudent)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Payment_Account (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Account
    FOREIGN KEY (IdAccount)
    REFERENCES Account (IdAccount)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SemesterEntry_Semester1 (table: SemesterEntry)
ALTER TABLE SemesterEntry ADD CONSTRAINT SemesterEntry_Semester1
    FOREIGN KEY (IdCurrentSemester)
    REFERENCES Semester (IdSemester)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SemesterEntry_Semester2 (table: SemesterEntry)
ALTER TABLE SemesterEntry ADD CONSTRAINT SemesterEntry_Semester2
    FOREIGN KEY (IdStartSemester)
    REFERENCES Semester (IdSemester)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SemesterEntry_Student (table: SemesterEntry)
ALTER TABLE SemesterEntry ADD CONSTRAINT SemesterEntry_Student
    FOREIGN KEY (IdStudent)
    REFERENCES Student (IdStudent)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: SemesterEntry_Studies (table: SemesterEntry)
ALTER TABLE SemesterEntry ADD CONSTRAINT SemesterEntry_Studies
    FOREIGN KEY (IdStudies)
    REFERENCES Studies (IdStudies)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Student_Person (table: Student)
ALTER TABLE Student ADD CONSTRAINT Student_Person
    FOREIGN KEY (IdStudent)
    REFERENCES Person (IdPerson)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Subject_Studies (table: Subject)
ALTER TABLE Subject ADD CONSTRAINT Subject_Studies
    FOREIGN KEY (IdStudies)
    REFERENCES Studies (IdStudies)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_13_Classes (table: Student_Classes)
ALTER TABLE Student_Classes ADD CONSTRAINT Table_13_Classes
    FOREIGN KEY (IdClasses)
    REFERENCES Classes (IdClasses)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Table_13_Student (table: Student_Classes)
ALTER TABLE Student_Classes ADD CONSTRAINT Table_13_Student
    FOREIGN KEY (IdStudent)
    REFERENCES Student (IdStudent)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Teacher_Person (table: Teacher)
ALTER TABLE Teacher ADD CONSTRAINT Teacher_Person
    FOREIGN KEY (IdTeacher)
    REFERENCES Person (IdPerson)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

