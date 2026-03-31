-- ===============================================
-- FULL DATABASE SCRIPT
-- Generated: 31/03/2026 17:41:31
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
(3042, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', 5211.00, 16, 83376.00, 6020, '2026-02-06T21:16:38', '2026-02-06T21:17:10', 1, NULL, N'TL')
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
(1041, 1019, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 1),
(1042, 1020, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 1, 960.00, 1),
(1043, 1020, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 9, 136800.00, 2),
(1044, 1021, 3027, N'F01', N'Fincan Seti', N'<p>Fincan Seti stonewarte</p>', 95000.00, 1, 95000.00, 1),
(1045, 1022, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 2, 1920.00, 1),
(1046, 1023, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 3, 45600.00, 1),
(1047, 1023, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 15, 14400.00, 2),
(1048, 1023, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 1, 10.00, 3),
(1049, 1023, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
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
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 9, 46899.00, 4),
(1050, 1024, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 2, 1920.00, 1),
(1051, 1024, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 3, 45600.00, 2),
(1052, 1024, 3027, N'F01', N'Fincan Seti', N'<p>Fincan Seti stonewarte</p>', 95000.00, 1, 95000.00, 3),
(1053, 1024, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 4),
(1054, 1024, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 1, 10.00, 5),
(1055, 1025, 3027, N'F01', N'Fincan Seti', N'<p>Fincan Seti stonewarte</p>', 95000.00, 1, 95000.00, 1),
(1056, 1026, 3006, N'A05', N'İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Seti', N'<p>İLİVA 6 Kişilik 12 Parça Modern Renkli Kahve Fincan Takımı - Şık Tasarım Sunum Seti İLİVA Modern Renkli Seri Renkler konuşur sessizce, Kahve kısa bir mola. Altı fincan, altı an, Her yudum başka bir ton. Şık bir duruş masada, Zaman biraz yavaşlar. İLİVA’da Kahve, stile dönüşür.</p>', 8714.00, 1, 8714.00, 1),
(1057, 1026, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 6, 471270.00, 2),
(1058, 1026, 3020, N'A01', N'Hopce Flora El Yapımı Papatya Desenli, 4 Parça 2 K', N'Hopce Flora Papatya Çay Fincanı

Bir papatya düşer sabaha,
Seramiğe işlenmiş bir gülümseme gibi.
İki fincan, iki kalp,
Bir çay buharında buluşur zaman.

Elde yoğrulmuş her çizgisinde emek,
Bir yudum huzur, bir tutam mutluluk saklı.
220 ml sevgiyle dolar,
Paylaştıkça çoğalır sohbet.

Çay soğusa bile,
Anı sıcak kalır bu fincanda. 🌼☕', 700.00, 5, 3500.00, 3),
(1059, 1026, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
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
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 5, 26055.00, 4),
(1060, 1027, 3027, N'F01', N'Fincan Seti', N'<p>Fincan Seti stonewarte</p>', 95000.00, 4, 380000.00, 1),
(1061, 1028, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 8, 7680.00, 1),
(1062, 1028, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 7, 106400.00, 2),
(1063, 1028, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 6, 60.00, 3),
(1064, 1029, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 10, 152000.00, 1),
(1065, 1029, 3019, N'A02', N'ŞURAMUTFAK 12 Parça Fincan Takımı | 6 Kişilik Finc', N'<p>Detayları buraya </p><p>yazaıyorum</p><p><strong>Bold</strong></p><p><br></p><p><br></p><p><br></p>', 960.00, 12, 11520.00, 2),
(1066, 1029, 3016, N'A03', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx ', N'Erbaşlar Love Bırd Yeşil Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
Love Bird Yeşil Seri

Yeşil bir sessizlik,
Tombul bir fincan.
Kahve ağır ağır konuşur,
Hatır sessizce kalır.

İki yudum huzur,
Bir an durur zaman.
Love Bird’de
Kahve, biraz aşktır.', 78545.00, 8, 628360.00, 3),
(1067, 1029, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
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
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 6, 31266.00, 4),
(1068, 1030, 3008, N'A04', N'WPAWZ Özel Tasarım Sevgililer Günü 2’li Evin Hanım', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze.</strong></li></ul>', 10.00, 2, 20.00, 1),
(1069, 1030, 3021, N'URN01024', N'Gelinlik Kahvesi', N'<ul><li><strong>Kahve köpüğünde saklı küçük mutluluklar,</strong></li><li><strong>Bir yudumda gülüş, bir yudumda anılar.</strong></li><li><strong>Sevgililer Günü’nde değil yalnız bugün,</strong></li><li><strong>Her sabah hatırlatır: “Bu evde sevgi hüküm sürer.”</strong></li><li><strong>İki fincan, tek kalp, paylaşılan bir ömür,</strong></li><li><strong>Sıcak bir kahve gibi… Aşk hep taze, hep dür.</strong></li></ul>', 15200.00, 3, 45600.00, 2),
(1070, 1030, 3018, N'A06', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça L', N'Erbaşlar Love Bırd Lacivert Seri Tombul 12 Parça Lüx Seramik Tombul Kahve Fincan Takımı Türk Kahvesi Fincanı
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
Beyaz fincanlarda mutluluk çoğalır. ☕🤍', 5211.00, 6, 31266.00, 3)
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
(1019, 7007, 1015, '2026-02-15T21:42:44', 0.00, N'TL', NULL, NULL, NULL),
(1020, 2003, 1, '2026-02-28T19:19:19', 0.00, N'TL', NULL, NULL, NULL),
(1021, 2004, 5, '2026-02-28T19:25:30', 0.00, N'TL', NULL, NULL, NULL),
(1022, 2004, 5, '2026-03-13T22:42:01', 0.00, N'TL', NULL, NULL, NULL),
(1023, 2004, 5, '2026-03-15T21:46:59', 0.00, N'TL', NULL, NULL, NULL),
(1024, 2004, 1018, '2026-03-26T15:52:43', 0.00, N'TL', NULL, NULL, NULL),
(1025, 7009, 1020, '2026-03-26T16:02:17', 0.00, N'TL', NULL, NULL, NULL),
(1026, 2004, 1017, '2026-03-26T22:05:32', 0.00, N'TL', NULL, NULL, NULL),
(1027, 2004, 1017, '2026-03-27T08:11:34', 0.00, N'TL', NULL, NULL, NULL),
(1028, 2004, 1017, '2026-03-28T13:11:01', 0.00, N'TL', NULL, NULL, NULL),
(1029, 2004, 1017, '2026-03-29T00:11:15', 0.00, N'TL', NULL, NULL, NULL),
(1030, 2004, 1017, '2026-03-30T22:13:27', 0.00, N'TL', NULL, NULL, NULL)
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
(1, 1, 10, '2026-01-11T22:14:23', 2004, 0, NULL, NULL),
(2, 2, 10, '2026-01-11T22:19:21', 2004, 0, NULL, NULL),
(3, 3, 10, '2026-01-11T22:36:07', 2004, 0, NULL, NULL),
(4, 4, 10, '2026-01-12T08:36:31', 2004, 0, NULL, NULL),
(5, 5, 10, '2026-01-17T22:48:12', 2004, 0, NULL, NULL),
(6, 6, 10, '2026-01-22T08:36:22', 2003, 0, NULL, NULL),
(7, 7, 10, '2026-01-22T08:37:12', 2003, 0, NULL, NULL),
(8, 8, 10, '2026-01-22T15:41:48', 2004, 0, NULL, NULL),
(9, 9, 10, '2026-02-10T09:13:52', 2004, 0, NULL, NULL),
(10, 10, 10, '2026-02-12T09:48:43', 7007, 0, NULL, NULL),
(11, 11, 10, '2026-02-15T12:37:39', 7007, 0, NULL, NULL),
(12, 12, 10, '2026-02-15T13:27:18', 7007, 0, NULL, NULL),
(13, 1011, 10, '2026-02-15T14:47:03', 7007, 0, NULL, NULL),
(14, 1012, 10, '2026-02-15T14:59:41', 7007, 0, NULL, NULL),
(15, 1013, 10, '2026-02-15T15:01:10', 7007, 0, NULL, NULL),
(16, 1014, 10, '2026-02-15T15:01:37', 7007, 0, NULL, NULL),
(17, 1015, 10, '2026-02-15T15:26:17', 7007, 0, NULL, NULL),
(18, 1, 20, '2026-01-11T22:14:24', 2004, 0, NULL, NULL),
(19, 2, 20, '2026-01-11T22:19:22', 2004, 0, NULL, NULL),
(20, 3, 20, '2026-01-11T22:36:08', 2004, 0, NULL, NULL),
(21, 4, 20, '2026-01-12T08:36:32', 2004, 0, NULL, NULL),
(22, 5, 20, '2026-01-17T22:48:13', 2004, 1, '2026-03-01T21:18:18', 2003),
(23, 6, 20, '2026-01-22T08:36:23', 2003, 0, NULL, NULL),
(24, 7, 20, '2026-01-22T08:37:13', 2003, 0, NULL, NULL),
(25, 8, 20, '2026-01-22T15:41:49', 2004, 0, NULL, NULL),
(26, 9, 20, '2026-02-10T09:13:53', 2004, 0, NULL, NULL),
(27, 10, 20, '2026-02-12T09:48:44', 7007, 0, NULL, NULL),
(28, 11, 20, '2026-02-15T12:37:40', 7007, 0, NULL, NULL),
(29, 12, 20, '2026-02-15T13:27:19', 7007, 0, NULL, NULL),
(30, 1011, 20, '2026-02-15T14:47:04', 7007, 0, NULL, NULL),
(31, 1012, 20, '2026-02-15T14:59:42', 7007, 0, NULL, NULL),
(32, 1013, 20, '2026-02-15T15:01:11', 7007, 0, NULL, NULL),
(33, 1014, 20, '2026-02-15T15:01:38', 7007, 0, NULL, NULL),
(34, 1015, 20, '2026-02-15T15:26:18', 7007, 0, NULL, NULL),
(35, 1016, 10, '2026-02-15T20:29:48', 7007, 0, NULL, NULL),
(36, 1016, 20, '2026-02-15T20:29:49', 7007, 0, NULL, NULL),
(37, 1017, 10, '2026-02-15T20:40:52', 7007, 0, NULL, NULL),
(38, 1017, 20, '2026-02-15T20:40:53', 7007, 0, NULL, NULL),
(39, 1018, 10, '2026-02-15T21:36:00', 7007, 0, NULL, NULL),
(40, 1018, 20, '2026-02-15T21:36:01', 7007, 1, '2026-03-02T15:20:51', 2003),
(41, 1019, 10, '2026-02-15T21:42:44', 7007, 0, NULL, NULL),
(42, 1019, 20, '2026-02-15T21:42:45', 7007, 0, NULL, NULL),
(43, 1021, 10, '2026-02-15T21:42:44', 7007, 0, NULL, NULL),
(44, 1021, 20, '2026-02-15T21:42:45', 7007, 0, NULL, NULL),
(45, 1020, 10, '2026-02-15T21:36:00', 7007, 0, NULL, NULL),
(46, 1020, 20, '2026-02-15T21:36:01', 7007, 0, NULL, NULL),
(47, 1021, 30, '2026-03-01T19:15:22', 2003, 0, NULL, NULL),
(48, 1021, 40, '2026-03-01T19:15:37', 2003, 0, NULL, NULL),
(49, 8, 30, '2026-03-01T19:36:24', 2003, 0, NULL, NULL),
(50, 8, 20, '2026-03-01T19:36:30', 2003, 0, NULL, NULL),
(51, 4, 30, '2026-03-01T19:37:58', 2003, 0, NULL, NULL),
(52, 5, 30, '2026-03-01T20:27:29', 2003, 1, '2026-03-01T20:27:52', 2003),
(53, 5, 20, '2026-03-01T21:18:38', 2003, 0, NULL, NULL),
(54, 5, 30, '2026-03-01T21:18:41', 2003, 0, NULL, NULL),
(55, 5, 20, '2026-03-01T21:18:48', 2003, 0, NULL, NULL),
(56, 1017, 20, '2026-03-02T14:18:08', 2003, 1, '2026-03-02T14:19:06', 2003),
(57, 1019, 30, '2026-03-02T15:19:43', 2003, 1, '2026-03-02T15:20:08', 2003),
(58, 1015, 30, '2026-03-02T15:51:13', 2003, 1, '2026-03-02T15:51:32', 2003),
(59, 1015, 30, '2026-03-02T15:54:52', 2003, 1, '2026-03-02T15:55:19', 2003),
(60, 1017, 30, '2026-03-02T16:37:32', 2003, 1, '2026-03-02T16:38:32', 2003),
(61, 1017, 40, '2026-03-02T16:37:39', 2003, 1, '2026-03-02T16:38:19', 2003),
(62, 1017, 30, '2026-03-02T16:38:38', 2003, 0, NULL, NULL),
(64, 1021, 80, '2026-03-02T16:49:50', 2003, 1, '2026-03-02T16:50:24', 2003),
(65, 1021, 80, '2026-03-02T16:56:56', 2003, 1, '2026-03-13T22:13:04', 2003),
(66, 1021, 50, '2026-03-13T22:13:48', 2003, 0, NULL, NULL),
(67, 1021, 80, '2026-03-13T22:13:55', 2003, 1, '2026-03-13T22:14:18', 2003),
(68, 1022, 10, '2026-03-13T22:42:01', 2004, 0, NULL, NULL),
(69, 1022, 20, '2026-03-13T22:42:02', 2004, 0, NULL, NULL),
(70, 1022, 30, '2026-03-14T16:11:51', 2003, 0, NULL, NULL),
(71, 1022, 40, '2026-03-14T16:11:58', 2003, 0, NULL, NULL),
(72, 1022, 50, '2026-03-14T16:12:05', 2003, 0, NULL, NULL),
(73, 1022, 60, '2026-03-14T16:12:09', 2003, 1, '2026-03-15T00:30:45', 2003),
(74, 1020, 80, '2026-03-14T18:10:27', 2003, 0, NULL, NULL),
(75, 1022, 80, '2026-03-14T18:10:57', 2004, 1, '2026-03-15T00:30:38', 2003),
(78, 4, 80, '2026-03-15T00:19:51', 2004, 1, '2026-03-15T00:23:02', 2003),
(79, 4, 80, '2026-03-15T00:23:38', 2004, 0, NULL, NULL),
(80, 5, 80, '2026-03-15T00:26:26', 2004, 0, NULL, NULL),
(81, 8, 80, '2026-03-15T00:26:49', 2004, 0, NULL, NULL),
(82, 3, 80, '2026-03-15T00:29:40', 2004, 0, NULL, NULL),
(83, 1022, 60, '2026-03-15T21:40:07', 2003, 0, NULL, NULL),
(84, 1022, 70, '2026-03-15T21:40:16', 2003, 0, NULL, NULL),
(85, 1023, 10, '2026-03-15T21:46:59', 2004, 0, NULL, NULL),
(86, 1023, 20, '2026-03-15T21:47:00', 2004, 0, NULL, NULL),
(87, 1023, 30, '2026-03-15T21:47:31', 2003, 0, NULL, NULL),
(88, 1023, 40, '2026-03-15T21:47:42', 2003, 0, NULL, NULL),
(89, 1023, 50, '2026-03-15T21:47:57', 2003, 0, NULL, NULL),
(90, 1023, 60, '2026-03-15T21:48:05', 2003, 0, NULL, NULL),
(91, 1023, 70, '2026-03-15T21:48:20', 2003, 0, NULL, NULL),
(92, 1024, 10, '2026-03-26T15:52:43', 2004, 0, NULL, NULL),
(93, 1024, 20, '2026-03-26T15:52:44', 2004, 0, NULL, NULL),
(94, 1025, 10, '2026-03-26T16:02:17', 7009, 0, NULL, NULL),
(95, 1025, 20, '2026-03-26T16:02:18', 7009, 0, NULL, NULL),
(96, 1026, 10, '2026-03-26T22:05:32', 2004, 0, NULL, NULL),
(97, 1026, 20, '2026-03-26T22:05:33', 2004, 0, NULL, NULL),
(98, 1027, 10, '2026-03-27T08:11:34', 2004, 0, NULL, NULL),
(99, 1027, 20, '2026-03-27T08:11:35', 2004, 0, NULL, NULL),
(100, 1028, 10, '2026-03-28T13:11:01', 2004, 0, NULL, NULL),
(101, 1028, 20, '2026-03-28T13:11:02', 2004, 0, NULL, NULL),
(102, 1029, 10, '2026-03-29T00:11:15', 2004, 0, NULL, NULL),
(103, 1029, 20, '2026-03-29T00:11:16', 2004, 0, NULL, NULL),
(104, 1030, 10, '2026-03-30T22:13:27', 2004, 0, NULL, NULL),
(105, 1030, 20, '2026-03-30T22:13:28', 2004, 0, NULL, NULL)
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
(3026, N'sdfs', N'dsfsd', N'<p>ww</p>', 3, 212.00, 1, 0, 12),
(3027, N'F01', N'Fincan Seti', N'<p>Fincan Seti stonewarte</p>', 5, 95000.00, 1, 1, 13)
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
(36, 3024, N'/uploads/products/3024/01d2ec99-35e6-4ac4-9916-2e6ac40dee23.png', 1, 0),
(37, 3027, N'/uploads/products/3027/0ef3b047-bce6-4e73-b187-918453e0efa9.jpg', 1, 0)
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
(1, N'Ürün hasarlı geldi', 1, 1),
(2, N'Yanlış ürün gönderildi', 1, 1),
(3, N'Beklentimi karşılamadı', 1, 1),
(4, N'Açıklamayla uyuşmuyor', 1, 0),
(5, N'Geç teslim edildi', 1, 0),
(6, N'Siparişi yanlış verdim', 1, 0),
(7, N'Sebep belirtmek istemiyorum', 1, 0),
(8, N'Diğer', 1, 1),
(9, N'ttrrt', 0, 0),
(10, N'dssaas', 0, 1),
(11, N'sdfsdf', 0, 1)
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
SET IDENTITY_INSERT [dbo].[ReturnDetail] ON
INSERT INTO [dbo].[ReturnDetail] ([Id], [ReturnId], [OrderDetailId], [ProductId], [ReturnUnitPrice], [ReturnQuantity], [ReturnLineTotal])
VALUES
(38, 24, 1047, 3019, 960.00, 1, 960.00),
(40, 26, 1047, 3019, 906.00, 3, 2718.00),
(41, 27, 1046, 3021, 15200.00, 1, 15200.00),
(42, 27, 1047, 3019, 960.00, 1, 960.00),
(43, 27, 1048, 3008, 10.00, 1, 10.00),
(44, 27, 1049, 3018, 5211.00, 9, 46899.00),
(45, 28, 1046, 3021, 15200.00, 1, 15200.00),
(46, 29, 1055, 3027, 95000.00, 1, 95000.00),
(47, 30, 1050, 3019, 960.00, 1, 960.00),
(48, 30, 1051, 3021, 15200.00, 1, 15200.00),
(49, 30, 1052, 3027, 95000.00, 1, 95000.00),
(50, 30, 1053, 3006, 8714.00, 1, 8714.00),
(51, 30, 1054, 3008, 10.00, 1, 10.00),
(52, 31, 1050, 3019, 960.00, 1, 960.00),
(53, 31, 1051, 3021, 15200.00, 1, 15200.00),
(54, 32, 1051, 3021, 15200.00, 1, 15200.00),
(55, 33, 1057, 3016, 78545.00, 1, 78545.00),
(56, 33, 1058, 3020, 700.00, 1, 700.00),
(57, 33, 1059, 3018, 5211.00, 1, 5211.00),
(58, 34, 1060, 3027, 95000.00, 1, 95000.00),
(59, 35, 1060, 3027, 95000.00, 2, 190000.00),
(60, 36, 1060, 3027, 95000.00, 1, 95000.00),
(61, 37, 1061, 3019, 960.00, 2, 1920.00),
(62, 37, 1062, 3021, 15200.00, 1, 15200.00),
(63, 37, 1063, 3008, 10.00, 1, 10.00),
(64, 38, 1061, 3019, 960.00, 1, 960.00),
(65, 38, 1062, 3021, 15200.00, 1, 15200.00),
(66, 38, 1063, 3008, 10.00, 1, 10.00),
(67, 39, 1061, 3019, 960.00, 1, 960.00),
(68, 39, 1062, 3021, 15200.00, 1, 15200.00),
(69, 39, 1063, 3008, 10.00, 1, 10.00),
(71, 41, 1061, 3019, 960.00, 1, 960.00),
(72, 41, 1062, 3021, 15200.00, 1, 15200.00),
(73, 42, 1061, 3019, 960.00, 1, 960.00),
(74, 42, 1062, 3021, 15200.00, 1, 15200.00),
(75, 42, 1063, 3008, 10.00, 1, 10.00),
(76, 43, 1061, 3019, 960.00, 1, 960.00),
(77, 44, 1061, 3019, 960.00, 1, 960.00),
(82, 49, 8, 3019, 960.00, 1, 960.00),
(83, 50, 7, 3021, 15200.00, 1, 15200.00),
(84, 51, 8, 3019, 960.00, 1, 960.00),
(85, 52, 1064, 3021, 15200.00, 2, 30400.00),
(88, 55, 1064, 3021, 15200.00, 2, 30400.00),
(89, 55, 1065, 3019, 960.00, 11, 10560.00),
(90, 56, 1064, 3021, 15200.00, 1, 15200.00),
(78, 45, 1062, 3021, 15200.00, 1, 15200.00),
(79, 46, 1062, 3021, 15200.00, 1, 15200.00),
(80, 47, 1063, 3008, 10.00, 1, 10.00),
(81, 48, 1063, 3008, 10.00, 1, 10.00),
(86, 53, 1064, 3021, 15200.00, 2, 30400.00),
(87, 54, 1064, 3021, 15200.00, 2, 30400.00),
(91, 57, 1064, 3021, 15200.00, 1, 15200.00),
(92, 58, 1067, 3018, 5211.00, 1, 5211.00),
(93, 59, 1067, 3018, 5211.00, 1, 5211.00),
(94, 60, 1066, 3016, 78545.00, 1, 78545.00),
(95, 61, 1067, 3018, 5211.00, 1, 5211.00),
(96, 62, 1067, 3018, 5211.00, 1, 5211.00),
(103, 69, 1066, 3016, 78545.00, 1, 78545.00),
(97, 63, 1067, 3018, 5211.00, 1, 5211.00),
(99, 65, 1066, 3016, 78545.00, 1, 78545.00),
(104, 70, 1068, 3008, 10.00, 1, 10.00),
(105, 70, 1069, 3021, 15200.00, 1, 15200.00),
(106, 70, 1070, 3018, 5211.00, 1, 5211.00),
(107, 71, 1068, 3008, 10.00, 1, 10.00),
(108, 71, 1069, 3021, 15200.00, 1, 15200.00),
(98, 64, 1067, 3018, 5211.00, 1, 5211.00),
(100, 66, 1066, 3016, 78545.00, 1, 78545.00),
(101, 67, 1066, 3016, 78545.00, 1, 78545.00),
(102, 68, 1066, 3016, 78545.00, 1, 78545.00)
GO
SET IDENTITY_INSERT [dbo].[ReturnDetail] OFF

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
   [ReasonDesc] nvarchar(500) NULL
)
GO
SET IDENTITY_INSERT [dbo].[ReturnHeader] ON
INSERT INTO [dbo].[ReturnHeader] ([Id], [UserId], [ReturnRequestDate], [OrderId], [ReasonId], [ReasonDesc])
VALUES
(24, 2004, '2026-03-15T22:28:24', 1023, 8, N'Bekledigim ürüen degil'),
(26, 2004, '2026-03-15T23:00:00', 1023, 8, N'Bunu da iade edeceğiöm'),
(27, 2004, '2026-03-25T20:28:59', 1023, 8, N'beğenmedim'),
(28, 2004, '2026-03-25T20:39:04', 1023, 8, N'beğenmedim'),
(29, 7009, '2026-03-26T16:04:35', 1025, 8, N'beğenmedim'),
(30, 2004, '2026-03-26T16:47:54', 1024, 8, N'beğenmedim'),
(31, 2004, '2026-03-26T16:50:37', 1024, 8, N'beğenmedim'),
(32, 2004, '2026-03-26T17:00:44', 1024, 8, N'beğenmedim'),
(33, 2004, '2026-03-26T22:16:15', 1026, 8, N'beğenmedim'),
(34, 2004, '2026-03-27T08:12:26', 1027, 8, N'beğenmedim'),
(35, 2004, '2026-03-27T21:01:57', 1027, 8, N'beğenmedim'),
(36, 2004, '2026-03-27T21:30:33', 1027, 8, N'bu ürünü iade etmek istiyorum çünkü iade edilmesi gerekiyor.'),
(37, 2004, '2026-03-28T13:11:15', 1028, 8, N'beğenmedim'),
(38, 2004, '2026-03-28T13:43:55', 1028, 8, N'beğenmedim'),
(39, 2004, '2026-03-28T16:15:14', 1028, 8, N'beğenmedim'),
(41, 2004, '2026-03-28T18:13:35', 1028, 8, N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has b'),
(42, 2004, '2026-03-28T18:56:51', 1028, 8, N'beğenmedim'),
(43, 2004, '2026-03-28T19:00:47', 1028, 8, N'beğenmedim'),
(44, 2004, '2026-03-28T19:01:04', 1028, 8, N'beğenmedim'),
(49, 2004, '2026-03-28T22:29:22', 2, 8, N'Yanlış ürün gönderildi'),
(50, 2004, '2026-03-28T23:11:45', 2, 8, N'Ürün hasarlı geldi'),
(51, 2004, '2026-03-28T23:23:46', 2, 8, N'Ürün hasarlı geldi'),
(52, 2004, '2026-03-29T00:16:21', 1029, 8, N'Ürün hasarlı geldi'),
(55, 2004, '2026-03-29T00:46:53', 1029, 8, N'Sebep belirtmek istemiyorum'),
(56, 2004, '2026-03-29T00:55:57', 1029, 8, N'beğenmedim'),
(45, 2004, '2026-03-28T19:30:02', 1028, 8, N'beğenmedim'),
(46, 2004, '2026-03-28T19:30:24', 1028, 8, N'dfdfdfdfdfdffff'),
(47, 2004, '2026-03-28T19:30:49', 1028, 8, N'Yanlış ürün gönderildi'),
(48, 2004, '2026-03-28T19:54:31', 1028, 8, N'beğenmedim'),
(53, 2004, '2026-03-29T00:17:16', 1029, 8, N'beğenmedim'),
(54, 2004, '2026-03-29T00:23:51', 1029, 8, N'beğenmedim'),
(57, 2004, '2026-03-30T16:23:12', 1029, 6, N'sasadsad'),
(58, 2004, '2026-03-30T17:24:35', 1029, 1, N'asddsaasdsad'),
(59, 2004, '2026-03-30T17:25:17', 1029, 1, N'assa'),
(60, 2004, '2026-03-30T21:05:29', 1029, 7, N''),
(61, 2004, '2026-03-30T21:05:58', 1029, 7, N''),
(62, 2004, '2026-03-30T21:07:42', 1029, 7, N''),
(69, 2004, '2026-03-30T21:57:23', 1029, 1, N'tamamen kırık'),
(63, 2004, '2026-03-30T21:24:49', 1029, 7, N'sa'),
(65, 2004, '2026-03-30T21:33:31', 1029, 2, N'ds'),
(70, 2004, '2026-03-30T22:13:59', 1030, 7, N''),
(71, 2004, '2026-03-30T22:16:20', 1030, 8, N'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop p'),
(64, 2004, '2026-03-30T21:31:29', 1029, 8, N'kkjjkkj'),
(66, 2004, '2026-03-30T21:36:19', 1029, 5, N''),
(67, 2004, '2026-03-30T21:38:24', 1029, 7, N''),
(68, 2004, '2026-03-30T21:39:00', 1029, 7, N'')
GO
SET IDENTITY_INSERT [dbo].[ReturnHeader] OFF

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
SET IDENTITY_INSERT [dbo].[ReturnHeaderStatus] ON
INSERT INTO [dbo].[ReturnHeaderStatus] ([Id], [OrderId], [ReturnHeaderId], [StatusForReturnCode], [IslemTarihi], [IslemUserid], [Iptal], [IptalTarihi], [IptalUserid])
VALUES
(1, 1028, 39, 110, '2026-03-28T16:15:14', 2004, 0, NULL, NULL),
(2, 1023, 24, 110, '2026-03-15T22:28:24', 2004, 0, NULL, NULL),
(3, 1023, 26, 110, '2026-03-15T23:00:00', 2004, 0, NULL, NULL),
(4, 1023, 27, 110, '2026-03-25T20:28:59', 2004, 0, NULL, NULL),
(5, 1023, 28, 110, '2026-03-25T20:39:04', 2004, 0, NULL, NULL),
(6, 1025, 29, 110, '2026-03-26T16:04:35', 7009, 0, NULL, NULL),
(7, 1024, 30, 110, '2026-03-26T16:47:54', 2004, 0, NULL, NULL),
(8, 1024, 31, 110, '2026-03-26T16:50:37', 2004, 0, NULL, NULL),
(9, 1024, 32, 110, '2026-03-26T17:00:44', 2004, 0, NULL, NULL),
(10, 1026, 33, 110, '2026-03-26T22:16:15', 2004, 0, NULL, NULL),
(11, 1027, 34, 110, '2026-03-27T08:12:26', 2004, 0, NULL, NULL),
(12, 1027, 35, 110, '2026-03-27T21:01:57', 2004, 0, NULL, NULL),
(13, 1027, 36, 110, '2026-03-27T21:30:33', 2004, 0, NULL, NULL),
(14, 1028, 37, 110, '2026-03-28T13:11:15', 2004, 0, NULL, NULL),
(15, 1028, 38, 110, '2026-03-28T13:43:55', 2004, 0, NULL, NULL),
(17, 1028, 41, 110, '2026-03-28T18:13:35', 2004, 0, NULL, NULL),
(18, 1028, 42, 110, '2026-03-28T18:56:51', 2004, 0, NULL, NULL),
(19, 1028, 43, 110, '2026-03-28T19:00:47', 2004, 0, NULL, NULL),
(20, 1028, 44, 110, '2026-03-28T19:01:04', 2004, 0, NULL, NULL),
(21, 1028, 45, 110, '2026-03-28T19:30:02', 2004, 0, NULL, NULL),
(22, 1028, 46, 110, '2026-03-28T19:30:24', 2004, 0, NULL, NULL),
(23, 1028, 47, 110, '2026-03-28T19:30:49', 2004, 0, NULL, NULL),
(24, 1028, 48, 110, '2026-03-28T19:54:31', 2004, 0, NULL, NULL),
(25, 2, 49, 110, '2026-03-28T22:29:22', 2004, 0, NULL, NULL),
(26, 2, 50, 110, '2026-03-28T23:11:45', 2004, 0, NULL, NULL),
(31, 1029, 55, 110, '2026-03-29T00:46:53', 2004, 0, NULL, NULL),
(32, 1029, 56, 110, '2026-03-29T00:55:57', 2004, 0, NULL, NULL),
(27, 2, 51, 110, '2026-03-28T23:23:46', 2004, 0, NULL, NULL),
(28, 1029, 52, 110, '2026-03-29T00:16:21', 2004, 0, NULL, NULL),
(29, 1029, 53, 110, '2026-03-29T00:17:16', 2004, 0, NULL, NULL),
(30, 1029, 54, 110, '2026-03-29T00:23:51', 2004, 0, NULL, NULL),
(33, 1029, 57, 110, '2026-03-30T16:23:12', 2004, 0, NULL, NULL),
(34, 1029, 58, 110, '2026-03-30T17:24:35', 2004, 0, NULL, NULL),
(35, 1029, 59, 110, '2026-03-30T17:25:17', 2004, 0, NULL, NULL),
(36, 1029, 60, 110, '2026-03-30T21:05:29', 2004, 0, NULL, NULL),
(37, 1029, 61, 110, '2026-03-30T21:05:58', 2004, 0, NULL, NULL),
(38, 1029, 62, 110, '2026-03-30T21:07:42', 2004, 0, NULL, NULL),
(45, 1029, 69, 110, '2026-03-30T21:57:23', 2004, 0, NULL, NULL),
(39, 1029, 63, 110, '2026-03-30T21:24:49', 2004, 0, NULL, NULL),
(41, 1029, 65, 110, '2026-03-30T21:33:31', 2004, 0, NULL, NULL),
(46, 1030, 70, 110, '2026-03-30T22:13:59', 2004, 0, NULL, NULL),
(47, 1030, 71, 110, '2026-03-30T22:16:20', 2004, 0, NULL, NULL),
(40, 1029, 64, 110, '2026-03-30T21:31:29', 2004, 0, NULL, NULL),
(42, 1029, 66, 110, '2026-03-30T21:36:19', 2004, 0, NULL, NULL),
(43, 1029, 67, 110, '2026-03-30T21:38:24', 2004, 0, NULL, NULL),
(44, 1029, 68, 110, '2026-03-30T21:39:00', 2004, 0, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[ReturnHeaderStatus] OFF

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
(1, 110, N'Talebiniz Değerlendiriliyor'),
(3, 120, N'İade Talebiniz Kabul Edildi'),
(4, 130, N'İade Talebiniz Reddedildi'),
(5, 180, N'İade Talebiniz İptal Edildi'),
(6, 140, N'Geri Ödeme Gerçekleşti'),
(7, 150, N'Hediye Kuponu Tanımlandı')
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
(7008, N'Meh', N'Gürel', N'ty@acom', N'AQAAAAIAAYagAAAAEBo4Z1Y0CA1YJM6dyHW2oOCvl6P0dMm2gRRA/ej+mf5l3ioPnIsRvAs/xTIig3c3Ow==', N'(544) 421 94 02', '2026-02-23T00:00:00', 1, 2, 1, 1, '2026-02-12T09:51:42', N'::1', 0, N'523ea9a182184faf8825502c57b72724', '2026-02-13T06:51:42', NULL, NULL, NULL, NULL),
(7009, N'Can', N'Gürel', N'sdf@saasd.com', N'AQAAAAIAAYagAAAAENSQs4JuV0p7NcR82YPMQ4xD/ZGFZ5MvKtu6rgUIMO1cwOm2iip+p5VHp+bEujO0qQ==', N'(544) 421 94 02', '2026-03-20T00:00:00', 1, 2, 1, 1, '2026-03-26T15:55:41', N'::1', 1, N'5e61dabe59554010b78ca39cc38f3c56', '2026-03-27T12:55:41', NULL, NULL, NULL, NULL)
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
(1014, 7007, N'Yama', N'Yama', N'dsadsa', N'saddsa', N'dsadsa', N'sdadsa', N'asdsda', N'Yamans', 0),
(1015, 7007, N'Mehmet', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'Yenişehir Mah. ', N'Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 ', N'rrrr', 1),
(1016, 7007, N'sasa', N'sasa', N'sasa', N'assa', N'sasa', N'assa', N'sasa', N'sasaffff', 0),
(1017, 2004, N'xc', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'sdsdds', N'Yenişehir Mah. Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 Pendik İstanbul', N'sdsdds', 1),
(1019, 2004, N'fsd', N'dsf', N'sfd', N'sdf', N'fsd', N'fds', N'fsd', N'fsdfdfd', 0),
(1020, 7009, N'Meh', N'Gürel', N'05444219402', N'İstanbul', N'Pendik', N'cxzzxczxc', N'vvvYenişehir Mah. Dedepaşa Cad. No2 Dumankaya Trend Sitesi 13A2 D:36 Pendik İstanbul', N'xzcxzcczx', 1)
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
	LEFT OUTER JOIN ReturnDetail t3 on t1.ProductId = t3.ProductId  and t1.Id= t3.OrderDetailId
	LEFT OUTER JOIN OrderHeader t4 on t1.OrderId = t4.Id
    WHERE OrderId = @OrderId AND UserId = @UserId
    
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

	ORDER BY DisplayNo



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
    @Items NVARCHAR(MAX) -- JSON
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
            FROM ReturnDetail
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

    INSERT INTO ReturnHeader (UserId, ReturnRequestDate, OrderId, ReasonId,ReasonDesc)
    VALUES (@UserId, GETDATE(), @OrderId, @ReasonId, @ReasonDesc);

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
		110,			  -- RequestUnderReview = 110,     // Talebiniz Değerlendiriliyor
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

		ISNULL(s.Code,0) AS StatusForReturnCode,
		ISNULL(s.Aciklama,'') AS StatusForReturnDesc
    FROM ReturnHeader rh
	OUTER APPLY
	(
		SELECT TOP 1 
			t2.Code,
			t2.Aciklama
		FROM ReturnHeaderStatus t1
		LEFT JOIN StatusForReturn t2 ON t1.StatusForReturnCode = t2.Code
		WHERE t1.ReturnHeaderId = rh.Id
		  AND t1.Iptal = 0
		ORDER BY t1.IslemTarihi DESC
	) s
	LEFT OUTER JOIN Reason re on rh.ReasonId = re.Id
    WHERE rh.OrderId = @OrderId AND UserId =@UserId
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
	ReturnHeader rh 
	LEFT OUTER JOIN ReturnDetail rd ON rh.Id = rd.ReturnId
    LEFT OUTER JOIN OrderDetail od ON od.Id = rd.OrderDetailId
	LEFT OUTER JOIN ProductImage pr on od.ProductId = pr.ProductId  and pr.IsMain =1
	LEFT OUTER JOIN OrderHeader oh on od.OrderId = oh.Id


    WHERE rh.OrderId = @OrderId AND rh.UserId =@UserId
    ORDER BY rd.ReturnId, od.DisplayNo;

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
    SELECT t1.Id,
	t1.FirstName,
	t1.LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
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
    SELECT t1.Id,FirstName,LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
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

    SELECT t1.Id,FirstName,LastName,
	(t1.FirstName + ' ' + t1.LastName) AS FullName,
    (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
	Email,PasswordHash,PhoneNumber,BirthDate,IsActive,t1.RoleId, t2.Name RoleName,
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
		(t1.FirstName + ' ' + t1.LastName) AS FullName,
        (LEFT(t1.FirstName,1) + LEFT(t1.LastName,1)) AS Avatar,
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

