/*Database Name*/
CREATE DATABASE food_delivery;



/*OFFER table*/
CREATE TABLE Offer_tableS
(
  Offer_id INT NOT NULL,
  Discount INT NOT NULL,
  Type VARCHAR(15) NOT NULL,
  Last_date DATE NOT NULL,
  Start_date DATE NOT NULL,

  CONSTRAINT offer_tableS_PK PRIMARY KEY (Offer_id)
);


/*Resturent_table*/
CREATE TABLE Resturent_tableS
(
  r_id INT NOT NULL,
  Frist_name VARCHAR(20) NOT NULL,
  Last_name VARCHAR(20) NOT NULL,
  City VARCHAR(30) NOT NULL,
  Street VARCHAR(100) NOT NULL,
  Posatl_code VARCHAR(10) NOT NULL,
  Email VARCHAR(40) CHECK (Email LIKE '%_@_%_%')NOT NULL,
  
  CONSTRAINT Resturent_tableS_PK PRIMARY KEY (r_id)
);


/*Restaurant_phone_number_*/
CREATE TABLE Restaurant_phone_numberS
(
  r_id INT NOT NULL,
  phone_number VARCHAR(10) NOT NULL,
  
  CONSTRAINT Restaurant_phone_numberS_FK FOREIGN KEY (r_id) REFERENCES Resturent_tables(r_id),
  CONSTRAINT phone_number_CHK CHECK (phone_number BETWEEN 0000000000 AND 9999999999)
);

/*deliver driver table*/
CREATE TABLE Deliver_Drivers_tables
(
  D_id INT NOT NULL,
  r_id INT NOT NULL,
  Frist_named VARCHAR(30) NOT NULL,
  Last_named VARCHAR(30) NOT NULL,
  Date DATE NOT NULL,
  Time TIME NOT NULL,
  
	
  CONSTRAINT Deliver_Drivers_tables_PK PRIMARY KEY (D_id),
  CONSTRAINT Deliver_Drivers_tables_FK FOREIGN KEY (r_id) REFERENCES Resturent_tableS(r_id)
);

/*delivery phone number*/
CREATE TABLE Delivery_phone_numbers
(
  D_id INT NOT NULL,
  phone_number VARCHAR(12)NOT NULL,
  
  CONSTRAINT Delivery_phone_numbers_FK FOREIGN KEY(D_id) REFERENCES Deliver_Drivers_tables(D_id),
  CONSTRAINT Delivery_phone_numbers_CHK CHECK (phone_number BETWEEN 0000000000 AND 9999999999)
);

/*create admin*/
CREATE TABLE Admin_tables
(
  A_id INT NOT NULL,
  Re_id INT NOT NULL,
  DOB DATE NOT NULL,
  Frist_name VARCHAR(20) NOT NULL,
  Last_name VARCHAR(20) NOT NULL,
  Email VARCHAR(40) CHECK (Email LIKE '%_@_%_%')NOT NULL,

  CONSTRAINT Admin_tables_PK PRIMARY KEY (A_id)
);


/*craete admin_phone_number_table*/
CREATE TABLE admin_phone_number_tables
(
  A_id INT NOT NULL,
  phone_number VARCHAR(10) NOT NULL,
  
  
  CONSTRAINT admin_phone_number_tables_FK FOREIGN KEY (A_id) REFERENCES Admin_tables(A_id),
  CONSTRAINT admin_phone_number_tables_CHK CHECK (phone_number BETWEEN 0000000000 AND 9999999999)
);

/*create report table*/
CREATE TABLE report_tables
(
  Re_id INT NOT NULL,
  Date DATE NOT NULL,
  Type VARCHAR(20) NOT NULL,
  A_id INT NOT NULL,

  CONSTRAINT report_tables_PK PRIMARY KEY (Re_id),
  CONSTRAINT report_tables_FK FOREIGN KEY (A_id) REFERENCES Admin_tables(A_id),
);

/*create table REGISTER_TABLE*/
CREATE TABLE REGISTER_TABLEs
(
  User_id INT NOT NULL,
  Offer_id INT NOT NULL,
  DOB DATE NOT NULL,
  Password VARCHAR(15) NOT NULL,
  Frist_name VARCHAR(20) NOT NULL,
  Last_name VARCHAR(20) NOT NULL,
  Postal_code VARCHAR(10) NOT NULL,
  City VARCHAR(35) NOT NULL,
  Street VARCHAR(100) NOT NULL,
  Gender VARCHAR(6) NOT NULL,
  Email VARCHAR(40) NOT NULL,
  
  CONSTRAINT REGISTER_TABLEs_PK PRIMARY KEY (User_id),
  CONSTRAINT REGISTER_TABLEs_FK FOREIGN KEY (Offer_id) REFERENCES Offer_tableS(Offer_id)
);

