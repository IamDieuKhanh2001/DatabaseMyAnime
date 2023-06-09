USE [hcmutemyanime]
GO
/****** Object:  StoredProcedure [hcmutemyanime].[commentsByEpisodeIdPageable]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[commentsByEpisodeIdPageable]  
   @episodeId int,
   @currentPage int,
   @productLimit int
AS
BEGIN
   
      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      DECLARE @startNumber int = 0

      SET @startNumber = (@currentPage - 1) * @productLimit

	select comments.*
	from hcmutemyanime.comments
	join hcmutemyanime.episodes on comments.episode_id = episodes.id
	where episodes.id = @episodeId
    ORDER BY comments.create_at DESC
	OFFSET @startNumber ROWS
    FETCH NEXT @productLimit ROWS ONLY
END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[findAllEpisodesBySeriesId]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[findAllEpisodesBySeriesId]
	@seriesId int
AS
BEGIN
    select *
	from hcmutemyanime.episodes
	where episodes.series_id = @seriesId
	ORDER BY episodes.num_episodes ASC
END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[findEpisodeTopMostViewWithDay]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[findEpisodeTopMostViewWithDay]
    @numberofDay int = 7 ,
    @size int = 2 
AS
BEGIN
    -- stored procedure logic here
	SELECT TOP(@size) e.*, COUNT(v.id) AS statisticsView
	FROM hcmutemyanime.episodes e
	JOIN hcmutemyanime.view_statistics v ON e.id = v.episode_id
	WHERE DATEDIFF(day, v.create_at , CURRENT_TIMESTAMP) <= @numberOfDay
	GROUP BY e.id, e.title, e.total_view, e.create_at, e.enable, e.premium_required, e.resource, e.resource_do, e.resource_public_id, e.series_id, e.num_episodes
	ORDER BY statisticsView DESC
END;
GO
/****** Object:  StoredProcedure [hcmutemyanime].[getEpisodeIDCommentRecentWithLimit]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [hcmutemyanime].[getEpisodeIDCommentRecentWithLimit]  
   @limitSeries int
AS 
BEGIN
	SELECT TOP (@limitSeries) *
	FROM (
	SELECT DISTINCT ms.id, ms.name, ms.description, ms.date_aired, ms.total_episode, ms.image, ms.create_at, ms.movie_id
	FROM movie_series ms
	JOIN episodes e ON ms.id = e.series_id
	JOIN comments c ON e.id = c.episode_id
	GROUP BY ms.id, ms.name, ms.description, ms.date_aired, ms.total_episode, ms.image, ms.create_at, ms.movie_id, c.create_at
	) AS newT
	ORDER BY create_at DESC
END;
GO
/****** Object:  StoredProcedure [hcmutemyanime].[getListNormalUser]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[getListNormalUser]
   @currentPage int,
   @productLimit int,
   @searchString varchar(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

      /*Routine body goes here...*/
	 DECLARE @startNumber int = 0
     SET @startNumber = (@currentPage - 1) * @productLimit

	 IF @searchString IS NOT NULL -- kiểm tra nếu @searchString khác NULL thì thực hiện điều kiện AND
	 BEGIN
		 SELECT *
		FROM hcmutemyanime.users
		LEFT JOIN (SELECT DISTINCT user_id 
				   FROM hcmutemyanime.user_premiums 
				   WHERE expired_at > CURRENT_TIMESTAMP
				   GROUP BY user_id) AS premiumUser
		ON users.id = premiumUser.user_id
		WHERE premiumUser.user_id IS NULL AND users.username LIKE '%' + @searchString + '%'
		ORDER BY users.id
		OFFSET @startNumber ROWS
        FETCH NEXT @productLimit ROWS ONLY
	 END
    ELSE -- ngược lại, nếu @searchString = NULL thì không thực hiện điều kiện AND
	BEGIN
		SELECT *
		FROM hcmutemyanime.users
		LEFT JOIN (SELECT DISTINCT user_id 
				   FROM hcmutemyanime.user_premiums 
				   WHERE expired_at > CURRENT_TIMESTAMP
				   GROUP BY user_id) AS premiumUser
		ON users.id = premiumUser.user_id
		WHERE premiumUser.user_id IS NULL
		ORDER BY users.id
		OFFSET @startNumber ROWS
        FETCH NEXT @productLimit ROWS ONLY
	END
END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[getListPremiumUser]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [hcmutemyanime].[getListPremiumUser]
   @currentPage int,
   @productLimit int,
   @searchString varchar(50) = NULL
