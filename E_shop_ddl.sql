CREATE DATABASE E_Shop_Conect;

USE E_Shop_Conect;

CREATE TABLE Users ( /*Armazena informações básicas sobre os usuários registrados no sistema, incluindo
compradores e vendedores.*/
	id_user int primary key,
    name varchar(40),
    phoneNum char(11)
    );
    
CREATE TABLE Buyer( /* Relaciona os usuários como compradores*/
	Buyer int,
    fk_id_user int,
    
    foreign key (fk_id_user) references users(id_user)
    );
    
CREATE TABLE Seller( /*Relaciona os usuários como vendedores*/
	Seller int,
    fk_id_user int,
    
    foreign key (fk_id_user) references users(id_user)
);

CREATE TABLE Bank_Card (
    id_card_number CHAR(16) PRIMARY KEY,
    fk_id_user INT,
    bank VARCHAR(60),
    expiryDate DATE,
    id_organization VARCHAR(30),
    FOREIGN KEY (fk_id_user)
        REFERENCES users (id_user)
);

CREATE TABLE Credt_Card ( /*Armazena informações específicas sobre os cartões de crédito*/
	fk_id_user int,
	fk_card_number char(16),
    fk_organization varchar(30),
    
    foreign key (fk_id_user) references users(id_user),
    foreign key (fk_card_number) references Bank_Card(id_card_number),
    foreign key (fk_organization) references Bank_Card(id_organization)
);

CREATE TABLE Debit_Card( /*Armazena informações específicas sobre os cartões de débito*/
	fk_id_user int,
	fk_card_number char(16),
    fk_organization varchar(30),
    
    foreign key (fk_id_user) references users(id_user),
    foreign key (fk_card_number) references Bank_Card(id_card_number),
    foreign key (fk_organization) references Bank_Card(id_organization)
);

CREATE TABLE Store( /*Representa informações sobre as lojas que vendem os produtos*/
	id_sid int primary key,
    name varchar(60),
    startTime time,
    customerGrade int(1),
    streetAddr varchar(40),
    city varchar(40),
    province varchar(40)
);

CREATE TABLE Product( /*Armazena detalhes sobre os produtos oferecidos pelas lojas*/
	id_pid int primary key,
    fk_sid int, 
    name varchar(60),
    brand varchar(40),
    type varchar(40),
    amount int,
    price decimal(3,2),
    color varchar(20),
    modelNumber int,
    
    foreign key (kf_sid) references Store(id_sid)
);

CREATE TABLE Item( /*Registra os itens individuais presentes em um pedido junto com seus preços*/
	id_item int primary key,
    pk_pid int,
	fk_price decimal(3,2),
    creationTime time,
    
    
    foreign key (kf_price) references Product(price),
    foreign key (kf_pid) references Product(id_pid)
);


CREATE TABLE Orders( /*Registra informações sobre os pedidos feitos pelos compradores, incluindo status de
pagamento e valor total.
*/
	orderNumber int primary key,
    creatiomTime  time,
    paymentStatus int(1), -- 1 = ativo, 2 = inativo
    totalAmount decimal (4,2)
);

CREATE TABLE Tabela_Address( /* Armazena os endereços de entrega dos compradores.
*/
	id_addr int primary key,
    fk_id_user int,
    name varchar(40),
    city varchar(40),
    postalCode char(8),
    streetAddr varchar(50),
    province varchar (40),
    
    foreign key (fk_id_user) references users(id_user)
);

CREATE TABLE Tabela_Brand ( /*Armazena os nomes das marcas do produtos*/
	brandName varchar(40)
);

CREATE TABLE Comments (
    creationTime datetime NOT NULL,
    fk_userid int,
    fk_pid int,
    grade float,
    content varchar(500),
    
    FOREIGN KEY (fk_userid) REFERENCES Buyer(Buyer), -- Referencia a tabela "Buyer" pelo Buyer.
    FOREIGN KEY (fk_pid) REFERENCES Product(id_pid) -- Referencia a tabela "Product" pelo id_pid.
);

CREATE TABLE ServicePoint (
    spid int PRIMARY KEY,
    streetAddr varchar(40),
    city varchar(30),
    province varchar(20),
    startTime time,
    endTime time
);

CREATE TABLE Save_to_ShoppingCart (
    fk_userid int,
    fk_pid int,
    addTime datetime,
    quantity int,
    
    FOREIGN KEY (fk_userid) REFERENCES Buyer(Buyer), -- Referencia a tabela "Buyer" pelo Buyer.
    FOREIGN KEY (fk_pid) REFERENCES Product(id_pid) -- Referencia a tabela "Product" pelo id_pid.
);

CREATE TABLE Contain (
    fk_orderNumber int,
    fk_itemid int,
    quantity int,
    
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(orderNumber), -- Referencia a tabela "Orders" pelo orderNumber.
    FOREIGN KEY (fk_itemid) REFERENCES Item(id_item) -- Referencia a tabela "Item" pelo id_item.
);

CREATE TABLE Payment (
    fk_orderNumber int,
    creditcardNumber varchar(25),
    payTime datetime,
    
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(orderNumber), -- Referencia a tabela "Orders" pelo orderNumber.
    FOREIGN KEY (creditcardNumber) REFERENCES Credit_Card(fk_card_number) -- Referencia a tabela "Credit_Card" pelo fk_card_number.
);

CREATE TABLE Deliver_To (
    fk_addrid int,
    fk_orderNumber int,
    TimeDelivered datetime,
    
    FOREIGN KEY (fk_addrid) REFERENCES Tabela_Address(id_addr), -- Referencia a tabela "Tabela_Address" pelo id_addr.
    FOREIGN KEY (fk_orderNumber) REFERENCES Orders(orderNumber) -- Referencia a tabela "Orders" pelo orderNumber.
);

CREATE TABLE Manage (
    fk_userid int,
    fk_sid int,
    SetUpTime datetime,
    
    FOREIGN KEY (fk_userid) REFERENCES Seller(Seller), -- Referencia a tabela "Seller" pelo Seller.
    FOREIGN KEY (fk_sid) REFERENCES Store(id_sid) -- Referencia a tabela "Store" pelo id_sid.
);

CREATE TABLE After_Sales_Service_At (
    brandName varchar(20) NOT NULL,
    fk_spid int,
    
    PRIMARY KEY (brandName, fk_spid),
    FOREIGN KEY (fk_spid) REFERENCES ServicePoint(spid) -- Referencia a tabela "ServicePoint" pelo spid.
);

