-- ===============================================
-- FULL DATABASE SCRIPT
-- Generated: 4/21/2026 10:54:43 PM
-- ===============================================

-- ===============================
-- dbo.Cart
-- ===============================

IF OBJECT_ID('dbo.Cart', 'U') IS NOT NULL
    DROP TABLE [dbo].[Cart]
GO
CREATE TABLE [dbo].[Cart] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ProductId] int NOT NULL,
   [ProductCode] nvarchar(50) NOT NULL,
   [ProductName] nvarchar(255) NOT NULL,
   [UnitPrice] decimal(9,2) NOT NULL,
   [Quantity] int NOT NULL,
   [TotalAmount] decimal(9,2) NOT NULL,
   [UserId] int NULL,
   [InsertDate] datetime NOT NULL,
   [UpdateDate] datetime NULL,
   [IsActive] bit NOT NULL,
   [cart_id_token] nvarchar(200) NULL,
   [CurrencyCode] nvarchar(10) NOT NULL
)
GO

ALTER TABLE [dbo].[Cart]
ADD CONSTRAINT [PK_Cart]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Cart] ON
INSERT INTO [dbo].[Cart] ([Id], [ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [InsertDate], [UpdateDate], [IsActive], [cart_id_token], [CurrencyCode])
VALUES
(10, 3029, N'PK01', N'P kulp  köpek desenli fincan', 850.00, 6, 4250.00, 7023, '2026-04-19T01:18:23', '2026-04-20T11:01:34', 1, NULL, N'TL'),
(11, 3028, N'TM01', N'Travel Mug', 750.00, 2, 750.00, 7023, '2026-04-19T01:18:28', '2026-04-20T08:30:25', 1, NULL, N'TL'),
(12, 3030, N'PK02', N'P kulp  düz fincan', 850.00, 5, 4250.00, 7023, '2026-04-19T01:22:35', '2026-04-19T01:22:44', 1, NULL, N'TL'),
(14, 3031, N'KY01', N'Kulpsuz sandal fincan (2''li set)', 400.00, 1, 400.00, 7023, '2026-04-20T08:31:22', '2026-04-20T10:41:56', 1, NULL, N'TL'),
(16, 3030, N'PK02', N'P kulp  düz fincan', 850.00, 1, 850.00, 2003, '2026-04-20T11:01:47', '2026-04-21T13:27:00', 1, NULL, N'TL')
GO
SET IDENTITY_INSERT [dbo].[Cart] OFF

-- ===============================
-- dbo.Category
-- ===============================

IF OBJECT_ID('dbo.Category', 'U') IS NOT NULL
    DROP TABLE [dbo].[Category]
GO
CREATE TABLE [dbo].[Category] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Name] nvarchar(50) NOT NULL,
   [IsActive] bit NOT NULL
)
GO

ALTER TABLE [dbo].[Category]
ADD CONSTRAINT [PK__Category__3214EC072C50CF94]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Category] ON
INSERT INTO [dbo].[Category] ([Id], [Name], [IsActive])
VALUES
(6, N'Bardaklar', 1),
(7, N'Fincanlar', 1),
(8, N'Kupalar', 1),
(9, N'Sunumluklar', 1),
(10, N'Tabaklar', 1),
(11, N'Tüm Ürünler', 1)
GO
SET IDENTITY_INSERT [dbo].[Category] OFF

-- ===============================
-- dbo.Currency
-- ===============================

IF OBJECT_ID('dbo.Currency', 'U') IS NOT NULL
    DROP TABLE [dbo].[Currency]
GO
CREATE TABLE [dbo].[Currency] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Code] nvarchar(10) NOT NULL,
   [Name] nvarchar(50) NOT NULL,
   [Symbol] nvarchar(10) NOT NULL,
   [IsDefault] bit NOT NULL,
   [IsActive] bit NOT NULL
)
GO

ALTER TABLE [dbo].[Currency]
ADD CONSTRAINT [PK_Currency]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Currency] ON
INSERT INTO [dbo].[Currency] ([Id], [Code], [Name], [Symbol], [IsDefault], [IsActive])
VALUES
(1, N'TL', N'Türk Lirası', N'₺', 1, 1),
(2, N'USD', N'Amerikan Doları', N'$', 0, 0),
(3, N'EUR', N'Euro', N'€', 0, 0)
GO
SET IDENTITY_INSERT [dbo].[Currency] OFF

-- ===============================
-- dbo.OrderAddress
-- ===============================

IF OBJECT_ID('dbo.OrderAddress', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderAddress]
GO
CREATE TABLE [dbo].[OrderAddress] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [OrderHeaderId] int NOT NULL,
   [UserId] int NOT NULL,
   [Ad] nvarchar(100) NULL,
   [Soyad] nvarchar(100) NULL,
   [Telefon] nvarchar(100) NULL,
   [Il] nvarchar(50) NULL,
   [Ilce] nvarchar(100) NULL,
   [Mahalle] nvarchar(100) NULL,
   [Adres] nvarchar(MAX) NULL,
   [Baslik] nvarchar(40) NULL,
   [IsDefault] bit NULL
)
GO

ALTER TABLE [dbo].[OrderAddress]
ADD CONSTRAINT [PK_OrderAddress]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[OrderAddress] ON
INSERT INTO [dbo].[OrderAddress] ([Id], [OrderHeaderId], [UserId], [Ad], [Soyad], [Telefon], [Il], [Ilce], [Mahalle], [Adres], [Baslik], [IsDefault])
VALUES
(1, 1, 2004, N'xc', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'sdsdds', N'Yenişehir Mah. Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 Pendik İstanbul', N'sdsdds', 1)
GO
SET IDENTITY_INSERT [dbo].[OrderAddress] OFF

-- ===============================
-- dbo.OrderDetail
-- ===============================

IF OBJECT_ID('dbo.OrderDetail', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderDetail]
GO
CREATE TABLE [dbo].[OrderDetail] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [OrderId] int NOT NULL,
   [ProductId] int NOT NULL,
   [ProductCode] nvarchar(50) NULL,
   [ProductName] nvarchar(255) NULL,
   [ProductDesc] nvarchar(MAX) NULL,
   [UnitPrice] decimal(9,2) NOT NULL,
   [Quantity] int NOT NULL,
   [LineTotal] decimal(9,2) NOT NULL,
   [DisplayNo] int NOT NULL
)
GO

ALTER TABLE [dbo].[OrderDetail]
ADD CONSTRAINT [PK__OrderDet__3214EC07BCF1795B]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON
INSERT INTO [dbo].[OrderDetail] ([Id], [OrderId], [ProductId], [ProductCode], [ProductName], [ProductDesc], [UnitPrice], [Quantity], [LineTotal], [DisplayNo])
VALUES
(1, 1, 3029, N'PK01', N'P kulp  köpek desenli fincan', N'<p><br></p>', 850.00, 1, 850.00, 1)
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF

-- ===============================
-- dbo.OrderHeader
-- ===============================

IF OBJECT_ID('dbo.OrderHeader', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderHeader]
GO
CREATE TABLE [dbo].[OrderHeader] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [UserId] int NOT NULL,
   [AddressId] int NOT NULL,
   [OrderDate] datetime NOT NULL,
   [CargoAmount] decimal(9,2) NOT NULL,
   [CurrencyCode] nvarchar(10) NULL,
   [KargoSirketi] nvarchar(50) NULL,
   [KargoyaVerilmeTarihi] datetime NULL,
   [KargoTakipNo] nvarchar(250) NULL
)
GO

ALTER TABLE [dbo].[OrderHeader]
ADD CONSTRAINT [PK__OrderHea__3214EC07E278841D]
PRIMARY KEY CLUSTERED ([Id])
GO

-- ===============================
-- dbo.OrderStatus
-- ===============================

IF OBJECT_ID('dbo.OrderStatus', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderStatus]
GO
CREATE TABLE [dbo].[OrderStatus] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [OrderId] int NOT NULL,
   [StatusCode] int NOT NULL,
   [IslemTarihi] datetime NOT NULL,
   [IslemUserid] int NOT NULL,
   [Iptal] bit NOT NULL,
   [IptalTarihi] datetime NULL,
   [IptalUserid] int NULL
)
GO

ALTER TABLE [dbo].[OrderStatus]
ADD CONSTRAINT [PK_OrderStstus]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON
INSERT INTO [dbo].[OrderStatus] ([Id], [OrderId], [StatusCode], [IslemTarihi], [IslemUserid], [Iptal], [IptalTarihi], [IptalUserid])
VALUES
(1, 1, 10, '2026-04-14T10:04:53', 2004, 0, NULL, NULL),
(2, 1, 20, '2026-04-14T10:04:54', 2004, 0, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF

-- ===============================
-- dbo.OrderStatusTransition
-- ===============================

IF OBJECT_ID('dbo.OrderStatusTransition', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderStatusTransition]
GO
CREATE TABLE [dbo].[OrderStatusTransition] (
   [CurrentStatus] int NULL,
   [NextStatus] int NULL
)
GO
INSERT INTO [dbo].[OrderStatusTransition] ([CurrentStatus], [NextStatus])
VALUES
(10, 10),
(10, 20),
(20, 20),
(20, 30),
(30, 30),
(30, 40),
(40, 40),
(40, 50),
(50, 50),
(50, 60),
(60, 60),
(60, 70),
(70, 70),
(80, 80)
GO

-- ===============================
-- dbo.Product
-- ===============================

IF OBJECT_ID('dbo.Product', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product]
GO
CREATE TABLE [dbo].[Product] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ProductCode] nvarchar(50) NOT NULL,
   [ProductName] nvarchar(255) NOT NULL,
   [ProductDesc] nvarchar(MAX) NOT NULL,
   [CategoryId] int NOT NULL,
   [UnitPrice] decimal(9,2) NOT NULL,
   [CurrencyId] int NOT NULL,
   [AvailableForSale] bit NOT NULL,
   [DisplayOrderNo] int NULL
)
GO

ALTER TABLE [dbo].[Product]
ADD CONSTRAINT [PK_Product]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Product] ON
INSERT INTO [dbo].[Product] ([Id], [ProductCode], [ProductName], [ProductDesc], [CategoryId], [UnitPrice], [CurrencyId], [AvailableForSale], [DisplayOrderNo])
VALUES
(3028, N'TM01', N'Travel Mug', N'<p><br></p>', 6, 750.00, 1, 1, 1),
(3029, N'PK01', N'P kulp  köpek desenli fincan', N'<p><br></p>', 7, 850.00, 1, 1, 2),
(3030, N'PK02', N'P kulp  düz fincan', N'<p><br></p>', 7, 850.00, 1, 1, 3),
(3031, N'KY01', N'Kulpsuz sandal fincan (2''li set)', N'<p><br></p>', 7, 400.00, 1, 1, 4),
(3032, N'AB1', N'Fincan', N'<p><br></p>', 7, 750.00, 1, 1, 5),
(3033, N'AB2', N'Hayal Dünyası', N'<p><br></p>', 8, 850.00, 1, 1, 6),
(3034, N'AB3', N'Yeniden Kahve', N'<p><br></p>', 6, 900.00, 1, 1, 7),
(3035, N'AB3', N'Benimle', N'<p><br></p>', 8, 400.00, 1, 1, 8),
(3036, N'AB7', N'Yine Gel', N'<p><br></p>', 7, 500.00, 1, 1, 9),
(3037, N'AB5', N'İşte o an', N'<p><br></p>', 9, 860.00, 1, 1, 10),
(3038, N'TM03', N'sd', N'<p>sd</p>', 6, 154.00, 1, 1, 11),
(3039, N'da', N'asd', N'<p>s</p>', 6, 122.00, 1, 0, 12)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF

-- ===============================
-- dbo.ProductCategory
-- ===============================

IF OBJECT_ID('dbo.ProductCategory', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductCategory]
GO
CREATE TABLE [dbo].[ProductCategory] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ProductId] int NOT NULL,
   [CategoryId] int NOT NULL
)
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] ON
INSERT INTO [dbo].[ProductCategory] ([Id], [ProductId], [CategoryId])
VALUES
(12, 3028, 6),
(13, 3028, 8),
(14, 3028, 11),
(4, 3038, 9),
(15, 3039, 7),
(16, 3039, 10)
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF

-- ===============================
-- dbo.ProductImage
-- ===============================

IF OBJECT_ID('dbo.ProductImage', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductImage]
GO
CREATE TABLE [dbo].[ProductImage] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ProductId] int NOT NULL,
   [ImagePath] nvarchar(510) NOT NULL,
   [IsMain] bit NOT NULL,
   [DisplayOrder] int NOT NULL
)
GO

