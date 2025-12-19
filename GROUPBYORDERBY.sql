CREATE DATABASE StudentCourseDB;

CREATE TABLE Students (
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    StudentEmail VARCHAR(100) UNIQUE
);


CREATE TABLE Courses (
    CourseId INT IDENTITY(1,1) PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
);


CREATE TABLE Enrollments (
    EnrollmentId INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    CourseId INT NOT NULL,
    EnrolledOn DATE NOT NULL,
    Grade DECIMAL(3,2),

    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentId) REFERENCES Students(StudentId),

    CONSTRAINT FK_Enrollments_Courses
        FOREIGN KEY (CourseId) REFERENCES Courses(CourseId)
);

INSERT INTO Students (StudentName, StudentEmail)
VALUES
('Neha',  'neha@gmail.com'),
('Amit',  'amit@gmail.com'),
('Sneha', 'sneha@gmail.com'),
('Karan', 'karan@gmail.com'),
('Aditya','aditya@gmail.com'),
('Shruti','shruti@gmail.com');

INSERT INTO Courses (CourseId, CourseName, Credits)
VALUES
('ASP.NET Core', 4),
('Java Basics', 3),
('Data Structures', 5),
('C# Fundamentals',4),
('Networking',3);

INSERT INTO Enrollments (StudentId, CourseId, EnrolledOn, Grade)
VALUES
(1, 1, GETDATE(), 3.30),
(1, 2, GETDATE(), 3.25),
(2, 1, GETDATE(), 3.54),
(3, 1, GETDATE(), 3.60),   
(3, 2, GETDATE(), 3.40),   
(4, 3, GETDATE(), 3.90),   
(5, 2, GETDATE(), 3.10),   
(5, 5, GETDATE(), 3.50),   
(6, 4, GETDATE(), 3.00);   



--Below are the queries done for practicing group by,order by,join,count,AVG



select StudentName,CourseName,Grade from students
join enrollments 
on students.StudentId = Enrollments.StudentId inner join courses 
on courses.CourseId = Enrollments.CourseId;

select StudentName,Count(CourseName) as enrolledcoursecount from Students
inner join Enrollments 
on Enrollments.StudentId = Students.StudentId inner join courses 
on Courses.CourseId = Enrollments.CourseId 
group by StudentName;

select StudentName,Count(CourseId) as enrolledcoursecount from Students
inner join Enrollments 
on Enrollments.StudentId = Students.StudentId  
group by StudentName 
having Count(CourseId) > 2;

select CourseName,Count(StudentId) as EnrolledStudents from Courses
inner join Enrollments 
on Enrollments.CourseId = Courses.CourseId 
group by CourseName;

select CourseName,Count(StudentId) as EnrolledStudents from Courses
inner join Enrollments 
on Enrollments.CourseId = Courses.CourseId 
group by CourseName 
having Count(StudentId) > 1;

SELECT TOP 1 c.CourseName,AVG(e.Grade) AS AvgGrade FROM Courses c
INNER JOIN Enrollments e 
ON e.CourseId = c.CourseId 
GROUP BY c.CourseId,c.CourseName 
ORDER BY AVG(e.Grade) DESC;


select s.StudentName, Avg(e.Grade) as AvgGrade from students s
inner join enrollments e 
on e.StudentId = s.StudentId 
group by s.StudentId, s.StudentName 
having Avg(e.Grade) > 3.5 ;

SELECT s.StudentName,(
SELECT COUNT(*)
FROM Enrollments e
WHERE e.StudentId = s.StudentId) 
AS EnrolledCourseCount
FROM Students s;


SELECT CourseName
FROM Courses
WHERE CourseId IN (
SELECT CourseId
FROM Enrollments
GROUP BY CourseId
HAVING COUNT(StudentId) > 1);



--Windows function and VIEWS 

SELECT s.StudentName, c.CourseName, e.Grade,
ROW_NUMBER() OVER(PARTITION BY c.CourseName ORDER BY e.Grade DESC) AS RowNum
FROM Enrollments e
JOIN Students s ON e.StudentId = s.StudentId
JOIN Courses c ON e.CourseId = c.CourseId;


SELECT s.StudentName, c.CourseName, e.Grade,
RANK() OVER(PARTITION BY c.CourseName ORDER BY e.Grade DESC) AS RankNo
FROM Enrollments e
JOIN Students s ON e.StudentId = s.StudentId
JOIN Courses c ON e.CourseId = c.CourseId;

SELECT s.StudentName, c.CourseName, e.Grade,
DENSE_RANK() OVER(PARTITION BY c.CourseName ORDER BY e.Grade DESC) AS DenseRankNo
FROM Enrollments e
JOIN Students s ON e.StudentId = s.StudentId
JOIN Courses c ON e.CourseId = c.CourseId;



--student course performance view
CREATE VIEW vw_StudentCoursePerformance AS
SELECT 
    s.StudentName,
    c.CourseName,
    e.Grade
FROM Enrollments e
JOIN Students s ON e.StudentId = s.StudentId
JOIN Courses c ON e.CourseId = c.CourseId;

select * from vw_StudentCoursePerformance;


--average grade per course view

CREATE VIEW vw_CourseAverageGrade AS
SELECT 
    c.CourseName,
    AVG(e.Grade) AS AvgGrade
FROM Courses c
JOIN Enrollments e ON c.CourseId = e.CourseId
GROUP BY c.CourseName;

SELECT * FROM vw_CourseAverageGrade;

