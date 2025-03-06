SELECT o.OrderId, p.Name, oi.Quantity, oi.Price, o.TotalAmount
FROM Orders o
JOIN OrderItem oi ON o.OrderId = oi.OrderId
JOIN Product p ON oi.ProductId = p.ProductId
WHERE o.CustomerId = 1;

--> Customer Purchase History

