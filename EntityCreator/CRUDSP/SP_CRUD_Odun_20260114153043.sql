CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_Insert]
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

    INSERT INTO [dbo].[Odun]
    ([ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [InsertDate], [IsActive])
    VALUES
    (@ProductId, @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId, GETDATE(), 1);

    SELECT SCOPE_IDENTITY() AS NewId;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_Update]
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

    UPDATE [dbo].[Odun]
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

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Odun]
    WHERE [Id] = @Id;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Odun]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Odun]
    WHERE [Id] = @Id
      AND IsActive = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Odun]
    WHERE IsActive = 1
END

GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Odun_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Odun]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Odun]
    WHERE IsActive = 1
END

