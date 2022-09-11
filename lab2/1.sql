USE [A_MyBase]
GO

/****** Object:  Table [dbo].[Data]    Script Date: 10.02.2022 17:45:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[Номер_заказа] [tinyint] NOT NULL,
	[Наименование_товара] [nvarchar](10) NULL,
	[Покупатель] [nvarchar](10) NULL,
	[Цена] [money] NULL,
	[Количество_заказанного_товара] [tinyint] NULL,
	PRIMARY KEY ([Номер_заказа])
) ON [PRIMARY] 
GO

CREATE TABLE [dbo].[Products](
	[Наименование_товара] [nvarchar](10) NOT NULL,
	[Описание] [nvarchar](50) NULL,
	[Количество_на_складе] [tinyint] NULL,
	PRIMARY KEY ([Наименование_товара])
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Clients](
	[Покупатель] [nvarchar](10) NOT NULL,
	[Телефон] [nchar](12) NULL,
	[Адрес] [nvarchar](50) NULL,
	PRIMARY KEY ([Покупатель])
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Products] FOREIGN KEY([Наименование_товара])
REFERENCES [dbo].[Products] ([Наименование_товара])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Clients] FOREIGN KEY([Покупатель])
REFERENCES [dbo].[Clients] ([Покупатель])
GO




