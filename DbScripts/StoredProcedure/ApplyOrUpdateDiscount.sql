CREATE PROCEDURE ApplyOrUpdateDiscount
    @ProductId INT = NULL,
    @CategoryId INT = NULL,
    @DiscountPercentage DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Validate discount percentage (should be between 0 and 100)
    IF @DiscountPercentage < 0 OR @DiscountPercentage > 100
    BEGIN
        PRINT 'Error: Discount percentage must be between 0 and 100.';
        RETURN;
    END

    -- Apply discount to a specific product
    IF @ProductId IS NOT NULL
    BEGIN
        UPDATE Product
        SET DiscountPrice = Price - (Price * @DiscountPercentage / 100)
        WHERE ProductId = @ProductId;

        PRINT 'Discount applied to the specified product.';
    END

    -- Apply discount to all products in a category
    IF @CategoryId IS NOT NULL
    BEGIN
        UPDATE Product
        SET DiscountPrice = Price - (Price * @DiscountPercentage / 100)
        WHERE CategoryId = @CategoryId;

        PRINT 'Discount applied to all products in the specified category.';
    END

    -- Return success message
    SELECT 'Discount applied successfully.' AS Status;
END;
GO