ALTER TABLE [dbo].[ProductImage]
ADD CONSTRAINT [PK__ProductI__3214EC07F21DBC9C]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON
INSERT INTO [dbo].[ProductImage] ([Id], [ProductId], [ImagePath], [IsMain], [DisplayOrder])
VALUES
(38, 3028, N'/uploads/products/3028/d36a8f9e-cee2-4067-a635-7a04a3102863.jpg', 0, 0),
(39, 3028, N'/uploads/products/3028/ffaca734-d2c5-4ffd-bc5f-d47d0f720c2f.jpg', 1, 0),
(40, 3028, N'/uploads/products/3028/a03d2d1c-13f5-4b21-be27-2875cb70ac44.jpg', 0, 0),
(41, 3028, N'/uploads/products/3028/2b871a71-bfa0-4d58-a21f-4531400ec216.jpg', 0, 0),
(42, 3029, N'/uploads/products/3029/08c0b053-886c-4e54-ab27-003e0b11daa7.jpg', 1, 0),
(43, 3029, N'/uploads/products/3029/33397b36-d4d9-4633-9a80-397a2c81d688.jpg', 0, 0),
(44, 3029, N'/uploads/products/3029/c16aceec-f0ed-4f92-8a54-8aacecefd8dc.jpg', 0, 0),
(45, 3030, N'/uploads/products/3030/321c5401-bbc7-4bbc-9774-9fe75e2df2a6.jpg', 0, 0),
(46, 3030, N'/uploads/products/3030/659dfd69-515b-4733-8a2c-7472666e5d0e.jpg', 1, 0),
(47, 3030, N'/uploads/products/3030/e14e2739-d7fd-48dc-a337-b14569645a46.jpg', 0, 0),
(48, 3030, N'/uploads/products/3030/db4d9247-d70f-4ce8-83b3-4cc97598d99e.jpg', 0, 0),
(49, 3031, N'/uploads/products/3031/cf99c94d-e857-45b4-a844-1c3333436452.jpg', 0, 0),
(50, 3031, N'/uploads/products/3031/80a6d4e6-c400-4217-a50f-e3003749bb98.jpg', 0, 0),
(51, 3031, N'/uploads/products/3031/be0eb7c3-a011-4684-90ac-b703870970fd.jpg', 1, 0),
(52, 3031, N'/uploads/products/3031/54eca33f-458e-4383-b61f-7e60d0c4eb6c.jpg', 0, 0),
(53, 3031, N'/uploads/products/3031/8cc6d11d-de67-4df4-bf5a-99396ad1b1af.jpg', 0, 0),
(54, 3032, N'/uploads/products/3032/c7b10942-ea2a-48d5-bfd1-443f8488e2cc.jpg', 1, 0),
(55, 3033, N'/uploads/products/3033/c1900ced-21cb-4ad7-8570-54eacd12b816.jpg', 1, 0),
(56, 3034, N'/uploads/products/3034/e7ef56ef-aba8-4a40-9917-898a466afcbd.jpg', 1, 0),
(57, 3035, N'/uploads/products/3035/98e698e8-090f-4b45-aa20-2b7fe55dce69.jpg', 1, 0),
(58, 3036, N'/uploads/products/3036/82c7f48b-f854-4eea-b30e-cb5aecb10399.jpg', 1, 0),
(59, 3037, N'/uploads/products/3037/4b16883a-379e-4be9-9cff-33c74836e80f.jpg', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[ProductImage] OFF

-- ===============================
-- dbo.Reason
-- ===============================

IF OBJECT_ID('dbo.Reason', 'U') IS NOT NULL
    DROP TABLE [dbo].[Reason]
GO
CREATE TABLE [dbo].[Reason] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Reasondesc] nvarchar(100) NOT NULL,
   [IsActive] bit NOT NULL,
   [IsCustom] bit NULL
)
GO
SET IDENTITY_INSERT [dbo].[Reason] ON
INSERT INTO [dbo].[Reason] ([Id], [Reasondesc], [IsActive], [IsCustom])
VALUES
(1, N'Ürün hasarlı geldi', 1, 0),
(2, N'Yanlış ürün gönderildi', 1, 0),
(3, N'Beklentimi karşılamadı', 1, 0),
(4, N'Açıklamayla uyuşmuyor', 1, 0),
(5, N'Geç teslim edildi', 1, 0),
(6, N'Siparişi yanlış verdim', 1, 0),
(7, N'Sebep belirtmek istemiyorum', 1, 0),
(8, N'Diğer', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Reason] OFF

-- ===============================
-- dbo.ReturnDetail
-- ===============================

IF OBJECT_ID('dbo.ReturnDetail', 'U') IS NOT NULL
    DROP TABLE [dbo].[ReturnDetail]
GO
CREATE TABLE [dbo].[ReturnDetail] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ReturnId] int NOT NULL,
   [OrderDetailId] int NOT NULL,
   [ProductId] int NOT NULL,
   [ReturnUnitPrice] decimal(9,2) NOT NULL,
   [ReturnQuantity] int NOT NULL,
   [ReturnLineTotal] decimal(9,2) NULL
)
GO

-- ===============================
-- dbo.ReturnHeader
-- ===============================

IF OBJECT_ID('dbo.ReturnHeader', 'U') IS NOT NULL
    DROP TABLE [dbo].[ReturnHeader]
GO
CREATE TABLE [dbo].[ReturnHeader] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [UserId] int NOT NULL,
   [ReturnRequestDate] datetime NOT NULL,
   [OrderId] int NOT NULL,
   [ReasonId] int NULL,
   [ReasonDesc] nvarchar(500) NULL,
   [BankName] nvarchar(100) NULL,
   [IBAN] nvarchar(50) NULL,
   [AccountHolderName] nvarchar(150) NULL,
   [ReturnCargoAmount] decimal(9,2) NULL,
   [IsFinalReturnForOrder] bit NULL
)
GO

-- ===============================
-- dbo.ReturnHeaderStatus
-- ===============================

IF OBJECT_ID('dbo.ReturnHeaderStatus', 'U') IS NOT NULL
    DROP TABLE [dbo].[ReturnHeaderStatus]
GO
CREATE TABLE [dbo].[ReturnHeaderStatus] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [OrderId] int NOT NULL,
   [ReturnHeaderId] int NOT NULL,
   [StatusForReturnCode] int NOT NULL,
   [IslemTarihi] datetime NOT NULL,
   [IslemUserid] int NOT NULL,
   [Iptal] bit NOT NULL,
   [IptalTarihi] datetime NULL,
   [IptalUserid] int NULL
)
GO

-- ===============================
-- dbo.Role
-- ===============================

IF OBJECT_ID('dbo.Role', 'U') IS NOT NULL
    DROP TABLE [dbo].[Role]
GO
CREATE TABLE [dbo].[Role] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Name] nvarchar(50) NULL
)
GO

ALTER TABLE [dbo].[Role]
ADD CONSTRAINT [PK_Role]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Role] ON
INSERT INTO [dbo].[Role] ([Id], [Name])
VALUES
(1, N'Admin'),
(2, N'Customer')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF

-- ===============================
-- dbo.Status
-- ===============================

IF OBJECT_ID('dbo.Status', 'U') IS NOT NULL
    DROP TABLE [dbo].[Status]
GO
CREATE TABLE [dbo].[Status] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Code] int NOT NULL,
   [Aciklama] nvarchar(50) NOT NULL
)
GO

ALTER TABLE [dbo].[Status]
ADD CONSTRAINT [PK_Status]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Status] ON
INSERT INTO [dbo].[Status] ([Id], [Code], [Aciklama])
VALUES
(1, 10, N'Şipariş Oluşturdu'),
(2, 20, N'Ödeme Bekleniyor'),
(3, 30, N'Ödeme Alındı'),
(4, 40, N'Sipariş Onaylandı'),
(5, 50, N'Sipariş Hazırlanıyor'),
(7, 60, N'Kargoya Verildi'),
(9, 70, N'Teslim Edildi'),
(10, 80, N'İptal')
GO
SET IDENTITY_INSERT [dbo].[Status] OFF

-- ===============================
-- dbo.StatusForReturn
-- ===============================

IF OBJECT_ID('dbo.StatusForReturn', 'U') IS NOT NULL
    DROP TABLE [dbo].[StatusForReturn]
GO
CREATE TABLE [dbo].[StatusForReturn] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Code] int NOT NULL,
   [Aciklama] nvarchar(50) NOT NULL
)
GO
SET IDENTITY_INSERT [dbo].[StatusForReturn] ON
INSERT INTO [dbo].[StatusForReturn] ([Id], [Code], [Aciklama])
VALUES
(1, 110, N'İade Kargosu Bekleniyor'),
(3, 120, N'İade Süreci Tamamlandı'),
(7, 180, N'İade Talebiniz İptal Edildi')
GO
SET IDENTITY_INSERT [dbo].[StatusForReturn] OFF

-- ===============================
-- dbo.User
-- ===============================

IF OBJECT_ID('dbo.User', 'U') IS NOT NULL
    DROP TABLE [dbo].[User]
GO
CREATE TABLE [dbo].[User] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [FirstName] nvarchar(50) NOT NULL,
   [LastName] nvarchar(50) NOT NULL,
   [Email] nvarchar(100) NOT NULL,
   [PasswordHash] nvarchar(254) NOT NULL,
   [PhoneNumber] nvarchar(20) NULL,
   [BirthDate] date NULL,
   [IsActive] bit NOT NULL,
   [RoleId] int NULL,
   [AcceptMembershipAgreement] bit NULL,
   [AcceptKvkk] bit NULL,
   [AgreementAcceptedAt] datetime2 NULL,
   [AgreementAcceptedIp] nvarchar(100) NULL,
   [IsEmailConfirmed] bit NOT NULL,
   [ResetPasswordToken] nvarchar(200) NULL,
   [ResetPasswordTokenExpire] datetime NULL,
   [RememberMeToken] nvarchar(200) NULL,
   [RememberMeExpire] datetime NULL,
   [EmailConfirmCode] nvarchar(10) NULL,
   [EmailConfirmCodeExpire] datetime NULL,
   [EmailConfirmAttemptCount] int NULL,
   [EmailConfirmLastSentAt] datetime NULL
)
GO

ALTER TABLE [dbo].[User]
ADD CONSTRAINT [PK__User__3214EC077669D901]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[User] ON
INSERT INTO [dbo].[User] ([Id], [FirstName], [LastName], [Email], [PasswordHash], [PhoneNumber], [BirthDate], [IsActive], [RoleId], [AcceptMembershipAgreement], [AcceptKvkk], [AgreementAcceptedAt], [AgreementAcceptedIp], [IsEmailConfirmed], [ResetPasswordToken], [ResetPasswordTokenExpire], [RememberMeToken], [RememberMeExpire], [EmailConfirmCode], [EmailConfirmCodeExpire], [EmailConfirmAttemptCount], [EmailConfirmLastSentAt])
VALUES
(2003, N'Can', N'Gürel', N'admin@admin.com', N'AQAAAAIAAYagAAAAEBCwp9AumgSg+KAR1R4NO6yyz3Dh9O8h4TSv9okU1MDWU7uDmT00cMgYv+W6M0RsoA==', N'321321', '2027-01-01T00:00:00', 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, N'a353203d3e4145cd93b95cbc9ff8efac', '2026-05-12T14:15:17', N'349997', '2026-04-18T21:12:28', 2, '2026-04-18T21:02:28'),
(2004, N'Ali', N'Veli', N'customer@customer.com', N'AQAAAAIAAYagAAAAEIfDOAtnAe0Y0ZCIgsJr/DvK5M8WbbfGGdyi5/mVzXCzJYNu2fZPDlfXVcm7CPVkDA==', N'32132', '2026-01-29T00:00:00', 1, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, N'349997', '2026-04-18T21:12:28', 2, '2026-04-18T21:02:28'),
(7023, N'Mehmet Can ve', N'Gürel', N'mehmetcangurel@gmail.com', N'AQAAAAIAAYagAAAAEHc4Nb/67kn13Mw9p4T8cINWoB/iJZw+0XRWG7MAv8cTIaLvkzRbs5hU1y+S4IhtCw==', N'(555) 555 55 55', '1978-01-01T00:00:00', 1, 2, 1, 1, '2026-04-18T22:33:44', N'::1', 0, N'c3dbbeb6b0af4471a526da09c2bb1122', '2026-04-20T19:26:18', NULL, NULL, N'125448', '2026-04-20T18:36:45', 5, '2026-04-20T18:26:45')
GO
SET IDENTITY_INSERT [dbo].[User] OFF

-- ===============================
-- dbo.UserAddress
-- ===============================

IF OBJECT_ID('dbo.UserAddress', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserAddress]
GO
CREATE TABLE [dbo].[UserAddress] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [UserId] int NOT NULL,
   [Ad] nvarchar(100) NULL,
   [Soyad] nvarchar(100) NULL,
   [Telefon] nvarchar(100) NULL,
   [Il] nvarchar(50) NULL,
   [Ilce] nvarchar(100) NULL,
   [Mahalle] nvarchar(100) NULL,
   [Adres] nvarchar(MAX) NULL,
   [Baslik] nvarchar(40) NULL,
   [IsDefault] bit NULL
)
GO

ALTER TABLE [dbo].[UserAddress]
ADD CONSTRAINT [PK__UserAddr__3214EC07A7406E1B]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[UserAddress] ON
INSERT INTO [dbo].[UserAddress] ([Id], [UserId], [Ad], [Soyad], [Telefon], [Il], [Ilce], [Mahalle], [Adres], [Baslik], [IsDefault])
VALUES
(1, 2003, N'Ahmet', N'Yılm', N'321321', N'İstanbul', N'Tuzla', N'meh', N'Hayır Sok. Evet Apt. No:25  ', N'Ev', 0),
(3, 2003, N'asas', N'as', N'as', N'sa', N'a', N'a', N'sa', N's', 0),
(1017, 2004, N'xc', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'sdsdds', N'Yenişehir Mah. Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 Pendik İstanbul', N'sdsdds', 1),
(1018, 7023, N'ad', N'ads', N'ad', N'as', N'asa', N'a', N'da', N'as', 1)
GO
SET IDENTITY_INSERT [dbo].[UserAddress] OFF


-- ===============================
-- STORED PROCEDURES
-- ===============================
-- dbo.sp_Cart_DecreaseQuantity

IF OBJECT_ID('dbo.sp_Cart_DecreaseQuantity', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_DecreaseQuantity]
GO
CREATE PROCEDURE [dbo].[sp_Cart_DecreaseQuantity]
    @CartId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Quantity INT;

    SELECT @Quantity = Quantity
    FROM Cart
    WHERE Id = @CartId
      AND IsActive = 1;

    IF (@Quantity > 1)
    BEGIN
        UPDATE Cart
        SET 
            Quantity = Quantity - 1,
            TotalAmount = (Quantity - 1) * UnitPrice
        WHERE Id = @CartId;
    END
    ELSE
    BEGIN
        -- 1’den 0’a düşüyorsa satırı sil
        DELETE FROM Cart WHERE Id = @CartId;
    END
END































GO

-- dbo.sp_Cart_Delete