/*create table REGISTER_USER_PHONE_NUMBER*/
CREATE TABLE REGISTER_USER_PHONE_NUMBERs
(
  User_id INT NOT NULL,
  phone_number VARCHAR(10) NOT NULL,
  
  CONSTRAINT REGISTER_USER_PHONE_NUMBERs_PK PRIMARY KEY (phone_number),
  CONSTRAINT REGISTER_USER_PHONE_NUMBERs_FK FOREIGN KEY (User_id) REFERENCES REGISTER_TABLEs(User_id),
  CONSTRAINT REGISTER_USER_PHONE_NUMBERs_CHK CHECK (phone_number BETWEEN 0000000000 AND 9999999999)
);

/*create table Payments*/
CREATE TABLE Payment
(
  P_id INT NOT NULL,
  A_id INT NOT NULL,
  R_id INT NOT NULL,
  Payment_amount INT NOT NULL,
  Time DATE NOT NULL,
  Visa VARCHAR(30) NOT NULL,
  Paypal VARCHAR(30) NOT NULL,
  Cash VARCHAR(30) NOT NULL,
  
  CONSTRAINT Payment_PK PRIMARY KEY (P_id),
  CONSTRAINT Payment_FK1 FOREIGN KEY (A_id) REFERENCES Admin_tables(A_id),
  CONSTRAINT Payment_FK2 FOREIGN KEY (R_id) REFERENCES Resturent_tableS(R_id)
);

/*ODER*/
CREATE TABLE order_tableS
(
  Order_id INT NOT NULL,
  Item_name VARCHAR(30) NOT NULL,
  Time DATE NOT NULL,
  Date DATE NOT NULL,
  P_id INT NOT NULL,

  CONSTRAINT order_tableS_PK PRIMARY KEY (Order_id),
  CONSTRAINT order_tableS_FK FOREIGN KEY (P_id) REFERENCES Payment(P_id)
);

/*CRATE restaurant_order*/
CREATE TABLE restaurant_order
(
  r_id INT NOT NULL,
  Order_id INT NOT NULL,
  
  CONSTRAINT restaurant_order_FK1 FOREIGN KEY (r_id) REFERENCES Resturent_tableS(r_id),
  CONSTRAINT restaurant_order_FK2 FOREIGN KEY (Order_id) REFERENCES order_tableS(Order_id),
);

/*CREATE supplier*/
CREATE TABLE supplier_table
(
  S_id INT NOT NULL,
  A_id CHAR(10) NOT NULL,
  Product_supplied VARCHAR(30) NOT NULL,
  name VARCHAR(20) NOT NULL,
  Email VARCHAR(40) CHECK (Email LIKE '%_@_%_%')NOT NULL,
  Address VARCHAR(100) NOT NULL,
  
  CONSTRAINT supplier_table_PK PRIMARY KEY (S_id),
  CONSTRAINT supplier_table_FK FOREIGN KEY (A_id) REFERENCES Admin_table(A_id)
);

/*supplier_phone_number_table*/
CREATE TABLE supplier_phone_number_table
(
  S_id INT NOT NULL,
  phone_number VARCHAR(10) NOT NULL,
  
  CONSTRAINT supplier_phone_number_table_PK PRIMARY KEY (S_id),
  CONSTRAINT supplier_phone_number_table_FK FOREIGN KEY (S_id) REFERENCES supplier_table(S_id),
  CONSTRAINT supplier_phone_number_table_CHK CHECK (phone_number BETWEEN 0000000000 AND 9999999999)
);

/*restaurant_supplier*/
CREATE TABLE restaurant_supplier
(
  R_id INT NOT NULL,
  S_id INT NOT NULL,
  
  CONSTRAINT restaurant_supplier_PK PRIMARY KEY (r_id, S_id),
  CONSTRAINT restaurant_supplier_FK FOREIGN KEY (r_id) REFERENCES Resturent_tables(r_id),
  CONSTRAINT restaurant_supplier_FK FOREIGN KEY (S_id) REFERENCES supplier_table(S_id)
);

