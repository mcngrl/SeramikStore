CREATE PROCEDURE [SeramikStore.Entities].[sp_Cart_Insert]
    @ProductId int,
    @ProductCode nvarchar,
    @ProductName nvarchar,
    @UnitPrice decimal,
    @Quantity int,
    @TotalAmount decimal,
    @UserId int,
    @InsertDate datetime,
    @UpdateDate datetime = NULL,
    @IsActive bit
AS
BEGIN
    INSERT INTO [SeramikStore.Entities].[Cart]
    ([ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [InsertDate], [UpdateDate], [IsActive])
    VALUES
    (@ProductId, @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId, @InsertDate, @UpdateDate, @IsActive)
    SELECT SCOPE_IDENTITY() AS NewId;
END

GO

CREATE PROCEDURE [SeramikStore.Entities].[sp_Cart_Update]
    @Id int,
    @ProductId int,
    @ProductCode nvarchar,
    @ProductName nvarchar,
    @UnitPrice decimal,
    @Quantity int,
    @TotalAmount decimal,
    @UserId int,
    @InsertDate datetime,
    @UpdateDate datetime = NULL,
    @IsActive bit
AS
BEGIN
    UPDATE [SeramikStore.Entities].[Cart]
    SET
        [ProductId] = @ProductId,
        [ProductCode] = @ProductCode,
        [ProductName] = @ProductName,
        [UnitPrice] = @UnitPrice,
        [Quantity] = @Quantity,
        [TotalAmount] = @TotalAmount,
        [UserId] = @UserId,
        [InsertDate] = @InsertDate,
        [UpdateDate] = @UpdateDate,
        [IsActive] = @IsActive
    WHERE [Id] = @Id;
END

GO