IF OBJECT_ID('dbo.sp_Cart_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Cart]
    WHERE [Id] = @Id;
END






























GO

-- dbo.sp_Cart_DeleteById

IF OBJECT_ID('dbo.sp_Cart_DeleteById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_DeleteById]
GO
CREATE PROCEDURE [dbo].[sp_Cart_DeleteById]
    @CartId INT
AS
BEGIN
    DELETE FROM [Cart]
    WHERE Id = @CartId;

    -- Silinen satır sayısını döndür
    SELECT @@ROWCOUNT AS Result;
END









































GO

-- dbo.sp_Cart_DeleteSoft

IF OBJECT_ID('dbo.sp_Cart_DeleteSoft', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_DeleteSoft]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Cart]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END






























GO

-- dbo.sp_Cart_GetById

IF OBJECT_ID('dbo.sp_Cart_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,ProductCode,ProductName,UnitPrice,Quantity,TotalAmount,UserId,cart_id_token,CurrencyCode
    FROM [dbo].[Cart]
    WHERE [Id] = @Id
      AND IsActive = 1
END






























GO

-- dbo.sp_Cart_GetById_withImage

IF OBJECT_ID('dbo.sp_Cart_GetById_withImage', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_GetById_withImage]
GO


CREATE PROCEDURE [dbo].[sp_Cart_GetById_withImage]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT t1.Id,t1.ProductId,t1.ProductCode,t1.ProductName,t1.UnitPrice,t1.Quantity,t1.TotalAmount,t1.UserId,t1.cart_id_token,t1.CurrencyCode,
    t2.ImagePath AS MainImagePath
    FROM [dbo].[Cart] t1
    LEFT OUTER JOIN [dbo].[ProductImage] t2 on t1.ProductId = t2.ProductId and t2.IsMain = 1
    WHERE t1.[Id] = @Id
      AND IsActive = 1
END






























GO

-- dbo.sp_Cart_IncreaseQuantity

IF OBJECT_ID('dbo.sp_Cart_IncreaseQuantity', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_IncreaseQuantity]
GO
CREATE PROCEDURE [dbo].[sp_Cart_IncreaseQuantity]
    @CartId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE Cart
    SET 
        Quantity = Quantity + 1,
        TotalAmount = (Quantity + 1) * UnitPrice
    WHERE Id = @CartId
      AND IsActive = 1;
END































GO

-- dbo.sp_Cart_Inserorj

IF OBJECT_ID('dbo.sp_Cart_Inserorj', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_Inserorj]
GO
CREATE PROCEDURE [dbo].[sp_Cart_Inserorj]
(
    @ProductId     INT,
    @ProductCode   NVARCHAR(100),
    @ProductName   NVARCHAR(100),
    @UnitPrice     DECIMAL(9,2),
    @Quantity      INT,
    @UserId        INT
)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Cart
    (
        ProductId,
        ProductCode,
        ProductName,
        UnitPrice,
        Quantity,
        TotalAmount,
        UserId
    )
      OUTPUT INSERTED.Id
    VALUES
    (
        @ProductId,
        @ProductCode,
        @ProductName,
        @UnitPrice,
        @Quantity,
        @UnitPrice * @Quantity,
        @UserId
    );

END







































GO

-- dbo.sp_Cart_Insert

IF OBJECT_ID('dbo.sp_Cart_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_Insert]
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int = NULL,
    @cart_id_token nvarchar(200) = NULL,
    @CurrencyCode nvarchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Cart]
    ([ProductId], [ProductCode], [ProductName], [UnitPrice], [Quantity], [TotalAmount], [UserId], [InsertDate], [IsActive], [cart_id_token], [CurrencyCode])
    VALUES
    (@ProductId, @ProductCode, @ProductName, @UnitPrice, @Quantity, @TotalAmount, @UserId, GETDATE(), 1, @cart_id_token, @CurrencyCode);

    SELECT SCOPE_IDENTITY() AS NewId;
END






























GO

-- dbo.sp_Cart_List

IF OBJECT_ID('dbo.sp_Cart_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,ProductCode,ProductName,UnitPrice,Quantity,TotalAmount,UserId,cart_id_token,CurrencyCode
    FROM [dbo].[Cart]
    WHERE IsActive = 1
END






























GO

-- dbo.sp_Cart_ListByCartToken

IF OBJECT_ID('dbo.sp_Cart_ListByCartToken', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_ListByCartToken]
GO


    

CREATE PROCEDURE [dbo].[sp_Cart_ListByCartToken]
    @cart_id_token NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalAmount DECIMAL(18,2);
    DECLARE @CargoAmount DECIMAL(18,2);

    -- Cart items
    SELECT
        t1.Id,
        t1.ProductId,
        t2.ProductCode,
        t2.ProductName,
        t2.UnitPrice,
        t1.Quantity,
        t2.UnitPrice * t1.Quantity AS LineTotal,
        UserId,
        t1.cart_id_token,
        t1.CurrencyCode,
        t3.ImagePath MainImagePath
    FROM [Cart] t1
    LEFT OUTER JOIN [Product] t2 on t1.ProductId = t2.Id
    LEFT OUTER JOIN [ProductImage] t3 on t1.ProductId = t3.ProductId  and t3.IsMain=1
    WHERE t1.cart_id_token = @cart_id_token
      AND t1.Quantity > 0;

    SELECT
    SUM(t2.UnitPrice * t1.Quantity) AS TotalAmount,
    CAST(0 AS decimal(18,2))        AS CargoAmount,
    SUM(t2.UnitPrice * t1.Quantity) AS GrandTotal,
    t1.CurrencyCode
    FROM [Cart] t1
    INNER JOIN [Product] t2 ON t1.ProductId = t2.Id
    WHERE t1.cart_id_token = @cart_id_token
    AND t1.Quantity > 0
    GROUP BY t1.CurrencyCode;

END









































GO

-- dbo.sp_Cart_ListByUserId

IF OBJECT_ID('dbo.sp_Cart_ListByUserId', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_ListByUserId]
GO
CREATE PROCEDURE [dbo].[sp_Cart_ListByUserId]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalAmount DECIMAL(9,2);
    DECLARE @CargoAmount DECIMAL(9,2);

	SELECT @CargoAmount =CAST(50 AS decimal(9,2)) 

    -- Cart items
    SELECT
        t1.Id,
        t1.ProductId,
        t2.ProductCode,
        t2.ProductName,
        t2.UnitPrice,
        t1.Quantity,
        t2.UnitPrice * t1.Quantity AS LineTotal,
        UserId,
        t1.cart_id_token,
        t1.CurrencyCode,
        t3.ImagePath MainImagePath
    FROM [Cart] t1
    LEFT OUTER JOIN [Product] t2 on t1.ProductId = t2.Id
    LEFT OUTER JOIN [ProductImage] t3 on t1.ProductId = t3.ProductId  and t3.IsMain=1
    WHERE t1.UserId = @UserId
      AND t1.Quantity > 0;


    SELECT
    SUM(t2.UnitPrice * t1.Quantity) AS TotalAmount,
    @CargoAmount       AS CargoAmount,
    SUM(t2.UnitPrice * t1.Quantity) + @CargoAmount AS GrandTotal,
    t1.CurrencyCode
    FROM [Cart] t1
    INNER JOIN [Product] t2 ON t1.ProductId = t2.Id
    WHERE t1.UserId = @UserId
    AND t1.Quantity > 0
    GROUP BY t1.CurrencyCode;



END









































GO

-- dbo.sp_Cart_ListByUserIdA

IF OBJECT_ID('dbo.sp_Cart_ListByUserIdA', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_ListByUserIdA]
GO
CREATE PROCEDURE [dbo].[sp_Cart_ListByUserIdA]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalAmount DECIMAL(9,2);
    DECLARE @CargoAmount DECIMAL(9,2);

    SELECT 1
END


































GO

-- dbo.sp_Cart_PagedList

IF OBJECT_ID('dbo.sp_Cart_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,ProductCode,ProductName,UnitPrice,Quantity,TotalAmount,UserId,cart_id_token,CurrencyCode
    FROM [dbo].[Cart]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Cart]
    WHERE IsActive = 1
END































GO

-- dbo.sp_Cart_Save

IF OBJECT_ID('dbo.sp_Cart_Save', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_Save]
GO
CREATE PROCEDURE [dbo].[sp_Cart_Save]
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int = NULL,
    @cart_id_token nvarchar(200) = NULL,
    @CurrencyCode nvarchar(10)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ExistingCartId INT;


    SELECT @ExistingCartId = Id
    FROM Cart
    WHERE ProductId = @ProductId
      AND IsActive = 1
      AND (
            (@UserId IS NOT NULL AND UserId = @UserId)
         OR (@UserId IS NULL AND cart_id_token = @cart_id_token)
      );

    IF @ExistingCartId IS NOT NULL
    BEGIN
        -- 🔄 UPDATE
        UPDATE Cart
        SET
            Quantity = Quantity + @Quantity,
            TotalAmount = (Quantity + @Quantity) * @UnitPrice
        WHERE Id = @ExistingCartId;

        SELECT @ExistingCartId AS CartId;
    END
    ELSE
    BEGIN
   
        SELECT @TotalAmount =  @Quantity * @UnitPrice

        INSERT INTO Cart
        (
            ProductId,
            ProductCode,
            ProductName,
            UnitPrice,
            Quantity,
            TotalAmount,
            UserId,
            InsertDate,
            IsActive,
            cart_id_token,
            CurrencyCode
        )
        VALUES
        (
            @ProductId,
            @ProductCode,
            @ProductName,
            @UnitPrice,
            @Quantity,
            @TotalAmount,
            @UserId,
            GETDATE(),
            1,
            @cart_id_token,
            @CurrencyCode
        );

        SELECT SCOPE_IDENTITY() AS CartId;
    END
END
































GO

-- dbo.sp_Cart_Update

IF OBJECT_ID('dbo.sp_Cart_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-13 16:12:55
-- Generated at (UTC): 2026-02-13 13:12:55
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Cart_Update]
    @Id int,
    @ProductId int,
    @ProductCode nvarchar(50),
    @ProductName nvarchar(255),
    @UnitPrice decimal(9,2),
    @Quantity int,
    @TotalAmount decimal(9,2),
    @UserId int = NULL,
    @cart_id_token nvarchar(200) = NULL,
    @CurrencyCode nvarchar(10)
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
        [cart_id_token] = @cart_id_token,
        [CurrencyCode] = @CurrencyCode
    WHERE [Id] = @Id;
END






























GO

-- dbo.sp_Cart_UpdateQuantity

IF OBJECT_ID('dbo.sp_Cart_UpdateQuantity', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Cart_UpdateQuantity]
GO
CREATE PROCEDURE [dbo].[sp_Cart_UpdateQuantity]
    @CartId INT,
    @Quantity INT
AS
BEGIN
    UPDATE [Cart]
    SET 
        Quantity = @Quantity,
        TotalAmount = UnitPrice * @Quantity
    WHERE Id = @CartId;

    -- Güncellenen satır sayısını döndür
    SELECT @@ROWCOUNT AS Result;
END









































GO

-- dbo.sp_Category_Delete

IF OBJECT_ID('dbo.sp_Category_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Category]
    WHERE [Id] = @Id;
END






































GO

-- dbo.sp_Category_DeleteSoft

IF OBJECT_ID('dbo.sp_Category_DeleteSoft', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_DeleteSoft]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Category]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END






































GO

-- dbo.sp_Category_GetById

IF OBJECT_ID('dbo.sp_Category_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Category]
    WHERE [Id] = @Id
      AND IsActive = 1
END






































GO

-- dbo.sp_Category_Insert

IF OBJECT_ID('dbo.sp_Category_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_Insert]
    @Name nvarchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Category]
    ([Name], [IsActive])
    VALUES
    (@Name, 1);

    SELECT SCOPE_IDENTITY() AS NewId;
END






































GO

-- dbo.sp_Category_List

IF OBJECT_ID('dbo.sp_Category_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Category]
    WHERE IsActive = 1
END






































GO

-- dbo.sp_Category_PagedList

IF OBJECT_ID('dbo.sp_Category_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Category]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Category]
    WHERE IsActive = 1
END






































GO

-- dbo.sp_Category_Update

IF OBJECT_ID('dbo.sp_Category_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Category_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-18 00:25:26
-- Generated at (UTC): 2026-01-17 21:25:26
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Category_Update]
    @Id int,
    @Name nvarchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Category]
    SET
        [Name] = @Name
    WHERE [Id] = @Id;
END






































GO

-- dbo.sp_Currency_Delete

IF OBJECT_ID('dbo.sp_Currency_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_Delete]
GO
CREATE PROCEDURE [dbo].[sp_Currency_Delete]
(
    @Id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Currency
    SET
        IsActive    = 0
    WHERE Id = @Id;
END









































GO

-- dbo.sp_Currency_GetById

IF OBJECT_ID('dbo.sp_Currency_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_GetById]
GO
CREATE PROCEDURE [dbo].[sp_Currency_GetById]
(
    @Id INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        Code,
        Name,
        Symbol,
        IsDefault,
        IsActive
    FROM dbo.Currency
    WHERE Id = @Id;
END









































GO

-- dbo.sp_Currency_GetDefault

IF OBJECT_ID('dbo.sp_Currency_GetDefault', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_GetDefault]
GO
CREATE PROCEDURE [dbo].[sp_Currency_GetDefault]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM dbo.Currency
    WHERE IsDefault = 1 AND IsActive = 1;
END









































GO

-- dbo.sp_Currency_Insert

IF OBJECT_ID('dbo.sp_Currency_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_Insert]
GO
CREATE PROCEDURE [dbo].[sp_Currency_Insert]
(
    @Code         NVARCHAR(10),
    @Name         NVARCHAR(50),
    @Symbol       NVARCHAR(10),
    @IsDefault    BIT
)
AS
BEGIN
    SET NOCOUNT ON;

    -- Eğer default yapılacaksa diğerlerini kapat
    IF @IsDefault = 1
    BEGIN
        UPDATE dbo.Currency SET IsDefault = 0;
    END

    INSERT INTO dbo.Currency
    (
        Code, Name, Symbol,  IsDefault,IsActive
    )
    VALUES
    (
        @Code, @Name, @Symbol,  @IsDefault,1
    );
END









































GO

-- dbo.sp_Currency_List

IF OBJECT_ID('dbo.sp_Currency_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_List]
GO
CREATE PROCEDURE [dbo].[sp_Currency_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        Code,
        Name,
        Symbol,
        IsDefault,
        IsActive
    FROM dbo.Currency
    WHERE IsActive = 1
    ORDER BY IsDefault DESC, Name;
END









































GO

-- dbo.sp_Currency_Update

IF OBJECT_ID('dbo.sp_Currency_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Currency_Update]
GO
CREATE PROCEDURE [dbo].[sp_Currency_Update]
(
    @Id   INT,
    @Code         NVARCHAR(10),
    @Name         NVARCHAR(50),
    @Symbol       NVARCHAR(10),
    @IsDefault    BIT
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @IsDefault = 1
    BEGIN
        UPDATE dbo.Currency SET IsDefault = 0;
    END

    UPDATE dbo.Currency
    SET
        Code         = @Code,
        Name         = @Name,
        Symbol       = @Symbol,
        IsDefault    = @IsDefault
    WHERE Id = @Id;
END









































GO

-- dbo.sp_Find

IF OBJECT_ID('dbo.sp_Find', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Find]
GO
CREATE PROCEDURE sp_Find
    @SearchText NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.name AS SchemaName,
        o.name AS ObjectName,
        o.type_desc AS ObjectType
    FROM sys.sql_modules m
    INNER JOIN sys.objects o ON m.object_id = o.object_id
    INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE m.definition LIKE '%' + @SearchText + '%'
      AND o.type IN ('P', 'V') -- P: Procedure, V: View
    ORDER BY s.name, o.name;
END





GO

-- dbo.sp_Order_CancelLastStatus

IF OBJECT_ID('dbo.sp_Order_CancelLastStatus', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_CancelLastStatus]
GO
Create   PROCEDURE [dbo].[sp_Order_CancelLastStatus]
    @OrderId INT,
    @UserId INT
AS
BEGIN

    DECLARE @LastOrderStatusId int

    SELECT TOP 1 
    @LastOrderStatusId = Id
    FROM [OrderStatus] 
    WHERE OrderId = @OrderId
    and Iptal =0
    ORDER BY IslemTarihi DESC;

    UPDATE OrderStatus 
    SET Iptal=1 , IptalTarihi = GETDATE(), IptalUserid =@UserId
    WHERE Id = @LastOrderStatusId
     
END





























GO

-- dbo.sp_Order_Create

IF OBJECT_ID('dbo.sp_Order_Create', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_Create]
GO


CREATE PROCEDURE [dbo].[sp_Order_Create]
    @UserId INT,
    @AddressId INT,
    @CargoAmount DECIMAL(9,2)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        DECLARE @CurrencyCode nvarchar(10)
        SELECT 
        TOP 1 @CurrencyCode = t1.CurrencyCode
        FROM [Cart] t1
        WHERE t1.UserId = @UserId
        AND t1.Quantity > 0
        GROUP BY t1.CurrencyCode;

        DECLARE @OrderId INT;

        -- 1️⃣ OrderHeader
        INSERT INTO OrderHeader
        (
            UserId,
            AddressId,
            OrderDate,
            CargoAmount,
            CurrencyCode
        )
        VALUES
        (
            @UserId,
            @AddressId,
            GETDATE(),
            @CargoAmount,
            @CurrencyCode
        );

        SET @OrderId = SCOPE_IDENTITY();

        -- 2️⃣ OrderDetail (Cart’tan snapshot)
        INSERT INTO OrderDetail
        (
            OrderId,
            ProductId,
            ProductCode,
            ProductName,
            ProductDesc,
            UnitPrice,
            Quantity,
            LineTotal,
            DisplayNo
        )
        SELECT
            @OrderId,
            p.Id,
            p.ProductCode,
            p.ProductName,
            p.ProductDesc,
            p.UnitPrice,
            c.Quantity,
            p.UnitPrice * c.Quantity,
            ROW_NUMBER() OVER (ORDER BY c.Id)
        FROM Cart c
        INNER JOIN Product p ON c.ProductId = p.Id
        WHERE c.UserId = @UserId
          AND c.Quantity > 0;

        -- 3️⃣ Cart temizleme (istersen soft yaparız)
        DELETE FROM Cart WHERE UserId = @UserId;

        INSERT INTO [dbo].[OrderStatus]
           ([OrderId]
           ,[StatusCode]
           ,[IslemTarihi]
           ,[IslemUserid]
           ,[Iptal])
        SELECT @OrderId,10,GETDATE(),@UserId,0

        INSERT INTO [dbo].[OrderStatus]
           ([OrderId]
           ,[StatusCode]
          ,[IslemTarihi]
           ,[IslemUserid]
           ,[Iptal])
        SELECT @OrderId,20,  DATEADD(SECOND, 1, GETDATE()) ,@UserId,0


		INSERT INTO [dbo].[OrderAddress]
		([OrderHeaderId],[UserId],[Ad],[Soyad],[Telefon],[Il],[Ilce],[Mahalle],[Adres],[Baslik],[IsDefault])

		select @OrderId,t2.UserId,t2.Ad,t2.Soyad,t2.Telefon,t2.Il,t2.Ilce,t2.Mahalle,t2.Adres,t2.Baslik,t2.IsDefault 
		from  UserAddress t2 
		where t2.UserId = @UserId
		and t2.Id = @AddressId


        COMMIT;


        -- 4️⃣ Output
        SELECT 
            @OrderId AS OrderId,
            'Siparişiniz oluşturuldu. Ödeme bekleniyor.' AS Message;

    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END







































GO

-- dbo.sp_Order_GetAllStatus

IF OBJECT_ID('dbo.sp_Order_GetAllStatus', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetAllStatus]
GO
CREATE   PROCEDURE [dbo].[sp_Order_GetAllStatus]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        s.Code,
        s.Aciklama
    FROM  [Status] s 
    WHERE s.Code <80
    ORDER BY s.Code;

END

























GO

-- dbo.sp_Order_GetById

IF OBJECT_ID('dbo.sp_Order_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetById]
GO
CREATE PROCEDURE [dbo].[sp_Order_GetById]
    @OrderId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Header
    SELECT
        oh.Id,
        oh.OrderDate,
        oh.CargoAmount,
        oh.UserId,
        oh.AddressId,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) AS ProductTotal,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) + oh.CargoAmount AS GrandTotal
    FROM OrderHeader oh
    WHERE oh.Id = @OrderId;

    -- Detail
    SELECT
        ProductCode,
        ProductName,
        ProductDesc,
        UnitPrice,
        Quantity,
        LineTotal,
        DisplayNo
    FROM OrderDetail
    WHERE OrderId = @OrderId
    ORDER BY DisplayNo;
END









































GO

-- dbo.sp_Order_GetDetailedInfoById

IF OBJECT_ID('dbo.sp_Order_GetDetailedInfoById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetDetailedInfoById]
GO

CREATE PROCEDURE [dbo].[sp_Order_GetDetailedInfoById]
    @OrderId INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @LastStatuAciklama nvarchar(50)
    DECLARE @LastStatuCode int

        SELECT TOP 1 
        @LastStatuAciklama =t2.Aciklama,
        @LastStatuCode = t2.Code
        FROM [OrderStatus] t1
        LEFT JOIN [Status] t2 ON t1.StatusCode = t2.Code
        WHERE t1.OrderId = @OrderId
        and t1.Iptal =0
        ORDER BY t1.IslemTarihi DESC;

    -- Header
    SELECT
        oh.Id,
        oh.OrderDate,
        @LastStatuCode AS OrderStatusCode,
        @LastStatuAciklama AS OrderStatus,
        oh.CargoAmount,
        oh.UserId,
        oh.CurrencyCode,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) AS ProductTotal,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) + oh.CargoAmount AS GrandTotal,
        oh.KargoSirketi,
        oh.KargoyaVerilmeTarihi,
        oh.KargoTakipNo,
		(select top 1 IslemTarihi from [OrderStatus] t1 where t1.OrderId = @OrderId
        and t1.Iptal =0 and 
		t1.StatusCode = 70 --Teslim Edildi
        ORDER BY t1.IslemTarihi DESC)  As DeliveryDate 
    FROM OrderHeader oh 
    WHERE oh.Id = @OrderId;

    -- Detail
    SELECT
        t1.ProductCode,
        t1.ProductName,
        t1.ProductDesc,
        t1.UnitPrice,
        t1.Quantity,
        t1.LineTotal,
        t1.DisplayNo,
        t2.ImagePath 
    FROM OrderDetail t1
    LEFT OUTER JOIN ProductImage t2 on t1.ProductId = t2.ProductId  and t2.IsMain =1
    WHERE OrderId = @OrderId
    ORDER BY DisplayNo;

    -- Teslimat Adresi
    SELECT 
        Ad,
        Soyad,
        Telefon,
        Mahalle,
        Adres,
        Ilce,
        Il
    FROM OrderAddress 
    WHERE OrderHeaderId= @OrderId 

    -- Aktif Geçmiş Durum Listesi
    SELECT [StatusCode] AS OrderStatusCode ,[IslemTarihi],t2.Aciklama,t3.FirstName + ' ' + t3.LastName AS UserNameSurname
    FROM [OrderStatus] t1
    LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
    LEFT OUTER JOIN [User] t3 on t1.IslemUserid = t3.Id
    WHERE OrderId = @OrderId 
    AND t1.Iptal = 0
    Order by IslemTarihi Desc

    -- History Log
    SELECT  t1.[StatusCode] AS OrderStatusCode, t1.IslemTarihi,t2.Aciklama,t3.FirstName + ' ' + t3.LastName AS UserNameSurname
    FROM [OrderStatus] t1
    LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
    LEFT OUTER JOIN [User] t3 on t1.IslemUserid = t3.Id
    WHERE t1.OrderId = @OrderId
    UNION ALL
    SELECT  t1.[StatusCode] AS OrderStatusCode,t1.IptalTarihi,t2.Aciklama + ' (Statü geri alındı.)' , t3.FirstName + ' ' + t3.LastName AS UserNameSurname
    FROM [OrderStatus] t1
    LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
    LEFT OUTER JOIN [User] t3 on t1.IptalUserid = t3.Id
    WHERE t1.OrderId = @OrderId and t1.Iptal = 1
    Order by IslemTarihi ASC
    


END




























GO

-- dbo.sp_Order_GetForNewReturn

IF OBJECT_ID('dbo.sp_Order_GetForNewReturn', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetForNewReturn]
GO
CREATE PROCEDURE [dbo].[sp_Order_GetForNewReturn]
    @OrderId INT, @UserId INT
AS
BEGIN
   SELECT
		t1.OrderId,
		t1.Id AS OrderDetailId,
		t1.ProductId,
        t1.ProductCode,
        t1.ProductName,
        t1.ProductDesc,
        t1.UnitPrice,
        t1.Quantity,
        t1.LineTotal,
        t1.DisplayNo,
        t2.ImagePath,
		ISNULL(SUM(t3.ReturnQuantity),0) LineReturnQuantityTotal,
		ISNULL(SUM(t3.ReturnLineTotal),0) LineReturnPriceTotal,
		ISNULL(t1.Quantity - ISNULL(SUM(t3.ReturnQuantity),0),0) AvaliableQuatityForReturn,
		t4.CurrencyCode
    FROM OrderDetail t1
    LEFT OUTER JOIN ProductImage t2 on t1.ProductId = t2.ProductId  and t2.IsMain =1
	LEFT OUTER JOIN vReturnDetail t3 on t1.ProductId = t3.ProductId  and t1.Id= t3.OrderDetailId and t3.LastStatus <> 180
	LEFT OUTER JOIN OrderHeader t4 on t1.OrderId = t4.Id
	
    WHERE t1.OrderId = @OrderId AND t4.UserId = @UserId 

	GROUP BY
	t1.OrderId,
	t1.Id,
	t1.ProductId,
	t1.ProductCode,
	t1.ProductName,
	t1.ProductDesc,
	t1.UnitPrice,
	t1.Quantity,
	t1.LineTotal,
	t1.DisplayNo,
	t2.ImagePath,
	t4.CurrencyCode


	HAVING 
    ISNULL(t1.Quantity - ISNULL(SUM(t3.ReturnQuantity),0),0) > 0 -- AvaliableQuatityForReturn  > 0

    ORDER BY t1.DisplayNo


	    DECLARE @LastStatuAciklama nvarchar(50)
    DECLARE @LastStatuCode int

        SELECT TOP 1 
        ISNULL(t2.Aciklama,'') AS Aciklama,
        ISNULL(t2.Code,0) AS OrderStatusCode
        FROM [OrderStatus] t1
        LEFT JOIN [Status] t2 ON t1.StatusCode = t2.Code
        WHERE t1.OrderId = @OrderId
        and t1.Iptal =0
        ORDER BY t1.IslemTarihi DESC;

	
			SELECT TOP 1 
				IslemTarihi AS DeliveryDate,

				DATEADD(DAY, 14, IslemTarihi) AS ReturnDeadline,
	

				CAST(
				CASE 
				WHEN IslemTarihi >= DATEADD(DAY, -14, GETDATE()) THEN 1
				ELSE 0
				END AS BIT
				)
				AS IsReturnable

			FROM [OrderStatus] t1 
			WHERE t1.OrderId = @OrderId
			  AND t1.Iptal = 0 
			  AND t1.StatusCode = 70 -- Teslim Edildi
			ORDER BY t1.IslemTarihi DESC

END









GO

-- dbo.sp_Order_GetNextStatusForUpdate

IF OBJECT_ID('dbo.sp_Order_GetNextStatusForUpdate', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetNextStatusForUpdate]
GO
CREATE   PROCEDURE [dbo].[sp_Order_GetNextStatusForUpdate]
    @OrderId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentStatus INT;

    -- Son statüyü al
    SELECT TOP 1 @CurrentStatus = StatusCode
    FROM OrderStatus
    WHERE OrderId = @OrderId
    and Iptal = 0
    ORDER BY IslemTarihi DESC;

    -- Eğer hiç statü yoksa çık
    IF @CurrentStatus IS NULL
    BEGIN
        SELECT NULL AS Code, NULL AS Aciklama;
        RETURN;
    END

    -- Geçilebilecek statüleri getir
    SELECT 
        s.Code,
        s.Aciklama
    FROM OrderStatusTransition t
    INNER JOIN Status s ON s.Code = t.NextStatus
    WHERE t.CurrentStatus = @CurrentStatus
    ORDER BY s.Code;
END


























GO

-- dbo.sp_Order_GetStatusHistory

IF OBJECT_ID('dbo.sp_Order_GetStatusHistory', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetStatusHistory]
GO

CREATE   PROCEDURE [dbo].[sp_Order_GetStatusHistory]
 @OrderId INT
 AS
BEGIN
    SET NOCOUNT ON;

    SELECT  t1.[StatusCode] AS OrderStatusCode, t1.IslemTarihi,t2.Aciklama,t3.FirstName + ' ' + t3.LastName AS UserNameSurname
    FROM [OrderStatus] t1
    LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
    LEFT OUTER JOIN [User] t3 on t1.IslemUserid = t3.Id
    WHERE t1.OrderId = @OrderId
    UNION ALL
    SELECT  t1.[StatusCode] AS OrderStatusCode,t1.IptalTarihi,t2.Aciklama + ' (Statü geri alındı.)' , t3.FirstName + ' ' + t3.LastName AS UserNameSurname
    FROM [OrderStatus] t1
    LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
    LEFT OUTER JOIN [User] t3 on t1.IptalUserid = t3.Id
    WHERE t1.OrderId = @OrderId and t1.Iptal = 1
    Order by IslemTarihi ASC
END



























GO

-- dbo.sp_Order_GetStatusProcess

IF OBJECT_ID('dbo.sp_Order_GetStatusProcess', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_GetStatusProcess]
GO
CREATE   PROCEDURE [dbo].[sp_Order_GetStatusProcess]
 @OrderId INT
 AS
BEGIN
    SET NOCOUNT ON;

        DECLARE @IptalStatusCode INT = 80;

        WITH StatusCTE AS (
            SELECT
                Faz =
                    CASE
                        WHEN t1.Code <> @IptalStatusCode AND t2.Id IS NOT NULL THEN '01_COMPLETED'
                        WHEN t1.Code = @IptalStatusCode AND t2.Id IS NOT NULL THEN '02_CANCELLED'
                        WHEN t1.Code <> @IptalStatusCode AND t2.Id IS  NULL THEN '03_NOTCOMPLETED'
                        WHEN t1.Code = @IptalStatusCode AND t2.Id IS  NULL THEN 'NA'
                    END,
                t1.Code,
                t1.Aciklama,
                t2.Id as OrderStatusId,
                ISNULL(t2.IslemTarihi,'') IslemTarihi,
                ISNULL(t3.FirstName + ' ' + t3.LastName,'') AS UserNameSurname
            FROM [Status] t1
            LEFT JOIN OrderStatus t2  
                ON t1.Code = t2.StatusCode  
               AND t2.OrderId = @OrderId  
               AND t2.Iptal = 0
            LEFT OUTER JOIN [User] t3 
                ON t2.IslemUserid = t3.Id
        )
        SELECT 
              CONVERT(int,ROW_NUMBER() OVER (ORDER BY Faz, Code)) AS RowOrderNo,  
                *,
               CASE 
                   WHEN IslemTarihi IS NOT NULL 
                        AND IslemTarihi = (SELECT MAX(IslemTarihi) 
                                           FROM StatusCTE 
                                           WHERE IslemTarihi IS NOT NULL)
                   THEN Convert(bit,'True')
                   ELSE Convert(bit,'False')
               END AS IsLast,
               CASE
                WHEN OrderStatusId IS NOT NULL
                                   THEN Convert(bit,'True')
                                   ELSE Convert(bit,'False')
                                   END AS IsCompleted
        FROM StatusCTE
        WHERE Faz <> 'NA'
        ORDER BY Faz, Code;

END



























GO

-- dbo.sp_Order_ListAll

IF OBJECT_ID('dbo.sp_Order_ListAll', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_ListAll]
GO
CREATE PROCEDURE [dbo].[sp_Order_ListAll]
AS
BEGIN
    SET NOCOUNT ON;

SELECT
    oh.Id,
    oh.OrderDate,
    oh.CargoAmount,
    ISNULL(SUM(od.LineTotal),0) AS ProductTotal,
    ISNULL(CargoAmount,0) AS CargoAmount,
    ISNULL(SUM(od.LineTotal),0) + oh.CargoAmount AS GrandTotal,
    os.LastStatusCode AS OrderStatusCode,
    os.LastStatusAciklama AS OrderStatus,
    oh.UserId,
    oh.CurrencyCode,
    us.FirstName,
    us.LastName,
    us.Email
FROM OrderHeader oh
LEFT OUTER JOIN OrderDetail od ON oh.Id = od.OrderId
LEFT OUTER JOIN [User] us ON oh.UserId = us.Id

OUTER APPLY (
    SELECT TOP 1 t2.Aciklama AS LastStatusAciklama ,t2.Code AS LastStatusCode
    FROM OrderStatus t1
    LEFT JOIN Status t2 ON t1.StatusCode = t2.Code
    WHERE t1.OrderId = oh.Id
    AND Iptal = 0
    ORDER BY t1.IslemTarihi DESC
) os


GROUP BY
    oh.Id,
    oh.OrderDate,
    oh.CargoAmount,
    os.LastStatusCode,
    os.LastStatusAciklama,
    oh.UserId,
    oh.CurrencyCode,
    us.FirstName,
    us.LastName,
    us.Email

ORDER BY oh.OrderDate DESC;



END



































GO

-- dbo.sp_Order_ListByUserId

IF OBJECT_ID('dbo.sp_Order_ListByUserId', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_ListByUserId]
GO



CREATE PROCEDURE [dbo].[sp_Order_ListByUserId]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

SELECT
    oh.Id,
    oh.OrderDate,
    ISNULL(SUM(od.LineTotal),0) AS ProductTotal,
    ISNULL(CargoAmount,0) AS CargoAmount,
    ISNULL(SUM(od.LineTotal),0) + oh.CargoAmount AS GrandTotal,
    os.LastStatusCode AS OrderStatusCode,
    os.LastStatusAciklama AS OrderStatus,
	oh.CurrencyCode
FROM OrderHeader oh
LEFT OUTER JOIN OrderDetail od ON oh.Id = od.OrderId

OUTER APPLY (
    SELECT TOP 1 t2.Aciklama AS LastStatusAciklama,t2.Code AS LastStatusCode
    FROM OrderStatus t1
    LEFT JOIN Status t2 ON t1.StatusCode = t2.Code
    WHERE t1.OrderId = oh.Id
    and t1.Iptal =0
    ORDER BY t1.IslemTarihi DESC
) os

WHERE oh.UserId = @UserId

GROUP BY
    oh.Id,
    oh.OrderDate,
    oh.CargoAmount,
    os.LastStatusCode,
    os.LastStatusAciklama,
	oh.CurrencyCode
    

ORDER BY oh.OrderDate DESC;





END


































GO

-- dbo.sp_Order_UpdateStatus

IF OBJECT_ID('dbo.sp_Order_UpdateStatus', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Order_UpdateStatus]
GO
CREATE   PROCEDURE [dbo].[sp_Order_UpdateStatus]
    @OrderId INT,
    @NewStatusCode INT,
    @UserId INT
AS
BEGIN

    DECLARE @CurrentStatus INT;

    -- Son statüyü al
    SELECT TOP 1 @CurrentStatus = StatusCode
    FROM OrderStatus
    WHERE OrderId = @OrderId
    and Iptal = 0
    ORDER BY IslemTarihi DESC;

    IF (@CurrentStatus = @NewStatusCode )
    BEGIN
       SELECT 0 AS RESULT
    END
    ELSE
    BEGIN
        INSERT INTO OrderStatus (OrderId, StatusCode, IslemTarihi,IslemUserid,Iptal)
        VALUES (@OrderId, @NewStatusCode, GETDATE(),@UserId,0)

        SELECT 1 AS RESULT
    END

END



























GO

-- dbo.sp_Potansiyel_Delete

IF OBJECT_ID('dbo.sp_Potansiyel_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Potansiyel]
    WHERE [Id] = @Id;
END



































GO

-- dbo.sp_Potansiyel_DeleteSoft

IF OBJECT_ID('dbo.sp_Potansiyel_DeleteSoft', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_DeleteSoft]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Potansiyel]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END



































GO

-- dbo.sp_Potansiyel_GetById

IF OBJECT_ID('dbo.sp_Potansiyel_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Potansiyel]
    WHERE [Id] = @Id
      AND IsActive = 1
END



































GO

-- dbo.sp_Potansiyel_Insert

IF OBJECT_ID('dbo.sp_Potansiyel_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_Insert]
    @Name nvarchar(50),
    @SurName nvarchar(50),
    @KnownName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(50),
    @Adress int,
    @tarih date = NULL,
    @kayıttarihi datetime = NULL,
    @saat time = NULL,
    @satir nvarchar(10) = NULL,
    @max nvarchar(MAX) = NULL,
    @resim image = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Potansiyel]
    ([Name], [SurName], [KnownName], [Email], [PhoneNumber], [IsActive], [Adress], [tarih], [kayıttarihi], [saat], [satir], [max], [resim])
    VALUES
    (@Name, @SurName, @KnownName, @Email, @PhoneNumber, 1, @Adress, @tarih, @kayıttarihi, @saat, @satir, @max, @resim);

    SELECT SCOPE_IDENTITY() AS NewId;
END



































GO

-- dbo.sp_Potansiyel_List

IF OBJECT_ID('dbo.sp_Potansiyel_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Potansiyel]
    WHERE IsActive = 1
END



































GO

-- dbo.sp_Potansiyel_PagedList

IF OBJECT_ID('dbo.sp_Potansiyel_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[Potansiyel]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Potansiyel]
    WHERE IsActive = 1
END




































GO

-- dbo.sp_Potansiyel_Update

IF OBJECT_ID('dbo.sp_Potansiyel_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Potansiyel_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-01-25 22:37:10
-- Generated at (UTC): 2026-01-25 19:37:10
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Potansiyel_Update]
    @Id int,
    @Name nvarchar(50),
    @SurName nvarchar(50),
    @KnownName nvarchar(50),
    @Email nvarchar(100),
    @PhoneNumber nvarchar(50),
    @Adress int,
    @tarih date = NULL,
    @kayıttarihi datetime = NULL,
    @saat time = NULL,
    @satir nvarchar(10) = NULL,
    @max nvarchar(MAX) = NULL,
    @resim image = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Potansiyel]
    SET
        [Name] = @Name,
        [SurName] = @SurName,
        [KnownName] = @KnownName,
        [Email] = @Email,
        [PhoneNumber] = @PhoneNumber,
        [Adress] = @Adress,
        [tarih] = @tarih,
        [kayıttarihi] = @kayıttarihi,
        [saat] = @saat,
        [satir] = @satir,
        [max] = @max,
        [resim] = @resim
    WHERE [Id] = @Id;
END



































GO

-- dbo.sp_Product_Delete

IF OBJECT_ID('dbo.sp_Product_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_Delete]
GO



CREATE PROCEDURE [dbo].[sp_Product_Delete]
    @Id INT
AS
BEGIN
    DELETE FROM Product
    WHERE Id = @Id

    SELECT @@ROWCOUNT
END









































GO

-- dbo.sp_Product_GetById

IF OBJECT_ID('dbo.sp_Product_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_GetById]
GO


CREATE PROCEDURE [dbo].[sp_Product_GetById]
    @Id INT
AS
BEGIN
    SELECT 
    t1.Id,t1.ProductCode,t1.ProductName,t1.ProductDesc,t1.CategoryId,
    t1.UnitPrice,t1.CurrencyId,t1.AvailableForSale,t1.DisplayOrderNo,
    t2.Code AS CurrencyCode, t2.Symbol AS CurrencySymbol, t3.Name AS CategoryName
    FROM [dbo].[Product] t1
    LEFT OUTER JOIN	 [dbo].[Currency] t2 ON t1.CurrencyId = t2.Id 
    LEFT OUTER JOIN	 [dbo].[Category] t3 ON t1.CategoryId = t3.Id
    WHERE t1.Id = @Id
END










































GO

-- dbo.sp_Product_InfoById

IF OBJECT_ID('dbo.sp_Product_InfoById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_InfoById]
GO
CREATE PROCEDURE [dbo].[sp_Product_InfoById]
    @Id INT
AS
BEGIN
    -- 🔹 Product info
    SELECT 
        t1.Id,
        t1.ProductCode,
        t1.ProductName,
        t1.ProductDesc,
        t1.UnitPrice,
        t1.CurrencyId,
        t1.AvailableForSale,
        t1.DisplayOrderNo,
        t2.Code AS CurrencyCode,
        t2.Symbol AS CurrencySymbol
    FROM [dbo].[Product] t1
    LEFT JOIN [dbo].[Currency] t2 ON t1.CurrencyId = t2.Id
    WHERE t1.Id = @Id;

    -- 🔥 Kategoriler (çoklu)
    SELECT CategoryId
    FROM ProductCategory
    WHERE ProductId = @Id;
END
GO

-- dbo.sp_Product_Insert

IF OBJECT_ID('dbo.sp_Product_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_Insert]
GO


CREATE PROCEDURE [dbo].[sp_Product_Insert]
(
    @ProductCode NVARCHAR(50),
    @ProductName NVARCHAR(255),
    @ProductDesc NVARCHAR(MAX),
    @CategoryId INT,
    @UnitPrice DECIMAL(9,2),
    @CurrencyId INT,
    @AvailableForSale BIT
)
AS
BEGIN

    DECLARE @DisplayOrderNo INT
    SELECT @DisplayOrderNo = ISNULL((SELECT MAX(DisplayOrderNo) FROM Product), 0) + 1
    
    INSERT INTO Product
    (
        ProductCode, ProductName, ProductDesc,
        CategoryId, UnitPrice, CurrencyId, AvailableForSale,DisplayOrderNo
    )
    VALUES
    (
        @ProductCode, @ProductName, @ProductDesc,
        @CategoryId, @UnitPrice, @CurrencyId, @AvailableForSale,@DisplayOrderNo
    )

    SELECT SCOPE_IDENTITY()
END











































GO

-- dbo.sp_Product_List

IF OBJECT_ID('dbo.sp_Product_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_List]
GO

CREATE PROCEDURE [dbo].[sp_Product_List]
AS
BEGIN
    SELECT 
        t1.Id,
        t1.ProductCode,
        t1.ProductName,
        t1.ProductDesc,
        t1.CategoryId,
        t4.Name CategoryName,
        t1.UnitPrice,
        t1.CurrencyId,
        t1.AvailableForSale,
        t2.Code AS CurrencyCode,
        t2.Symbol AS CurrencySymbol,
        ISNULL(t3.ImagePath,'') MainImagePath,
        ISNULL(img.ImageCount, 0) AS ImageCount,
        t1.DisplayOrderNo
    FROM Product t1
    LEFT OUTER JOIN Currency t2	ON t1.CurrencyId = t2.Id
    LEFT OUTER JOIN ProductImage t3 ON t1.Id = t3.ProductId and t3.IsMain=1
    LEFT OUTER JOIN (
    SELECT ProductId, COUNT(*) AS ImageCount
    FROM ProductImage
    GROUP BY ProductId
    ) img ON img.ProductId = t1.Id
    LEFT OUTER JOIN Category t4	ON t1.CategoryId = t4.Id

    ORDER BY DisplayOrderNo ASC
END









































GO

-- dbo.sp_Product_ListForHomePage

IF OBJECT_ID('dbo.sp_Product_ListForHomePage', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_ListForHomePage]
GO

CREATE PROCEDURE [dbo].[sp_Product_ListForHomePage]
AS
BEGIN
    SELECT 
        t1.Id,
        t1.ProductCode,
        t1.ProductName,
        t1.ProductDesc,
        t1.CategoryId,
        t4.Name CategoryName,
        t1.UnitPrice,
        t1.CurrencyId,
        t1.AvailableForSale,
        t2.Code AS CurrencyCode,
        t2.Symbol AS CurrencySymbol,
        t3.ImagePath MainImagePath
    FROM Product t1
    LEFT OUTER JOIN Currency t2	ON t1.CurrencyId = t2.Id
    LEFT OUTER JOIN ProductImage t3 ON t1.Id = t3.ProductId and t3.IsMain=1
    LEFT OUTER JOIN Category t4	ON t1.CategoryId = t4.Id
    WHERE
    t1.AvailableForSale =1
    and 
    t3.ImagePath IS NOT NULL
    ORDER BY DisplayOrderNo ASC
END









































GO

-- dbo.sp_Product_SaveCategories

IF OBJECT_ID('dbo.sp_Product_SaveCategories', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_SaveCategories]
GO

CREATE PROCEDURE [dbo].[sp_Product_SaveCategories]
    @ProductId INT,
    @CategoryJson NVARCHAR(MAX)
AS
BEGIN
	DELETE ProductCategory WHERE ProductId = @ProductId

    INSERT INTO ProductCategory (ProductId, CategoryId)
    SELECT @ProductId, value
    FROM OPENJSON(@CategoryJson)
END
GO

-- dbo.sp_Product_SwapOrder

IF OBJECT_ID('dbo.sp_Product_SwapOrder', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_SwapOrder]
GO
CREATE PROCEDURE [dbo].[sp_Product_SwapOrder]
(
    @ProductId1 INT,
    @ProductId2 INT
)
AS
BEGIN
    DECLARE @Order1 INT, @Order2 INT

    SELECT @Order1 = DisplayOrderNo FROM Product WHERE Id = @ProductId1
    SELECT @Order2 = DisplayOrderNo FROM Product WHERE Id = @ProductId2

    UPDATE Product SET DisplayOrderNo = @Order2 WHERE Id = @ProductId1
    UPDATE Product SET DisplayOrderNo = @Order1 WHERE Id = @ProductId2
END









































GO

-- dbo.sp_Product_Update

IF OBJECT_ID('dbo.sp_Product_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_Update]
GO


CREATE PROCEDURE [dbo].[sp_Product_Update]
(
    @Id INT,
    @ProductCode NVARCHAR(50),
    @ProductName NVARCHAR(255),
    @ProductDesc NVARCHAR(MAX),
    @CategoryId INT,
    @UnitPrice DECIMAL(9,2),
    @CurrencyId INT,
    @AvailableForSale BIT
)
AS
BEGIN
    UPDATE Product
    SET
        ProductCode = @ProductCode,
        ProductName = @ProductName,
        ProductDesc = @ProductDesc,
        CategoryId = @CategoryId,
        UnitPrice = @UnitPrice,
        CurrencyId = @CurrencyId,
        AvailableForSale = @AvailableForSale
    WHERE Id = @Id

    SELECT @@ROWCOUNT
END











































GO

-- dbo.sp_Product_UpdateDisplayOrder

IF OBJECT_ID('dbo.sp_Product_UpdateDisplayOrder', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Product_UpdateDisplayOrder]
GO
CREATE PROCEDURE [dbo].[sp_Product_UpdateDisplayOrder]
(
    @JsonData NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- JSON -> temp table
    SELECT 
        Id,
        DisplayOrderNo
    INTO #TmpOrder
    FROM OPENJSON(@JsonData)
    WITH (
        Id INT '$.Id',
        DisplayOrderNo INT '$.DisplayOrderNo'
    )
BEGIN TRY
    BEGIN TRAN

    UPDATE p
    SET p.DisplayOrderNo = t.DisplayOrderNo
    FROM Product p
    INNER JOIN #TmpOrder t ON p.Id = t.Id

    COMMIT TRAN

END TRY
BEGIN CATCH
    ROLLBACK TRAN
    THROW
END CATCH
END









































GO

-- dbo.sp_ProductCategory_Delete

IF OBJECT_ID('dbo.sp_ProductCategory_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[ProductCategory]
    WHERE [Id] = @Id;
END


GO

-- dbo.sp_ProductCategory_GetById

IF OBJECT_ID('dbo.sp_ProductCategory_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,CategoryId
    FROM [dbo].[ProductCategory]
    WHERE [Id] = @Id
END


GO

-- dbo.sp_ProductCategory_Insert

IF OBJECT_ID('dbo.sp_ProductCategory_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_Insert]
    @ProductId int,
    @CategoryId int
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[ProductCategory]
    ([ProductId], [CategoryId])
    VALUES
    (@ProductId, @CategoryId);

    SELECT SCOPE_IDENTITY() AS NewId;
END


GO

-- dbo.sp_ProductCategory_List

IF OBJECT_ID('dbo.sp_ProductCategory_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,CategoryId
    FROM [dbo].[ProductCategory]
END


GO

-- dbo.sp_ProductCategory_PagedList

IF OBJECT_ID('dbo.sp_ProductCategory_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,ProductId,CategoryId
    FROM [dbo].[ProductCategory]
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[ProductCategory]
END



GO

-- dbo.sp_ProductCategory_Update

IF OBJECT_ID('dbo.sp_ProductCategory_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductCategory_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-04-21 14:26:25
-- Generated at (UTC): 2026-04-21 11:26:25
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_ProductCategory_Update]
    @Id int,
    @ProductId int,
    @CategoryId int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[ProductCategory]
    SET
        [ProductId] = @ProductId,
        [CategoryId] = @CategoryId
    WHERE [Id] = @Id;
END


GO

-- dbo.sp_ProductImage_Delete

IF OBJECT_ID('dbo.sp_ProductImage_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductImage_Delete]
GO
CREATE PROCEDURE [dbo].[sp_ProductImage_Delete]
    @Id INT
AS
BEGIN
    DELETE FROM ProductImage WHERE Id = @Id
    SELECT @@ROWCOUNT
END









































GO

-- dbo.sp_ProductImage_Insert

IF OBJECT_ID('dbo.sp_ProductImage_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductImage_Insert]
GO
CREATE PROCEDURE [dbo].[sp_ProductImage_Insert]
    @ProductId INT,
    @ImagePath NVARCHAR(255),
    @IsMain BIT,
    @DisplayOrder INT
AS
BEGIN
    INSERT INTO ProductImage
    (ProductId, ImagePath, IsMain, DisplayOrder)
    VALUES
    (@ProductId, @ImagePath, @IsMain, @DisplayOrder)

    SELECT SCOPE_IDENTITY()
END









































GO

-- dbo.sp_ProductImage_ListByProductId

IF OBJECT_ID('dbo.sp_ProductImage_ListByProductId', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductImage_ListByProductId]
GO
CREATE PROCEDURE [dbo].[sp_ProductImage_ListByProductId]
    @ProductId INT
AS
BEGIN
    SELECT
        Id,
        ProductId,
        ImagePath,
        IsMain,
        DisplayOrder
    FROM ProductImage
    WHERE ProductId = @ProductId
    ORDER BY DisplayOrder
END









































GO

-- dbo.sp_ProductImage_SetMain

IF OBJECT_ID('dbo.sp_ProductImage_SetMain', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductImage_SetMain]
GO
CREATE PROCEDURE [dbo].[sp_ProductImage_SetMain]
    @ProductId INT,
    @ImageId INT
AS
BEGIN
    UPDATE ProductImage
    SET IsMain = 0
    WHERE ProductId = @ProductId

    UPDATE ProductImage
    SET IsMain = 1
    WHERE Id = @ImageId
END









































GO

-- dbo.sp_ProductImage_Update

IF OBJECT_ID('dbo.sp_ProductImage_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_ProductImage_Update]
GO
CREATE PROCEDURE [dbo].[sp_ProductImage_Update]
    @Id INT,
    @IsMain BIT,
    @DisplayOrder INT
AS
BEGIN
    UPDATE ProductImage
    SET
        IsMain = @IsMain,
        DisplayOrder = @DisplayOrder
    WHERE Id = @Id

    SELECT @@ROWCOUNT
END









































GO

-- dbo.sp_Reason_Delete

IF OBJECT_ID('dbo.sp_Reason_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Reason]
    WHERE [Id] = @Id;
END



















GO

-- dbo.sp_Reason_DeleteSoft

IF OBJECT_ID('dbo.sp_Reason_DeleteSoft', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_DeleteSoft]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_DeleteSoft]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Reason]
    SET [IsActive] = 0
    WHERE [Id] = @Id;
END



















GO

-- dbo.sp_Reason_GetById

IF OBJECT_ID('dbo.sp_Reason_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Reasondesc,IsCustom
    FROM [dbo].[Reason]
    WHERE [Id] = @Id
      AND IsActive = 1
END



















GO

-- dbo.sp_Reason_Insert

IF OBJECT_ID('dbo.sp_Reason_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_Insert]
    @Reasondesc nvarchar(100),
    @IsCustom bit = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Reason]
    ([Reasondesc], [IsActive], [IsCustom])
    VALUES
    (@Reasondesc, 1, @IsCustom);

    SELECT SCOPE_IDENTITY() AS NewId;
END



















GO

-- dbo.sp_Reason_List

IF OBJECT_ID('dbo.sp_Reason_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Reasondesc,IsCustom
    FROM [dbo].[Reason]
    WHERE IsActive = 1
END



















GO

-- dbo.sp_Reason_PagedList

IF OBJECT_ID('dbo.sp_Reason_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Reasondesc,IsCustom
    FROM [dbo].[Reason]
    WHERE IsActive = 1
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Reason]
    WHERE IsActive = 1
END




















GO

-- dbo.sp_Reason_Update

IF OBJECT_ID('dbo.sp_Reason_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Reason_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-03-29 20:43:36
-- Generated at (UTC): 2026-03-29 17:43:36
-- Machine: DESKTOP-IITN2G2
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Reason_Update]
    @Id int,
    @Reasondesc nvarchar(100),
    @IsCustom bit = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Reason]
    SET
        [Reasondesc] = @Reasondesc,
        [IsCustom] = @IsCustom
    WHERE [Id] = @Id;
END



















GO

-- dbo.sp_Return_Cancel

IF OBJECT_ID('dbo.sp_Return_Cancel', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Return_Cancel]
GO
CREATE PROCEDURE [dbo].[sp_Return_Cancel]
(
    @ReturnHeaderId INT,
    @UserId INT
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastStatusForReturnCode INT;

    SELECT TOP 1 @LastStatusForReturnCode = StatusForReturnCode
    FROM ReturnHeaderStatus
    WHERE ReturnHeaderId = @ReturnHeaderId
      AND Iptal = 0
    ORDER BY IslemTarihi DESC;

    -- 1️⃣ Kayıt var mı?
    IF NOT EXISTS (
        SELECT 1 
        FROM ReturnHeader 
        WHERE Id = @ReturnHeaderId 
          AND UserId = @UserId 
    )
    BEGIN
        SELECT -1 AS Result, N'İade talebi bulunamadı veya iade edilemez.' AS Message;
        RETURN;
    END

    -- 2️⃣ Status kontrolü (sadece 110 İade Kargosu Bekleniyor ise iptal edilebilir. 110 harici iptal edilemez.)
    IF ISNULL(@LastStatusForReturnCode,0) <> 110
    BEGIN
        SELECT -1 AS Result, N'Bu durumda iade iptal edilemez.' AS Message;
        RETURN;
    END

    -- 3️⃣ Yeni status ekle
    INSERT INTO [dbo].[ReturnHeaderStatus] 
    (
        OrderId,
        ReturnHeaderId,
        StatusForReturnCode,
        IslemTarihi,
        IslemUserid,
        Iptal,
        IptalTarihi,
        IptalUserid
    )
    SELECT 
        OrderId,
        Id,
        180, -- iptal statusu
        GETDATE(),
        @UserId,
        0,
        NULL,
        NULL
    FROM [dbo].[ReturnHeader] 
    WHERE Id = @ReturnHeaderId;

    -- 4️⃣ SUCCESS
    SELECT 
        @ReturnHeaderId AS Result, 
        CONVERT(NVARCHAR(10),@ReturnHeaderId) + N' Nolu iade talebi iptal edildi.' AS [Message];

END














GO

-- dbo.sp_Return_Create

IF OBJECT_ID('dbo.sp_Return_Create', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Return_Create]
GO
CREATE   PROCEDURE [dbo].[sp_Return_Create]
(
    @OrderId INT,
    @UserId INT,
	@ReasonId INT,
    @ReasonDesc NVARCHAR(500),
    @Items NVARCHAR(MAX), -- JSON
	@BankName NVARCHAR(500),
	@IBAN NVARCHAR(500),
	@AccountHolderName NVARCHAR(500)
)
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ Sipariş kontrolü (user + status)
    IF NOT EXISTS (
        SELECT 1 
        FROM OrderHeader 
        WHERE Id = @OrderId 
          AND UserId = @UserId
 
    )
    BEGIN
        SELECT -1 AS Result, N'Sipariş bulunamadı veya iade edilemez.' AS Message;
        RETURN;
    END

    -- 2️⃣ En az 1 ürün seçilmiş mi
    IF NOT EXISTS (
        SELECT 1
        FROM OPENJSON(@Items)
        WITH (
            OrderDetailId INT,
            ReturnQuantity INT
        )
        WHERE ReturnQuantity > 0
    )
    BEGIN
        SELECT -2 AS Result, N'İade edilecek ürün seçmelisiniz.' AS Message;
        RETURN;
    END

    -- 3️⃣ Quantity kontrol (EN KRİTİK NOKTA)
    IF EXISTS (
        SELECT 1
        FROM OPENJSON(@Items)
        WITH (
            OrderDetailId INT,
            ReturnQuantity INT
        ) j
        INNER JOIN OrderDetail od ON od.Id = j.OrderDetailId
        LEFT JOIN (
            SELECT OrderDetailId, SUM(ReturnQuantity) TotalReturned
            FROM [vReturnDetail]
			WHERE LastStatus <> 180
            GROUP BY OrderDetailId
        ) r ON r.OrderDetailId = od.Id
        WHERE j.ReturnQuantity + ISNULL(r.TotalReturned,0) > od.Quantity
    )
    BEGIN
        SELECT -3 AS Result, N'İade miktarı sipariş miktarını aşıyor.' AS Message;
        RETURN;
    END

    -- 4️⃣ HEADER INSERT
    DECLARE @ReturnId INT;

    INSERT INTO ReturnHeader (UserId, ReturnRequestDate, OrderId, ReasonId,ReasonDesc,BankName,IBAN,AccountHolderName)
    VALUES (@UserId, GETDATE(), @OrderId, @ReasonId, @ReasonDesc,@BankName,@IBAN,@AccountHolderName);

    SET @ReturnId = SCOPE_IDENTITY();


	INSERT INTO [dbo].[ReturnHeaderStatus]
	(
		[OrderId],
		[ReturnHeaderId],
		[StatusForReturnCode],
		[IslemTarihi],
		[IslemUserid],
		[Iptal],
		[IptalTarihi],
		[IptalUserid]
	)
	VALUES
	(
		@OrderId,
		@ReturnId,
		110,			  -- 110 İade kargosu bekleniyor
		GETDATE(), 
		@UserId,          -- IslemUserid
		0,                -- Iptal (0 = aktif, 1 = iptal)
		NULL,             -- IptalTarihi
		NULL              -- IptalUserid
	);



    -- 5️⃣ DETAIL INSERT
    INSERT INTO ReturnDetail
    (
        ReturnId,
        OrderDetailId,
        ProductId,
        ReturnUnitPrice,
        ReturnQuantity,
		ReturnLineTotal  
    )
    SELECT
        @ReturnId,
        j.OrderDetailId,
        od.ProductId,
        od.UnitPrice,
        j.ReturnQuantity,
		od.UnitPrice * j.ReturnQuantity
    FROM OPENJSON(@Items)
    WITH (
        OrderDetailId INT,
        ReturnQuantity INT
    ) j
    INNER JOIN OrderDetail od ON od.Id = j.OrderDetailId
    WHERE j.ReturnQuantity > 0;

    -- 6️⃣ SUCCESS
    SELECT @ReturnId AS Result, N'' + CONVERT(NVARCHAR(10),@ReturnId) + ' Nolu iade talebi oluşturuldu.' AS Message;

END
























GO

-- dbo.sp_Return_GetByOrderId

IF OBJECT_ID('dbo.sp_Return_GetByOrderId', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Return_GetByOrderId]
GO
CREATE   PROCEDURE [dbo].[sp_Return_GetByOrderId]
    @OrderId INT, @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1️⃣ HEADER
    SELECT 
        rh.Id,
        rh.UserId,
        rh.ReturnRequestDate,
        rh.OrderId,
		rh.ReasonId,
		re.Reasondesc,
        rh.ReasonDesc As ManuelDescriptionForReason,

		ISNULL(rh.LastStatus,0) AS StatusForReturnCode,
		ISNULL(rh.LastStatusDesc,'') AS StatusForReturnDesc,
		ISNULL(rh.BankName,'') AS BankName,
		ISNULL(rh.IBAN,'') AS IBAN,
		ISNULL(rh.AccountHolderName,'') AS AccountHolderName,
		(SELECT SUM(ReturnLineTotal) FROM ReturnDetail WHERE ReturnId = rh.Id) AS ReturnProductTotal,
        (SELECT SUM(ReturnLineTotal) FROM ReturnDetail WHERE ReturnId = rh.Id) + ISNULL(rh.ReturnCargoAmount,0) AS ReturnGrandTotal,
		 ISNULL(rh.ReturnCargoAmount,0)  AS ReturnCargoAmount,
		 ISNULL(rh.IsFinalReturnForOrder,0)  AS IsFinalReturnForOrder,
		ord.CurrencyCode
    FROM vReturnHeader rh
	LEFT OUTER JOIN Reason re on rh.ReasonId = re.Id
	LEFT OUTER JOIN OrderHeader ord on rh.OrderId = ord.Id
    WHERE rh.OrderId = @OrderId AND rh.UserId =@UserId
		and rh.LastStatus <> 180
    ORDER BY rh.ReturnRequestDate DESC;


    -- 2️⃣ DETAIL + OrderDetail JOIN
    SELECT 
        rd.Id,
        rd.ReturnId,
        rd.OrderDetailId,
        rd.ProductId,
        rd.ReturnUnitPrice,
        rd.ReturnQuantity,
		rd.ReturnLineTotal,

        -- OrderDetail bilgileri
        od.OrderId,
        od.ProductCode,
        od.ProductName,
        od.ProductDesc,
        od.UnitPrice AS OrderUnitPrice,
        od.Quantity,
        od.LineTotal,
        od.DisplayNo,
	    pr.ImagePath,
		oh.CurrencyCode

    FROM
	vReturnHeader rh 
	LEFT OUTER JOIN ReturnDetail rd ON rh.Id = rd.ReturnId
    LEFT OUTER JOIN OrderDetail od ON od.Id = rd.OrderDetailId
	LEFT OUTER JOIN ProductImage pr on od.ProductId = pr.ProductId  and pr.IsMain =1
	LEFT OUTER JOIN OrderHeader oh on od.OrderId = oh.Id


    WHERE rh.OrderId = @OrderId AND rh.UserId =@UserId
	and rh.LastStatus <> 180
    ORDER BY rd.ReturnId, od.DisplayNo;

END



















GO

-- dbo.sp_Return_UpdateReturnCargoAmount

IF OBJECT_ID('dbo.sp_Return_UpdateReturnCargoAmount', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Return_UpdateReturnCargoAmount]
GO
CREATE PROCEDURE [dbo].[sp_Return_UpdateReturnCargoAmount]
    @ReturnHeaderId INT,
    @IsFinalReturnForOrder BIT
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @OrderId int

	SELECT @OrderId =OrderId 
	FROM ReturnHeader 
	WHERE Id = @ReturnHeaderId

    IF (@IsFinalReturnForOrder = 1)
    BEGIN

		IF(SELECT COUNT(*) FROM vReturnHeader where  
		OrderId = @OrderId and LastStatus <> 180 and IsFinalReturnForOrder = 1 and
		ReturnCargoAmount > 0
		) > 0
		-- Daha Önce Cargo ücreti işlenmiş FinalReturn var mı?
		BEGIN
			UPDATE ReturnHeader 
			SET ReturnCargoAmount = 0 , IsFinalReturnForOrder = 0
			WHERE Id = @ReturnHeaderId;
		END
		ELSE
		BEGIN
			UPDATE ReturnHeader 
			SET ReturnCargoAmount = 
			(
				SELECT MIN(CargoAmount) 
				FROM OrderHeader 
				WHERE Id = @OrderId
			),
			IsFinalReturnForOrder = 1
			WHERE Id = @ReturnHeaderId;  
		END
    END
    ELSE
    BEGIN
        UPDATE ReturnHeader 
        SET ReturnCargoAmount = 0 ,IsFinalReturnForOrder = 0
        WHERE Id = @ReturnHeaderId;
    END
END








GO

-- dbo.sp_RoleGetById

IF OBJECT_ID('dbo.sp_RoleGetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_RoleGetById]
GO
CREATE PROCEDURE [dbo].[sp_RoleGetById]
    @RoleId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Id,
        Name
    FROM [Role]
    WHERE Id = @RoleId;
END









































GO

-- dbo.sp_Tasit_Delete

IF OBJECT_ID('dbo.sp_Tasit_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_Delete]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_Delete]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM [dbo].[Tasit]
    WHERE [Id] = @Id;
END




























GO

-- dbo.sp_Tasit_GetById

IF OBJECT_ID('dbo.sp_Tasit_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_GetById]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_GetById]
    @Id int
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Aciklama,Tipi,PlakaKodu,Sehir
    FROM [dbo].[Tasit]
    WHERE [Id] = @Id
END




























GO

-- dbo.sp_Tasit_Insert

IF OBJECT_ID('dbo.sp_Tasit_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_Insert]
GO
-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_Insert]
    @Aciklama nvarchar(50),
    @Tipi int,
    @PlakaKodu nvarchar(50),
    @Sehir nvarchar(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Tasit]
    ([Aciklama], [Tipi], [PlakaKodu], [Sehir])
    VALUES
    (@Aciklama, @Tipi, @PlakaKodu, @Sehir);

    SELECT SCOPE_IDENTITY() AS NewId;
END




























GO

-- dbo.sp_Tasit_List

IF OBJECT_ID('dbo.sp_Tasit_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_List]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_List]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Aciklama,Tipi,PlakaKodu,Sehir
    FROM [dbo].[Tasit]
END




























GO

-- dbo.sp_Tasit_PagedList

IF OBJECT_ID('dbo.sp_Tasit_PagedList', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_PagedList]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_PagedList]
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT Id,Aciklama,Tipi,PlakaKodu,Sehir
    FROM [dbo].[Tasit]
    ORDER BY [Id] DESC
    OFFSET (@Page - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(1) AS TotalCount
    FROM [dbo].[Tasit]
END





























GO

-- dbo.sp_Tasit_Update

IF OBJECT_ID('dbo.sp_Tasit_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_Tasit_Update]
GO

-- <auto-generated>
-- This file is generated. Do not edit manually.
-- Generated at      : 2026-02-19 17:07:06
-- Generated at (UTC): 2026-02-19 14:07:06
-- Machine: YAZILIM3
-- Generator: EntityCreator v1.0
-- Class Name: SpWriter
-- </auto-generated>

CREATE   PROCEDURE [dbo].[sp_Tasit_Update]
    @Id int,
    @Aciklama nvarchar(50),
    @Tipi int,
    @PlakaKodu nvarchar(50),
    @Sehir nvarchar(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [dbo].[Tasit]
    SET
        [Aciklama] = @Aciklama,
        [Tipi] = @Tipi,
        [PlakaKodu] = @PlakaKodu,
        [Sehir] = @Sehir
    WHERE [Id] = @Id;
END




























GO

-- dbo.sp_User_ChangePassword

IF OBJECT_ID('dbo.sp_User_ChangePassword', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_ChangePassword]
GO
CREATE PROCEDURE [dbo].[sp_User_ChangePassword]
    @Id INT,
    @PasswordHashNew NVARCHAR(256)
AS
BEGIN
    UPDATE [User]
    SET
        PasswordHash = @PasswordHashNew
    WHERE Id = @Id
END









































GO

-- dbo.sp_User_ClearRememberMeToken

IF OBJECT_ID('dbo.sp_User_ClearRememberMeToken', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_ClearRememberMeToken]
GO
CREATE PROCEDURE [dbo].[sp_User_ClearRememberMeToken]
    @Token NVARCHAR(200)
AS
BEGIN

    UPDATE [User] 
    SET 
    RememberMeToken  = NULL,
    RememberMeExpire = NULL
    WHERE RememberMeToken =@Token

END



































GO

-- dbo.sp_User_ConfirmEmail

IF OBJECT_ID('dbo.sp_User_ConfirmEmail', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_ConfirmEmail]
GO
CREATE PROCEDURE [dbo].[sp_User_ConfirmEmail]
    @UserId INT
AS
BEGIN
    UPDATE [User]
    SET 
        IsEmailConfirmed = 1,
        EmailConfirmCode = NULL,
        EmailConfirmCodeExpire = NULL,
        EmailConfirmAttemptCount = 0,
		EmailConfirmLastSentAt = NULL
    WHERE Id = @UserId
END



































GO

-- dbo.sp_User_Delete

IF OBJECT_ID('dbo.sp_User_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_Delete]
GO
CREATE PROCEDURE [dbo].[sp_User_Delete]
    @Id INT
AS
BEGIN
    UPDATE [User]
    SET IsActive = 0
    WHERE Id = @Id
END









































GO

-- dbo.sp_User_GetByEmail

IF OBJECT_ID('dbo.sp_User_GetByEmail', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_GetByEmail]
GO
CREATE PROCEDURE [dbo].[sp_User_GetByEmail]
    @Email NVARCHAR(100)
AS
BEGIN
    SELECT t1.Id,
	t1.FirstName,
	t1.LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,
	t1.EmailConfirmCode,
	t1.EmailConfirmCodeExpire,
	ISNULL(t1.EmailConfirmAttemptCount,0) AS EmailConfirmAttemptCount,
	t1.EmailConfirmLastSentAt,
	t1.ResetPasswordToken,
	t1.ResetPasswordTokenExpire,
    t1.RememberMeToken, 
	t1.RememberMeExpire
    FROM [User] t1
    LEFT OUTER JOIN [Role] t2 on t1.RoleId = t2.Id
    WHERE Email = @Email
    AND IsActive = 1
END



  


































GO

-- dbo.sp_User_GetById

IF OBJECT_ID('dbo.sp_User_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_GetById]
GO
CREATE PROCEDURE [dbo].[sp_User_GetById]
    @Id INT
AS
BEGIN
    SELECT t1.Id,FirstName,LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,
	t1.EmailConfirmCode,
	t1.EmailConfirmCodeExpire,
	ISNULL(t1.EmailConfirmAttemptCount,0) AS EmailConfirmAttemptCount,
	t1.EmailConfirmLastSentAt,
	t1.ResetPasswordToken, 
	t1.ResetPasswordTokenExpire,
    t1.RememberMeToken, t1.RememberMeExpire
    FROM [User] t1
    LEFT OUTER JOIN [Role] t2 on t1.RoleId = t2.Id
    WHERE t1.Id = @Id
END









































GO

-- dbo.sp_User_GetByRememberMeToken

IF OBJECT_ID('dbo.sp_User_GetByRememberMeToken', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_GetByRememberMeToken]
GO
CREATE PROCEDURE [dbo].[sp_User_GetByRememberMeToken]
    @Token NVARCHAR(200)
AS
BEGIN

    SELECT t1.Id,FirstName,LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,
	t1.EmailConfirmCode,
	t1.EmailConfirmCodeExpire,
	ISNULL(t1.EmailConfirmAttemptCount,0) AS EmailConfirmAttemptCount,
	t1.EmailConfirmLastSentAt,
	t1.ResetPasswordToken,
	t1.ResetPasswordTokenExpire,
    t1.RememberMeToken, t1.RememberMeExpire
    FROM [User] t1
    LEFT OUTER JOIN [Role] t2 on t1.RoleId = t2.Id
    WHERE RememberMeToken = @Token
    AND IsActive = 1

END



































GO

-- dbo.sp_User_Insert

IF OBJECT_ID('dbo.sp_User_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_Insert]
GO
CREATE PROCEDURE [dbo].[sp_User_Insert]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(256),
    @PhoneNumber NVARCHAR(20),
    @BirthDate DATE,
    @IsActive BIT,
    @RoleId	INT,
    @AcceptMembershipAgreement BIT,
    @AcceptKvkk BIT,
    @AgreementAcceptedIp NVARCHAR(100),
    @IsEmailConfirmed BIT,
    @EmailConfirmCode NVARCHAR(20),
    @EmailConfirmCodeExpire DATETIME,
	@EmailConfirmAttemptCount INT,
	@EmailConfirmLastSentAt DATETIME
AS
BEGIN
    INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, PhoneNumber, BirthDate,IsActive,
    RoleId ,AcceptMembershipAgreement,AcceptKvkk,AgreementAcceptedAt,AgreementAcceptedIp,
    IsEmailConfirmed,EmailConfirmCode,EmailConfirmCodeExpire,EmailConfirmAttemptCount,EmailConfirmLastSentAt)
    VALUES
    (@FirstName, @LastName, @Email, @PasswordHash, @PhoneNumber, @BirthDate,@IsActive,
    @RoleId,@AcceptMembershipAgreement,@AcceptKvkk,getdate(),@AgreementAcceptedIp,
    @IsEmailConfirmed,@EmailConfirmCode,@EmailConfirmCodeExpire,@EmailConfirmAttemptCount,@EmailConfirmLastSentAt)
END




























GO

-- dbo.sp_User_IsEmailExists

IF OBJECT_ID('dbo.sp_User_IsEmailExists', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_IsEmailExists]
GO
CREATE PROCEDURE [dbo].[sp_User_IsEmailExists]
    @Email NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM [User]
        WHERE Email = @Email
        AND IsActive = 1
    )
        SELECT 1;
    ELSE
        SELECT 0;
END



































GO

-- dbo.sp_User_List

IF OBJECT_ID('dbo.sp_User_List', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_List]
GO
CREATE PROCEDURE [dbo].[sp_User_List]
AS
BEGIN
    SELECT
        t1.Id,
        FirstName,
        LastName,
		(t1.FirstName + ' ' + t1.LastName) AS FullName,
        (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
        Email,
        PhoneNumber,
        BirthDate,
        IsActive,t1.RoleId, t2.Name RoleName,
        t1.IsEmailConfirmed,
		t1.EmailConfirmCode,
		t1.EmailConfirmCodeExpire,
		ISNULL(t1.EmailConfirmAttemptCount,0) AS EmailConfirmAttemptCount,
		t1.EmailConfirmLastSentAt,
		t1.ResetPasswordToken,
		t1.ResetPasswordTokenExpire,
        t1.RememberMeToken, t1.RememberMeExpire
    FROM [User] t1
    LEFT OUTER JOIN [Role] t2 on t1.RoleId = t2.Id
    ORDER BY t1.Id DESC
END









































GO

-- dbo.sp_User_ResendConfirmationEmail

IF OBJECT_ID('dbo.sp_User_ResendConfirmationEmail', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_ResendConfirmationEmail]
GO
CREATE PROCEDURE [dbo].[sp_User_ResendConfirmationEmail]
    @Email NVARCHAR(100),
    @EmailConfirmCode NVARCHAR(20),
    @EmailConfirmCodeExpire DATETIME,
	@EmailConfirmAttemptCount INT,
	@EmailConfirmLastSentAt DATETIME
AS
BEGIN
	UPDATE [User]
	SET 
	EmailConfirmCode = @EmailConfirmCode,
	EmailConfirmCodeExpire = @EmailConfirmCodeExpire,
	EmailConfirmAttemptCount =@EmailConfirmAttemptCount,
	EmailConfirmLastSentAt = @EmailConfirmLastSentAt
	WHERE
	Email = @Email
END













GO

-- dbo.sp_User_ResetPassword

IF OBJECT_ID('dbo.sp_User_ResetPassword', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_ResetPassword]
GO

CREATE PROCEDURE [dbo].[sp_User_ResetPassword]
    @UserId INT,
    @PasswordHash NVARCHAR(MAX)
AS
BEGIN
    UPDATE [User]
    SET PasswordHash = @PasswordHash,
        ResetPasswordToken = NULL,
        ResetPasswordTokenExpire = NULL
    WHERE Id = @UserId
END


































GO

-- dbo.sp_User_SetRememberMeToken

IF OBJECT_ID('dbo.sp_User_SetRememberMeToken', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_SetRememberMeToken]
GO
CREATE PROCEDURE [dbo].[sp_User_SetRememberMeToken]
    @UserId INT,
    @Token NVARCHAR(200),
    @Expire DATETIME
AS
BEGIN
    UPDATE [User]
    SET RememberMeToken = @Token,
        RememberMeExpire = @Expire
    WHERE Id = @UserId
END



































GO

-- dbo.sp_User_SetResetPasswordToken

IF OBJECT_ID('dbo.sp_User_SetResetPasswordToken', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_SetResetPasswordToken]
GO
CREATE PROCEDURE [dbo].[sp_User_SetResetPasswordToken]
    @UserId INT,
    @Token NVARCHAR(200),
    @Expire DATETIME
AS
BEGIN
    UPDATE [User]
    SET ResetPasswordToken = @Token,
        ResetPasswordTokenExpire = @Expire
    WHERE Id = @UserId
END



































GO

-- dbo.sp_User_Update

IF OBJECT_ID('dbo.sp_User_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_User_Update]
GO
CREATE PROCEDURE [dbo].[sp_User_Update]
    @Id INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @PhoneNumber NVARCHAR(20),
    @BirthDate DATE,
	@Email NVARCHAR(100)

AS
BEGIN
-- Emaili başka bir kullanıcı kullanıyor mu?
    IF EXISTS (
        SELECT 1
        FROM [User]
        WHERE Email = @Email
        AND IsActive = 1
		AND  Id <> @Id
    )
	BEGIN
        SELECT 0 AS Result, '{0} kullanılıyor. Başka bir email adresi deneyiniz.' AS [Message]
		RETURN
	END


	DECLARE @CurrentEmail NVARCHAR(100)
	SELECT @CurrentEmail =Email FROM [User] WHERE  Id = @Id

	DECLARE @IsCurrenEmailConfirmed BIT
	SELECT @IsCurrenEmailConfirmed =IsEmailConfirmed FROM [User] WHERE  Id = @Id

    IF(@CurrentEmail<>@Email)
	BEGIN
	    IF(@IsCurrenEmailConfirmed = 1)
		BEGIN
			UPDATE [User]
			SET
				FirstName = @FirstName,
				LastName = @LastName,
				PhoneNumber = @PhoneNumber,
				BirthDate = @BirthDate,
				Email = @Email,
				IsEmailConfirmed = 0,
				EmailConfirmCode = NULL,
				EmailConfirmCodeExpire = NULL,
				EmailConfirmAttemptCount =0,
				EmailConfirmLastSentAt = NULL
			WHERE Id = @Id
			SELECT 2 AS Result, 'Güncellendi. Yeni email adresini doğrulayınız.' AS [Message]
		END
		ELSE
		BEGIN
			UPDATE [User]
			SET
				FirstName = @FirstName,
				LastName = @LastName,
				PhoneNumber = @PhoneNumber,
				BirthDate = @BirthDate,
				Email = @Email
			WHERE Id = @Id
			SELECT 1 AS Result, 'Güncellendi.' AS [Message]
		END

	END
	ELSE
	BEGIN
		UPDATE [User]
		SET
			FirstName = @FirstName,
			LastName = @LastName,
			PhoneNumber = @PhoneNumber,
			BirthDate = @BirthDate
		WHERE Id = @Id
		SELECT 1 AS Result, 'Güncellendi' AS [Message]

	END



END









































GO

-- dbo.sp_UserAddress_Delete

IF OBJECT_ID('dbo.sp_UserAddress_Delete', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_Delete]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM UserAddress
    WHERE Id = @Id;
END









































GO

-- dbo.sp_UserAddress_GetById

IF OBJECT_ID('dbo.sp_UserAddress_GetById', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_GetById]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        UserId,
        Ad,
        Soyad,
        Telefon,
        Il,
        Ilce,
        Mahalle,
        Adres,
        Baslik,
        IsDefault
    FROM UserAddress
    WHERE Id = @Id
    ORDER BY IsDefault DESC, Id DESC;
END









































GO

-- dbo.sp_UserAddress_GetDefault

IF OBJECT_ID('dbo.sp_UserAddress_GetDefault', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_GetDefault]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_GetDefault]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 1 *
    FROM UserAddress
    WHERE UserId = @UserId AND IsDefault = 1;
END









































GO

-- dbo.sp_UserAddress_Insert

IF OBJECT_ID('dbo.sp_UserAddress_Insert', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_Insert]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_Insert]
    @UserId INT,
    @Ad NVARCHAR(100),
    @Soyad NVARCHAR(100),
    @Telefon NVARCHAR(20),
    @Il NVARCHAR(50),
    @Ilce NVARCHAR(100),
    @Mahalle NVARCHAR(100),
    @Adres NVARCHAR(MAX),
    @Baslik NVARCHAR(20),
    @IsDefault BIT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eğer yeni adres default ise, diğerlerini kapat
    IF (@IsDefault = 1)
    BEGIN
        UPDATE UserAddress
        SET IsDefault = 0
        WHERE UserId = @UserId;
    END

    INSERT INTO UserAddress
    (
        UserId, Ad, Soyad, Telefon,
        Il, Ilce, Mahalle, Adres,
        Baslik, IsDefault
    )
    VALUES
    (
        @UserId, @Ad, @Soyad, @Telefon,
        @Il, @Ilce, @Mahalle, @Adres,
        @Baslik, @IsDefault
    );
END









































GO

-- dbo.sp_UserAddress_ListByUserId

IF OBJECT_ID('dbo.sp_UserAddress_ListByUserId', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_ListByUserId]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_ListByUserId]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        UserId,
        Ad,
        Soyad,
        Telefon,
        Il,
        Ilce,
        Mahalle,
        Adres,
        Baslik,
        IsDefault
    FROM UserAddress
    WHERE UserId = @UserId
    ORDER BY IsDefault DESC, Id DESC;
END









































GO

-- dbo.sp_UserAddress_Update

IF OBJECT_ID('dbo.sp_UserAddress_Update', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserAddress_Update]
GO
CREATE PROCEDURE [dbo].[sp_UserAddress_Update]
    @Id INT,
    @UserId INT,
    @Ad NVARCHAR(100),
    @Soyad NVARCHAR(100),
    @Telefon NVARCHAR(20),
    @Il NVARCHAR(50),
    @Ilce NVARCHAR(100),
    @Mahalle NVARCHAR(100),
    @Adres NVARCHAR(MAX),
    @Baslik NVARCHAR(20),
    @IsDefault BIT
AS
BEGIN
    SET NOCOUNT ON;

    -- Eğer bu adres default olacaksa
    IF (@IsDefault = 1)
    BEGIN
        UPDATE UserAddress
        SET IsDefault = 0
        WHERE UserId = @UserId
          AND Id <> @Id;
    END

    UPDATE UserAddress
    SET
        Ad = @Ad,
        Soyad = @Soyad,
        Telefon = @Telefon,
        Il = @Il,
        Ilce = @Ilce,
        Mahalle = @Mahalle,
        Adres = @Adres,
        Baslik = @Baslik,
        IsDefault = @IsDefault
    WHERE Id = @Id;
END









































GO

-- dbo.sp_UserGetByUserNameAndPassword

IF OBJECT_ID('dbo.sp_UserGetByUserNameAndPassword', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_UserGetByUserNameAndPassword]
GO
CREATE PROCEDURE [dbo].[sp_UserGetByUserNameAndPassword]
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        Id,
        UserName,
        Email,
        Name,
        RoleId
    FROM [UserTable]
    WHERE UserName = @UserName 
      AND Password = @Password;
END























GO


-- ===============================
-- VIEWS
-- ===============================
-- dbo.vReturnDetail

IF OBJECT_ID('dbo.vReturnDetail', 'V') IS NOT NULL
    DROP VIEW [dbo].[vReturnDetail]
GO

CREATE VIEW [dbo].[vReturnDetail]
AS
select 
t1.Id,t1.ReturnId,t1.OrderDetailId,t1.ProductId,t1.ReturnUnitPrice,t1.ReturnQuantity,t1.ReturnLineTotal,
t5.LastStatus,t5.LastIslemTarihi,t5.LastUserid
from ReturnDetail t1 
LEFT OUTER JOIN vReturnHeader t5 on t1.ReturnId = t5.Id










GO

-- dbo.vReturnHeader

IF OBJECT_ID('dbo.vReturnHeader', 'V') IS NOT NULL
    DROP VIEW [dbo].[vReturnHeader]
GO
CREATE       VIEW [dbo].[vReturnHeader]
AS
SELECT 
t1.Id,t1.UserId,t1.ReturnRequestDate,t1.OrderId,t1.ReasonId,t1.ReasonDesc,
s.StatusForReturnCode AS LastStatus,
s.Aciklama AS LastStatusDesc,
s.IslemTarihi AS LastIslemTarihi,
s.IslemUserid AS LastUserid,
BankName,
IBAN,
AccountHolderName,
ReturnCargoAmount,
IsFinalReturnForOrder
FROM ReturnHeader t1
OUTER APPLY
(
SELECT TOP 1 ts.StatusForReturnCode,tsta.Aciklama,ts.IslemTarihi,ts.IslemUserid 
FROM ReturnHeaderStatus ts
LEFT JOIN StatusForReturn tsta ON ts.StatusForReturnCode = tsta.Code
WHERE ts.Iptal = 0 AND ts.ReturnHeaderId=t1.Id
ORDER BY ts.IslemTarihi DESC
) s












GO

