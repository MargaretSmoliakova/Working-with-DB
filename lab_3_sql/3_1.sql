USE EDUCATION;

SELECT AVG (MARK) AS ev_mark FROM EXAM_MARKS;

SELECT COUNT(*) FROM EXAM_MARKS;

SELECT COUNT (DISTINCT SUBJ_ID) FROM SUBJECT;

SELECT STUDENT_ID, MAX(MARK) AS max_mark FROM EXAM_MARKS GROUP BY STUDENT_ID;

SELECT STUDENT_ID, SUBJ_ID, MAX(MARK) FROM EXAM_MARKS GROUP BY STUDENT_ID, SUBJ_ID;

SELECT SUBJ_NAME, MAX(KHOUR) FROM SUBJECT GROUP BY SUBJ_NAME 
	HAVING MAX(KHOUR) >= 22;

SELECT * FROM SUBJECT ORDER BY SUBJ_NAME;

SELECT * FROM SUBJECT ORDER BY SUBJ_NAME DESC;

SELECT * FROM SUBJECT ORDER BY SEMESTR, SUBJ_NAME;

SELECT SUBJ_NAME, SEMESTR, MAX(KHOUR) FROM SUBJECT
	GROUP BY SEMESTR, SUBJ_NAME ORDER BY SEMESTR;

SELECT SUBJ_ID, SEMESTR FROM SUBJECT ORDER BY 2 DESC;
