USE master;

CREATE DATABASE var9
	ON (NAME = var9_dat,
		FILENAME = 'C:\ALL\PROGRAMMING\DB\Homework\var9.mdf',
		SIZE = 10,
		FILEGROWTH = 5)
	LOG ON (NAME = var9_log,
			FILENAME= 'C:\ALL\PROGRAMMING\DB\Homework\var9.ldf',
			SIZE = 40,
			FILEGROWTH = 10);