/*raiting_and_review*/
CREATE TABLE raiting_and_review
(
  Raiting_id INT NOT NULL,
  A_id INT NOT NULL,
  User_id INT NOT NULL,
  r_id INT NOT NULL,
  Time DATE NOT NULL,
  Date DATE NOT NULL,
  raiting_text TEXT NOT NULL,
  
  CONSTRAINT raiting_and_review_PK PRIMARY KEY (Raiting_id),
  CONSTRAINT raiting_and_review_FK FOREIGN KEY (A_id) REFERENCES Admin_table(A_id),
  CONSTRAINT raiting_and_review_FK FOREIGN KEY (User_id) REFERENCES REGISTER_TABLE(User_id),
  CONSTRAINT raiting_and_review_FK FOREIGN KEY (r_id) REFERENCES Resturent_tables(r_id)
);

CREATE TABLE Item
(
  Item_id INT NOT NULL,
  Time TIME NOT NULL,
  Item_price DECIMAL NOT NULL,
  Item_description VARCHAR(255) NOT NULL,
  Offer_id INT NOT NULL,
  P_id INT NOT NULL,

  CONSTRAINT Item_PK PRIMARY KEY (Item_id),
  CONSTRAINT Item_FK FOREIGN KEY (Offer_id) REFERENCES OFFER(Offer_id),
  CONSTRAINT Item_FK FOREIGN KEY (P_id) REFERENCES Payment(P_id)
);

CREATE TABLE Register_user_item_
(
  User_id INT NOT NULL,
  Item_id INT NOT NULL,
  
  
  CONSTRAINT Register_user_item_FK FOREIGN KEY (Item_id) REFERENCES Item(Item_id),
  CONSTRAINT Register_user_item_FK FOREIGN KEY (User_id) REFERENCES REGISTER_TABLE(User_id)
);


		-- Insert data into the offer table--
INSERT INTO Offer_tableS(Offer_id, Discount, Type, Last_date , Start_date)
VALUES 
   (23001, '10', 'Percentage', '2023-11-31', '2023-10-01'),
   (23002, '20', 'Fixed Amount', '2023-11-15' , '2023-10-15'),
   (23003, '45', 'BOGO', '2023-11-01', '2023-10-01'),
   (23004, '15', 'Percentage', '2023-09-15', '2023-10-15'),
   (23005, '25', 'Fixed Amount', '2023-12-15', '2023-11-15');



		-- Insert data into the Restaurant table--
INSERT INTO Resturent_tables (r_id, Frist_name, Last_name, City, Street, Posatl_code, Email)
VALUES 
   (010, 'chamindu', 'wimukthi', 'Colombo', '123 Main St', '12345', 'chamindu1@example.com'),
   (020, 'siripal', 'gunathilaka', 'Tangalle', '456 Elm St', '54321', 'kalifa2@example.com'),
   (030, 'kavidu', 'keshan', 'Jaffna', '789 Oak St', '67890', 'keshan3@example.com'),
   (040, 'rusith', 'piyasiri', 'Galle', '101 Pine St', '23456', 'rusith4@example.com'),
   (050, 'sathira', 'pramudith', 'Hambantota', '555 Cedar St', '98765', 'pramudith5@example.com');



		-- Insert data into the Restaurant phone number table--
INSERT INTO  Restaurant_phone_numberS (r_id, phone_number)
VALUES
	(010,'0713475038'),
	(020,'0724275938'),
	(030,'0783250300'),
	(040,'0774550398'),
	(050,'0701475703');

	
		-- Insert data into the Delivery driver table--
INSERT INTO Deliver_Drivers_table(D_id, r_id, Frist_named, Last_named, Date, Time)
VALUES
	(1011 ,010,'KAMAL','SAMANTHA', '2023-04-05','02:30'),
	(1012 ,020,'DEVINDA','DILSHAN', '2023-07-10','12:30'),
	(1013 ,030,'THIWANKA','DEDUNU', '2023-06-11','02:00'),
	(1014 ,040,'DENUWAN','SENANAYAKA', '2023-04-05','02:30'),
	(1015 ,050,'SAHAN','GIMHANA', '2023-09-25','05:48');

	-- Insert data into the Delivery phone number table--
INSERT INTO Delivery_phone_number (D_id, phone_number)
VALUES 
	(1011,'0713245640'),
	(1012,'0706345640'),
	(1013,'0779245640'),
	(1014,'0723295680'),
	(1015,'0710245540');



	-- Insert data into the Admin table--
