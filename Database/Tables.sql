USE ApplicationDB;

drop table if exists State_Tax;
drop table if exists Shopping_Cart_Items;
drop table if exists Credit_Card_Details;
drop table if exists Product_Reviews;
drop table if exists Purchase_History;
drop table if exists Order_Details;
drop table if exists Shipping_Type;
drop table if exists Customers;
drop table if exists Products;

create table Customers (
  userID varchar(50) not null primary key,
  password varchar(50) not null,
  firstName varchar(50) not null,
  lastName varchar(50) not null,
  addressLine1 varchar(50) not null,
  addressLine2 varchar(50),
  city varchar(50) not null,
  zipCode varchar(50)not null,
  state varchar(50) not null,
  emailAddress varchar(50) not null,
  phoneNumber varchar(50) not null,
  CONSTRAINT userID UNIQUE (userID)
);

create table Products(
  productID int not null primary key,
  productName varchar(50) not null,
  manufacturer varchar(50) not null,
  category varchar(50) not null,
  expirationDate varchar(50),
  price float,
  CONSTRAINT productID UNIQUE (productID)
);

create table State_Tax(
  storeName varchar(50) not null primary key,
  stateTax float,
  CONSTRAINT storeName UNIQUE (storeName)
);

create table Shopping_Cart_Items(
  shoppingCartID int not null primary key,
  productID int,
  price float,
  date date,
  userID varchar(50),
  quantity int,
  foreign key (productID) references Products(productID),
  foreign key (userID) references Customers(userID),
  CONSTRAINT shoppingCartID UNIQUE (shoppingCartID)
);

create table Shipping_Type(
  typeOfShipping varchar(50) not null primary key,
  price float,
  approxDeliveryDate int,
  CONSTRAINT typeOfShipping UNIQUE (typeOfShipping)
);

create table Order_Details(
  orderID int not null primary key,
  userID varchar(50) not null,
  addressLine1 varchar(50) not null,
  addressLine2 varchar(50),
  city varchar(50) not null,
  zipCode varchar(50) not null,
  state varchar(50) not null,
  stateTax float,
  typeOfShipping varchar(50),
  dateOfPurchase date,
  foreign key (userID) references Customers(userID),
  foreign key (typeOfShipping) references Shipping_Type(typeOfShipping),
  CONSTRAINT orderID UNIQUE (orderID)
);

create table Credit_Card_Details(
  userID varchar(50) not null primary key,
  creditCardNumber varchar(50) not null,
  cardType varchar(50) not null,
  CNN int not null,
  expiryDate date not null,
  foreign key (userID) references Customers(userID),
  CONSTRAINT creaditUsername UNIQUE (userID)
);

create table Product_Reviews(
  productID int not null primary key,
  title varchar(50) not null,
  review varchar(1000) not null,
  rating int not null,
  reviewDate date not null,
  userID varchar(50) not null,
  foreign key (productID) references Products(productID),
  foreign key (userID) references Customers(userID)
);

create table Purchase_History(
  userID varchar(50) not null,
  productID int not null,
  dateOfPurchase date not null,
  orderID int not null,
  quantity int not null,
  price float not null,
  foreign key (userID) references Customers(userID),
  foreign key (productID) references Products(productID),
  foreign key (orderID) references Order_Details(orderID)
);


/*Customers*/
insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('User1', 'password', 'John', 'Doe', '133 S 42nd St', 'd', 'Lincoln', '68123', 'Nebraska', 'johndoe@gmail.com', '123-456-7890');

insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('nuggetwugget2345645', 'JohnDoeIsMyHusband1234', 'Jane', 'Doe', '133 S 42nd St', 'd', 'Lincoln', '68123', 'Nebraska', 'janedoe@gmail.com', '123-867-5309');

insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('EclipseFox25', 'ctyndall2@!3', 'Christian', 'Tyndall', '1780 R St', 'Room 190', 'Lincoln', '68508', 'Nebraska', 'eclipsefox25@gmail.com', '402-421-1233');

insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('Anon535', 'AmveryGoodh4k3r', 'Harry', 'Gonzales', '229 John Daniel Drive', 'd', 'Farmington', '63640', 'Missouri', 'candida1990@hotmail.com', '573-664-1273');

insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('BumbleB33', 'timjTXthKorkcmERkHpU', 'Ann', 'Gomez', '3759 Round Table Drive', 'd', 'Sharonville', '45241', 'Ohio', 'everette.ha3@hotmail.com', '330-201-6505');

 insert into Customers (userID, password, firstName, lastName, addressLine1, addressLine2, city, zipCode, state, emailAddress, phoneNumber)
 values ('ehinderer', 'test123', 'd', 'e', 'r Round Table Drive', '3', '5', '1', '3', '5.ha3@hotmail.com', '6-201-6505');


/*Fruits*/
insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (1, 'Apple', 'Diamond Creek Acres', 'Fruits', 'jan', '1');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (2, 'Banana', 'Oak Ridge Ranch', 'Fruits', 'jan', '0.5');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (3, 'Cherry', 'Apple Inc.', 'Fruits', 'jan', '2');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (4, 'Grape', 'Apple Inc.', 'Fruits', 'jan', '1.5');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (5, 'Lemon', 'The Lego Company', 'Fruits', 'jan', '0.75');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (6, 'Mango', 'The Lego Company', 'Fruits', 'jan', '1.25');

 insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (7, 'Strawberry', 'The Lego Company', 'Fruitss', 'jan', '1.0');

/*Meats*/
insert into Products (productID, productName, manufacturer, category, expirationDate, price)
 values (8, 'Beef', 'Diamond Creek Acres', 'Meats', 'jan', '5');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (9, 'Chicken', 'Diamond Creek Acres', 'Meats', 'jan', '4');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (10, 'Duck', 'Diamond Creek Acres', 'Meats', 'jan', '6');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (11, 'Fish', 'Diamond Creek Acres', 'Meats', 'jan', '7');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (12, 'Lamb', 'Diamond Creek Acres', 'Meats', 'jan', '8');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (13, 'Pork', 'Diamond Creek Acres', 'Meats', 'jan', '4.5');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (14, 'Turkey', 'Diamond Creek Acres', 'Meats', 'jan', '6.5');

insert into Products (productID, productName, manufacturer, category, expirationDate, price)
  values (15, 'Venison', 'Diamond Creek Acres', 'Meats', 'jan', '9');

  /*Vegetables*/
  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
   values (16, 'Broccoli', 'Diamond Creek Acres', 'Vegetables', 'jan', '2');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (17, 'Carrot', 'Diamond Creek Acres', 'Vegetables', 'jan', '1');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (18, 'Cucumber', 'Diamond Creek Acres', 'Vegetables', 'jan', '5');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (19, 'Lettuce', 'Diamond Creek Acres', 'Vegetables', 'jan', '2');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (20, 'Onion', 'Diamond Creek Acres', 'Vegetables', 'jan', '8');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (21, 'Pepper', 'Diamond Creek Acres', 'Vegetables', 'jan', '0.3');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (22, 'Potato', 'Diamond Creek Acres', 'Vegetables', 'jan', '0.5');

  insert into Products (productID, productName, manufacturer, category, expirationDate, price)
    values (23, 'Tomato', 'Diamond Creek Acres', 'Vegetables', 'jan', '1.0');


-- /*State Tax*/
-- insert into State_Tax (storeName, stateTax) values ('Store #1234', '5.5');

-- insert into State_Tax (storeName, stateTax) values ('Store #5678', '0.5');

-- insert into State_Tax (storeName, stateTax) values ('Store #8675309', '2.4');

-- insert into State_Tax (storeName, stateTax) values ('Store #68508', '2.0');

-- /*Shopping Cart Items*/
-- -- insert into Shopping_Cart_Items (shoppingCartID, productID, price, date, userID, quantity)
-- --  values ('1234', '987', '799.99', '2023-01-25', 'EclipseFox25', '1');
-- --
-- -- insert into Shopping_Cart_Items (shoppingCartID, productID, price, date, userID, quantity)
-- --  values ('5433', '71411', '269.99', '2023-04-30', 'Anon535', '3');
-- --
-- -- insert into Shopping_Cart_Items (shoppingCartID, productID, price, date, userID, quantity)
-- --  values ('1344', '456', '2.02', '2023-04-30', 'Anon535', '150');

-- /*Shipping Type*/
-- insert into Shipping_Type (typeOfShipping, price, approxDeliveryDate)
--  values ('Free', '0.0', '7');

-- insert into Shipping_Type (typeOfShipping, price, approxDeliveryDate)
--  values ('Store-Pickup', '0.0', '2');

