--MyAirline Reservasion Database
-- Majid Mazrooei
-- Data Science Projects
-- University of Tehran

Create Schema Customers;
Go


Create Schema Employees;
Go


Create Schema Crafts;
Go



Create Schema Flights;
Go

create schema Sales;
Go

create schema Final;
Go





--Tables of Customers 
create table Customers.Passengers
(
   NationalId NVARCHAR(10) not null 
       constraint pk_Passengers primary key,
   Firstname nvarchar(30) not null,
   Lastname nvarchar(30) not null,
   Father nvarchar(10) not null,
   Mobile nvarchar(11) not null,
   );

drop table customers.passengersinfo;
create table Customers.PassengersInfo
(
   InfId int not null identity(1,1)
       constraint pk_PassengersInfo primary key,
   NationalId NVARCHAR(10) not null references Customers.Passengers(NationalId),
   PassportNum nvarchar(8),
   BirthDate date not null,
   Country nvarchar(10) not null,
   City nvarchar(15) not null,
   Region nvarchar(20) not null,
   PostCode nvarchar(11),
   Plate nvarchar(5) not null
);








--Table of Employees
create table Employees.Emps
(
   EmpId int not null 
       constraint pk_emps primary key,
   NationalId NVARCHAR(10) not null,
   Firstname nvarchar(10) not null,
   Lastname nvarchar(15) not null,
   Position nvarchar(10) not null,
   Mobile nvarchar(11) not null,
   );



--Tables of Crafts
create table crafts.comps
(
   CompanyId int not null identity(1,1) 
       constraint pk_comps primary key,
   Company nvarchar(10) not null
);




create table crafts.crafts
(
    Craftid int not null identity(1,1)
	   constraint pk_crafts primary key,
    CompanyId int not null references crafts.comps(CompanyId),
	Model nvarchar(10) not null,
	Capacity int not null
);
   



-- Tables of Flights
create table Flights.Lanes
(
    LaneId int not null identity(1,1)
	   constraint pk_lanes primary key,
   	Origin nvarchar(20) not null,
	OriginAirport nvarchar(30) not null,
	Destination nvarchar(20) not null,
	DestinationAirport nvarchar(30) not null,
	RouteLength float not null
);


create table Flights.LanesDetails
(
    DetailId int not null identity(1,1)
	   constraint pk_lanesdetails primary key,
    LaneId int not null references Flights.Lanes(LaneId),
	FlightNumber nvarchar(10) not null,
	DeptDay nvarchar(12) not null,
   	DeptTime time(0) not null,
	ArrTime time(0) not null
	);




create table Flights.FlightInfo
(
    FlightId int not null identity(1,1)
	   constraint pk_FlightInfo primary key,
    DetailId int not null references Flights.LanesDetails(DetailId),
    CraftId int not null references crafts.crafts(CraftId),
   	DeptDate date not null,
	AvailableSeats int not null,
	--Price money not null
);








--Tables of Sales
--drop sequence sales.seq_no
drop sequence Sales.seq_no 


create table Sales.Orders
(
    OrderId int not null identity(1,1)
	   constraint pk_Orders primary key,
    FlightId int not null references flights.flightinfo(FlightId),
    NationalId NVARCHAR(10) not null references customers.Passengers(NationalId),
   	EmpId int not null references employees.emps(EmpId),
	Cost money not null 
);



create table Sales.Tickets
(
    TicketId int not null identity(1,1)
	   constraint pk_Tickets primary key,
    OrderId int not null references Sales.Orders(OrderId),
    SeatNumber int not null,
   	BaggageWeight Decimal(4,2) not null
);


-- Tables of Final
create table Final.FinalCheck
(
    CheckId int not null identity(1,1)
	     constraint pk_FinalCheck primary key,
    TicketId int not null references Sales.Tickets(TicketId),
	Presence nvarchar(3) not null,
	Boarding nvarchar(3) not null
);