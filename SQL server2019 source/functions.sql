USE [hcmutemyanime]
GO
/****** Object:  UserDefinedFunction [hcmutemyanime].[countNormalUser]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[countPremiumUser]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[countTopupPackage]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[countTotalViewByYear]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[countViewStatisticsByCategoryId]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[countViewStatisticsByYearAndMonth]    Script Date: 5/11/2023 10:58:14 AM ******/
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
/****** Object:  UserDefinedFunction [hcmutemyanime].[totalRevenueInYearAndMonth]    Script Date: 5/11/2023 10:58:14 AM ******/
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
