
create table Customers
 (ID				      int,
  First_Name		      varchar(15)         not null,
  Last_Name		          varchar(15)         not null,
  Gender			      char                not null,
  Status			      varchar(10),
  Email			          varchar(20),
  phone			          varchar(15)         not null,
  Address			      varchar(30),
  Birth_Date              Date,
  Registeration_Date      Date,
  Primary key (ID));

create table Departments
 (ID                     int,
  Dep_Name               varchar(15)          not null,
  Mgr_ID                 int,
  primary key (ID),
  );

create table Employees
 (ID                     int,
  Status                 varchar(10),
  Salary                 Decimal(10,2),
  First_Name             varchar(15)          not null,
  Last_Name              varchar(15)          not null,
  Email                  varchar(20),
  Gender                 varchar(10)          not null,
  Attribute              varchar(20),
  Super_ID               int,
  Phone                  varchar(15),
  Dep_ID                 int,
  Address                varchar(30),
  Birth_Date             date,
  Hire_Date              date,
  primary key (ID),
  constraint SuperFK
   foreign key (Super_ID) references Employees(ID),
  constraint DepFK
   foreign key (Dep_ID) references Departments(ID));

alter table Departments add constraint MgrFk
 foreign key (Mgr_ID) references Employees(ID);

create table Orders
 (ID                     int,
  Amount                 int,
  Order_Date             Date,
  Delivery_Date          Date,
  Status                 varchar(10),
  Customer_ID            int,
  Delivery_ID            int,
  primary key (ID),
  constraint CustomerFK 
    foreign key (Customer_ID) references Customers(ID),
  constraint EmployeeFK
    foreign key (Delivery_ID) references Employees(ID));

create table Categories
 (ID                     int,
  Description            varchar(50),
  Name                   varchar(15)          not null,
  primary key (ID));

create table Products
 (ID                     int,
  Price                  Decimal(10,2),
  Name                   varchar(15)          not null,
  Quantity               int,
  Category_ID            int,
  Status                 varchar(10)          not null,
  primary key (ID),
  constraint CategoryFK
   foreign key (Category_ID) references Categories(ID));

create table Order_Details
 (Order_ID               int,
  Product_ID             int,
  Quantity               int                  not null,
  Price                  decimal(10,2)        not null,
  constraint OrderFK
   foreign key (Order_ID) references Orders(ID),
  constraint ProductFK
   foreign key (Product_ID) references Products(ID));

create table Warehouse
 (ID                     int,
  Name                   int                  not null,
  Location               varchar(30)          not null,
  Capacity               int
  Primary key (ID));

create table Contain
 (Category_ID            int,
  Warehouse_ID           int,
  Product_ID             int,
  Quantity               int,
  constraint CategoryFK1
   foreign key (Category_ID) references Categories(ID),
  constraint ProductFK1
   foreign key (Product_ID) references Products(ID),
  constraint WarehouseFK
   foreign key (Warehouse_ID) references Warehouse(ID));

create table Vendor
 (ID                     int,
  First_Name             varchar(15)          not null,
  Last_Name              varchar(15)          not null,
  Email                  varchar(30),
  Address                varchar(30),
  Phone                  varchar(15),
  primary key (ID));

create table Sell
 (Product_ID             int,
  Category_ID            int,
  Vendor_ID              int,
  Quantity               int                  not null,
  Date                   date,
  Price                  decimal(10,2)        not null,
  constraint CategoryFK2
   foreign key (Category_ID) references Categories(ID),
  constraint ProductFK2
   foreign key (Product_ID) references Products(ID),
  constraint VendorFK
   foreign key (Vendor_ID) references Vendor(ID));







