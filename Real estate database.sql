use week9;
CREATE TABLE staff(
    staffNo varchar(5) not null,
    fName varchar(20) not null,
    lName varchar(20),
    position varchar(20) not null,
    sex char CHECK(sex in ('M', 'F')),
    d_o_b date,
    salary decimal(6,2),
    branchNo varchar(5) not null,
    PRIMARY KEY(staffNo));

CREATE TABLE Branch(
    branchNo varchar(5) not null,
    branchStreet varchar(20),
    branchCity varchar(20),
    branchState varchar(10), 
    branchZipCode varchar(7), 
    branchTelNo integer, 
    branchFaxNo integer, 
    managerStaffNo varchar(5),
    Primary Key (branchNo),
    UNIQUE(branchTelNo, branchFaxNo),
    CONSTRAINT Branch_FK Foreign Key (managerStaffNo) references staff(staffNo));

CREATE TABLE PrivateOwner(
    ownerNo varchar(5) not null,
    ownerName varchar(20),
    ownerAddress varchar(100),
    ownerTelNo integer,
    Primary Key (ownerNo));

CREATE TABLE PropertyType(
    propTypeNo varchar(5),
    propTypeDescription varchar(100),
    Primary Key (propTypeNo));

ALTER TABLE staff ADD CONSTRAINT staff_FK FOREIGN KEY(branchNo) REFERENCES Branch(branchNo);

CREATE TABLE Renter(
    renterNo varchar(5) not null,
    rFName varchar(20), 
    rLName varchar(20), 
    rAddress varchar(100), 
    rTelNo integer,
    maxRent integer,
    prefTypeNo varchar(5),
    Primary Key (renterNo),
    CONSTRAINT Renter_FK Foreign Key (prefTypeNo) references PropertyType(propTypeNo));
    
CREATE TABLE PropertyForRent(
    propertyNo varchar(5) not null,
    street varchar(30) not null,
    city varchar(30) not null,
    postCode varchar(5),
    type varchar(10) not null DEFAULT('F'),
    rooms integer not null DEFAULT(4),
    rent integer not null DEFAULT(600),
    ownerNo varchar(5) not null,
    staffNo varchar(5),
    branchNo varchar(5) not null,
    PRIMARY KEY(propertyNo),
    CONSTRAINT PropertyForRent_FK1 FOREIGN KEY(staffNo) REFERENCES staff(staffNo) on UPDATE CASCADE on DELETE set null,
    CONSTRAINT PropertyForRent_FK2 FOREIGN KEY(ownerNo) REFERENCES PrivateOwner(ownerNo) on UPDATE CASCADE on DELETE no ACTION,
    CONSTRAINT PropertyForRent_FK3 FOREIGN KEY(branchNo) REFERENCES Branch(branchNo) on UPDATE CASCADE on DELETE no ACTION);

CREATE TABLE Viewing(
	    propertyNo varchar(5) not null,
	    renterNo varchar(5) not null,
	    dateView date not null,
	    comments varchar(100),
	    Primary Key (propertyNo, renterNo, dateView),
	    CONSTRAINT Viewing_FK1 Foreign Key(propertyNo) references PropertyForRent(propertyNo),
	    CONSTRAINT Viewing_FK2 Foreign Key (renterNo) references Renter(renterNo));

ALTER TABLE staff DROP CONSTRAINT staff_FK ;

INSERT INTO staff
VALUES ('SG16', 'Alan', 'Brown', 'Assistant', 'M', Date'1957-05-25', 8300, 'B003');

INSERT INTO staff
VALUES ('SG17', 'Abraham', 'Deng', 'Supervisor', 'M', Date'2000-05-25', 9000, 'B003');

INSERT INTO staff
VALUES ('SG17', 'Edna', 'Akoth', 'Manager', 'F', Date'2001-06-25', 9000, 'B003');

INSERT INTO staff
VALUES ('SG17', 'Grace', 'Gihozo', 'Supervisor', 'M', Date'2000-05-25', 9000, 'B003');






