USE [hcmutemyanime]
GO
/****** Object:  View [hcmutemyanime].[GiftcodeView]    Script Date: 4/27/2023 6:29:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   ALGORITHM =  UNDEFINED.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   SQL SECURITY DEFINER.
*/

CREATE VIEW [hcmutemyanime].[GiftcodeView] (
   [id], 
   [create_at], 
   [redemption_code], 
   [subcription_package_id])
AS 
   SELECT gift_codes.id AS id, gift_codes.create_at AS create_at, gift_codes.redemption_code AS redemption_code, gift_codes.subcription_package_id AS subcription_package_id
   FROM hcmutemyanime.gift_codes
GO
/****** Object:  View [hcmutemyanime].[ListCategoryView]    Script Date: 4/27/2023 6:29:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [hcmutemyanime].[ListCategoryView] (
   [id], 
   [create_at], 
   [name]
)
AS 
   select categories.id, categories.create_at, categories.name
   from hcmutemyanime.categories
GO
/****** Object:  View [hcmutemyanime].[premiumuser]    Script Date: 4/27/2023 6:29:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
*   SSMA informational messages:
*   M2SS0003: The following SQL clause was ignored during conversion:
*   ALGORITHM =  UNDEFINED.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   DEFINER = `root`@`localhost`.
*   M2SS0003: The following SQL clause was ignored during conversion:
*   SQL SECURITY DEFINER.
*/

CREATE VIEW [hcmutemyanime].[premiumuser] (
   [id], 
   [expired_at], 
   [subscribe_date], 
   [subscription_package_id], 
   [user_id])
AS 
   /*
   *   SSMA warning messages:
   *   M2SS0104: Non aggregated column ID is aggregated with Min(..) in Select, Orderby and Having clauses.
   *   M2SS0104: Non aggregated column EXPIRED_AT is aggregated with Min(..) in Select, Orderby and Having clauses.
   *   M2SS0104: Non aggregated column SUBSCRIBE_DATE is aggregated with Min(..) in Select, Orderby and Having clauses.
   *   M2SS0104: Non aggregated column SUBSCRIPTION_PACKAGE_ID is aggregated with Min(..) in Select, Orderby and Having clauses.
   */

   SELECT TOP (9223372036854775807) 
      min(user_premiums.id) AS id, 
      min(user_premiums.expired_at) AS expired_at, 
      min(user_premiums.subscribe_date) AS subscribe_date, 
      min(user_premiums.subscription_package_id) AS subscription_package_id, 
      user_premiums.user_id AS user_id
   FROM hcmutemyanime.user_premiums
   WHERE (user_premiums.expired_at > getdate())
   GROUP BY user_premiums.user_id
      ORDER BY user_premiums.user_id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.giftcodeview' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'VIEW',@level1name=N'GiftcodeView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.premiumuser' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'VIEW',@level1name=N'premiumuser'
GO
