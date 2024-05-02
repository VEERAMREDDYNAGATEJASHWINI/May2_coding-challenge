-- SQL Schema:
create database codingchallenge1;
create table Vehicle (
vehicleID INT PRIMARY KEY,
make VARCHAR(30),
model VARCHAR(30),
year INT,
dailyRate DECIMAL(9, 2),
status ENUM('available', 'notAvailable', 'Null'),
passengerCapacity INT,
engineCapacity DECIMAL(9, 2)
);

create table Customer (
customerID INT PRIMARY KEY,
firstName VARCHAR(30),
lastName VARCHAR(30),
email VARCHAR(50),
phoneNumber VARCHAR(50)
);

create table Lease (
leaseID INT PRIMARY KEY,
vehicleID INT,
customerID INT,
startDate DATE,
endDate DATE,
type ENUM('DailyLease', 'MonthlyLease'),
foreign key (vehicleID) references Vehicle(vehicleID),
foreign key (customerID) references Customer(customerID)
);

create table Lease (
leaseID INT PRIMARY KEY,
vehicleID INT,
customerID INT,
startDate DATE,
endDate DATE,
type ENUM('DailyLease', 'MonthlyLease'),
foreign key (vehicleID) references Vehicle(vehicleID),
foreign key (customerID) references Customer(customerID)
);

create table Payment (
paymentID INT primary key,
leaseID INT,
paymentDate DATE,
amount DECIMAL(10, 2),
foreign key (leaseID) references Lease(leaseID)
);

-- inserting values 
insert into Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity) VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 1, 8, 2599);
(9, 'Audi', 'A4', 2022, 55.00,1, 4, 2500);
(10, 'Lexus', 'ES', 2023, 54.00, 1, 4, 2500);
select * from Vehicle;


insert into Customer (customerID, firstName, lastName, email, phoneNumber) values
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

insert into Lease (leaseID, vehicleID, customerID, startDate, endDate, type) values
(9, 9, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
(1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease'),
(3, 9, 3, '2023-03-10', '2023-03-15', 'DailyLease'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease');

select * from lease;

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount) VALUES
(1,1,'2023-01-03',200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4,'2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6,6,'2023-06-18', 1200.00),
(7,7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);


-- 1. Update the daily rate for a Mercedes car to 68.
update vehicle set dailyRate = 68.00 where make ='Mercedes';

-- 2. Delete a specific customer and all associated leases and payments.
delete from Payment where leaseID in(select leaseID from Lease where customerID = 9);
delete from Lease where customerID = 9;
delete from Customer where customerID = 9;

-- 3. Rename the "paymentDate" column in the Payment table to "transactionDate".
alter table Payment rename COLUMN paymentDate to transactionDate;

-- 4. Find a specific customer by email.
select * from Customer where customerID = 2;

-- 5. Get active leases for a specific customer.
select * from Lease where customerID <9 and enddate >= current_date;

-- 6. Find all payments made by a customer with a specific phone number.
select Payment.* from Payment
join Lease on Payment.leaseID = Lease.leaseID
join Customer on Lease.customerID = Customer.customerID
where Customer.phoneNumber = '555-555-5555';

-- 7. Calculate the average daily rate of all available cars.
select avg(dailyRate) as avg from vehicle where status = 'available';

-- 8. Find the car with the highest daily rate.
select * from vehicle where dailyRate = (select max(dailyRate) from Vehicle);

select * from vehicle
order by  dailyRate DESC
limit 1;

-- 9. Retrieve all cars leased by a specific customer.
select * from vehicle where vehicleID in ( select vehicleID from Lease where customerID = 1);

-- 10. Find the details of the most recent lease.
select * from  Lease where endDate = (select max(enddate) from Lease);

-- 11.	List all payments made in the year 2023. 
select transactiondate as payments_made from Payment where transactiondate >= '2023-01-01' and transactiondate < '2024-01-01';
select * from payment;

-- 12.	Retrieve customers who have not made any payments. 
select * from customer where customerID not in ( select distinct customer.customerID from customer
inner join Lease on customer.customerID = Lease.customerID
inner join Payment on Lease.leaseID = Payment.leaseID);

-- 13.	Retrieve Car Details and Their Total Payments. 
select vehicle.make,COALESCE(SUM(Payment.amount), 0) as total_payments from vehicle
left join Lease on vehicle.vehicleID = Lease.vehicleID
left join Payment on Lease.leaseID = Payment.leaseID group by vehicle.vehicleID;

select vehicle.make,SUM(Payment.amount) as total_payments from vehicle
left join Lease on vehicle.vehicleID = Lease.vehicleID
left join Payment on Lease.leaseID = Payment.leaseID group by vehicle.make;

-- 14.	Calculate Total Payments for Each Customer. 
select c.customerID,( select SUM(P.amount) from Lease 
join Payment AS P ON Lease.leaseID = P.leaseID where Lease.customerID = C.customerID) as total_payments from customer AS C;

-- 15.	List Car Details for Each Lease. 
select lease.leaseID,vehicle.make,vehicle.model,Vehicle.year,Vehicle.dailyRate,Vehicle.status,Vehicle.passengerCapacity,Vehicle.engineCapacity
from lease join vehicle on lease.vehicleID = Vehicle.vehicleID;

-- 16.	Retrieve Details of Active Leases with Customer and Car Information. 
SELECT lease.leaseID,customer.email,customer.phoneNumber,vehicle.make,vehicle.model,vehicle.year,vehicle.dailyRate,vehicle.status,
vehicle.passengerCapacity,vehicle.engineCapacity,lease.startDate,lease.endDate,lease.type from lease
join customer on Lease.customerID = Customer.customerID
join vehicle on Lease.vehicleID = vehicle.vehicleID
where lease.endDate >= current_date();

SELECT lease.leaseID,customer.email,customer.phoneNumber,vehicle.make,vehicle.model,vehicle.year,vehicle.dailyRate,vehicle.status,
vehicle.passengerCapacity,vehicle.engineCapacity,lease.startDate,lease.endDate,lease.type from lease
join customer on Lease.customerID = Customer.customerID
join vehicle on Lease.vehicleID = vehicle.vehicleID
where lease.endDate >= 2023;

-- 17.	Find the Customer Who Has Spent the Most on Leases. 
select Customer.customerID, sum(Payment.amount) AS total_payments from customer
left join lease on Customer.customerID = Lease.customerID left join Payment on Lease.leaseID = Payment.leaseID
group by customer.customerID
order by total_payments desc
limit 1;

-- 18.	List All Cars with Their Current Lease Information. 
select * FROM vehicle;
select * from Lease where endDate >= CURDATE() or endDate is null;

