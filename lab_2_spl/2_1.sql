USE EDUCATION;

SELECT '�������', SURNAME, '���', FNAME, 100 
	FROM STUDENT;

SELECT SURNAME, FNAME, STIPEND, -(STIPEND*KURS)/2 
	FROM STUDENT 
	WHERE KURS = 4 AND STIPEND > 0;

SELECT SURNAME +'_'+ FNAME, STIPEND 
	FROM STUDENT 
	WHERE KURS = 4 AND STIPEND > 0;

SELECT LOWER (SURNAME), UPPER (FNAME) 
	FROM STUDENT 
	WHERE KURS = 4 AND STIPEND > 0;

SELECT SUBSTRING(FNAME,1,1)+'.'+SURNAME,CITY,LEN(CITY)
	FROM STUDENT 
    WHERE KURS IN(2,3,4)AND STIPEND > 0;

SELECT surname,charindex('���',surname),substring(surname,charindex('���',surname),3)
	FROM STUDENT;

/*DECLARE @myval decimal (5, 2);

SET @myval = 193.57;

SELECT CAST(@myval AS decimal(10,5));

SELECT CONVERT(varchar(6), @myval);

SELECT SURNAME,FNAME,BIRTHDAY,CONVERT(SMALLDATETIME, BIRTHDAY)
	FROM STUDENT;

SELECT SURNAME,BIRTHDAY,DATEDIFF(YEAR, CONVERT(SMALLDATETIME, BIRTHDAY), getdate()) AS VOZRAST
	FROM STUDENT;
	*/
