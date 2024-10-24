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
