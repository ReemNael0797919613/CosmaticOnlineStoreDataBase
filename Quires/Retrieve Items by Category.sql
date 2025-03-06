SELECT p.Name, p.Price, p.HasDiscount, p.DiscountAmount
FROM Product p
JOIN Category c ON p.CategoryId = c.CategoryId
WHERE c.Name = 'Skincare';

--> Retrieve Items by Category


