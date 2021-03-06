USE [master]
GO
/****** Object:  Database [HomeShareDB]    Script Date: 29-03-18 09:34:17 ******/
CREATE DATABASE [HomeShareDB]
GO
USE [HomeShareDB]
GO
/****** Object:  UserDefinedTableType [dbo].[Tabletest]    Script Date: 29-03-18 09:34:18 ******/
CREATE TYPE [dbo].[Tabletest] AS TABLE(
	[IdBien] [int] NULL,
	[titre] [varchar](50) NULL,
	[Moyenne] [int] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[sp_RecupBienDispo]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cognitic 
-- Create date: 28/02/2015
-- Description:	Récupérer les biens disponible entre deux dates
-- =============================================
Create PROCEDURE [dbo].[sp_RecupBienDispo]
	@DateDeb date,
	@DateFin date
AS
BEGIN
	SELECT     *
FROM         BienEchange
where idBien not in (select idBien from MembreBienEchange where 
(@DateDeb >=DateDebEchange and DateFinEchange >= @DateDeb)
or
(DateFinEchange>=@DateFin and DateDebEchange<= @DateFin )
or 
(@DateDeb<=DateDebEchange and DateFinEchange>= @DateFin)
)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_RecupBienMembre]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cognitic 
-- Create date: 28/02/2015
-- Description:	Récupérer les biens d'un membre
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecupBienMembre] 
	@idMembre int
AS
BEGIN
	select * from BienEchange
	where idMembre = @idMembre
END

