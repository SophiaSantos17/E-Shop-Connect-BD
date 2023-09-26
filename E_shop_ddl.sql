
-- banco de dados
CREATE DATABASE EShopConnect;
USE EShopConnect;
 
-- Criação das tabelas

CREATE TABLE users(
    pk_userID       INT NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(100) NOT NULL,
    phoneNumber     VARCHAR(12) NULL COMMENT "scontando com os hifens",
    
    PRIMARY KEY(pk_userID)
);

CREATE TABLE buyer(
    pk_userID       INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY(pk_userID),
    FOREIGN KEY (pk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE seller(
    pk_userID       INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY (pk_userID),
    FOREIGN KEY (pk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE bankCard(
	pk_cardNumber	CHAR(16) NOT NULL COMMENT "sem o espaço dos numeros",
    expiryDate 		DATE NOT NULL,
    bank			VARCHAR(20),
    PRIMARY KEY (pk_cardNumber)
);

CREATE TABLE creditCard(
	pk_cardNumber	CHAR(16) NOT NULL COMMENT "sem o espaço dos numeros",
    fk_userID		INT NOT NULL,
    organization	VARCHAR(50),
    
    PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
	FOREIGN KEY (fk_userID) REFERENCES users(pk_userID)

);

CREATE TABLE debitCard(
	pk_cardNumber	CHAR(16) NOT NULL COMMENT "sem o espaço dos numeros",
    fk_userID		INT NOT NULL,
    
    PRIMARY KEY (pk_cardNumber),
    FOREIGN KEY (pk_cardNumber) REFERENCES bankCard(pk_cardNumber),
	FOREIGN KEY (fk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE store(
	pk_sid			INT NOT NULL,
    name			VARCHAR(50) NOT NULL,
    province		VARCHAR(35) NOT NULL,
    city			VARCHAR(40) NOT NULL,
    streetaddr		VARCHAR(40),
    costumerGrade	INT,
    startTime		DATE,
    
    PRIMARY KEY (pk_sid)
);

CREATE TABLE brand(
	pk_brand 		VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (pk_brand)
);

CREATE TABLE product(
	pk_pid			INT NOT NULL AUTO_INCREMENT,
    fk_sid			INT NOT NULL,
    name 			VARCHAR(120) NOT NULL,
    fk_brandName	VARCHAR(50) NOT NULL,
    type			VARCHAR(50),
    amount			INT DEFAULT 0,
    price			DECIMAL(6,2) NOT NULL,
    color			VARCHAR(25),
    modelNumber		VARCHAR(50),
    
    PRIMARY KEY (pk_pid),
    FOREIGN KEY (fk_sid) REFERENCES store(pk_sid),
    FOREIGN KEY (fk_brandName) REFERENCES brand(pk_brand)
    
);

CREATE TABLE orderItem(
	pk_itemID 		INT NOT NULL AUTO_INCREMENT,
    fk_pid 			INT NOT NULL,
    price			DECIMAL(6,2) NOT NULL,
    creationTime	TIME NOT NULL,
    
    PRIMARY  KEY (pk_itemID),
    FOREIGN KEY (fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE orders(
	pk_orderNumber	INT NOT NULL,
    payment_state	ENUM('Paid', 'Unpaid') NOT NULL,
    creation_time	TIME NOT NULL,
    totalAmount		DECIMAL(10,2),
    
    PRIMARY KEY (pk_orderNumber)
);

CREATE TABLE address(
	pk_addID			INT NOT NULL,
    fk_userID			INT NOT NULL,
    name				VARCHAR(50),
    contactPhoneNumber	VARCHAR(20),
    province			VARCHAR(100),
    city				VARCHAR(100),
    streetAddr			VARCHAR(100),
    postCode			VARCHAR(12),
    
    PRIMARY KEY (pk_addID),
    FOREIGN KEY (fk_userID) REFERENCES users(pk_userID)
);

CREATE TABLE comments(-- Entidade fraca
	creationTime	DATE NOT NULL,
    fk_userID		INT NOT NULL,
    fk_pid			INT NOT NULL,
    grade			FLOAT,
    content 		VARCHAR(500),
    
    PRIMARY KEY	(creationTime, fk_userID, fk_pid),
    FOREIGN KEY (fk_userID) REFERENCES users(pk_userID),
    FOREIGN KEY (fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE servicePoint(
	pk_spid		INT NOT NULL,
    streetAddr	VARCHAR(100) NOT NULL,
    city		VARCHAR(50),
    province	VARCHAR(100),
    startTime	VARCHAR(20),
    endTime		VARCHAR(20),
    
    PRIMARY KEY (pk_spid)
);

CREATE TABLE save_to_shopping_card(
	fk_userID 	INT NOT NULL,
    fk_pid		INT NOT NULL,
    addTime		DATE NOT NULL,
    quantity	INT NOT NULL,
    
    PRIMARY KEY (fk_userID, fk_pid),
    FOREIGN KEY (fk_userID) REFERENCES users(pk_userID),
    FOREIGN KEY (fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE contain(
	fk_orderNumber	INT NOT NULL,
    fk_itemID 		INT NOT NULL,
    qunatity		INT,
    
    PRIMARY KEY (fk_orderNumber, fk_itemID),
    FOREIGN KEY (fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY (fk_itemID) REFERENCES orderItem(pk_itemID)
);

CREATE TABLE payment(
	fk_orderNumber		INT NOT NULL,
    fk_creditCardNumber	VARCHAR(25),
    payTime				DATE,
    
    PRIMARY KEY (fk_orderNumber, fk_creditCardNumber),
	FOREIGN KEY (fk_orderNumber) REFERENCES orders(pk_orderNumber),
	FOREIGN KEY (fk_creditCardNumber) REFERENCES bankCard(pk_cardNumber)
);

CREATE TABLE deliver_To(
	fk_addID		INT NOT NULL,
    fk_orderNumber	INT NOT NULL,
    TimeDelivered	DATE,
    
    PRIMARY KEY(fk_addID, fk_orderNumber),
    FOREIGN KEY (fk_addID) REFERENCES address(pk_addID),
	FOREIGN KEY (fk_orderNumber) REFERENCES orders(pk_orderNumber)
);

CREATE TABLE manage (
    fk_userid             INT NOT NULL,
    fk_sid                 INT NOT NULL,
    setUpTime             DATE,
    
    PRIMARY KEY(fk_userid,fk_sid),
    FOREIGN KEY(fk_userid) REFERENCES seller(pk_userid),
    FOREIGN KEY(fk_sid) REFERENCES store (pk_sid)
);

 

CREATE TABLE After_Sales_Service_At(
    fk_brandName         VARCHAR(20) NOT NULL,
    fk_spid             INT NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand (pk_brand),
    FOREIGN KEY(fk_spid) REFERENCES servicePoint(pk_spid)
);
