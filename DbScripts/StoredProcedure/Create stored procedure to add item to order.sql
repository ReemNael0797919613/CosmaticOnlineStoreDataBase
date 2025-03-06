-- Create stored procedure to add item to order
CREATE PROCEDURE AddItemToOrder
    @CustomerId INT,
    @ProductId INT,
    @Quantity INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OrderId INT;
    DECLARE @ProductPrice DECIMAL(10,2);
    DECLARE @TotalAmount DECIMAL(10,2);

    -- Get the most recent order for the customer
    SELECT TOP 1 @OrderId = OrderId
    FROM Orders
    WHERE CustomerId = @CustomerId
    ORDER BY OrderDate DESC;

    -- Get the price of the product
    SELECT @ProductPrice = Price FROM Product WHERE ProductId = @ProductId;

    -- Calculate total amount for the added items
    SET @TotalAmount = @ProductPrice * @Quantity;

    -- Insert the order item into the OrderItem table
    INSERT INTO OrderItem (OrderId, ProductId, Quantity, Price)
    VALUES (@OrderId, @ProductId, @Quantity, @ProductPrice);

    -- Update the total amount of the order
    UPDATE Orders
    SET TotalAmount = TotalAmount + @TotalAmount
    WHERE OrderId = @OrderId;

    -- Update product stock after the order item is added
    UPDATE Product
    SET Quantity = Quantity - @Quantity
    WHERE ProductId = @ProductId;

    -- Return success message
    SELECT 'Item added successfully to the order.' AS Status;
END;
GO
