-- Active: 1729760896279@@127.0.0.1@5432@edu_institute_db

--- CREATE A STUDENTS TABLE!
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,   -- Unique identifier for students
    student_name VARCHAR(100),       -- Student's name
    age INTEGER,                     -- Student's age
    email VARCHAR(100),              -- Student's email address
    frontend_mark INTEGER,           -- Frontend assignment marks
    backend_mark INTEGER,            -- Backend assignment marks
    status VARCHAR(50)               -- Result status of the student
);

-- CREATE THE COURSES TABLE!
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,     -- Unique identifier for courses
    course_name VARCHAR(100),         -- Course's name
    credits INTEGER                   -- Number of credits for the course
);


-- CREATE THE ENROLLMENT TABLE!
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,  -- Unique identifier for enrollments
    student_id INTEGER REFERENCES students(student_id),  -- Foreign key referencing students
    course_id INTEGER REFERENCES courses(course_id)     -- Foreign key referencing courses
);


--** INSERT SAMPLE DATA **--

-- INSERT SAMPLE DATA INTO THE STUDENTS TABEL!
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- INSERT SAMPLE DATA INTO THE COURSES TABLE! 
INSERT INTO courses (course_name, credits) VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

-- INSERT SAMPLE DATA INTO THE ENROLLMENT TABLE!
INSERT INTO enrollment (student_id, course_id) VALUES
(1, 1),  -- Sameer enrolled in Next.js
(1, 2),  -- Sameer enrolled in React.js
(2, 1),  -- Zoya enrolled in Next.js
(3, 2);  -- Nabil enrolled in React.js



--** SQL QUERIES FOR VARIUS TASKS! **--

-- QUERY 1: INSERT A NEW STUDENT RECORD!
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Abdullah Al Mahfuz', 23, 'aamahfuz.pro@gmail.com', 60, 58, NULL);

-- QUERY 2: RETRIVE NAMES OF STUDENTS ENROLLED IN NEXT.JS! 
SELECT student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';


-- QUERY 3: UPDATE THE STATUS THE STUDENT WITH THE HIGHEST TOTAL MARKS!
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- QUERY 4: DELETE COURSES WITH NO STUDENTS ENROLLED!
DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);

-- QUERY 5: RETRIVE NAMES OF STUDENTS WITH LIMIT AND OFFSET!
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;  -- Start from the 3rd student

-- QUERY 6: RETRIVE COURSE NAME AND NUMBER OF STUDENTS ENROLLED!
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- QUERY 7: CALCULATE AND DISPLAY THE AVARAGE AGE OF ALL STUDENTS! 
SELECT AVG(age) AS average_age
FROM students;

-- QUERY 8: RETRIVE NAME OF STUDENTS WHOSE EMAILS  CONTAIN 'example.com'
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';