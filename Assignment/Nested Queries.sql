-- 1. Question: For each class, find the student(s) who scored the highest in Science.
SELECT st.student_name
FROM students st
JOIN Scores sc1 ON st.student_id = sc1.student_id AND sc1.subject = 'Math'
JOIN Scores sc2 ON st.student_id = sc2.student_id AND sc2.subject = 'Science'
GROUP BY st.student_name
HAVING AVG(sc1.score) < AVG(sc2.score);

-- 2. Question: List the names of students who scored lower in Math than their average Science score.
 SELECT s.class_id, COUNT(*) AS count_above_80
    FROM Scores sc
    JOIN students s ON sc.student_id = s.student_id
    WHERE sc.score > 80
    GROUP BY s.class_id)

SELECT c.class_name
FROM Classes c
JOIN Above80 a ON c.class_id = a.class_id
WHERE a.count_above_80 = (SELECT MAX(count_above_80) FROM Above80);

-- 3. Question: Display the class names with the highest number of students who scored above 80 in any subject.
SELECT s.subject, st.student_name, sc.score
FROM Scores sc
JOIN students st ON sc.student_id = st.student_id
WHERE (sc.subject, sc.score) IN (
    SELECT subject, MAX(score) AS max_score
    FROM Scores
    GROUP BY subject
);

-- 4. Question: Find the students who scored the highest in each subject.
SELECT s.student_name
FROM students s
JOIN Scores sc ON s.student_id = sc.student_id
WHERE sc.score > (
    SELECT AVG(score)
    FROM Scores
    WHERE student_id IN (SELECT student_id FROM Students WHERE class_id = s.class_id)
);

-- 5. Question: List the names of students who scored higher than the average of any student's score in their own class.

WITH ClassAvgAge AS (
    SELECT s.class_id, AVG(s.age) AS avg_age
    FROM Students s
    GROUP BY s.class_id
)
SELECT c.class_name
FROM Classes c
JOIN ClassAvgAge caa ON c.class_id = caa.class_id
WHERE caa.avg_age > (SELECT AVG(age) FROM Students);

-- 6. Question: Find the class(es) where the students average age is above the average age of all students.

SELECT st.student_name, SUM(sc.score) AS total_score
FROM Students st
JOIN Scores sc ON st.student_id = sc.student_id
GROUP BY st.student_name
ORDER BY total_score DESC;

-- 7. Question: Display the student names and their total scores, ordered by the total score in descending order.

WITH ClassAvgScore AS (
    SELECT s.class_id, AVG(sc.score) AS avg_score
    FROM Students s
    JOIN Scores sc ON s.student_id = sc.student_id
    GROUP BY s.class_id
)
SELECT st.student_name, sc.score
FROM Students st
JOIN Scores sc ON st.student_id = sc.student_id
WHERE (st.class_id, sc.score) IN (
    SELECT class_id, MAX(avg_score) AS max_avg_score
    FROM ClassAvgScore
);

-- 8. Question: Find the student(s) who scored the highest in the class with the lowest average score.
SELECT st.student_name
FROM Students st
JOIN Scores sa ON st.student_id = sa.student_id
JOIN Scores sb ON sa.subject = sb.subject AND sa.score = sb.score
WHERE sa.student_name = 'Alice' AND st.student_name != 'Alice';

-- 9. Question: List the names of students who scored the same as Alice in at least one subject.
WITH ClassAvgScore AS (
    SELECT s.class_id, AVG(sc.score) AS avg_score
    FROM Students s
    JOIN Scores sc ON s.student_id = sc.student_id
    GROUP BY s.class_id
)
SELECT c.class_name, COUNT(*) AS count_below_avg
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Scores sc ON s.student_id = sc.student_id
JOIN ClassAvgScore cas ON c.class_id = cas.class_id
WHERE sc.score < cas.avg_score
GROUP BY c.class_name;

-- 10. Question: Display the class names along with the number of students who scored below the average score in their class.
WITH ClassAvgScore AS (
    SELECT s.class_id, AVG(sc.score) AS avg_score
    FROM Students s
    JOIN Scores sc ON s.student_id = sc.student_id
    GROUP BY s.class_id
)
SELECT c.class_name, COUNT(*) AS count_below_avg
FROM Classes c
JOIN Students s ON c.class_id = s.class_id
JOIN Scores sc ON s.student_id = sc.student_id
JOIN ClassAvgScore cas ON c.class_id = cas.class_id
WHERE sc.score < cas.avg_score
GROUP BY c.class_name;