AS 
BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
	  DECLARE @startNumber int = 0
      SET @startNumber = (@currentPage - 1) * @productLimit

      IF @searchString IS NOT NULL -- kiểm tra nếu @searchString khác NULL thì thực hiện điều kiện AND
      BEGIN
         SELECT DISTINCT 
         users.id,
         users.username,
         users.user_role_id, 
         users.password, 
         users.full_name, 
         users.enable, 
         users.email, 
         users.create_at, 
         users.avatar
         FROM hcmutemyanime.user_premiums
         join hcmutemyanime.users on user_premiums.user_id = users.id
         WHERE user_premiums.expired_at > getdate()
         AND users.username LIKE '%' + @searchString + '%'
         GROUP BY users.id, users.username, users.user_role_id, users.password, users.full_name, users.enable, users.email, users.create_at, users.avatar
         ORDER BY users.id
		 OFFSET @startNumber ROWS
         FETCH NEXT @productLimit ROWS ONLY
      END
      ELSE -- ngược lại, nếu @searchString = NULL thì không thực hiện điều kiện AND
      BEGIN
         SELECT DISTINCT 
         users.id,
         users.username,
         users.user_role_id, 
         users.password, 
         users.full_name, 
         users.enable, 
         users.email, 
         users.create_at, 
         users.avatar
         FROM hcmutemyanime.user_premiums
         join hcmutemyanime.users on user_premiums.user_id = users.id
         WHERE user_premiums.expired_at > getdate()
         GROUP BY users.id, users.username, users.user_role_id, users.password, users.full_name, users.enable, users.email, users.create_at, users.avatar
         ORDER BY users.id
		 OFFSET @startNumber ROWS
         FETCH NEXT @productLimit ROWS ONLY
      END
   END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[moviePageable]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[moviePageable]  
   @currentPage int,
   @productLimit int
AS
BEGIN
   
      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      DECLARE
         @startNumber int = 0

      SET @startNumber = (@currentPage - 1) * @productLimit

      /*
      *   SSMA warning messages:
      *   M2SS0290: OFFSET clause requires ORDER BY clause which is missing in the source statement. SSMA use an expression as ORDER BY clause during conversion. The query result may be different than that of the source.
      */

      SELECT 
         *
      FROM hcmutemyanime.movies
      ORDER BY create_at DESC, title ASC
       
      OFFSET @startNumber ROWS
      FETCH NEXT @productLimit ROWS ONLY
END

GO
/****** Object:  StoredProcedure [hcmutemyanime].[movieSeriesByCategoryIdPageable]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[movieSeriesByCategoryIdPageable]  
   @categoryId int,
   @currentPage int,
   @productLimit int
AS
BEGIN
   
      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      DECLARE
      @startNumber int = 0

      SET @startNumber = (@currentPage - 1) * @productLimit

	SELECT movie_series.id, 
         movie_series.create_at, 
         movie_series.date_aired, 
         movie_series.description, 
         movie_series.image, 
         movie_series.name, 
         movie_series.total_episode, 
         movie_series.movie_id
	FROM hcmutemyanime.movie_series 
	INNER JOIN dbo.category_movie ON category_movie.movie_id = movie_series.movie_id
	WHERE category_movie.category_id = @categoryId
    ORDER BY movie_series.create_at DESC, movie_series.name ASC
	OFFSET @startNumber ROWS
    FETCH NEXT @productLimit ROWS ONLY
END

GO
/****** Object:  StoredProcedure [hcmutemyanime].[movieSeriesPageable]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE PROCEDURE [hcmutemyanime].[movieSeriesPageable]  
   @currentPage int,
   @productLimit int
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      DECLARE
         @startNumber int = 0

      SET @startNumber = (@currentPage - 1) * @productLimit

      /*
      *   SSMA warning messages:
      *   M2SS0290: OFFSET clause requires ORDER BY clause which is missing in the source statement. SSMA use an expression as ORDER BY clause during conversion. The query result may be different than that of the source.
      */

      SELECT 
         movie_series.id, 
         movie_series.create_at, 
         movie_series.date_aired, 
         movie_series.description, 
         movie_series.image, 
         movie_series.name, 
         movie_series.total_episode, 
         movie_series.movie_id
      FROM hcmutemyanime.movie_series
      ORDER BY create_at DESC, name ASC --last create at will turn back in top

         OFFSET @startNumber ROWS
         FETCH NEXT @productLimit ROWS ONLY

   END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[usersPageable]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[usersPageable]  
   @currentPage int,
   @productLimit int
AS
BEGIN
   
      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      DECLARE
         @startNumber int = 0

      SET @startNumber = (@currentPage - 1) * @productLimit

      /*
      *   SSMA warning messages:
      *   M2SS0290: OFFSET clause requires ORDER BY clause which is missing in the source statement. SSMA use an expression as ORDER BY clause during conversion. The query result may be different than that of the source.
      */

      SELECT 
         *
      FROM hcmutemyanime.users
         ORDER BY 
            (
               SELECT 1
            )
         OFFSET @startNumber ROWS
         FETCH NEXT @productLimit ROWS ONLY
