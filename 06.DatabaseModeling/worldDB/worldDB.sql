USE [master]
GO
/****** Object:  Database [world]    Script Date: 10/6/2015 2:25:07 PM ******/
CREATE DATABASE [world]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'world', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\world.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'world_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\world_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [world] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [world].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [world] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [world] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [world] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [world] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [world] SET ARITHABORT OFF 
GO
ALTER DATABASE [world] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [world] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [world] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [world] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [world] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [world] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [world] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [world] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [world] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [world] SET  DISABLE_BROKER 
GO
ALTER DATABASE [world] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [world] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [world] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [world] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [world] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [world] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [world] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [world] SET RECOVERY FULL 
GO
ALTER DATABASE [world] SET  MULTI_USER 
GO
ALTER DATABASE [world] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [world] SET DB_CHAINING OFF 
GO
ALTER DATABASE [world] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [world] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [world] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'world', N'ON'
GO
USE [world]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 10/6/2015 2:25:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressText] [nvarchar](200) NOT NULL,
	[TownId] [int] NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Continents]    Script Date: 10/6/2015 2:25:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Continents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Continents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Countries]    Script Date: 10/6/2015 2:25:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[ContinentId] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Persons]    Script Date: 10/6/2015 2:25:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[AddressId] [int] NOT NULL,
 CONSTRAINT [PK_Persons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Towns]    Script Date: 10/6/2015 2:25:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Towns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_Towns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (1, N'ul. Pozitano 20', 1)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (2, N'bul. Makedonia 2', 1)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (3, N'bul. Slivnitca 33', 2)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (4, N'bul. Vasil Levski 100', 2)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (5, N'Calle Gran Via 15', 3)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (6, N'Calle Requena 12', 3)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (7, N'Gran Via de les Corts Catalanes 33', 4)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (8, N'Carrer Sao Paulo 2', 4)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (9, N'Yan''an Elevated Rd 71', 5)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (10, N'Wuning Rd 65', 5)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (11, N'Dongfeng W Rd 23', 6)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (12, N'Zhongshan 7th Rd 43', 6)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (13, N'Shankar Rd 55', 7)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (14, N'Mandir Marg 88', 7)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (15, N'Daftary Road 17', 8)
INSERT [dbo].[Addresses] ([Id], [AddressText], [TownId]) VALUES (16, N'Mathuradas Road 99', 8)
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Continents] ON 

INSERT [dbo].[Continents] ([Id], [Name]) VALUES (1, N'Europe')
INSERT [dbo].[Continents] ([Id], [Name]) VALUES (2, N'Asia')
SET IDENTITY_INSERT [dbo].[Continents] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([Id], [Name], [ContinentId]) VALUES (1, N'Bulgaria', 1)
INSERT [dbo].[Countries] ([Id], [Name], [ContinentId]) VALUES (2, N'Spain', 1)
INSERT [dbo].[Countries] ([Id], [Name], [ContinentId]) VALUES (3, N'China', 2)
INSERT [dbo].[Countries] ([Id], [Name], [ContinentId]) VALUES (4, N'India', 2)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[Persons] ON 

INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (1, N'Ivan', N'Ivanov', 1)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (2, N'Stefan', N'Stefanov', 2)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (3, N'Maria', N'Kostadinova', 3)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (4, N'Valentina', N'Trifonova', 4)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (5, N'Fabio', N'Castelo', 5)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (6, N'Ernesto', N'Garcia', 6)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (7, N'Adela', N'Castillo', 7)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (8, N'Delia', N'Alberta', 8)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (9, N'Mon', N'Keung', 9)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (10, N'Soo', N'Ling', 10)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (11, N'Tsang', N'Zhong', 11)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (12, N'Jia', N'Guotin', 12)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (13, N'Visha', N'Pathak', 13)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (14, N'Shiva', N'Nakhtare', 14)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (15, N'Kali', N'Kade', 15)
INSERT [dbo].[Persons] ([Id], [FirstName], [LastName], [AddressId]) VALUES (16, N'Kumara', N'Arora', 16)
SET IDENTITY_INSERT [dbo].[Persons] OFF
SET IDENTITY_INSERT [dbo].[Towns] ON 

INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (1, N'Sofia', 1)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (2, N'Varna', 1)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (3, N'Madrid', 2)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (4, N'Barcelona', 2)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (5, N'Shanghai', 3)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (6, N'Guangzhou', 3)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (7, N'New Delhi', 4)
INSERT [dbo].[Towns] ([Id], [Name], [CountryId]) VALUES (8, N'Mumbai', 4)
SET IDENTITY_INSERT [dbo].[Towns] OFF
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD  CONSTRAINT [FK_Addresses_Towns] FOREIGN KEY([TownId])
REFERENCES [dbo].[Towns] ([Id])
GO
ALTER TABLE [dbo].[Addresses] CHECK CONSTRAINT [FK_Addresses_Towns]
GO
ALTER TABLE [dbo].[Countries]  WITH CHECK ADD  CONSTRAINT [FK_Countries_Continents] FOREIGN KEY([ContinentId])
REFERENCES [dbo].[Continents] ([Id])
GO
ALTER TABLE [dbo].[Countries] CHECK CONSTRAINT [FK_Countries_Continents]
GO
ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK_Persons_Addresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Addresses] ([Id])
GO
ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK_Persons_Addresses]
GO
ALTER TABLE [dbo].[Towns]  WITH CHECK ADD  CONSTRAINT [FK_Towns_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Towns] CHECK CONSTRAINT [FK_Towns_Countries]
GO
USE [master]
GO
ALTER DATABASE [world] SET  READ_WRITE 
GO
