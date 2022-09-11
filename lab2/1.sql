USE [A_MyBase]
GO

/****** Object:  Table [dbo].[Data]    Script Date: 10.02.2022 17:45:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Orders](
	[�����_������] [tinyint] NOT NULL,
	[������������_������] [nvarchar](10) NULL,
	[����������] [nvarchar](10) NULL,
	[����] [money] NULL,
	[����������_�����������_������] [tinyint] NULL,
	PRIMARY KEY ([�����_������])
) ON [PRIMARY] 
GO

CREATE TABLE [dbo].[Products](
	[������������_������] [nvarchar](10) NOT NULL,
	[��������] [nvarchar](50) NULL,
	[����������_��_������] [tinyint] NULL,
	PRIMARY KEY ([������������_������])
) ON [PRIMARY]
GO
CREATE TABLE [dbo].[Clients](
	[����������] [nvarchar](10) NOT NULL,
	[�������] [nchar](12) NULL,
	[�����] [nvarchar](50) NULL,
	PRIMARY KEY ([����������])
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Products] FOREIGN KEY([������������_������])
REFERENCES [dbo].[Products] ([������������_������])
GO

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Clients] FOREIGN KEY([����������])
REFERENCES [dbo].[Clients] ([����������])
GO




