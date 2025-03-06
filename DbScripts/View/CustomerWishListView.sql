CREATE VIEW CustomerWishlistView AS
SELECT 
    c.CustomerId,
    c.FullName AS CustomerName,
    c.Email,
    w.WishlistId,
    p.ProductId,
    p.Name AS ProductName,
    p.Description,
    p.Price,
    p.Quantity AS AvailableQuantity
FROM Customer c
INNER JOIN Wishlist w ON c.CustomerId = w.CustomerId
INNER JOIN Product p ON w.ProductId = p.ProductId;
GO


SELECT*FROM CustomerWishlistView;
--> Customer Wishlist View 