GO
/****** Object:  StoredProcedure [dbo].[sp_RecupToutesInfosBien]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cognitic 
-- Create date: 28/02/2015
-- Description:	Récupérer les infos complètes d'un bien à partir de son id
-- =============================================
CREATE PROCEDURE [dbo].[sp_RecupToutesInfosBien] 
	@idBien int
AS
BEGIN
SELECT     *
FROM        BienEchange  left JOIN
                      AvisMembreBien ON AvisMembreBien.idBien = BienEchange.idBien left JOIN
                      Membre ON AvisMembreBien.idMembre = Membre.idMembre AND BienEchange.idMembre = Membre.idMembre left JOIN
                      MembreBienEchange ON BienEchange.idBien = MembreBienEchange.idBien AND Membre.idMembre = MembreBienEchange.idMembre left JOIN
                      OptionsBien ON BienEchange.idBien = OptionsBien.idBien left JOIN
                      Options ON OptionsBien.idOption = Options.idOption left JOIN
                      Pays ON BienEchange.Pays = Pays.idPays
                      where BienEchange.idBien=@idBien
END

GO
/****** Object:  UserDefinedFunction [dbo].[NbJoursEchangeBien]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NbJoursEchangeBien] (@idBien INT)
RETURNS INT
BEGIN
	DECLARE @NbJours INT
	DECLARE @DateDebEchange DATE
	DECLARE @DateFinEchange DATE

	SET @NbJours = 0

	DECLARE CURBIEN CURSOR
	FOR SELECT DateDebEchange, DateFinEchange FROM MembreBienEchange

	OPEN CURBIEN
	FETCH CURBIEN INTO @DateDebEchange, @DateFinEchange
	
	WHILE (@@FETCH_STATUS=0)
	BEGIN
		SET @NbJours += DATEDIFF(DAY, @DateDebEchange, @DateFinEchange)
		FETCH CURBIEN INTO @DateDebEchange, @DateFinEchange	
	END

	CLOSE CURBIEN
	DEALLOCATE CURBIEN
	
	RETURN @NbJours
END
GO
/****** Object:  Table [dbo].[AvisMembreBien]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvisMembreBien](
	[idAvis] [int] IDENTITY(1,1) NOT NULL,
	[note] [int] NOT NULL,
	[message] [ntext] NOT NULL,
	[idMembre] [int] NOT NULL,
	[idBien] [int] NOT NULL,
	[DateAvis] [datetime] NOT NULL,
	[Approuve] [bit] NOT NULL,
 CONSTRAINT [PK_AvisMembreBien] PRIMARY KEY CLUSTERED 
(
	[idAvis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BienEchange]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BienEchange](
	[idBien] [int] IDENTITY(1,1) NOT NULL,
	[titre] [nvarchar](50) NOT NULL,
	[DescCourte] [nvarchar](150) NOT NULL,
	[DescLong] [ntext] NOT NULL,
	[NombrePerson] [int] NOT NULL,
	[Pays] [int] NOT NULL,
	[Ville] [nvarchar](50) NOT NULL,
	[Rue] [nvarchar](50) NOT NULL,
	[Numero] [nvarchar](5) NOT NULL,
	[CodePostal] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](50) NOT NULL,
	[AssuranceObligatoire] [bit] NOT NULL,
	[isEnabled] [bit] NOT NULL,
	[DisabledDate] [date] NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[idMembre] [int] NOT NULL,
	[DateCreation] [date] NOT NULL,
 CONSTRAINT [PK_BienEchange] PRIMARY KEY CLUSTERED 
(
	[idBien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HistoAvis]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoAvis](
	[idAvis] [int] NOT NULL,
	[DateAvis] [datetime] NOT NULL,
	[NoteAvis] [int] NOT NULL,
	[idMembre] [int] NOT NULL,
	[idProprio] [int] NOT NULL,
	[TitreBien] [nvarchar](50) NOT NULL,
	[VilleBien] [nvarchar](50) NOT NULL,
	[NbEchange] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idAvis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Membre]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Membre](
	[idMembre] [int] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	[Prenom] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](256) NOT NULL,
	[Pays] [int] NOT NULL,
	[Telephone] [nvarchar](20) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](256) NOT NULL,
	[PhotoUser] [nchar](10) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_membre] PRIMARY KEY CLUSTERED 
(
	[idMembre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MembreBienEchange]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MembreBienEchange](
	[idMembre] [int] NOT NULL,
	[idBien] [int] NOT NULL,
	[DateDebEchange] [date] NOT NULL,
	[DateFinEchange] [date] NOT NULL,
	[Assurance] [bit] NULL,
	[Valide] [bit] NOT NULL,
 CONSTRAINT [PK_MembreBienEchange] PRIMARY KEY CLUSTERED 
(
	[idMembre] ASC,
	[idBien] ASC,
	[DateDebEchange] ASC,
	[DateFinEchange] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Options]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[idOption] [int] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[idOption] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OptionsBien]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OptionsBien](
	[idOption] [int] NOT NULL,
	[idBien] [int] NOT NULL,
	[Valeur] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_OptionsBien] PRIMARY KEY CLUSTERED 
(
	[idOption] ASC,
	[idBien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pays]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pays](
	[idPays] [int] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](50) NOT NULL,
	[Photo] [nvarchar](50) NULL,
 CONSTRAINT [PK_Pays] PRIMARY KEY CLUSTERED 
(
	[idPays] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[Vue_BiensParPays]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vue_BiensParPays]
AS
SELECT     TOP (100) PERCENT idBien, titre, DescCourte, DescLong, NombrePerson, Pays, Ville, Rue, Numero, CodePostal, Photo, AssuranceObligatoire, isEnabled, DisabledDate, Latitude, Longitude, 
                      idMembre, DateCreation
FROM         dbo.BienEchange
ORDER BY Pays

GO
/****** Object:  View [dbo].[Vue_CinqDernierBiens]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vue_CinqDernierBiens]
AS
SELECT     TOP (5) idBien, titre, DescCourte, DescLong, NombrePerson, Pays, Ville, Rue, Numero, CodePostal, Photo, AssuranceObligatoire, isEnabled, DisabledDate, Latitude, Longitude, idMembre, 
                      DateCreation
FROM         dbo.BienEchange
ORDER BY DateCreation DESC

GO
/****** Object:  View [dbo].[Vue_MeilleursAvis]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Vue_MeilleursAvis]
AS
SELECT     TOP (100) PERCENT dbo.BienEchange.idBien, dbo.BienEchange.titre, dbo.BienEchange.DescCourte, dbo.BienEchange.DescLong, dbo.BienEchange.NombrePerson, dbo.BienEchange.Pays, 
                      dbo.BienEchange.Ville, dbo.BienEchange.Rue, dbo.BienEchange.Numero, dbo.BienEchange.CodePostal, dbo.BienEchange.Photo, dbo.BienEchange.AssuranceObligatoire, 
                      dbo.BienEchange.isEnabled, dbo.BienEchange.DisabledDate, dbo.BienEchange.Latitude, dbo.BienEchange.Longitude, dbo.BienEchange.idMembre, dbo.BienEchange.DateCreation
FROM         dbo.AvisMembreBien INNER JOIN
                      dbo.BienEchange ON dbo.AvisMembreBien.idBien = dbo.BienEchange.idBien
WHERE     (dbo.AvisMembreBien.note > 6)
ORDER BY dbo.AvisMembreBien.note DESC

GO
SET IDENTITY_INSERT [dbo].[AvisMembreBien] ON 

GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (2, 4, N'Beaucoup trop humide', 1, 2, CAST(0x0000A45300000000 AS DateTime), 1)
GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (4, 10, N'Quel merveille', 4, 3, CAST(0x0000A45300000000 AS DateTime), 1)
GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (5, 1, N'Vraiment n''importe quoi ce bien', 1, 2, CAST(0x0000A45300000000 AS DateTime), 0)
GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (6, 2, N'yes', 7, 2, CAST(0x0000A5CE01894DDD AS DateTime), 0)
GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (7, 8, N'Très bien', 3, 2, CAST(0x0000A7B40103456B AS DateTime), 0)
GO
INSERT [dbo].[AvisMembreBien] ([idAvis], [note], [message], [idMembre], [idBien], [DateAvis], [Approuve]) VALUES (8, 8, N'Très bien', 3, 2, CAST(0x0000A7B401038847 AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[AvisMembreBien] OFF
GO
SET IDENTITY_INSERT [dbo].[BienEchange] ON 

GO
INSERT [dbo].[BienEchange] ([idBien], [titre], [DescCourte], [DescLong], [NombrePerson], [Pays], [Ville], [Rue], [Numero], [CodePostal], [Photo], [AssuranceObligatoire], [isEnabled], [DisabledDate], [Latitude], [Longitude], [idMembre], [DateCreation]) VALUES (2, N'Un peu Humide', N'Petite maison sous-marine tout confort', N'Maison tout confort située au large de Miami. <br /> Possibilité de venir avec votre animal de compagnie si celui-ci adore les longs séjours dans l''eau ou si il est naturellement amphibie. Pas de piscine mais une magnifique serre contenant algues et anémones.', 2, 6, N'Miami', N'UnderStreet', N'8', N'123456', N'maisonSousMarine.jpg', 0, 1, NULL, N'25.774', N'36.874', 1, CAST(0xAE390B00 AS Date))
GO
INSERT [dbo].[BienEchange] ([idBien], [titre], [DescCourte], [DescLong], [NombrePerson], [Pays], [Ville], [Rue], [Numero], [CodePostal], [Photo], [AssuranceObligatoire], [isEnabled], [DisabledDate], [Latitude], [Longitude], [idMembre], [DateCreation]) VALUES (3, N'Vue imprenable sur le grand Canyon', N'Maison perchée sur la falaise offrant une vue imprenable.', N'Vivre comme un aigle et respirer l''air pur.<br > Cette maison est un petit paradis perché offrant confort moderne.', 1, 7, N'Colorado Sping', N'RockNRoll', N'10', N'784521', N'rockHouse.jpg', 1, 0, CAST(0x693C0B00 AS Date), N'36.159420', N'-112.202579', 3, CAST(0xAE390B00 AS Date))
GO
INSERT [dbo].[BienEchange] ([idBien], [titre], [DescCourte], [DescLong], [NombrePerson], [Pays], [Ville], [Rue], [Numero], [CodePostal], [Photo], [AssuranceObligatoire], [isEnabled], [DisabledDate], [Latitude], [Longitude], [idMembre], [DateCreation]) VALUES (18, N'La cabane au fond du canyon', N'Magnifique petite cabane de trappeur', N'Devenez le david Croquet du 21ème siècle', 1, 7, N'Colorado Sping', N'RockNRoll', N'10', N'784521', N'rockHouse.jpg', 1, 1, NULL, N'36.159420', N'-112.202579', 3, CAST(0xAE390B00 AS Date))
GO
SET IDENTITY_INSERT [dbo].[BienEchange] OFF
GO
SET IDENTITY_INSERT [dbo].[Membre] ON 

GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (1, N'Pink', N'Panther', N'pink@panther.com', 7, N'555-456325', N'Pink', N'Pink', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (3, N'Admin', N'Admin', N'admin@HomeShare.be', 1, N'4562325214', N'Admin', N'Admin', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (4, N'Dolphin', N'Flipper', N'dolphin.Flip@sea.us', 1, N'0000000000', N'Dol', N'Phin', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (5, N'Mike', N'Mike', N'mpg', 1, N'-5', N'mike', N'ZLTQ9HyTziPRV+aKWHZzVig9ybY8RZ1F0ODjmzpkubk=', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (6, N'zorro', N'test', N'lk@dd.be', 7, N'-12', N'azerty', N'azerty', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (7, N'MIke', N'mikel', N'mpg@sss.be', 1, N'-45', N'poi', N'+wcWYXmxzjxJ3/S1kMRNZhGWCL5APZvoxD5zcqmX7nU=', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (9, N'm', N'm', N'm@dd.com', 1, N'-4', N'test', N'test1234=', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (10, N'MIke', N'mikel', N'fd', 7, N'-12', N'ha', N'ha', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (11, N'mikel', N'mikel', N'l@dd.com', 1, N'-45', N'po', N'YZmuzyOrp+h7La+4tJFSYNqF489TVoGXt+RRmCOS+44=', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (12, N'MIke', N'mikel', N'kk@jj.be', 1, N'-4', N'lo', N'lo', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (13, N'zorro', N'mikel', N'fd', 1, N'-45', N'lop', N'oeDpVa9JpZtpxa4Jp7+VSlBHzmRuuDokaKclx9PcGhY=', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (14, N'MIke', N'dqs', N'fd', -1, N'-45', N'de', N'de', NULL, 0)
GO
INSERT [dbo].[Membre] ([idMembre], [Nom], [Prenom], [Email], [Pays], [Telephone], [Login], [Password], [PhotoUser], [isDeleted]) VALUES (15, N'zz', N'zz', N'zz@ff.be', 1, N'45', N'dd', N'ddd', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Membre] OFF
GO
INSERT [dbo].[MembreBienEchange] ([idMembre], [idBien], [DateDebEchange], [DateFinEchange], [Assurance], [Valide]) VALUES (1, 3, CAST(0xBD3B0B00 AS Date), CAST(0xC13B0B00 AS Date), 0, 1)
GO
INSERT [dbo].[MembreBienEchange] ([idMembre], [idBien], [DateDebEchange], [DateFinEchange], [Assurance], [Valide]) VALUES (1, 3, CAST(0x0D3D0B00 AS Date), CAST(0x193D0B00 AS Date), 0, 1)
GO
INSERT [dbo].[MembreBienEchange] ([idMembre], [idBien], [DateDebEchange], [DateFinEchange], [Assurance], [Valide]) VALUES (3, 2, CAST(0x0D3D0B00 AS Date), CAST(0x193D0B00 AS Date), 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Options] ON 

GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (1, N'Chien admis')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (2, N'Lave Linge')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (3, N'Lave vaisselle')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (4, N'Wifi')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (5, N'Parking')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (6, N'Piscine')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (7, N'Feu ouvert')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (8, N'Lit enfant')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (9, N'WC')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (10, N'Salle de bain')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (11, N'Jardin')
GO
INSERT [dbo].[Options] ([idOption], [Libelle]) VALUES (12, N'Douche')
GO
SET IDENTITY_INSERT [dbo].[Options] OFF
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (1, 2, N'Oui')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (1, 3, N'Non')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (2, 2, N'Non')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (2, 18, N'Non')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (3, 3, N'Non')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (4, 2, N'Oui')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (6, 2, N'Oui')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (8, 3, N'1')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (8, 18, N'1')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (9, 2, N'1')
GO
INSERT [dbo].[OptionsBien] ([idOption], [idBien], [Valeur]) VALUES (10, 2, N'5')
GO
SET IDENTITY_INSERT [dbo].[Pays] ON 

GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (1, N'Belgique', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (2, N'France', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (3, N'Italie', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (4, N'Pays-Bas', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (5, N'Luxembourg', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (6, N'Austalie', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (7, N'USA', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (8, N'Anglettere', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (9, N'Espagne', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (10, N'Portugal', NULL)
GO
INSERT [dbo].[Pays] ([idPays], [Libelle], [Photo]) VALUES (11, N'Islande', NULL)
GO
SET IDENTITY_INSERT [dbo].[Pays] OFF
GO
ALTER TABLE [dbo].[AvisMembreBien] ADD  CONSTRAINT [DF_AvisMembreBien_Approuve]  DEFAULT ((0)) FOR [Approuve]
GO
ALTER TABLE [dbo].[BienEchange] ADD  CONSTRAINT [DF_BienEchange_Pays]  DEFAULT ((1)) FOR [Pays]
GO
ALTER TABLE [dbo].[BienEchange] ADD  CONSTRAINT [DF_BienEchange_AssuranceObligatoire]  DEFAULT ((0)) FOR [AssuranceObligatoire]
GO
ALTER TABLE [dbo].[BienEchange] ADD  CONSTRAINT [DF_BienEchange_isEnabled]  DEFAULT ((0)) FOR [isEnabled]
GO
ALTER TABLE [dbo].[BienEchange] ADD  CONSTRAINT [DF_BienEchange_DateCreation]  DEFAULT (getdate()) FOR [DateCreation]
GO
ALTER TABLE [dbo].[Membre] ADD  CONSTRAINT [DF_Membre_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[MembreBienEchange] ADD  CONSTRAINT [DF_MembreBienEchange_Valide]  DEFAULT ((0)) FOR [Valide]
GO
ALTER TABLE [dbo].[AvisMembreBien]  WITH CHECK ADD  CONSTRAINT [FK_AvisMembreBien_BienEchange] FOREIGN KEY([idBien])
REFERENCES [dbo].[BienEchange] ([idBien])
GO
ALTER TABLE [dbo].[AvisMembreBien] CHECK CONSTRAINT [FK_AvisMembreBien_BienEchange]
GO
ALTER TABLE [dbo].[AvisMembreBien]  WITH CHECK ADD  CONSTRAINT [FK_AvisMembreBien_membre] FOREIGN KEY([idMembre])
REFERENCES [dbo].[Membre] ([idMembre])
GO
ALTER TABLE [dbo].[AvisMembreBien] CHECK CONSTRAINT [FK_AvisMembreBien_membre]
GO
ALTER TABLE [dbo].[BienEchange]  WITH CHECK ADD  CONSTRAINT [FK_BienEchange_membre] FOREIGN KEY([idMembre])
REFERENCES [dbo].[Membre] ([idMembre])
GO
ALTER TABLE [dbo].[BienEchange] CHECK CONSTRAINT [FK_BienEchange_membre]
GO
ALTER TABLE [dbo].[BienEchange]  WITH CHECK ADD  CONSTRAINT [FK_BienEchange_Pays] FOREIGN KEY([Pays])
REFERENCES [dbo].[Pays] ([idPays])
GO
ALTER TABLE [dbo].[BienEchange] CHECK CONSTRAINT [FK_BienEchange_Pays]
GO
ALTER TABLE [dbo].[MembreBienEchange]  WITH CHECK ADD  CONSTRAINT [FK_MembreBienEchange_BienEchange] FOREIGN KEY([idBien])
REFERENCES [dbo].[BienEchange] ([idBien])
GO
ALTER TABLE [dbo].[MembreBienEchange] CHECK CONSTRAINT [FK_MembreBienEchange_BienEchange]
GO
ALTER TABLE [dbo].[MembreBienEchange]  WITH CHECK ADD  CONSTRAINT [FK_MembreBienEchange_membre] FOREIGN KEY([idMembre])
REFERENCES [dbo].[Membre] ([idMembre])
GO
ALTER TABLE [dbo].[MembreBienEchange] CHECK CONSTRAINT [FK_MembreBienEchange_membre]
GO
ALTER TABLE [dbo].[OptionsBien]  WITH CHECK ADD  CONSTRAINT [FK_OptionsBien_BienEchange] FOREIGN KEY([idBien])
REFERENCES [dbo].[BienEchange] ([idBien])
GO
ALTER TABLE [dbo].[OptionsBien] CHECK CONSTRAINT [FK_OptionsBien_BienEchange]
GO
ALTER TABLE [dbo].[OptionsBien]  WITH CHECK ADD  CONSTRAINT [FK_OptionsBien_Options] FOREIGN KEY([idOption])
REFERENCES [dbo].[Options] ([idOption])
GO
ALTER TABLE [dbo].[OptionsBien] CHECK CONSTRAINT [FK_OptionsBien_Options]
GO
/****** Object:  Trigger [dbo].[TR_CommentaireHistorique]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_CommentaireHistorique]
ON [dbo].[AvisMembreBien]
FOR DELETE
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE name='HistoAvis')  
	CREATE TABLE HistoAvis (idAvis INT PRIMARY KEY,
							DateAvis DATETIME NOT NULL, 
							NoteAvis INT NOT NULL, 
							idMembre INT NOT NULL,
							idProprio INT NOT NULL, 
							TitreBien NVARCHAR(50) NOT NULL, 
							VilleBien NVARCHAR(50) NOT NULL,
							NbEchange INT NOT NULL);
	DECLARE @idAvis INT, @DateAvis DATETIME, @NoteAvis INT, @idMembre INT, @idProprio INT, @TitreBien NVARCHAR(50), @VilleBien NVARCHAR(50), @NbEchange INT

	DECLARE CR_Avis CURSOR
	FOR SELECT D.idAvis, D.DateAvis, D.note, D.idMembre, BE.idMembre, BE.titre, BE.Ville, COUNT(MBE.idBien) AS 'Nb Echange' FROM deleted D 
		JOIN BienEchange BE ON D.idBien = BE.idBien
		JOIN MembreBienEchange MBE ON BE.idBien = MBE.idBien
		GROUP BY D.idAvis, D.DateAvis, D.note, D.idMembre, BE.idMembre, BE.titre, BE.Ville

	OPEN CR_Avis
	FETCH CR_Avis INTO @idAvis, @DateAvis, @NoteAvis, @idMembre, @idProprio, @TitreBien, @VilleBien, @NbEchange

	WHILE (@@FETCH_STATUS = 1)
	BEGIN
		INSERT INTO HistoAvis VALUES (@idAvis, @DateAvis, @NoteAvis, @idMembre, @idProprio, @TitreBien, @VilleBien, @NbEchange)
		FETCH CR_Avis INTO @idAvis, @DateAvis, @NoteAvis, @idMembre, @idProprio, @TitreBien, @VilleBien, @NbEchange
	END

	CLOSE CR_Avis
	DEALLOCATE CR_Avis

END
GO
/****** Object:  Trigger [dbo].[Trig_DelMembre]    Script Date: 29-03-18 09:34:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Trig_DelMembre]
   ON  [dbo].[Membre]
  instead of delete
AS 
BEGIN
	
	Declare @datesup date

	set @datesup = GETDATE();
	
--Si l'échange commence après la suppression, on n'en tient pas compte
--Si l'échange se termine avant la suppression, on n'en tient pas compte

	if( exists(select * from MembreBienEchange
				where MembreBienEchange.Valide =1
				and (DateDebEchange<=GETDATE() and DateFinEchange >=GETDATE()
				and idMembre in (select idMembre from deleted)
				)
			  )
	 )
				BEGIN
					RAISERROR (N'Vous ne pouvez pas supprimer un bien dont l''échange est en cours', 
								10,
								1);    
								Rollback;
				END

	ELSE
				BEGIN
					UPDATE MEmbre set isDeleted=1 where idMembre in (select idMembre from deleted)
				END
		
END

GO

USE [master]
GO
ALTER DATABASE [HomeShareDB] SET  READ_WRITE 
GO
