CREATE TABLE students(
	roll_no INT,
    name VARCHAR(32),
    mark FLOAT
);

DELIMITER &&
CREATE TRIGGER marks_varify
BEFORE INSERT ON students
FOR EACH ROW
IF NEW.mark < 0 THEN SET NEW.mark = 0;
END IF; &&

INSERT INTO students VALUES
(111, "Sam", 75.5),
(112, "Anthony", -25);

SELECT * FROM students;