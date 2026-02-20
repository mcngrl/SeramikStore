-- ===============================================
-- FULL DATABASE SCRIPT
-- Generated: 2/17/2026 10:14:52 PM
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
(3, 3, N'F02', N'Arnica', 7500.00, 1, 7500.00, 1, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(4, 3, N'F02', N'Arnica', 7500.00, 1, 7500.00, 1, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(10, 3, N'F02', N'Arnica', 7500.00, 1, 7500.00, 1, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(11, 3, N'F02', N'Arnica', 7500.00, 1, 7500.00, 1, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(2007, 3008, N'as', N'as', 243.00, 3, 729.00, 2, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(2009, 3020, N'11', N'11', 123.00, 1, 123.00, 2, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3005, 3020, N'11', N'11', 123.00, 1, 123.00, 1002, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3006, 3020, N'11', N'11', 123.00, 1, 123.00, 3, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3007, 3008, N'as', N'as', 243.00, 33, 8019.00, 3, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3008, 3008, N'as', N'as', 243.00, 32, 7776.00, 1002, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3009, 3020, N'Hayal kahvesi', N'Hayal kahvesi', 123.00, 1, 123.00, 1004, '2026-01-12T23:50:00', NULL, 1, NULL, N'TL'),
(3010, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', 960.00, 1, 0.00, 5008, '2026-02-01T01:30:19', NULL, 1, NULL, N'TL'),
(3034, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', 8714.00, 4, 8714.00, 6020, '2026-02-06T20:51:23', '2026-02-06T21:17:10', 1, NULL, N'TL'),
(3037, 3021, N'URN01024', N'Gelinlik Kahvesi', 15200.00, 1000, 0.00, NULL, '2026-02-06T20:54:52', NULL, 1, N'7f16dfffb4084ca99941d9b0583f710d', N'TL'),
(3040, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', 78545.00, 1, 78545.00, 6020, '2026-02-06T21:16:10', '2026-02-06T21:17:10', 1, NULL, N'TL'),
(3042, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', 5211.00, 16, 83376.00, 6020, '2026-02-06T21:16:38', '2026-02-06T21:17:10', 1, NULL, N'TL'),
(3048, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', 960.00, 1, 960.00, 2003, '2026-02-06T22:48:25', '2026-02-06T23:37:25', 1, NULL, N'TL')
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
(1, N'Seramik', 0),
(2, N'Seramik', 0),
(3, N'Seramik', 1),
(4, N'Seramik e', 0),
(5, N'Stoneware', 1),
(7, N'fddfcccc', 0),
(8, N'ccccddd', 0),
(5006, N'ewew', 1),
(5007, N'eee', 1)
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
(1, 1, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
ŞURAMUTFAK Beyaz Tombul Fincan

Beyazın sessizliğinde saklı huzur,
Tombul bir fincanda tamamlanan an.
Altı kişilik bir sofra,
Altı ayrı gülümseme, tek sıcak çay.

Ne fazla konuşur, ne eksik kalır,
Sadeliğiyle sarar sohbeti.
Her yudumda ev hissi,
Her masada dinginlik.

Çay demlenir, zaman yavaşlar,
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 1, 5211.00, 1),
(2, 1, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 2),
(3, 1, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 3),
(4, 1, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 4),
(5, 1, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 5),
(6, 1, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 6),
(7, 2, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 1),
(8, 2, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 2, 1920.00, 2),
(9, 3, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 1),
(10, 3, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 2),
(11, 4, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Finca', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti
İLİVA Modern Renkli Seri

Renkler konuşur sessizce,
Kahve kısa bir mola.
Altı fincan, altı an,
Her yudum başka bir ton.

Şık bir duruş masada,
Zaman biraz yavaşlar.
İLİVA’da
Kahve, stile dönüşür.', 8714.00, 1, 8714.00, 1),
(12, 5, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 1),
(13, 5, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 2),
(14, 5, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 3),
(15, 5, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 4),
(16, 5, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 5),
(17, 5, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 6),
(18, 6, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 1),
(19, 7, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 1),
(20, 7, 3020, N'A01', N'Hopce Flora El Yapımı Papatya Desenli, 4 Parça 2 K', N'Hopce Flora Papatya Çay Fincanı

Bir papatya düşer sabaha,
Seramiğe işlenmiş bir gülümseme gibi.
İki fincan, iki kalp,
Bir çay buharında buluşur zaman.

Elde yoğrulmuş her çizgisinde emek,
Bir yudum huzur, bir tutam mutluluk saklı.
220 ml sevgiyle dolar,
Paylaştıkça çoğalır sohbet.

Çay soğusa bile,
Anı sıcak kalır bu fincanda. 🌼☕', 700.00, 8, 5600.00, 2),
(21, 7, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
ŞURAMUTFAK Beyaz Tombul Fincan

Beyazın sessizliğinde saklı huzur,
Tombul bir fincanda tamamlanan an.
Altı kişilik bir sofra,
Altı ayrı gülümseme, tek sıcak çay.

Ne fazla konuşur, ne eksik kalır,
Sadeliğiyle sarar sohbeti.
Her yudumda ev hissi,
Her masada dinginlik.

Çay demlenir, zaman yavaşlar,
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 9, 46899.00, 3),
(22, 8, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 1, 960.00, 1),
(23, 10, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 11, 95854.00, 1),
(24, 10, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
ŞURAMUTFAK Beyaz Tombul Fincan

Beyazın sessizliğinde saklı huzur,
Tombul bir fincanda tamamlanan an.
Altı kişilik bir sofra,
Altı ayrı gülümseme, tek sıcak çay.

Ne fazla konuşur, ne eksik kalır,
Sadeliğiyle sarar sohbeti.
Her yudumda ev hissi,
Her masada dinginlik.

Çay demlenir, zaman yavaşlar,
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 2, 10422.00, 2),
(25, 10, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 1, 10.00, 3),
(26, 10, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 15, 1178175.00, 4),
(27, 11, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 6, 52284.00, 1),
(28, 11, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 5, 50.00, 2),
(29, 11, 3024, N'cxzczx', N'xczcxzxcz', N'<p>xzczxc</p>', 21.00, 1, 21.00, 3),
(30, 12, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 2, 30400.00, 1),
(31, 12, 3020, N'A01', N'Hopce Flora El Yapımı Papatya Desenli, 4 Parça 2 K', N'Hopce Flora Papatya Çay Fincanı

Bir papatya düşer sabaha,
Seramiğe işlenmiş bir gülümseme gibi.
İki fincan, iki kalp,
Bir çay buharında buluşur zaman.

Elde yoğrulmuş her çizgisinde emek,
Bir yudum huzur, bir tutam mutluluk saklı.
220 ml sevgiyle dolar,
Paylaştıkça çoğalır sohbet.

Çay soğusa bile,
Anı sıcak kalır bu fincanda. 🌼☕', 700.00, 3, 2100.00, 2),
(1027, 1011, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 1),
(1028, 1011, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 1, 960.00, 2),
(1029, 1012, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 1),
(1030, 1012, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 2),
(1031, 1012, 3020, N'A01', N'Hopce Flora El Yapımı Papatya Desenli, 4 Parça 2 K', N'Hopce Flora Papatya Çay Fincanı

Bir papatya düşer sabaha,
Seramiğe işlenmiş bir gülümseme gibi.
İki fincan, iki kalp,
Bir çay buharında buluşur zaman.

Elde yoğrulmuş her çizgisinde emek,
Bir yudum huzur, bir tutam mutluluk saklı.
220 ml sevgiyle dolar,
Paylaştıkça çoğalır sohbet.

Çay soğusa bile,
Anı sıcak kalır bu fincanda. 🌼☕', 700.00, 1, 700.00, 3),
(1032, 1012, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 1, 10.00, 4),
(1033, 1013, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 1),
(1034, 1014, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 1),
(1035, 1014, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 2),
(1036, 1015, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 2, 20.00, 1),
(1037, 1016, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 1, 15200.00, 1),
(1038, 1016, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 2),
(1039, 1017, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 1, 78545.00, 1),
(1040, 1018, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
ŞURAMUTFAK Beyaz Tombul Fincan

Beyazın sessizliğinde saklı huzur,
Tombul bir fincanda tamamlanan an.
Altı kişilik bir sofra,
Altı ayrı gülümseme, tek sıcak çay.

Ne fazla konuşur, ne eksik kalır,
Sadeliğiyle sarar sohbeti.
Her yudumda ev hissi,
Her masada dinginlik.

Çay demlenir, zaman yavaşlar,
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 1, 5211.00, 1),
(1041, 1019, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 1)
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
SET IDENTITY_INSERT [dbo].[OrderHeader] ON
INSERT INTO [dbo].[OrderHeader] ([Id], [UserId], [AddressId], [OrderDate], [CargoAmount], [CurrencyCode], [KargoSirketi], [KargoyaVerilmeTarihi], [KargoTakipNo])
VALUES
(1, 2004, 5, '2026-01-11T22:14:23', 150.00, N'TL', NULL, NULL, NULL),
(2, 2004, 5, '2026-01-11T22:19:21', 150.00, N'TL', NULL, NULL, NULL),
(3, 2004, 4, '2026-01-11T22:36:07', 150.00, N'TL', NULL, NULL, NULL),
(4, 2004, 5, '2026-01-12T08:36:31', 150.00, N'TL', NULL, NULL, NULL),
(5, 2004, 5, '2026-01-17T22:48:12', 0.00, N'TL', NULL, NULL, NULL),
(6, 2003, 3, '2026-01-22T08:36:22', 0.00, N'TL', NULL, NULL, NULL),
(7, 2003, 1, '2026-01-22T08:37:12', 0.00, N'TL', NULL, NULL, NULL),
(8, 2004, 5, '2026-01-22T15:41:48', 0.00, N'TL', NULL, NULL, NULL),
(9, 2004, 5, '2026-02-10T09:13:52', 0.00, N'TL', NULL, NULL, NULL),
(10, 7007, 1002, '2026-02-12T09:48:43', 0.00, N'TL', NULL, NULL, NULL),
(11, 7007, 1015, '2026-02-15T12:37:39', 0.00, N'TL', NULL, NULL, NULL),
(12, 7007, 1015, '2026-02-15T13:27:18', 0.00, N'TL', NULL, NULL, NULL),
(1011, 7007, 1015, '2026-02-15T14:47:03', 0.00, N'TL', NULL, NULL, NULL),
(1012, 7007, 1015, '2026-02-15T14:59:41', 0.00, N'TL', NULL, NULL, NULL),
(1013, 7007, 1015, '2026-02-15T15:01:10', 0.00, N'TL', NULL, NULL, NULL),
(1014, 7007, 1015, '2026-02-15T15:01:37', 0.00, N'TL', NULL, NULL, NULL),
(1015, 7007, 1015, '2026-02-15T15:26:17', 0.00, N'TL', NULL, NULL, NULL),
(1016, 7007, 1015, '2026-02-15T20:29:48', 0.00, N'TL', NULL, NULL, NULL),
(1017, 7007, 1015, '2026-02-15T20:40:52', 0.00, N'TL', NULL, NULL, NULL),
(1018, 7007, 1015, '2026-02-15T21:36:00', 0.00, N'TL', NULL, NULL, NULL),
(1019, 7007, 1015, '2026-02-15T21:42:44', 0.00, N'TL', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[OrderHeader] OFF

-- ===============================
-- dbo.OrderStatus
-- ===============================

IF OBJECT_ID('dbo.OrderStatus', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderStatus]
GO
CREATE TABLE [dbo].[OrderStatus] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [OrderId] int NOT NULL,
   [StatusCode] nvarchar(10) NOT NULL,
   [IslemTarihi] datetime NOT NULL,
   [Userid] int NOT NULL
)
GO

ALTER TABLE [dbo].[OrderStatus]
ADD CONSTRAINT [PK_OrderStstus]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] ON
INSERT INTO [dbo].[OrderStatus] ([Id], [OrderId], [StatusCode], [IslemTarihi], [Userid])
VALUES
(1, 1, N'010', '2026-01-11T22:14:23', 2004),
(2, 2, N'010', '2026-01-11T22:19:21', 2004),
(3, 3, N'010', '2026-01-11T22:36:07', 2004),
(4, 4, N'010', '2026-01-12T08:36:31', 2004),
(5, 5, N'010', '2026-01-17T22:48:12', 2004),
(6, 6, N'010', '2026-01-22T08:36:22', 2003),
(7, 7, N'010', '2026-01-22T08:37:12', 2003),
(8, 8, N'010', '2026-01-22T15:41:48', 2004),
(9, 9, N'010', '2026-02-10T09:13:52', 2004),
(10, 10, N'010', '2026-02-12T09:48:43', 7007),
(11, 11, N'010', '2026-02-15T12:37:39', 7007),
(12, 12, N'010', '2026-02-15T13:27:18', 7007),
(13, 1011, N'010', '2026-02-15T14:47:03', 7007),
(14, 1012, N'010', '2026-02-15T14:59:41', 7007),
(15, 1013, N'010', '2026-02-15T15:01:10', 7007),
(16, 1014, N'010', '2026-02-15T15:01:37', 7007),
(17, 1015, N'010', '2026-02-15T15:26:17', 7007),
(18, 1, N'020', '2026-01-11T22:14:24', 2004),
(19, 2, N'020', '2026-01-11T22:19:22', 2004),
(20, 3, N'020', '2026-01-11T22:36:08', 2004),
(21, 4, N'020', '2026-01-12T08:36:32', 2004),
(22, 5, N'020', '2026-01-17T22:48:13', 2004),
(23, 6, N'020', '2026-01-22T08:36:23', 2003),
(24, 7, N'020', '2026-01-22T08:37:13', 2003),
(25, 8, N'020', '2026-01-22T15:41:49', 2004),
(26, 9, N'020', '2026-02-10T09:13:53', 2004),
(27, 10, N'020', '2026-02-12T09:48:44', 7007),
(28, 11, N'020', '2026-02-15T12:37:40', 7007),
(29, 12, N'020', '2026-02-15T13:27:19', 7007),
(30, 1011, N'020', '2026-02-15T14:47:04', 7007),
(31, 1012, N'020', '2026-02-15T14:59:42', 7007),
(32, 1013, N'020', '2026-02-15T15:01:11', 7007),
(33, 1014, N'020', '2026-02-15T15:01:38', 7007),
(34, 1015, N'020', '2026-02-15T15:26:18', 7007),
(35, 1016, N'010', '2026-02-15T20:29:48', 7007),
(36, 1016, N'020', '2026-02-15T20:29:49', 7007),
(37, 1017, N'010', '2026-02-15T20:40:52', 7007),
(38, 1017, N'020', '2026-02-15T20:40:53', 7007),
(39, 1018, N'010', '2026-02-15T21:36:00', 7007),
(40, 1018, N'020', '2026-02-15T21:36:01', 7007),
(41, 1019, N'010', '2026-02-15T21:42:44', 7007),
(42, 1019, N'020', '2026-02-15T21:42:45', 7007)
GO
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF

-- ===============================
-- dbo.PERON
-- ===============================

IF OBJECT_ID('dbo.PERON', 'U') IS NOT NULL
    DROP TABLE [dbo].[PERON]
GO
CREATE TABLE [dbo].[PERON] (
   [DOLUId] int IDENTITY(1,1) NOT NULL,
   [DOLUBigId] bigint NOT NULL,
   [DOLUUniqueId] uniqueidentifier NULL,
   [DOLUIntValue] int NOT NULL,
   [DOLUSmallIntValue] smallint NOT NULL,
   [DOLUTinyIntValue] tinyint NOT NULL,
   [DOLUBitValue] bit NOT NULL,
   [DOLUDecimalValue] decimal(18,2) NULL,
   [DOLUNumericValue] numeric(10,4) NULL,
   [DOLUMoneyValue] money NOT NULL,
   [DOLUSmallMoneyValue] smallmoney NOT NULL,
   [DOLUFloatValue] float NOT NULL,
   [DOLURealValue] real NOT NULL,
   [DOLUDateValue] date NOT NULL,
   [DOLUTimeValue] time NULL,
   [DOLUDateTimeValue] datetime NOT NULL,
   [DOLUSmallDateTimeValue] smalldatetime NOT NULL,
   [DOLUDateTime2Value] datetime2 NOT NULL,
   [DOLUDateTimeOffsetValue] datetimeoffset NOT NULL,
   [DOLUCharValue] char(10) NOT NULL,
   [DOLUVarCharValue] varchar(100) NOT NULL,
   [DOLUVarCharMaxValue] varchar(MAX) NOT NULL,
   [DOLUNCharValue] nchar(10) NOT NULL,
   [DOLUNVarCharValue] nvarchar(100) NOT NULL,
   [DOLUNVarCharMaxValue] nvarchar(MAX) NOT NULL,
   [DOLUNTextValue] ntext NOT NULL,
   [DOLUBinaryValue] binary NOT NULL,
   [DOLUVarBinaryValue] varbinary NOT NULL,
   [DOLUVarBinaryMaxValue] varbinary NOT NULL,
   [DOLUImageValue] image NOT NULL,
   [DOLUXmlValue] xml NOT NULL,
   [DOLUSqlVariantValue] sql_variant NOT NULL,
   [DOLURowVersionValue] timestamp NOT NULL,
   [DOLUHierarchyIdValue] hierarchyid NOT NULL,
   [DOLUGeographyValue] geography NOT NULL,
   [DOLUGeometryValue] geometry NOT NULL,
   [DOLUIsActive] bit NOT NULL,
   [DOLUInsertDate] datetime2 NOT NULL,
   [DOLUUpdateDate] datetime2 NOT NULL,
   [NALBigId] bigint NULL,
   [NALUniqueId] uniqueidentifier NULL,
   [NALIntValue] int NULL,
   [NALSmallIntValue] smallint NULL,
   [NALTinyIntValue] tinyint NULL,
   [NALBitValue] bit NULL,
   [NALDecimalValue] decimal(18,2) NULL,
   [NALNumericValue] numeric(10,4) NULL,
   [NALMoneyValue] money NULL,
   [NALSmallMoneyValue] smallmoney NULL,
   [NALFloatValue] float NULL,
   [NALRealValue] real NULL,
   [NALDateValue] date NULL,
   [NALTimeValue] time NULL,
   [NALDateTimeValue] datetime NULL,
   [NALSmallDateTimeValue] smalldatetime NULL,
   [NALDateTime2Value] datetime2 NULL,
   [NALDateTimeOffsetValue] datetimeoffset NULL,
   [NALCharValue] char(10) NULL,
   [NALVarCharValue] varchar(100) NULL,
   [NALVarCharMaxValue] varchar(MAX) NULL,
   [NALNCharValue] nchar(10) NULL,
   [NALNVarCharValue] nvarchar(100) NULL,
   [NALNVarCharMaxValue] nvarchar(MAX) NULL,
   [NALNTextValue] ntext NULL,
   [NALBinaryValue] binary NULL,
   [NALVarBinaryValue] varbinary NULL,
   [NALVarBinaryMaxValue] varbinary NULL,
   [NALImageValue] image NULL,
   [NALXmlValue] xml NULL,
   [NALSqlVariantValue] sql_variant NULL,
   [NALHierarchyIdValue] hierarchyid NULL,
   [NALGeographyValue] geography NULL,
   [NALGeometryValue] geometry NULL,
   [NALIsActive] bit NULL,
   [NALInsertDate] datetime2 NULL,
   [NALUpdateDate] datetime2 NULL
)
GO

-- ===============================
-- dbo.Potansiyel
-- ===============================

IF OBJECT_ID('dbo.Potansiyel', 'U') IS NOT NULL
    DROP TABLE [dbo].[Potansiyel]
GO
CREATE TABLE [dbo].[Potansiyel] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Name] nvarchar(50) NOT NULL,
   [SurName] nvarchar(50) NOT NULL,
   [KnownName] nvarchar(50) NOT NULL,
   [Email] nvarchar(100) NOT NULL,
   [PhoneNumber] nvarchar(50) NOT NULL,
   [IsActive] bit NOT NULL,
   [Adress] int NOT NULL,
   [tarih] date NULL,
   [kayıttarihi] datetime NULL,
   [saat] time NULL,
   [satir] nvarchar(10) NULL,
   [max] nvarchar(MAX) NULL,
   [resim] image NULL
)
GO

ALTER TABLE [dbo].[Potansiyel]
ADD CONSTRAINT [PK_Potansiyel]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[Potansiyel] ON
INSERT INTO [dbo].[Potansiyel] ([Id], [Name], [SurName], [KnownName], [Email], [PhoneNumber], [IsActive], [Adress], [tarih], [kayıttarihi], [saat], [satir], [max], [resim])
VALUES
(1, N'can', N'hj', N'kjhDSDS', N'khjk', N'jhg', 1, 32, '2026-01-31T00:00:00', NULL, NULL, NULL, NULL, NULL),
(3, N'sadas', N'sdds', N'hg', N'ass', N'dsd', 1, 45, NULL, NULL, NULL, NULL, NULL, NULL),
(4, N'asas', N'asas', N'ghf', N'h', N'h', 1, 4, NULL, NULL, NULL, NULL, NULL, NULL),
(5, N'232323', N'asd', N'sa', N'sa', N'sa', 1, 56, NULL, NULL, NULL, NULL, NULL, NULL),
(6, N'xzc', N'zcx', N'zxc', N'zcx', N'zx', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(8, N'WQ', N'WQ', N'DQ', N'DQ', N'DQ', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Potansiyel] OFF

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
(3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 5, 8714.00, 1, 1, 4),
(3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 5, 10.00, 1, 1, 6),
(3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 3, 78545.00, 1, 1, 5),
(3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
ŞURAMUTFAK Beyaz Tombul Fincan

Beyazın sessizliğinde saklı huzur,
Tombul bir fincanda tamamlanan an.
Altı kişilik bir sofra,
Altı ayrı gülümseme, tek sıcak çay.

Ne fazla konuşur, ne eksik kalır,
Sadeliğiyle sarar sohbeti.
Her yudumda ev hissi,
Her masada dinginlik.

Çay demlenir, zaman yavaşlar,
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5, 5211.00, 1, 1, 7),
(3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 5, 960.00, 1, 1, 3),
(3020, N'A01', N'Hopce Flora El Yapımı Papatya Desenli, 4 Parça 2 K', N'Hopce Flora Papatya Çay Fincanı

Bir papatya düşer sabaha,
Seramiğe işlenmiş bir gülümseme gibi.
İki fincan, iki kalp,
Bir çay buharında buluşur zaman.

Elde yoğrulmuş her çizgisinde emek,
Bir yudum huzur, bir tutam mutluluk saklı.
220 ml sevgiyle dolar,
Paylaştıkça çoğalır sohbet.

Çay soğusa bile,
Anı sıcak kalır bu fincanda. 🌼☕', 5, 700.00, 1, 1, 8),
(3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 5, 15200.00, 1, 1, 1),
(3022, N'dsaasd', N'sdasda', N'<p><strong>sdasdaads</strong></p>', 5, 2331.00, 1, 1, 9),
(3023, N'ABC', N'ACa111', N'<p><strong>assad</strong></p>', 3, 1.00, 1, 1, 2),
(3024, N'cxzczx', N'xczcxzxcz', N'<p>xzczxc</p>', 5, 21.00, 1, 1, 10),
(3025, N'2112', N'1212', N'<p>2121</p>', 3, 1212.00, 1, 1, 11),
(3026, N'sdfs', N'dsfsd', N'<p>ww</p>', 3, 212.00, 1, 0, 12)
GO
SET IDENTITY_INSERT [dbo].[Product] OFF

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
(1, 0, N'/uploads/products/0/464ad953-e14c-4e11-8332-55400f71ec6f.jpg', 0, 4),
(2, 0, N'/uploads/products/0/7636156a-03e1-4cd7-9d20-7b4cbec267fa.jpg', 0, 5),
(16, 3020, N'/uploads/products/3020/d2fedf1b-319a-492b-9adf-b6b18a8316a5.jpg', 1, 1),
(17, 3020, N'/uploads/products/3020/f86cbe43-259d-4fae-b141-f864e0f8ede8.jpg', 0, 3),
(18, 3020, N'/uploads/products/3020/703f7b0c-5be4-40f5-96a8-a7216c6de609.jpg', 0, 2),
(19, 3019, N'/uploads/products/3019/1175bdea-7530-45b2-815c-7ab5726ee223.jpg', 0, 1),
(20, 3019, N'/uploads/products/3019/11800c81-3586-4888-aaca-bde65142b0b3.jpg', 1, 2),
(21, 3018, N'/uploads/products/3018/20a6d811-425c-4e55-98fd-b8ed312155b5.jpg', 0, 2),
(22, 3018, N'/uploads/products/3018/114a05f7-a7d5-4c19-8297-251ae719c6aa.jpg', 1, 1),
(23, 3016, N'/uploads/products/3016/ad11eaec-7af2-4840-955d-5c3a63b665d1.jpg', 1, 1),
(24, 3016, N'/uploads/products/3016/365f4ae6-108d-4cb7-b399-ebd89c0580c0.jpg', 0, 2),
(25, 3016, N'/uploads/products/3016/35b2b1f9-877c-4d5c-9ff1-7081486b745f.jpg', 0, 3),
(26, 3016, N'/uploads/products/3016/4e636099-9e99-48bd-89f3-eeb77d9c578a.jpg', 0, 4),
(27, 3008, N'/uploads/products/3008/3ca3713a-a65f-4d59-98c9-f21fe10a1ed6.jpg', 1, 1),
(28, 3008, N'/uploads/products/3008/76de6f2f-436d-472b-b49d-533866a32485.jpg', 0, 2),
(29, 3008, N'/uploads/products/3008/30b9be82-29e8-4461-b1db-6e6c0202d30f.jpg', 0, 3),
(30, 3008, N'/uploads/products/3008/0dd204e5-041c-4acb-af0e-38f57df02a62.jpg', 0, 4),
(31, 3006, N'/uploads/products/3006/9ffe9f65-35f1-4c5a-85a8-0365833f43f0.jpg', 0, 1),
(32, 3006, N'/uploads/products/3006/e578361d-fdf1-4c1a-a077-28e3a937001e.jpg', 0, 2),
(33, 3006, N'/uploads/products/3006/1f57c635-b047-4eb2-9c1c-36ad6207daaa.jpg', 0, 3),
(34, 3006, N'/uploads/products/3006/1317d027-5a52-46e5-8544-dd13576be44e.jpg', 1, 0),
(35, 3021, N'/uploads/products/3021/c48f05f8-0b0a-4730-89a8-cededdadd2ed.jpg', 1, 0),
(36, 3024, N'/uploads/products/3024/01d2ec99-35e6-4ac4-9916-2e6ac40dee23.png', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[ProductImage] OFF

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
-- dbo.Shop
-- ===============================

IF OBJECT_ID('dbo.Shop', 'U') IS NOT NULL
    DROP TABLE [dbo].[Shop]
GO
CREATE TABLE [dbo].[Shop] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ShopName] nvarchar(255) NOT NULL,
   [UserId] int NOT NULL,
   [InsertDate] datetime NOT NULL,
   [UpdateDate] datetime NULL,
   [IsActive] bit NOT NULL
)
GO

ALTER TABLE [dbo].[Shop]
ADD CONSTRAINT [PK_Shop]
PRIMARY KEY CLUSTERED ([Id])
GO

-- ===============================
-- dbo.Status
-- ===============================

IF OBJECT_ID('dbo.Status', 'U') IS NOT NULL
    DROP TABLE [dbo].[Status]
GO
CREATE TABLE [dbo].[Status] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [Code] nvarchar(10) NOT NULL,
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
(1, N'010', N'Şipariş Oluşturdu.'),
(2, N'020', N'Ödeme Bekleniyor.'),
(3, N'030', N'Sipariş Onaylandı.'),
(4, N'050', N'Kargoya Verildi.'),
(5, N'060', N'Sipariş Müşteri Tarafından İptal Edildi.'),
(7, N'070', N'Sipariş Satıcı Tarafından İptal Edildi.'),
(9, N'040', N'Siparişiniz Hazırlanıyor.'),
(10, N'100', N'Sipariş Tamamlandı.')
GO
SET IDENTITY_INSERT [dbo].[Status] OFF

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
   [EmailConfirmToken] nvarchar(200) NULL,
   [EmailConfirmTokenExpire] datetime NULL,
   [ResetPasswordToken] nvarchar(200) NULL,
   [ResetPasswordTokenExpire] datetime NULL,
   [RememberMeToken] nvarchar(200) NULL,
   [RememberMeExpire] datetime NULL
)
GO

ALTER TABLE [dbo].[User]
ADD CONSTRAINT [PK__User__3214EC077669D901]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[User] ON
INSERT INTO [dbo].[User] ([Id], [FirstName], [LastName], [Email], [PasswordHash], [PhoneNumber], [BirthDate], [IsActive], [RoleId], [AcceptMembershipAgreement], [AcceptKvkk], [AgreementAcceptedAt], [AgreementAcceptedIp], [IsEmailConfirmed], [EmailConfirmToken], [EmailConfirmTokenExpire], [ResetPasswordToken], [ResetPasswordTokenExpire], [RememberMeToken], [RememberMeExpire])
VALUES
(2003, N'Can', N'Gürel', N'admin@admin.com', N'AQAAAAIAAYagAAAAEBCwp9AumgSg+KAR1R4NO6yyz3Dh9O8h4TSv9okU1MDWU7uDmT00cMgYv+W6M0RsoA==', N'321321', '2027-01-01T00:00:00', 1, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(2004, N'Ali', N'Veli', N'customer@customer.com', N'AQAAAAIAAYagAAAAEIfDOAtnAe0Y0ZCIgsJr/DvK5M8WbbfGGdyi5/mVzXCzJYNu2fZPDlfXVcm7CPVkDA==', N'32132', '2026-01-29T00:00:00', 1, 2, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(5007, N'sdas', N'asads', N'a@a.com', N'AQAAAAIAAYagAAAAEBYkVU5MdLtgyYfqioOEYZo9ByZ3V14Jt+OR5P+mXPFFsDZGKjn9DM8rdZmaZbJSWg==', N'(544) 444 55 11', '2026-01-17T00:00:00', 1, 2, 1, 1, '2026-01-31T22:36:21', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(5008, N'ayşe', N'gürel', N'agurel@boun.edu.tr', N'AQAAAAIAAYagAAAAENW6oSGGuug5EyOETkpxYcnjOGTbNhgjueT0pvOMYSjGwSNsVdtGu+mNYTWvCtmHbQ==', N'(534) 125 21 25', '2026-02-18T00:00:00', 1, 2, 1, 1, '2026-02-01T01:29:50', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6005, N'as', N'sa', N'as@a.com', N'AQAAAAIAAYagAAAAEFbtggdHwpIgbg3H3HWNysAVcRmByBtn+DLiDHGtvI2OCdv8Mx0zq65NhL66IqbvrQ==', N'(532) 362 15 12', '2026-02-18T00:00:00', 1, 2, 1, 1, '2026-02-01T19:11:43', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6006, N'ssd', N'sdsd', N'sd@saas.com', N'AQAAAAIAAYagAAAAENfwe+WXOFeaFi+JyKZtHOs4tufu/beI6veof+hxJWOKooiwS5tMgwWJqnqx5cSFQw==', N'(541) 521 45 12', '2026-02-27T00:00:00', 1, 2, 1, 1, '2026-02-01T20:21:02', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6007, N'ad', N'ds', N'b@a.com', N'AQAAAAIAAYagAAAAEE/JF/mKwcPbXup5NhbIhE1UujNwHz/0wlS1hkUxoRXhkWUeoYTGsem9InT1lFa1MQ==', N'(542) 152 15 12', '2026-02-27T00:00:00', 1, 2, 1, 1, '2026-02-01T20:40:24', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6008, N'asas', N'asdsa', N'asdas@ss.com', N'AQAAAAIAAYagAAAAEOfSqy0fYQjEPnOTtu546j11U0J/v7qgNxmkKU1ZZRoVz7fvY2+oTg4DpctPLvfM9Q==', N'(544) 125 89 45', '2026-02-12T00:00:00', 1, 2, 1, 1, '2026-02-01T21:02:35', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6009, N'sd', N'dsf', N'fsd@fsd.com.tr', N'AQAAAAIAAYagAAAAENHhnR+2Ld7Ie82NFrqfhV3nvXAC23jlKPDyaFpoLUk4aOw6omBemLzBqbWWQ0P4mw==', N'(532) 666 23 65', '2026-02-21T00:00:00', 1, 2, 1, 1, '2026-02-01T22:30:51', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6010, N'WQ', N'ASAS', N'AS@AS.COM', N'AQAAAAIAAYagAAAAEGL0w9XwNgWEWS3yho6tWXTroD/uc3P8DAPPBQI7pNMpH0UNymZ6XKDtQ/qa3l9Lsg==', N'(564) 646 54 65', NULL, 1, 2, 1, 1, '2026-02-01T22:36:53', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6011, N'sada', N'asad', N'me@me.com', N'AQAAAAIAAYagAAAAEIakZ7uqAu8udhF/u+jOd0WDb9fdOHtgCOn1ivo3K91kFMMsz3jnVdM8abAO61A8Iw==', N'(545) 125 45 61', '2026-02-12T00:00:00', 1, 2, 1, 1, '2026-02-01T22:53:50', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6016, N'kjhkljh', N'lkjhlkjhlkjh', N'mehmetcangurel1@gmail.com', N'AQAAAAIAAYagAAAAEMfGcPMFuNyU8biwYyZp/L3mwHsna0onLQm94Oeo0uWWg1sKCm9B5phk3lG1olDhhA==', N'(545) 421 45 12', '2026-03-05T00:00:00', 1, 2, 1, 1, '2026-02-02T12:24:18', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6017, N'asddas', N'dsadsa', N'mehmetcangurel3@gmail.com', N'AQAAAAIAAYagAAAAEIiiyUrFL+WL8AhZT47/FblwraGnrl30fWWbqrqT46BImMW26ou1Mm15cMC+4IgEgA==', N'(542) 212 15 12', NULL, 1, 2, 1, 1, '2026-02-02T13:01:17', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6020, N'dsa', N'asd', N'mehmetcangurel@gmail.com', N'AQAAAAIAAYagAAAAEIalE4pm0g+7uEbweHnChh3hCJwdAOfbvuZEHyq3ipoI0SchBD0GgNBVKeL/hCNJKg==', N'(544) 421 94 02', NULL, 0, 2, 1, 1, '2026-02-02T13:14:14', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6021, N'dsa', N'dsa', N'dsa@ha.com', N'AQAAAAIAAYagAAAAEEDVkn9hwxnnyrMtU0bCM2ad/9Q8os0LlhAt9OPxBndJ0YyYslfjCQpCAk/8V6WKxA==', N'(545) 512 52 10', '2026-01-01T00:00:00', 1, 2, 1, 1, '2026-02-03T08:11:37', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6022, N'sd', N'ds', N'email@email.com', N'AQAAAAIAAYagAAAAEG+oP7ARpqih5lWyayU6+UApNr3QQA2XDaC6Y3bHN5uwEParQ0fpRtENgXJuHlV77Q==', N'(555) 555 55 55', NULL, 1, 2, 1, 1, '2026-02-03T08:14:43', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6023, N'ads', N'asd', N'emailq@email.com', N'AQAAAAIAAYagAAAAENMJz45/53vu78ayAdI6u2D1DwaaI+nXgSuTBZRXs40HixlCrthciFSDiurFE0eXeg==', N'(555) 555 55 55', '2026-02-04T00:00:00', 1, 2, 1, 1, '2026-02-03T08:41:38', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6024, N'hasa', N'hasan', N'hasan@hasan.com', N'AQAAAAIAAYagAAAAELAGJz00zyiNbpFOJ6KaiyMqQ5jGtJFCYv0JxDqBAKpy6fAKVOaD3ZzS3Bsq/LmmLQ==', N'(555) 555 55 55', '2026-01-01T00:00:00', 1, 2, 1, 1, '2026-02-03T09:23:43', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(6025, N'Serap', N'Pakdemir', N'spakdemir@gmail.com', N'AQAAAAIAAYagAAAAEIr3edYXhFUzVfeyS4kRPH6MyV31WHW662fktZJMYcx2fZIAfO187luNOAyEeH2HDA==', N'(555) 555 55 55', '2021-01-01T00:00:00', 1, 2, 1, 1, '2026-02-04T09:12:36', N'::1', 0, N'5fca62a368624cf78e2dde03acef3cd0', '2026-02-05T06:12:36', NULL, NULL, NULL, NULL),
(6026, N'sinem', N'batakan', N'sbatakan@gmail.com', N'AQAAAAIAAYagAAAAEAsVxHcYMPXWASZlpF+FIKDoR8jrOdkY/8J7jQbykWqXiZFJhYQ5q17Q0pEmHXzw7Q==', N'(555) 555 55 55', '2026-02-18T00:00:00', 1, 2, 1, 1, '2026-02-04T09:18:50', N'::1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(7007, N'cc', N'saas', N'mehmetcangurel@gmail.com', N'AQAAAAIAAYagAAAAED2hq1j+Xl/om2vMSHak0cAJvXy/mYwWFvjnAL7N51sv2iSysjEtRfS1tsWOMPlT2g==', N'(555) 555 55 55', '2026-02-24T00:00:00', 1, 1, 1, 1, '2026-02-07T18:16:43', N'::1', 1, NULL, NULL, N'8fde9903c43c4f06bd23395ac1f9eef4', '2026-02-07T22:48:52', NULL, NULL),
(7008, N'Meh', N'Gürel', N'ty@acom', N'AQAAAAIAAYagAAAAEBo4Z1Y0CA1YJM6dyHW2oOCvl6P0dMm2gRRA/ej+mf5l3ioPnIsRvAs/xTIig3c3Ow==', N'(544) 421 94 02', '2026-02-23T00:00:00', 1, 2, 1, 1, '2026-02-12T09:51:42', N'::1', 0, N'523ea9a182184faf8825502c57b72724', '2026-02-13T06:51:42', NULL, NULL, NULL, NULL)
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
(4, 2004, N'Baturan', N'Dursun', N'5301415', N'İstanbul', N'Esenyurt', N'Yeniyaşam Mah.', N'Birumut sok. Zafer Ap.t No:12fff', N'İş Adresi', 0),
(5, 2004, N'Atakan', N'Samuray', N'5323652356', N'İstanbul', N'Ataşehir', N'Acarlar Mah...', N'Salihli Sokak. Zafirox Konakları No:2 Kat :1 Da:25', N'Ev Adresi', 1),
(1014, 7007, N'Yama', N'Yama', N'dsadsa', N'saddsa', N'dsadsa', N'sdadsa', N'asdsda', N'Yamans', 0),
(1015, 7007, N'Mehmet', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'Yenişehir Mah. ', N'Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 ', N'rrrr', 1),
(1016, 7007, N'sasa', N'sasa', N'sasa', N'assa', N'sasa', N'assa', N'sasa', N'sasaffff', 0)
GO
SET IDENTITY_INSERT [dbo].[UserAddress] OFF

-- ===============================
-- dbo.UserTable
-- ===============================

IF OBJECT_ID('dbo.UserTable', 'U') IS NOT NULL
    DROP TABLE [dbo].[UserTable]
GO
CREATE TABLE [dbo].[UserTable] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [UserName] nvarchar(100) NULL,
   [Email] nvarchar(100) NULL,
   [Password] nvarchar(100) NULL,
   [Name] nvarchar(100) NULL,
   [TelephoneNumber] nvarchar(100) NULL,
   [Address] nvarchar(MAX) NULL,
   [RoleId] int NULL
)
GO

ALTER TABLE [dbo].[UserTable]
ADD CONSTRAINT [PK_UserTable]
PRIMARY KEY CLUSTERED ([Id])
GO
SET IDENTITY_INSERT [dbo].[UserTable] ON
INSERT INTO [dbo].[UserTable] ([Id], [UserName], [Email], [Password], [Name], [TelephoneNumber], [Address], [RoleId])
VALUES
(1, N'Admin', N'Can@Can.com', N'1', N'Can Gürel', N'54125', N'asdsdsas', 1),
(2, N'Ali', N'Ali@Ali.com', N'1', N'Ali Veli', N'654654', N'87987', 2)
GO
SET IDENTITY_INSERT [dbo].[UserTable] OFF

-- ===============================
-- dbo.Vatan
-- ===============================

IF OBJECT_ID('dbo.Vatan', 'U') IS NOT NULL
    DROP TABLE [dbo].[Vatan]
GO
CREATE TABLE [dbo].[Vatan] (
   [Id] int IDENTITY(1,1) NOT NULL,
   [ProductId] int NOT NULL,
   [ProductCode] nvarchar(50) NOT NULL,
   [ProductName] nvarchar(255) NOT NULL,
   [UnitPrice] decimal(9,2) NOT NULL,
   [Quantity] int NOT NULL,
   [TotalAmount] decimal(9,2) NOT NULL,
   [UserId] int NOT NULL,
   [InsertDate] datetime NULL,
   [UpdateDate] datetime NULL,
   [IsActive] bit NULL
)
GO

ALTER TABLE [dbo].[Vatan]
ADD CONSTRAINT [PK_Vatan]
PRIMARY KEY CLUSTERED ([Id])
GO


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
    CAST(0 AS decimal(18,2))        AS CargoAmount,
    SUM(t2.UnitPrice * t1.Quantity) AS GrandTotal,
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
           ,[Userid])
		SELECT @OrderId,'010',GETDATE(),@UserId

		INSERT INTO [dbo].[OrderStatus]
           ([OrderId]
           ,[StatusCode]
           ,[IslemTarihi]
           ,[Userid])
		SELECT @OrderId,'020',  DATEADD(SECOND, 1, GETDATE()) ,@UserId

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




Select * from Cart








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

		SELECT TOP 1 
		@LastStatuAciklama =t2.Aciklama
		FROM [OrderStatus] t1
		LEFT JOIN [Status] t2 ON t1.StatusCode = t2.Code
		WHERE t1.OrderId = @OrderId
		ORDER BY t1.IslemTarihi DESC;

    -- Header
    SELECT
        oh.Id,
        oh.OrderDate,
        @LastStatuAciklama AS OrderStatus,
        oh.CargoAmount,
        oh.UserId,
		oh.CurrencyCode,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) AS ProductTotal,
        (SELECT SUM(LineTotal) FROM OrderDetail WHERE OrderId = oh.Id) + oh.CargoAmount AS GrandTotal,
		oh.KargoSirketi,
		oh.KargoyaVerilmeTarihi,
		oh.KargoTakipNo
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
	FROM UserAddress 
	WHERE Id IN (SELECT TOP 1 AddressId  FROM OrderHeader WHERE Id= @OrderId )

	-- Durum Tarihçesi
	SELECT [StatusCode],[IslemTarihi],t2.Aciklama
	FROM [OrderStatus] t1
	LEFT OUTER JOIN [Status] t2 on t1.StatusCode = t2.Code
	WHERE OrderId = @OrderId Order by IslemTarihi Desc


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
    SELECT TOP 1 t2.Aciklama AS LastStatusAciklama
    FROM OrderStatus t1
    LEFT JOIN Status t2 ON t1.StatusCode = t2.Code
    WHERE t1.OrderId = oh.Id
    ORDER BY t1.IslemTarihi DESC
) os


GROUP BY
    oh.Id,
    oh.OrderDate,
    oh.CargoAmount,
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
    oh.CargoAmount,
	ISNULL(SUM(od.LineTotal),0) AS ProductTotal,
	ISNULL(CargoAmount,0) AS CargoAmount,
	ISNULL(SUM(od.LineTotal),0) + oh.CargoAmount AS GrandTotal,
    os.LastStatusAciklama AS OrderStatus
FROM OrderHeader oh
LEFT OUTER JOIN OrderDetail od ON oh.Id = od.OrderId

OUTER APPLY (
    SELECT TOP 1 t2.Aciklama AS LastStatusAciklama
    FROM OrderStatus t1
    LEFT JOIN Status t2 ON t1.StatusCode = t2.Code
    WHERE t1.OrderId = oh.Id
    ORDER BY t1.IslemTarihi DESC
) os

WHERE oh.UserId = @UserId

GROUP BY
    oh.Id,
    oh.OrderDate,
    oh.CargoAmount,
    os.LastStatusAciklama

ORDER BY oh.OrderDate DESC;



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
CREATE PROCEDURE sp_User_ConfirmEmail
    @UserId INT
AS
BEGIN
    UPDATE [User]
    SET 
        IsEmailConfirmed = 1,
        EmailConfirmToken = NULL,
        EmailConfirmTokenExpire = NULL
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
    SELECT t1.Id,FirstName,LastName,Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,t1.EmailConfirmToken,t1.EmailConfirmTokenExpire,t1.ResetPasswordToken,t1.ResetPasswordTokenExpire,
    t1.RememberMeToken, t1.RememberMeExpire
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
    SELECT t1.Id,FirstName,LastName,Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,t1.EmailConfirmToken,t1.EmailConfirmTokenExpire,t1.ResetPasswordToken, t1.ResetPasswordTokenExpire,
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

    SELECT t1.Id,FirstName,LastName,Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
    t1.IsEmailConfirmed,t1.EmailConfirmToken,t1.EmailConfirmTokenExpire,t1.ResetPasswordToken,t1.ResetPasswordTokenExpire,
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
    @EmailConfirmToken NVARCHAR(200),
    @EmailConfirmTokenExpire DATETIME
AS
BEGIN
    INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, PhoneNumber, BirthDate,IsActive,
    RoleId ,AcceptMembershipAgreement,AcceptKvkk,AgreementAcceptedAt,AgreementAcceptedIp,
    IsEmailConfirmed,EmailConfirmToken,EmailConfirmTokenExpire)
    VALUES
    (@FirstName, @LastName, @Email, @PasswordHash, @PhoneNumber, @BirthDate,@IsActive,
    @RoleId,@AcceptMembershipAgreement,@AcceptKvkk,getdate(),@AgreementAcceptedIp,
    @IsEmailConfirmed,@EmailConfirmToken,@EmailConfirmTokenExpire)
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
        Email,
        PhoneNumber,
        BirthDate,
        IsActive,t1.RoleId, t2.Name RoleName,
        t1.IsEmailConfirmed,t1.EmailConfirmToken,t1.EmailConfirmTokenExpire,t1.ResetPasswordToken,t1.ResetPasswordTokenExpire,
        t1.RememberMeToken, t1.RememberMeExpire
    FROM [User] t1
    LEFT OUTER JOIN [Role] t2 on t1.RoleId = t2.Id
    ORDER BY t1.Id DESC
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
    @BirthDate DATE
AS
BEGIN
    UPDATE [User]
    SET
        FirstName = @FirstName,
        LastName = @LastName,
        PhoneNumber = @PhoneNumber,
        BirthDate = @BirthDate
    WHERE Id = @Id
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

