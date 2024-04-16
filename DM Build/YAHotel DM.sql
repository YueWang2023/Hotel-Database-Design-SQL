IF NOT EXISTS( 

	SELECT name FROM master.dbo.sysdatabases  

	WHERE name = N'YAHotelDM') 

	 

	CREATE DATABASE YAHotelDM

  

GO 

USE YAHotelDM

--

IF EXISTS( 

	SELECT * 

	FROM sys.tables 

	WHERE name = N'FactOrders') 

  

	DROP TABLE FactOrders; 

-- 

IF EXISTS( 

	SELECT * 

	FROM sys.tables 

	WHERE name = N'DimEmployees') 

	 

	DROP TABLE DimEmployees; 

-- 

IF EXISTS( 

	SELECT * 

	FROM sys.tables 

	WHERE name = N'DimCustomers') 

  

	DROP TABLE DimCustomers; 

-- 



IF EXISTS( 

	SELECT * 

	FROM sys.tables 

	WHERE name = N'DimRooms') 

  

	DROP TABLE DimRooms;  

 --

IF EXISTS(

	SELECT *

	FROM sys.tables

	WHERE name = N'DimDate')



	DROP TABLE DimDate;  


-- Create Tables


-- Create Table Date


 CREATE TABLE DimDate

	(

	Date_SK				INT PRIMARY KEY, 

	Date				DATE,

	FullDate			NCHAR(10),-- Date in MM-dd-yyyy format

	DayOfMonth			INT, -- Field will hold day number of Month

	DayName				NVARCHAR(9), -- Contains name of the day, Sunday, Monday 

	DayOfWeek			INT,-- First Day Sunday=1 and Saturday=7

	DayOfWeekInMonth	INT, -- 1st Monday or 2nd Monday in Month

	DayOfWeekInYear		INT,

	DayOfQuarter		INT,

	DayOfYear			INT,

	WeekOfMonth			INT,-- Week Number of Month 

	WeekOfQuarter		INT, -- Week Number of the Quarter

	WeekOfYear			INT,-- Week Number of the Year

	Month				INT, -- Number of the Month 1 to 12{}

	MonthName			NVARCHAR(9),-- January, February etc

	MonthOfQuarter		INT,-- Month Number belongs to Quarter

	Quarter				NCHAR(2),

	QuarterName			NVARCHAR(9),-- First,Second..

	Year				INT,-- Year value of Date stored in Row

	YearName			CHAR(7), -- CY 2017,CY 2018

	MonthYear			CHAR(10), -- Jan-2018,Feb-2018

	MMYYYY				INT,

	FirstDayOfMonth		DATE,

	LastDayOfMonth		DATE,

	FirstDayOfQuarter	DATE,

	LastDayOfQuarter	DATE,

	FirstDayOfYear		DATE,

	LastDayOfYear		DATE,

	IsHoliday			BIT,-- Flag 1=National Holiday, 0-No National Holiday

	IsWeekday			BIT,-- 0=Week End ,1=Week Day

	Holiday				NVARCHAR(50),--Name of Holiday in US

	Season				NVARCHAR(10)--Name of Season

	);
  

-- Create Room Table


CREATE TABLE DimRooms 

( 

Room_SK					INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 

RoomID					INT NOT NULL,

RoomNumber				INT NOT NULL, 

RoomSize				VARCHAR(50) NOT NULL, 

BedNumber			    INT NOT NULL, 

BedType					VARCHAR(50) NOT NULL, 

FloorNumber				INT NOT NULL, 

PetFriendly				INT NOT NULL, 

Handicap				INT NOT NULL, 

Smooking				INT NOT NULL, 

RoomPrice				MONEY NOT NULL 

); 
  

--Create Table Customers  


CREATE TABLE DimCustomers 

( 

Customer_SK				INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

CustomerID				INT NOT NULL, 

CustomerFName			NVARCHAR(15) NOT NULL, 

CustomerLName			NVARCHAR(30) NOT NULL, 

CustomerDOB				DATE NOT NULL, 

CustomerAge				INT NOT NULL, 

CustomerAgeGroup		NVARCHAR(30) NOT NULL, 

CustomerGender			NVARCHAR(15) NOT NULL, 

MembershipTier			NVARCHAR(15) NOT NULL, 

EmploymentType			NVARCHAR(15) NOT NULL 

); 

  
--Create Table Employees  


CREATE TABLE DimEmployees 

( 

Employee_SK				INT PRIMARY KEY IDENTITY(1,1) NOT NULL,

EmployeeID				INT NOT NULL, 

EmployeeFName			NVARCHAR(15) NOT NULL, 

EmployeeLName			NVARCHAR(30) NOT NULL, 

EmployeeTitle			NVARCHAR(15) NOT NULL 

); 


--Create Table Orders, Orders table has RoomID, EmployeeID, CustomerID, Date as foreign key.  


CREATE TABLE FactOrders 

( 

OrderID				INT PRIMARY KEY NOT NULL, 

Employee_SK			INT NOT NULL CONSTRAINT FK_Orders_Employees FOREIGN KEY REFERENCES DimEmployees(Employee_SK), 

Customer_SK			INT NOT NULL CONSTRAINT FK_Orders_Customers FOREIGN KEY REFERENCES DimCustomers(Customer_SK),   

Room_SK				INT NOT NULL CONSTRAINT FK_Orders_Rooms FOREIGN KEY REFERENCES DimRooms(Room_SK),     

ReservationPrice	MONEY NOT NULL, 

ReservationDate		INT NOT NULL CONSTRAINT FK_Orders_ReservationDate FOREIGN KEY REFERENCES DimDate(Date_SK), 

Quantity			INT NOT NULL, 

RoomPrice			MONEY NOT NULL, 

StartDate			INT NOT NULL CONSTRAINT FK_Orders_StartDate FOREIGN KEY REFERENCES DimDate(Date_SK), 

EndDate				INT NOT NULL CONSTRAINT FK_Orders_EndDate FOREIGN KEY REFERENCES DimDate(Date_SK), 

StayTime			INT NOT NULL, 

NumberofPeople		INT NOT NULL 

) 
