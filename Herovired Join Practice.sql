SELECT * FROM batch11.Courses;
-- 1. Retrieve the course name and teacher for each enrollment.
SELECT c.CourseName, c.Teacher FROM Courses c JOIN Enrollments e ON c.CourseID = e.CourseID;

-- 1.retrive course name and teacher for each enrollment
select c.CourseName, c.Teacher from Courses c inner join Enrollments e on c.CourseID = e.CourseID;

-- -- 2.- Get a list of all students and their enrollments if available, including students who haven't enrolled in any courses. 
SELECT s.StudentID, s.FirstName, s.LastName, e.EnrollmentID
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID;

-- 3.List all courses and their teachers, including courses without any enrolled students.
Select c.CourseName, c.Teacher from Courses c left join Enrollment e ON c.CourseID = e.CourseID;

-- 4.Display a list of all students and their enrollments along with all courses and their teachers.
Select s.StudentID, s.FirstName, s.LastName, c.CourseID, c.CourseName, c.Teacher 
From Student s 
Left Join Enrollments e on s.StudentID = e.StudentID
Left Join Courses c on e.CourseID =c.CourseID; 

select  s.StudentID, s.FirstName, s.LastName, c.CourseID, c.CourseName, c.Teacher 
from Students s 
left join Enrollments e on s.StudentID = e.studentID
left join Courses c on e.CourseID = c.CourseID;