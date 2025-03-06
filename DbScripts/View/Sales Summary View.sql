CREATE VIEW SalesSummaryView AS
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalAmount) AS TotalRevenue,
    COUNT(OrderId) AS NumberOfOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate);
GO

SELECT*FROM SalesSummaryView;