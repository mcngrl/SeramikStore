CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_Insert]
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

    INSERT INTO [dbo].[Vatan]
    ([ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [InsertDate], [IsActive])
    VALUES
    (@ProductId, @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId, GETDATE(), 1);

    SELECT SCOPE_IDENTITY() AS NewId;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_Update]
    @Id int,
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int,
    @UpdateDate datetime = NULL,
    @IsActive bit = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Vatan]
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

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Vatan]
    WHERE [Id] = @Id;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Vatan]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Vatan]
    WHERE [Id] = @Id
      AND IsActive = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Vatan]
    WHERE IsActive = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Vatan_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Vatan]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Vatan]
    WHERE IsActive = 1
END

