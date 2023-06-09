USE [hcmutemyanime]
GO
/****** Object:  User [admin]    Script Date: 5/11/2023 11:00:09 AM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [guestUser]    Script Date: 5/11/2023 11:00:09 AM ******/
CREATE USER [guestUser] FOR LOGIN [guestUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [admin_MyAnime]    Script Date: 5/11/2023 11:00:09 AM ******/
CREATE ROLE [admin_MyAnime]
GO
/****** Object:  DatabaseRole [guest_MyAnime]    Script Date: 5/11/2023 11:00:09 AM ******/
CREATE ROLE [guest_MyAnime]
GO
ALTER ROLE [admin_MyAnime] ADD MEMBER [admin]
GO
ALTER ROLE [guest_MyAnime] ADD MEMBER [guestUser]
GO
