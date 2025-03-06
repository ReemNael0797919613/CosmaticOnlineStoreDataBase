SELECT p.Name, SUM(oi.Quantity) AS TotalQuantity
FROM OrderItem oi
JOIN Product p ON oi.ProductId = p.ProductId
JOIN Orders o ON oi.OrderId = o.OrderId
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY p.Name
ORDER BY TotalQuantity DESC;

--> Top-Selling Products
