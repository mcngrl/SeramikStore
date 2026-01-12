CREATE OR ALTER PROCEDURE [dbo].[sp_Sepet_Insert]
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Sepet]
    ([ProductId], [InsertDate], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId])
    VALUES
    (@ProductId, GETDATE(), @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId);

    SELECT SCOPE_IDENTITY() AS NewId;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Sepet_Update]
    @Id int,
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Sepet]
    SET
        [ProductId] = @ProductId,
        [ProductCode] = @ProductCode,
        [ProductName] = @ProductName,
        [UnitPrice] = @UnitPrice,
        [Quantity] = @Quantity,
        [TotalAmount] = @TotalAmount,
        [UserId] = @UserId
    WHERE [Id] = @Id;
END

GO

