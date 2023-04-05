USE [hcmutemyanime]
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countNormalUser]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [hcmutemyanime].[countNormalUser]()
RETURNS int
AS
BEGIN
	DECLARE @count int;
	SELECT @count = COUNT(*) 
	FROM hcmutemyanime.users
	LEFT JOIN (SELECT DISTINCT user_id 
			   FROM hcmutemyanime.user_premiums 
			   WHERE expired_at > CURRENT_TIMESTAMP
			   GROUP BY user_id) AS premiumUser
	ON users.id = premiumUser.user_id
	WHERE premiumUser.user_id IS NULL;
	RETURN @count;
END
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countPremiumUser]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [hcmutemyanime].[countPremiumUser]()
RETURNS INT
AS
BEGIN
	DECLARE @count INT;
	SELECT @count = COUNT(*) FROM
	(SELECT DISTINCT user_premiums.user_id FROM hcmutemyanime.user_premiums
	WHERE expired_at > CURRENT_TIMESTAMP
	GROUP BY user_id) AS premiumUserTable;
	RETURN @count;
END;
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countTopupPackage]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE FUNCTION [hcmutemyanime].[countTopupPackage] 
( 
   @topupPackageId int,
   @paymentStatus nvarchar(255)
)
RETURNS int
AS 
   BEGIN

      /*Routine body goes here...*/
      DECLARE
         @count int

      SET @paymentStatus = ISNULL(@paymentStatus, N'paid')

      SELECT @count = count_big(*)
      FROM hcmutemyanime.order_premium
      WHERE order_premium.status = @paymentStatus AND order_premium.subcription_package_id = @topupPackageId

      RETURN @count

   END
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countTotalViewByYear]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE FUNCTION [hcmutemyanime].[countTotalViewByYear] 
( 
   @year int
)
RETURNS bigint
AS 
   BEGIN

      /*Routine body goes here...*/
      DECLARE
         @count bigint = 0

      SET @year = ISNULL(@year, year(getdate()))

      SELECT @count = count_big(*)
      FROM hcmutemyanime.view_statistics
      WHERE year(view_statistics.create_at) = @year

      RETURN @count

   END
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countViewStatisticsByCategoryId]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE FUNCTION [hcmutemyanime].[countViewStatisticsByCategoryId] 
( 
   @categoryId int
)
RETURNS bigint
AS 
   BEGIN

      /*Routine body goes here...*/
      DECLARE
         @count int

      SELECT @count = count_big(*)
      FROM 
         hcmutemyanime.view_statistics 
            INNER JOIN hcmutemyanime.episodes 
            ON view_statistics.episode_id = episodes.id 
            INNER JOIN hcmutemyanime.movie_series 
            ON episodes.series_id = movie_series.id 
            INNER JOIN hcmutemyanime.movies 
            ON movie_series.movie_id = movies.id 
            INNER JOIN dbo.category_movie 
            ON category_movie.movie_id = movies.id
      WHERE category_movie.category_id = @categoryId

      RETURN @count

   END
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countViewStatisticsByYearAndMonth]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE FUNCTION [hcmutemyanime].[countViewStatisticsByYearAndMonth] 
( 
   @year int,
   @month int
)
RETURNS bigint
AS 
   BEGIN

      /*Routine body goes here...*/
      DECLARE
         @count bigint = 0

      SET @year = ISNULL(@year, year(getdate()))

      SET @month = ISNULL(@month, datepart(MONTH, getdate()))

      SELECT @count = count_big(*)
      FROM hcmutemyanime.view_statistics
      WHERE year(view_statistics.create_at) = @year AND datepart(MONTH, view_statistics.create_at) = @month

      RETURN @count

   END
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[totalRevenueInYearAndMonth]    Script Date: 4/5/2023 2:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*/