-- insert into Shipping_Type (typeOfShipping, price, approxDeliveryDate)
--  values ('Standard-Shipping', '4.00', '5');

-- insert into Shipping_Type (typeOfShipping, price, approxDeliveryDate)
--  values ('Same Day Delivery', '10.0', '1');

-- /*Order Details*/
-- insert into Order_Details (orderID, userID, addressLine1, addressLine2, city, zipCode, state, stateTax, typeOfShipping, dateOfPurchase)
--  values ('1234', 'EclipseFox25', '1780 R St', 'Room 190', 'Lincoln', '68508', 'Nebraska', '5.5', 'Free', '2023-01-25');

-- insert into Order_Details (orderID, userID, addressLine1, addressLine2, city, zipCode, state, stateTax, typeOfShipping, dateOfPurchase)
--  values ('5433', 'Anon535', '229 John Daniel Drive', null, 'Farmington', '63640', 'Missouri', '4.2', 'Store-Pickup', '2023-04-30');

-- insert into Order_Details (orderID, userID, addressLine1, addressLine2, city, zipCode, state, stateTax, typeOfShipping, dateOfPurchase)
--  values ('1344', 'Anon535', '229 John Daniel Drive', null, 'Farmington', '63640', 'Missouri', '4.2', 'Store-Pickup', '2023-04-30');

-- /*Credit Card Details*/
-- insert into Credit_Card_Details (userID, creditCardNumber, cardType, CNN, expiryDate)
--  values ('Anon535', '5097-1489-3622-2041', 'Mastercard', '810', '2026-01-01');

-- insert into Credit_Card_Details (userID, creditCardNumber, cardType, CNN, expiryDate)
--  values ('BumbleB33', '4048-3442-4724-3627', 'Visa', '774', '2026-03-01');

-- insert into Credit_Card_Details (userID, creditCardNumber, cardType, CNN, expiryDate)
--  values ('EclipseFox25', '4879-9046-7344-3415', 'Visa', '026', '2023-08-01');

-- insert into Credit_Card_Details (userID, creditCardNumber, cardType, CNN, expiryDate)
--  values ('nuggetwugget2345645', '6510-6774-6802-7813', 'Discover', '341', '2027-05-01');

-- insert into Credit_Card_Details (userID, creditCardNumber, cardType, CNN, expiryDate)
--  values ('Photobomber346969', '6504-0912-8010-0410', 'Discover', '124', '2026-07-01');

-- /*Product Reviews*/
-- insert into Product_Reviews (productID, title, review, rating, reviewDate, userID)
--  values ('987', 'Average Performance, iPhone 14 Review', 'As a long-time iPhone user, I was excited to upgrade to the iPhone 14, but not the best phone. The design is sleek, but nothing groundbreaking. The display is decent, but not as vibrant as I expected. Performance is fine, but not significantly better than previous models. Camera is good, but not exceptional. Overall, it is an average phone.', '3', '2023-01-25', 'EclipseFox25');

-- insert into Product_Reviews (productID, title, review, rating, reviewDate, userID)
--  values ('71411', 'Thrilling LEGO Bowser Set for Mario Fans!', 'I recently bought the LEGO Bowser set for my son, who is a big fan of Mario, and it has been a big hit! The build was challenging but enjoyable, with clear instructions and high-quality LEGO pieces. The final model is impressive, with authentic details and a menacing appearance. The interactive feature with the LEGO Mario figure adds an extra layer of playability, with Bowser''s moving arms and mouth. My son loves playing out epic battles between Bowser and Mario. It''s a fantastic addition to our LEGO Mario collection and has brought hours of imaginative play. Highly recommended for any Mario fans or LEGO enthusiasts!', '5', '2023-04-30', 'Anon535');

-- /*Purchase History*/
-- insert into Purchase_History (userID, productID, dateOfPurchase, orderID, quantity, price)
--  values ('EclipseFox25', '987', '2023-01-25', '1234', '1', '799.99');

-- insert into Purchase_History (userID, productID, dateOfPurchase, orderID, quantity, price)
--  values ('Anon535', '71411', '2023-04-30', '5433', '3', '269.99');

-- insert into Purchase_History (userID, productID, dateOfPurchase, orderID, quantity, price)
--  values ('Anon535', '456', '2023-04-30', '1344', '150', '2.02');