USE [master]
GO

CREATE DATABASE [Movies]
 CONTAINMENT = NONE
GO

ALTER DATABASE [Movies] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Movies].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Movies] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Movies] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Movies] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Movies] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Movies] SET ARITHABORT OFF 
GO
ALTER DATABASE [Movies] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Movies] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Movies] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Movies] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Movies] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Movies] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Movies] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Movies] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Movies] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Movies] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Movies] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Movies] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Movies] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Movies] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Movies] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Movies] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Movies] SET RECOVERY FULL 
GO
ALTER DATABASE [Movies] SET  MULTI_USER 
GO
ALTER DATABASE [Movies] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Movies] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Movies] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Movies] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Movies] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Movies] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Movies', N'ON'
GO
ALTER DATABASE [Movies] SET QUERY_STORE = OFF
GO
USE [Movies]
GO
/****** Object:  UserDefinedFunction [dbo].[fnCalculateMovieAverageRating]    Script Date: 3/27/2022 11:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnCalculateMovieAverageRating]
(
	@MovieId int
)
RETURNS decimal(4,2)
AS
BEGIN
	return (SELECT CAST(AVG(CAST(rating as decimal(4,2))) as decimal(4,2))
			FROM	MovieRating
			WHERE	MovieId = @MovieId
			GROUP BY (MovieId))
END
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 3/27/2022 11:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[Id] [smallint] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 3/27/2022 11:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[YearOfRelease] [smallint] NOT NULL,
	[GenreId] [smallint] NOT NULL,
	[RunningTime] [tinyint] NOT NULL,
	[AverageRating] [decimal](4, 2) NOT NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieRating]    Script Date: 3/27/2022 11:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieRating](
	[MovieId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Rating] [tinyint] NOT NULL,
 CONSTRAINT [PK_MovieRating] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/27/2022 11:51:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Genre] ([Id], [Description]) VALUES (1, N'Action')
GO
INSERT [dbo].[Genre] ([Id], [Description]) VALUES (2, N'Comedy')
GO
INSERT [dbo].[Genre] ([Id], [Description]) VALUES (3, N'Horror')
GO
INSERT [dbo].[Genre] ([Id], [Description]) VALUES (4, N'Science Fiction')
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (1, N'Mad Max: Fury Road', 2015, 1, 120, CAST(5.56 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (2, N'Wonder Woman', 2017, 1, 141, CAST(3.56 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (3, N'Baby Driver', 2017, 1, 113, CAST(2.89 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (4, N'The Hurt Locker', 2009, 1, 131, CAST(3.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (5, N'Skyfall', 2012, 1, 145, CAST(4.33 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (6, N'True Grit', 2010, 1, 110, CAST(3.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (7, N'Sicario', 2015, 1, 121, CAST(5.11 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (8, N'13 Assassins ', 2011, 1, 126, CAST(3.56 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (9, N'John Wick', 2014, 1, 96, CAST(4.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (10, N'Rush', 2013, 1, 123, CAST(4.33 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (11, N'The Lego Movie', 2014, 2, 101, CAST(6.22 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (12, N'The Nice Guys', 2016, 2, 116, CAST(5.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (13, N'Zombie Land', 2009, 2, 88, CAST(4.56 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (14, N'The Worlds End', 2013, 2, 109, CAST(4.78 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (15, N'Tuck & Dale vs. Evil', 2011, 2, 88, CAST(3.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (16, N'Spy', 2015, 2, 117, CAST(4.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (17, N'The Grand Budapest Hotel', 2014, 2, 99, CAST(4.89 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (18, N'Enough Said', 2014, 2, 93, CAST(3.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (19, N'Midnight in Paris', 2011, 2, 94, CAST(4.11 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (20, N'It Follows', 2015, 3, 94, CAST(4.11 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (21, N'Let The Right One In', 2009, 3, 114, CAST(5.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (22, N'Night of The Living Dead', 1968, 3, 90, CAST(4.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (23, N'The Birds', 1963, 3, 119, CAST(3.56 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (24, N'The Cabin in The Woods', 2012, 3, 95, CAST(4.89 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (25, N'Splice', 2010, 3, 100, CAST(4.11 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (26, N'Fright Night', 2011, 3, 101, CAST(5.78 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (27, N'Stake Land', 2011, 3, 96, CAST(4.22 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (28, N'The Crazies', 2010, 3, 101, CAST(4.78 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (29, N'Evil Dead 2: Dead by Dawn', 1987, 3, 84, CAST(5.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (30, N'Metropolis ', 1927, 4, 115, CAST(3.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (31, N'Star Trek', 2009, 4, 127, CAST(4.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (32, N'Her', 2014, 4, 126, CAST(3.89 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (33, N'Ex Machina ', 2015, 4, 108, CAST(5.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (34, N'Avatar', 2009, 4, 162, CAST(5.44 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (35, N'Akira', 1988, 4, 124, CAST(6.22 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (36, N'Super 8', 2011, 4, 112, CAST(3.78 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (37, N'Total Recall ', 1990, 4, 113, CAST(4.78 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (38, N'Prometheus', 2012, 4, 123, CAST(4.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (39, N'Bladerunner', 1982, 4, 114, CAST(5.67 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (40, N'2001: A Space Odyssey', 1968, 4, 139, CAST(5.22 AS Decimal(4, 2)))
GO
INSERT [dbo].[Movie] ([Id], [Title], [YearOfRelease], [GenreId], [RunningTime], [AverageRating]) VALUES (43, N'Torn B', 2020, 3, 100, CAST(9.00 AS Decimal(4, 2)))
GO
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 1, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 2, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 3, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 4, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 5, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 6, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 7, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 8, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (1, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 1, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 2, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 3, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 4, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 6, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 7, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (2, 9, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 1, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 4, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 7, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 8, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (3, 9, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 1, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 3, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 4, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 5, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 6, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 7, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 8, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (4, 9, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 1, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 2, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 3, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 4, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 5, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 6, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 7, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (5, 9, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 1, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 4, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 7, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 8, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (6, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 1, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 4, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 5, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 6, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 7, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (7, 9, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 2, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 4, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 5, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (8, 9, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 1, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 2, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 4, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 5, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 6, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 7, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 8, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (9, 9, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 1, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 4, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 5, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 6, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 7, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (10, 9, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 1, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 4, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 5, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 7, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 8, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (11, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 1, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 3, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 4, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 6, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 7, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 8, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (12, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 1, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 2, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 3, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 4, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 5, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 6, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 7, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (13, 9, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 1, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 2, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 3, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 4, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 5, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (14, 9, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 1, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 4, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 5, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 7, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 8, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (15, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 1, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 2, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 4, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 5, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 8, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (16, 9, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 3, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 4, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 6, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 7, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (17, 9, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 1, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 3, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 4, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 5, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 7, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 8, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (18, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 1, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 3, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 4, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 5, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 6, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 7, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (19, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 2, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 4, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 6, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 8, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (20, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 1, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 2, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 3, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 4, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 6, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 7, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 8, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (21, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 1, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 2, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 3, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 4, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 7, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (22, 9, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 1, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 2, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 3, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 4, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 5, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 6, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 7, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (23, 9, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 1, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 2, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 3, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 4, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 8, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (24, 9, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 2, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 4, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 5, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 6, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 7, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (25, 9, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 1, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 2, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 3, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 4, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 6, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 7, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (26, 9, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 2, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 3, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 4, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 7, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 8, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (27, 9, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 1, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 2, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 3, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 4, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 5, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 6, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 7, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 8, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (28, 9, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 1, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 2, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 3, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 4, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 8, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (29, 9, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 1, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 2, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 4, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 5, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 7, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 8, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (30, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 1, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 3, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 4, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 5, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 6, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 7, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 8, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (31, 9, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 1, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 3, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 4, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 7, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (32, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 1, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 3, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 4, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 5, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 6, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 7, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 8, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (33, 9, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 1, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 3, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 4, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 5, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 6, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 8, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (34, 9, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 1, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 3, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 4, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 5, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 6, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 7, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 8, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (35, 9, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 1, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 3, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 4, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 5, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 6, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 7, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 8, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (36, 9, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 1, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 2, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 3, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 4, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 5, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 6, 4)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 7, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 8, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (37, 9, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 1, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 2, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 3, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 4, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 5, 0)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 6, 8)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 7, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 8, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (38, 9, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 1, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 2, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 3, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 4, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 5, 1)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 6, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 7, 5)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 8, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (39, 9, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 1, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 2, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 3, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 4, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 5, 7)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 6, 3)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 7, 2)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 8, 6)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (40, 9, 9)
GO
INSERT [dbo].[MovieRating] ([MovieId], [UserId], [Rating]) VALUES (43, 1, 9)
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (1, N'Test User 1')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (2, N'Test User 2')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (3, N'Test User 3')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (4, N'Test User 4')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (5, N'Test User 5')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (6, N'Test User 6')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (7, N'Test User 7')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (8, N'Test User 8')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (9, N'Test User 9')
GO
INSERT [dbo].[User] ([Id], [Name]) VALUES (10, N'Test User 10')
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_Movie_Genre] FOREIGN KEY([GenreId])
REFERENCES [dbo].[Genre] ([Id])
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_Movie_Genre]
GO
ALTER TABLE [dbo].[MovieRating]  WITH CHECK ADD  CONSTRAINT [FK_MoveiRating_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([Id])
GO
ALTER TABLE [dbo].[MovieRating] CHECK CONSTRAINT [FK_MoveiRating_Movie]
GO
ALTER TABLE [dbo].[MovieRating]  WITH CHECK ADD  CONSTRAINT [FK_MovieRating_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[MovieRating] CHECK CONSTRAINT [FK_MovieRating_User]
GO
USE [master]
GO
ALTER DATABASE [Movies] SET  READ_WRITE 
GO
