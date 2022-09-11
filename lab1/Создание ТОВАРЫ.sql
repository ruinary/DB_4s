USE [АртёмПРОДАЖИ]
GO

/****** Object:  Table [dbo].[TОВАРЫ]    Script Date: 11.02.2022 14:27:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TОВАРЫ](
	[Наименование] [nvarchar](20) NOT NULL,
	[Цена] [real] NULL,
	[Количество] [int] NULL,
 CONSTRAINT [PK_TОВАРЫ] PRIMARY KEY CLUSTERED 
(
	[Наименование] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


