--Below are tables with no foreign keys
--@Block,
CREATE TABLE Department (
    Department_ID INT PRIMARY KEY NOT NULL,
    Department_Name VARCHAR(30) NOT NULL,
    Manager_ID INT NULL,
    Created_By VARCHAR(30),
    Created_At DATE,
    Updated_By VARCHAR(30),
    Updated_AT DATE
);

--@Block
CREATE TABLE Artist(
    Artist_ID INT PRIMARY KEY NOT NULL,
    Artist_Name VARCHAR(30) NOT NULL,
    Date_of_Birth DATE,
    Date_of_Death DATE NULL,
    Birth_Place VARCHAR(30)
);

--@Block
CREATE TABLE Exhibition(
    Exhibition_ID INT PRIMARY KEY NOT NULL,
    Exhibition_Name VARCHAR(50) NOT NULL,
    Starting_Date DATE NOT NULL,
    Ending_Date DATE NOT NULL
);

--@Block
CREATE TABLE Gift_Shop_Item(
    Gift_Shop_Item INT PRIMARY KEY NOT NULL,
    Name_of_Item VARCHAR(30),
    Price_of_Item DECIMAL(4,2),
    Category VARCHAR(30),
    Stock_Quantity INT NULL,
    Created_By VARCHAR(30),
    Created_At DATE,
    Updated_By VARCHAR(30),
    Updated_AT DATE
);

--@Block
CREATE TABLE Food(
    Food_ID INT PRIMARY KEY NOT NULL,
    Food_Name VARCHAR(30),
    Food_Price DECIMAL(4,2),
    Created_By VARCHAR(30),
    Created_At DATE,
    Updated_By VARCHAR(30),
    Updated_AT DATE
);

--@Block
CREATE TABLE Membership(
    Membership_ID INT PRIMARY KEY NOT NULL,
    Last_Name VARCHAR(30) NOT NULL,
    First_Name VARCHAR(30) NOT NULL,
    Phone_Number VARCHAR(10),
    Email VARCHAR(50),
    Date_Joined DATE,
    Date_Exited DATE NULL,
    Created_By VARCHAR(30),
    Created_At DATE,
    Updated_By VARCHAR(30),
    Updated_AT DATE
);

-- Below are tales with foreign keys
--@block

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY NOT NULL,
    Last_Name VARCHAR(30),
    First_Name VARCHAR(30),
    Date_Hired DATE,
    Email VARCHAR(50),
    Employee_Address VARCHAR(50),
    Date_of_Birth DATE,
    Hourly_Pay DECIMAL (6,2),
    Salary DECIMAL(10, 2),
    Employee_Role VARCHAR(20),
    Supervisor_ID INT NULL, 
    Department_ID INT NULL,
    Created_By VARCHAR(30),
    Created_At DATE,
    Updated_By VARCHAR(30),
    Updated_AT DATE,

    CONSTRAINT fk_Employee_Supervisor
    FOREIGN KEY (Supervisor_ID) REFERENCES Employee(Employee_ID)
    ON DELETE SET NULL,

    CONSTRAINT fk_Employee_Department
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
    ON DELETE SET NULL
);

--@Block, this is for circular foreign keys after tables have been made

ALTER TABLE Department
ADD CONSTRAINT fk_Employee_Manager
FOREIGN KEY (Manager_ID) REFERENCES Employee(Employee_ID)
ON DELETE SET NULL;