INSERT INTO Admin_table (A_id, DOB, Frist_name, Last_name, Email)
VALUES
   (5001, '1990-03-15', 'keshan', 'Smith', 'keshan1@example.com'),
   (5002, '1985-08-22', 'vimukthi', 'Johnson', 'vimukthi2@example.com'),
   (5003, '1982-11-10', 'lakshan', 'Williams', 'Williams3@example.com'),
   (5004, '1995-04-30', 'davinda', 'Davis', 'davinda4@example.com'),
   (5005, '1980-07-05', 'thilina', 'Brown', 'thilina5@example.com');


	-- Insert data into the Admin phone number table--
INSERT INTO admin_phone_number_table(A_id, phone_number) 
VALUES 
	(5001,'0723456789'),
    (5002,'0773455632'),
    (5003,'0700896789'),
    (5004,'0723456789'),
    (5005,'0723456389');


	-- Insert data into the Report table--
INSERT INTO report_table (Re_id, Date, Type, A_id)
VALUES
   (1, '2023-10-01', 'Incident',1),
   (2, '2023-10-02', 'Performance',2),
   (3, '2023-10-03', 'Financial',3),
   (4, '2023-10-04', 'Security',4),
   (5, '2023-10-05', 'Compliance',5);


   -- Insert data into the Register table--
INSERT INTO REGISTER_TABLE (User_id, DOB, Password, Frist_name, Last_name, Postal_code, City, Street, Gender, Email, Offer_id)
VALUES
   (1, '1990-01-15', 'mypassword1', 'Sudesh', 'Doe', '12345', 'Colombo', 'Main St', 'Male', 'sudesh.doe@example.com', 23001),
   (2, '1985-06-20', 'securepass123', 'Alice', 'Smith', '54321', 'Kurunagela', 'Elm St', 'Female', 'alice.smith@example.com',23002),
   (3, '1982-09-10', 'password1234', 'Hansi', 'Johnson', '98765', 'NuwaraEliya', 'Oak St', 'Male', 'hansi.j@example.com',23003),
   (4, '1992-03-30', 'secret789', 'Emily', 'Davis', '67890', 'Matara', 'Maple St', 'Female', 'emily.d@example.com',23004),
   (5, '2005-07-05', 'p@ssw0rd', 'Michael', 'Brown', '23456', 'Tangelle', 'Palm St', 'Male', 'michael.b@example.com',23005);


   -- Insert data into the Register user phone number table--
INSERT INTO REGISTER_USER_PHONE_NUMBER (User_id, phone_number)
VALUES 
	(1, '0706785431'),
	(2, '0727885490'),
	(3, '0719045431'),
	(4, '0776734631'),
	(5, '0706784322');


	-- Insert data into the Payment table--
INSERT INTO Payments (P_id, A_id, R_id, Payment_amount, Time, Visa, Paypal, Cash) 
VALUES
   (10200, 1, 010, 25.50, '07:50:34', 'Visa', 'A001','RS6'),
   (10201, 2, 020, 15.75, '18:30:30', 'Paypal', 'A002','RS45'),
   (10202, 3, 030, 30.00, '09:45:19', 'Cash', 'A003','RS30'),
   (10203, 4, 040, 12.99, '20:56:00', 'Visa', 'A004','RS5'),
   (10204, 5, 050, 50.25, '12:00:56', 'Paypal', 'A005','RS39');
   
   
   -- Insert data into the Order table
INSERT INTO order_tableS  (Order_id, Item_name, Time, Date, P_id)
VALUES
   (8001, 'Burger', '20:05', '2023-10-01', 1),
   (8002, 'Pizza', '03:25', '2023-10-02', 2),
   (8003, 'Pasta', '07:00', '2023-10-03', 3),
   (8004, 'Salad', '06:30', '2023-10-04', 4),
   (8005, 'Soda', '15:00', '2023-10-05', 5);   


   -- Insert data into the Resturent order table--
INSERT INTO  restaurant_order (r_id,Order_id)
VALUES
   (010,8001),
   (020,8002),
   (030,8003),
   (040,8004),
   (050,8005);

SELECT * FROM Offer_tableS;
SELECT * FROM Resturent_tableS;
SELECT * FROM Restaurant_phone_numberS;
SELECT * FROM Deliver_Drivers_table;
SELECT * FROM Delivery_phone_number;
SELECT * FROM Admin_table;
SELECT * FROM admin_phone_number_table;
SELECT * FROM report_table;
SELECT * FROM REGISTER_TABLE;
SELECT * FROM REGISTER_USER_PHONE_NUMBER;
SELECT * FROM Payment;
SELECT * FROM order_tableS;
SELECT * FROM restaurant_order;


DROP TABLE Offer_tableS;
