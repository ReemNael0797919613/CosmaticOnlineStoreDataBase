DROP VIEW IF EXISTS ActiveItemsView;
GO

--> Activate Item View :

CREATE VIEW ActiveItemsView AS
SELECT 
    p.ProductId,
    p.Name AS ProductName,
    c.Name AS Category,
    b.Name AS Brand,
    p.Price,
    p.DiscountAmount,
    (p.Price - p.DiscountAmount) AS FinalPrice
FROM 
    Product p
JOIN 
    Category c ON p.CategoryId = c.CategoryId
JOIN 
    Brand b ON p.BrandId = b.BrandId
WHERE 
    p.Quantity > 0;
GO
SELECT*FROM ActiveItemsView;


--> Customer Wishlist View:
