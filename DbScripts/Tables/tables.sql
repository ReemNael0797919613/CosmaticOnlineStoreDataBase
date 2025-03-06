DROP TABLE IF EXISTS IngredientProduct;
DROP TABLE IF EXISTS ProductRequest;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS Wishlist;
DROP TABLE IF EXISTS Discount;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Brand;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Person;
GO
-- Table for Person (Base table for Admin and Customer)
CREATE TABLE Person (
    PersonId INT IDENTITY(1,1) PRIMARY KEY,
    CreatedBy INT NULL,
    UpdatedBy INT NULL,
    IsActive BIT DEFAULT 1,
    CreationDate DATETIME DEFAULT GETDATE(),
    UpdateDate DATETIME DEFAULT GETDATE()
);
GO

-- Table for Admin
CREATE TABLE Admin (
    AdminId INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    ProfileImage NVARCHAR(255),
    PhoneNumber NVARCHAR(15),
    PersonId INT,  -- Reference to Person table
    FOREIGN KEY (PersonId) REFERENCES Person(PersonId) ON DELETE CASCADE
);
GO

-- Table for Customer
CREATE TABLE Customer (
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15),
    ProfileImage NVARCHAR(255),
    PersonId INT,  -- Reference to Person table
    FOREIGN KEY (PersonId) REFERENCES Person(PersonId) ON DELETE CASCADE
);
GO

-- Table for Category
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
	
);
GO


-- Table for Brand
CREATE TABLE Brand (
    BrandId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);
GO


-- Table for Product
CREATE TABLE Product (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    CategoryId INT,
    BrandId INT,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Cost DECIMAL(10,2) NOT NULL CHECK (Cost >= 0),
    HasDiscount BIT DEFAULT 0,
    DiscountAmount DECIMAL(10,2) DEFAULT 0 CHECK (DiscountAmount >= 0),
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE SET NULL,
    FOREIGN KEY (BrandId) REFERENCES Brand(BrandId) ON DELETE SET NULL
);
GO

-- Table for Orders
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE
	);
GO

-- Table for Order Items
CREATE TABLE OrderItem (
    OrderItemId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);
GO

-- Table for Wishlist
CREATE TABLE Wishlist (
    WishlistId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    ProductId INT NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE
);
GO

-- Table for Rating
CREATE TABLE Rating (
    RatingID INT IDENTITY(1,1) PRIMARY KEY,
    OrderItemID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FOREIGN KEY (OrderItemID) REFERENCES OrderItem(OrderItemID) ON DELETE CASCADE
);
GO

-- Table for Product Request
CREATE TABLE ProductRequest (
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Status VARCHAR(50) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Approved', 'Rejected')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);
GO
-- Table for Ingredient
CREATE TABLE Ingredient (
    IngredientId INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0)
);
GO

-- Table for Discount
CREATE TABLE Discount (
    DiscountId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT,
    CategoryId INT,
    DiscountAmount DECIMAL(10,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE SET NULL,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId) ON DELETE SET NULL
);
GO

-- Table for IngredientProduct
CREATE TABLE IngredientProduct (
    IngredientProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL,
    IngredientId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    FOREIGN KEY (ProductId) REFERENCES Product(ProductId) ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredient(IngredientId) ON DELETE CASCADE
);
GO


ALTER TABLE Admin
ADD CONSTRAINT CHK_Admin_Email CHECK (Email LIKE '%_@__%.__%');


ALTER TABLE Customer
ADD CONSTRAINT CHK_Customer_Email CHECK (Email LIKE '%_@__%.__%');

ALTER TABLE Category
ADD CONSTRAINT CHK_Category_Name CHECK (LEN(Name) >= 2),
CONSTRAINT CHK_Category_Name_NoSpecialChars CHECK (Name NOT LIKE '%[^a-zA-Z0-9 ]%');


ALTER TABLE Brand
ADD CONSTRAINT CHK_Brand_Name CHECK (LEN(Name) >= 2),
CONSTRAINT CHK_Brand_Name_NoSpecialChars CHECK (Name NOT LIKE '%[^a-zA-Z0-9 ]%');



ALTER TABLE Product
ADD CONSTRAINT CHK_Product_Price_GreaterThan_Cost CHECK (Price >= Cost),
 CONSTRAINT CHK_Product_DiscountAmount CHECK (DiscountAmount <= Price);


 ALTER TABLE Orders
ADD CONSTRAINT CHK_Orders_TotalAmount CHECK (TotalAmount >= 0),
CONSTRAINT CHK_Orders_OrderDate CHECK (OrderDate <= GETDATE());


ALTER TABLE OrderItem
ADD CONSTRAINT CHK_OrderItem_Quantity CHECK (Quantity > 0),
 CONSTRAINT CHK_OrderItem_Price CHECK (Price >= 0);

 ALTER TABLE Wishlist
ADD CONSTRAINT CHK_Wishlist_CustomerId CHECK (CustomerId > 0),
CONSTRAINT CHK_Wishlist_ProductId CHECK (ProductId > 0);


ALTER TABLE Rating
ADD CONSTRAINT CHK_Rating_Rating CHECK (Rating BETWEEN 1 AND 5);


ALTER TABLE ProductRequest
ADD CONSTRAINT CHK_ProductRequest_ProductName CHECK (LEN(ProductName) >= 2),
CONSTRAINT CHK_ProductRequest_Status CHECK (Status IN ('Pending', 'Approved', 'Rejected'));

ALTER TABLE Ingredient
ADD CONSTRAINT CHK_Ingredient_Name CHECK (LEN(Name) >= 2),
CONSTRAINT CHK_Ingredient_Quantity CHECK (Quantity >= 0);


ALTER TABLE Discount
ADD CONSTRAINT CHK_Discount_StartDate_EndDate CHECK (StartDate <= EndDate),
CONSTRAINT CHK_Discount_Amount CHECK (DiscountAmount >= 0);

ALTER TABLE IngredientProduct
ADD CONSTRAINT CHK_IngredientProduct_Quantity CHECK (Quantity > 0);
    