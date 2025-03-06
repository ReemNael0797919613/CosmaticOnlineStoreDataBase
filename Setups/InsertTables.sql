-- Insert data into Person table
INSERT INTO Person (CreatedBy, UpdatedBy)
VALUES (1, 1), (2, 2), (3, 3);


INSERT INTO Admin (FullName, Email, Password, ProfileImage, PhoneNumber, PersonId)
VALUES ('John Doe', 'john.doe@cosmeticsstore.com', 'adminpassword', 'admin1.jpg', '1234567890', 1),
       ('Alice Green', 'alice.green@cosmeticsstore.com', 'adminpassword', 'admin2.jpg', '0987654321', 2);

INSERT INTO Customer (FullName, Email, Password, PhoneNumber, ProfileImage, PersonId)
VALUES ('Mary Johnson', 'mary.johnson@cosmeticsstore.com', 'customerpassword', '1112233445', 'customer1.jpg', 1),
       ('Emily Davis', 'emily.davis@cosmeticsstore.com', 'customerpassword', '5566778899', 'customer2.jpg', 2),
       ('Sophia Lee', 'sophia.lee@cosmeticsstore.com', 'customerpassword', '6677889900', 'customer3.jpg', 3);

-- Insert data into Category table
INSERT INTO Category (Name)
VALUES ('Skin Care'),
       ('Hair Care'),
       ('Makeup'),
       ('Fragrance'),
       ('Body Care');

-- Insert data into Brand table
INSERT INTO Brand (Name)
VALUES ('Brand A'),
       ('Brand B'),
       ('Brand C'),
       ('Brand D'),
       ('Brand E');

-- Insert data into Product table
INSERT INTO Product (Name, Description, CategoryId, BrandId, Quantity, Price, Cost, HasDiscount, DiscountAmount)
VALUES ('Face Cream', 'Moisturizing face cream for dry skin', 1, 1, 100, 25.99, 15.00, 1, 5.00),
       ('Shampoo', 'Shampoo for oily hair', 2, 2, 150, 15.99, 8.00, 0, 0),
       ('Lipstick', 'Matte red lipstick', 3, 3, 50, 19.99, 10.00, 1, 3.00),
       ('Eau de Parfum', 'Luxury fragrance for women', 4, 4, 200, 49.99, 25.00, 0, 0),
       ('Body Lotion', 'Hydrating body lotion for smooth skin', 5, 5, 120, 18.99, 10.00, 1, 4.00);

-- Insert data into Orders table
INSERT INTO Orders (CustomerId, TotalAmount)
VALUES (1, 60.99),
       (2, 35.99),
       (3, 75.99);

-- Insert data into OrderItem table
INSERT INTO OrderItem (OrderId, ProductId, Quantity, Price)
VALUES (1, 1, 2, 25.99),  -- Order 1, Product: Face Cream, Quantity 2
       (1, 2, 1, 15.99),  -- Order 1, Product: Shampoo, Quantity 1
       (2, 3, 2, 19.99),  -- Order 2, Product: Lipstick, Quantity 2
       (3, 4, 1, 49.99),  -- Order 3, Product: Eau de Parfum, Quantity 1
       (3, 5, 2, 18.99);  -- Order 3, Product: Body Lotion, Quantity 2

-- Insert data into Wishlist table
INSERT INTO Wishlist (CustomerId, ProductId)
VALUES (1, 4),  -- Customer 1 adds Eau de Parfum to Wishlist
       (2, 5),  -- Customer 2 adds Body Lotion to Wishlist
       (3, 1);  -- Customer 3 adds Face Cream to Wishlist

-- Insert data into Rating table
INSERT INTO Rating (OrderItemID, Rating, Comment)
VALUES (1, 5, 'Amazing face cream, very moisturizing!'),
       (2, 4, 'Shampoo is good, but I expected more volume.'),
       (3, 3, 'Good lipstick, but the color didn’t last long enough.'),
       (4, 5, 'Great fragrance, long-lasting!'),
       (5, 4, 'Body lotion is nice, but a bit thick for summer.');

-- Insert data into ProductRequest table
INSERT INTO ProductRequest (CustomerID, ProductName, Description, Status)
VALUES (1, 'Anti-Aging Serum', 'Serum that reduces wrinkles and fine lines', 'Pending'),
       (2, 'Hair Growth Oil', 'Oil for hair regrowth and nourishment', 'Approved'),
       (3, 'Cleansing Gel', 'Gel to clean and hydrate the skin', 'Rejected');

	  -- Insert data into Product table (if not already done)
INSERT INTO Product (Name, Description, CategoryId, BrandId, Quantity, Price, Cost, HasDiscount, DiscountAmount)
VALUES 
('Hydrating Serum', 'Moisturizing serum for dry skin', 1, 1, 100, 25.00, 15.00, 1, 5.00),
('Lipstick Red', 'Matte red lipstick for all-day wear', 2, 2, 200, 15.00, 8.00, 0, 0.00),
('Shampoo', 'Sulfate-free shampoo for hair growth', 3, 3, 150, 20.00, 12.00, 0, 0.00),
('Foundation', 'Full coverage foundation with SPF', 2, 1, 80, 30.00, 18.00, 1, 8.00),
('Face Cream', 'Anti-aging face cream with vitamin C', 1, 3, 120, 35.00, 22.00, 0, 0.00),
('Conditioner', 'Nourishing conditioner for all hair types', 3, 2, 90, 18.00, 10.00, 1, 4.00);
GO

-- Insert data into Discount table with valid ProductId from the Product table
INSERT INTO Discount (ProductId, CategoryId, DiscountAmount, StartDate, EndDate)
VALUES 
(1, 1, 5.00, '2025-03-01', '2025-03-31'),
(4, 2, 8.00, '2025-03-01', '2025-03-31'),
(6, 3, 4.00, '2025-03-01', '2025-03-31');
GO

-- Insert data into IngredientProduct table 
INSERT INTO IngredientProduct (ProductId, IngredientId, Quantity)
VALUES 
(1, 1, 20),  -- Hydrating Serum with Vitamin C
(2, 2, 15),  -- Lipstick Red with Shea Butter
(3, 4, 30),  -- Shampoo with Argan Oil
(4, 5, 25),  -- Foundation with Tea Tree Oil
(5, 3, 10),  -- Face Cream with Cocoa Butter
(6, 2, 20);  -- Conditioner with Shea Butter
GO


INSERT INTO Ingredient (Name, Quantity)
VALUES ('Vitamin C', 100),
       ('Shea Butter', 200),
       ('Cocoa Butter', 150),
       ('Argan Oil', 80),
       ('Tea Tree Oil', 60);
GO
