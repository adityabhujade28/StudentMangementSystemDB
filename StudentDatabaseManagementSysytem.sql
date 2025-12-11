CREATE DATABASE StudentManagementDB;


USE StudentManagementDB;


CREATE TABLE Department (
    DepartmentId INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE,
);


CREATE TABLE Student (
    StudentId INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Age INT check ( Age >= 18 ),
    CGPA DECIMAL(3,2) DEFAULT 0.0 CHECK (CGPA BETWEEN 0.0 AND 10.0),
    DepartmentId INT NOT NULL,
    EnrollmentDate DATE DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT FK_Student_Department FOREIGN KEY (DepartmentId)
        REFERENCES Department(DepartmentId)
);


CREATE TABLE Course (
    CourseId INT PRIMARY KEY IDENTITY(1,1),
    CourseName VARCHAR(150) NOT NULL UNIQUE,
    Credits INT NOT NULL DEFAULT 0 CHECK (Credits BETWEEN 0 AND 5),
    DepartmentId INT NOT NULL,

    CONSTRAINT FK_Course_Department FOREIGN KEY (DepartmentId)
        REFERENCES Department(DepartmentId)
);


CREATE TABLE StudentCourse (
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    EnrollmentDate DATE DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT PK_StudentCourse PRIMARY KEY (StudentId, CourseId),

    CONSTRAINT FK_StudentCourse_Student FOREIGN KEY (StudentId)
        REFERENCES Student(StudentId)
        ON DELETE CASCADE,

    CONSTRAINT FK_StudentCourse_Course FOREIGN KEY (CourseId)
        REFERENCES Course(CourseId)
        ON DELETE CASCADE
);


INSERT INTO Department (DepartmentName)
VALUES
('Computer Science'),
('Electronics'),
('Mechanical Engineering'),
('Civil Engineering'),
('Information Technology');


INSERT INTO Student (FirstName, LastName, Email, EnrollmentDate, CGPA, DepartmentId, Age)
VALUES
('Aarav',  'Sharma', 'aarav.sharma@example.com', '2003-05-15', 3.5, 1,21),
('Riya',   'Mehta', 'riya.mehta@example.com', '2004-02-20', 3.8, 1,18),
('Kabir',  'Singh', 'kabir.singh@example.com', '2002-11-10', 2.9, 2,19),
('Anaya',  'Patel', 'anaya.patel@example.com', '2003-09-12', 3.2, 3,21),
('Vihaan', 'Rao', 'vihaan.rao@example.com', '2001-08-25', 2.7, 4,18),
('Zara',   'Khan', 'zara.khan@example.com', '2004-07-17', 3.9, 5,19),
('Dev',    'Joshi', 'dev.joshi@example.com', '2003-03-11', 2.5, 1,20),
('Myra',   'Desai', 'myra.desai@example.com', '2002-05-30', 3.1, 2,20),
('Advait', 'Nair', 'advait.nair@example.com', '2004-01-14', 3.7, 3,19),
('Aisha',  'Iqbal', 'aisha.iqbal@example.com', '2003-10-19', 2.8, 4,18),
('Reyansh','Gupta', 'reyansh.gupta@example.com', '2001-09-07', 3.3, 5,18),
('Tara',   'Menon', 'tara.menon@example.com', '2002-12-02', 3.6, 1,22),
('Arjun',  'Verma', 'arjun.verma@example.com', '2003-04-18', 2.6, 2,19),
('Sana',   'Ali', 'sana.ali@example.com', '2004-06-24', 3.4, 3,18),
('Ishaan', 'Pawar', 'ishaan.pawar@example.com', '2001-03-03', 3.0, 5,23);


INSERT INTO Course (CourseName, Credits, DepartmentId)
VALUES
('Data Structures', 4, 1),
('Database Systems', 3, 1),
('Digital Electronics', 3, 2),
('Thermodynamics', 4, 3),
('Structural Engineering Basics', 3, 4),
('Operating Systems', 4, 1),
('Machine Learning Basics', 3, 5),
('Networking Fundamentals', 3, 1);


INSERT INTO StudentCourse (StudentId, CourseId)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 6),
(3, 3),
(4, 4),
(5, 5),
(6, 7),
(7, 1),
(7, 8),
(8, 3),
(8, 1),
(9, 1),
(10, 5),
(11, 7);