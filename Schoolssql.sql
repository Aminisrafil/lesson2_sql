CREATE DATABASE School
Go
USE School
CREATE TABLE Student
(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(20) CHECK(LEN(Name)>1),
	Surname NVARCHAR(20) CHECK(LEN(Surname)>1),
)
DELETE  FROM Student
INSERT INTO Student
VALUES
('Amin','Israfilzade'),
('Elvin','Bilalov'),
('Maqsud','Muslumov'),
('Abb','Abb'),
('Tural','Isbatov'),
('Elcin','Agayev')

SELECT * FROM Student


CREATE TABLE Groups
(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(20) CHECK(LEN(Name)>1),
)

ALTER TABLE Student
ADD GroupId INT FOREIGN KEY REFERENCES Groups(Id)

INSERT INTO Groups
Values
('P132'),
('P232'),
('P332')



CREATE TABLE Subjects
(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(20) CHECK(LEN(Name)>1),
)
DELETE FROM SUBJECTS

INSERT INTO SUBJECTS
VALUES
('Math'),
('English'),
('Physics'),
('Chemistry')
DELETE FROM StudentSubject
CREATE TABLE StudentSubject
(
	StudentId INT NOT NULL FOREIGN KEY REFERENCES Student(Id),
	SubjectId INT NOT NULL FOREIGN KEY REFERENCES Subjects(Id),
)
ALTER TABLE StudentSubject
ADD PRIMARY KEY (StudentId,SubjectId)
SELECT COUNT(StudentId) AS StudentSubjects FROM StudentSubject WHERE StudentId=7
SELECT *,(SELECT Count(StudentId) FROM StudentSubject WHERE StudentId = Student.Id) AS CountofSubjects FROM Student

SELECT * FROM Student
JOIN Groups
ON Student.GroupId = Groups.Id

CREATE TABLE Exam
(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(20) CHECK(LEN(Name)>1),
	StudentId INT FOREIGN KEY REFERENCES Student(Id),
	ExamDate Date,
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id),
)
GO 
INSERT INTO Exam
VALUES
('First Semester Exam',7,'04-9-2023',1),
('First Semester Exam',8,'04-10-2023',2),
('First Semester Exam',8,'04-12-2023',1),
('First Semester Exam',12,'04-18-2023',3),
('First Semester Exam',10,'04-5-2023',3),
('First Semester Exam',9,'04-7-2023',2)

SELECT * FROM Exam

CREATE TABLE ExamResult
(
	Id INT PRIMARY KEY IDENTITY (1,1),
	ExamId INT FOREIGN KEY REFERENCES Exam(Id),
	StudentId INT FOREIGN KEY REFERENCES Student(Id),
	Point INT,
)

INSERT INTO ExamResult
VALUES
(1,7,85),
(3,8,55),
(3,9,95),
(4,11,10),
(4,10,100),
(1,12,0)

//BIRINCI TASK

SELECT *,(SELECT Name FROM Groups WHERE GroupId=Groups.Id) AS GroupName FROM Student 

//IKINCI TASK

SELECT *,(SELECT COUNT(ID) FROM Exam WHERE Exam.StudentId=Student.Id) AS CountofAttendedExams FROM Student

//UCUNCU TASK

SELECT * FROM Subjects
LEFT JOIN Exam AS E
ON E.SubjectId = Subjects.Id

//BESINCI TASK

SELECT *, CONCAT(Student.Name, ' ', Student.Surname) AS FullName, Student.GroupId FROM ExamResult AS ER
JOIN Student
ON ER.StudentId = Student.Id;

//ALTINCI TASK

SELECT *,(SELECT AVG(POINT) FROM ExamResult WHERE ExamResult.StudentId=Student.Id) FROM Student