CREATE FUNCTION [hcmutemyanime].[totalRevenueInYearAndMonth] 
( 
   @year int,
   @month int
)
RETURNS float(53)
AS 
   BEGIN

      /*Routine body goes here...*/
      DECLARE
         @totalRevenue float(53) = 0

      SET @year = ISNULL(@year, year(getdate()))

      SET @month = ISNULL(@month, datepart(MONTH, getdate()))

      SELECT @totalRevenue = sum(paypal_order.price)
      FROM 
         hcmutemyanime.paypal_order 
            INNER JOIN hcmutemyanime.order_premium 
            ON paypal_order.id = order_premium.bill_id
      WHERE 
         paypal_order.status = 'paid' AND 
         year(order_premium.create_at) = @year AND 
         datepart(MONTH, order_premium.create_at) = @month

      SET @totalRevenue = ISNULL(@totalRevenue, 0)

      RETURN @totalRevenue

   END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[findAllEpisodesBySeriesId]    Script Date: 4/5/2023 2:52:09 PM ******/
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
/****** Object:  StoredProcedure [hcmutemyanime].[findEpisodeTopMostViewWithDay]    Script Date: 4/5/2023 2:52:09 PM ******/
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
/****** Object:  StoredProcedure [hcmutemyanime].[getEpisodeIDCommentRecentWithLimit]    Script Date: 4/5/2023 2:52:09 PM ******/
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
/****** Object:  StoredProcedure [hcmutemyanime].[getListPremiumUser]    Script Date: 4/5/2023 2:52:09 PM ******/
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
AS 
   BEGIN

      SET  XACT_ABORT  ON

      SET  NOCOUNT  ON

      /*Routine body goes here...*/
      /*
      *   SSMA warning messages:
      *   M2SS0104: Non aggregated column ID is aggregated with Min(..) in Select, Orderby and Having clauses.
      *   M2SS0104: Non aggregated column EXPIRED_AT is aggregated with Min(..) in Select, Orderby and Having clauses.
      *   M2SS0104: Non aggregated column SUBSCRIBE_DATE is aggregated with Min(..) in Select, Orderby and Having clauses.
      *   M2SS0104: Non aggregated column SUBSCRIPTION_PACKAGE_ID is aggregated with Min(..) in Select, Orderby and Having clauses.
      */

      SELECT DISTINCT 
         min(user_premiums.id) AS id, 
         min(user_premiums.expired_at) AS expired_at, 
         min(user_premiums.subscribe_date) AS subscribe_date, 
         min(user_premiums.subscription_package_id) AS subscription_package_id, 
         user_premiums.user_id
      FROM hcmutemyanime.user_premiums
      WHERE user_premiums.expired_at > getdate()
      GROUP BY user_premiums.user_id
         ORDER BY user_premiums.user_id

   END
GO
/****** Object:  StoredProcedure [hcmutemyanime].[moviePageable]    Script Date: 4/5/2023 2:52:09 PM ******/
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
/****** Object:  StoredProcedure [hcmutemyanime].[movieSeriesPageable]    Script Date: 4/5/2023 2:52:09 PM ******/
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
/****** Object:  StoredProcedure [hcmutemyanime].[usersPageable]    Script Date: 4/5/2023 2:52:09 PM ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.getEpisodeIDCommentRecentWithLimit' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'getEpisodeIDCommentRecentWithLimit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countPremiumUser' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'getListPremiumUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.movieSeriesPageable' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'PROCEDURE',@level1name=N'movieSeriesPageable'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countTopupPackage' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'FUNCTION',@level1name=N'countTopupPackage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countTotalViewByYear' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'FUNCTION',@level1name=N'countTotalViewByYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countViewStatisticsByCategoryId' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'FUNCTION',@level1name=N'countViewStatisticsByCategoryId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.countViewStatisticsByYearAndMonth' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'FUNCTION',@level1name=N'countViewStatisticsByYearAndMonth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.totalRevenueInYearAndMonth' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'FUNCTION',@level1name=N'totalRevenueInYearAndMonth'
GO
