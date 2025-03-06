CREATE PROCEDURE GenerateSalesReport
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        O.OrderId,
        C.FullName AS CustomerName,
        P.Name AS ProductName,
        OI.Quantity,
        OI.Price AS PricePerItem,
        (OI.Quantity * OI.Price) AS TotalRevenue,
        O.OrderDate
    FROM Orders O
    INNER JOIN OrderItem OI ON O.OrderId = OI.OrderId
    INNER JOIN Product P ON OI.ProductId = P.ProductId
    INNER JOIN Customer C ON O.CustomerId = C.CustomerId
    WHERE O.OrderDate BETWEEN @StartDate AND @EndDate
    ORDER BY O.OrderDate DESC;
END;
GO

EXEC GenerateSalesReport '2025-03-01', '2025-03-31';
