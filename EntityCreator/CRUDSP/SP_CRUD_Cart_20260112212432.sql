CREATE OR ALTER PROCEDURE [dbo].[sp_Cart_Insert]
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int,
    @IsActive bit
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Cart]
    ([ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [IsActive])
    VALUES
    (@ProductId, @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId, 1);

    SELECT SCOPE_IDENTITY() AS NewId;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Cart_Update]
    @Id int,
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int,
    @UpdateDate datetime = NULL,
    @IsActive bit
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Cart]
    SET
        [ProductId] = @ProductId,
        [ProductCode] = @ProductCode,
        [ProductName] = @ProductName,
        [UnitPrice] = @UnitPrice,
        [Quantity] = @Quantity,
        [TotalAmount] = @TotalAmount,
        [UserId] = @UserId,
        [UpdateDate] = GETDATE(),
        [IsActive] = @IsActive
    WHERE [Id] = @Id;
END

GO

