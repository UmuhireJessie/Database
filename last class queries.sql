-- List staff full details of staff members whose staff numbers are found in Branch Table.
-- use c2_db;
-- select * from staff
-- where branchNo = (select branchNo  from branch where branchNo='B003')

SELECT staffNo, fName, lName, position, 
  salary - (SELECT AVG(salary) FROM Staff) As SalDiff
FROM Staff
WHERE salary >
		(SELECT AVG(salary)
		 FROM Staff);
SELECT branchNo, count(staffNo) as NumberofStaffMembers, salary - 
(SELECT AVG(salary) FROM staff) As HowFarTheyGoAboveAverage FROM staff 
WHERE salary > (SELECT AVG(salary) FROM staff) GROUP by branchNo order by salary DESC;

-- Find the names of staff whose salary is larger than the average salary of the members of staff at branch B003.

-- select fName, lName, 
-- salary > (SELECT AVG(salary) FROM staff) as AverageSalary from staff 
-- where branchno=  (select branchno = 'B003' from branch) group by branchNo;

SELECT staffNo, fName, lName,
salary - (SELECT AVG(salary) FROM Staff) As AvgSal
FROM Staff
WHERE salary >
(SELECT AVG(salary)
FROM Staff);

SELECT fName, lName, salary
	FROM staff
	WHERE salary > ALL
				(SELECT AVG(salary)
				 FROM staff
				 WHERE branchNo = 'B003');
 SELECT s.branchNo, fName, lName
FROM Staff s, PropertyForRent p
WHERE s.staffNo = p.staffNo
ORDER BY s.branchNo, s.staffNo, propertyNo;

-- Find the names of Managers and the addresses of their branches 
select fName, lName, s.branchNo, b.branchNo 
from staff
where s.branchNo = b.branchNo;

SELECT s.fName, s.lname, s.position, s.branchNo, branchStreet
	FROM staff s, branch b
    WHERE s.branchNo = b.branchNo and s.position = 'manager';
    
-- 	Find the names of staff members who are managing/responsible for the properties which were viewed.
select s.fName, s.LName, p.staffNo, v.propertyNo 
from staff s, propertyforrent p, viewing v
where s.staffNo = p.staffNo and p.propertyNo = v.propertyNo;