END

GO
/****** Object:  StoredProcedure [hcmutemyanime].[usp_InsertOrUpdateComment]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[usp_InsertOrUpdateComment]
    @id int,
    @content nvarchar(max),
    @episode_id int,
    @user_id int
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		DECLARE @create_at datetime2(0) = GETDATE(); --Lay ngay hien tai
        IF (@id = 0) --Neu ID = 0 se insert vao moi
        BEGIN
            INSERT INTO [hcmutemyanime].[comments] ([content],[create_at],[episode_id], [user_id])
            VALUES (@content, @create_at, @episode_id, @user_id);
            SET @id = SCOPE_IDENTITY(); -- tra ve id cua row moi vua tạo trong session này
        END
        ELSE --Neu ID khac 0 se update vao moi
        BEGIN
            IF EXISTS (SELECT * FROM [hcmutemyanime].[comments] WHERE [id] = @id)
            BEGIN
                UPDATE [hcmutemyanime].[comments]
                SET [content] = @content,
                    [episode_id] = @episode_id,
					[user_id] = @user_id
                WHERE [id] = @id;
            END
        END
		--Khi insert hoac update xong se tra ve dong da xu li xong
        SELECT *
        FROM [hcmutemyanime].[comments]
        WHERE [id] = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH --Throw exception
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
    
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[usp_InsertOrUpdateMovie]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [hcmutemyanime].[usp_InsertOrUpdateMovie]
    @id int,
    @studio_name nvarchar(255),
	@title nvarchar(255)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		DECLARE @create_at datetime2(0) = GETDATE(); --Lay ngay hien tai
        IF (@id = 0) --Neu ID = 0 se insert vao moi
        BEGIN
            INSERT INTO [hcmutemyanime].[movies] ([studio_name], [title],[create_at])
            VALUES (@studio_name, @title, @create_at);
            SET @id = SCOPE_IDENTITY(); --lay id moi nhat khi da insert
        END
        ELSE --Neu ID khac 0 se update vao moi
        BEGIN
            IF EXISTS (SELECT * FROM [hcmutemyanime].[movies] WHERE [id] = @id)
            BEGIN
                UPDATE [hcmutemyanime].[movies]
                SET [studio_name] = @studio_name,
                    [title] = @title
                WHERE [id] = @id;
            END
        END
		--Khi insert hoac update xong se tra ve dong da xu li xong
        SELECT *
        FROM [hcmutemyanime].[movies]
        WHERE [id] = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH --Throw exception
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
    
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END

GO
/****** Object:  StoredProcedure [hcmutemyanime].[usp_InsertOrUpdateMovieSeries]    Script Date: 5/11/2023 10:55:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [hcmutemyanime].[usp_InsertOrUpdateMovieSeries]
    @id int,
    @name nvarchar(255),
    @description nvarchar(max),
    @date_aired datetime2(0),
    @total_episode int,
    @movie_id int,
    @image nvarchar(255)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		DECLARE @create_at datetime2(0) = GETDATE(); --Lay ngay hien tai
        IF (@id = 0) --Neu ID = 0 se insert vao moi
        BEGIN
            INSERT INTO [hcmutemyanime].[movie_series] ([name], [description], [date_aired],[create_at], [total_episode], [movie_id], [image])
            VALUES (@name, @description, @date_aired, @create_at, @total_episode, @movie_id, @image);
            SET @id = SCOPE_IDENTITY(); -- tra ve id cua row moi vua tạo trong session này
        END
        ELSE --Neu ID khac 0 se update vao moi
        BEGIN
            IF EXISTS (SELECT * FROM [hcmutemyanime].[movie_series] WHERE [id] = @id)
            BEGIN
                UPDATE [hcmutemyanime].[movie_series]
                SET [name] = @name,
                    [description] = @description,
                    [date_aired] = @date_aired,
                    [total_episode] = @total_episode,
                    [movie_id] = @movie_id,
                    [image] = @image
                WHERE [id] = @id;
            END
        END
		--Khi insert hoac update xong se tra ve dong da xu li xong
        SELECT *
        FROM [hcmutemyanime].[movie_series]
        WHERE [id] = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH --Throw exception
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();
    
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.getEpisodeIDCommentRecentWithLimit' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'getEpisodeIDCommentRecentWithLimit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countPremiumUser' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'getListPremiumUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.movieSeriesPageable' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'movieSeriesPageable'
GO
