USE [hcmutemyanime]
GO
/****** Object:  Table [dbo].[category_movie]    Script Date: 4/27/2023 6:27:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category_movie](
	[id] [int] IDENTITY(357,1) NOT NULL,
	[category_id] [int] NOT NULL,
	[movie_id] [int] NOT NULL,
 CONSTRAINT [PK_category_movie_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[attempt_logs]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[attempt_logs](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[attempt_type] [nvarchar](255) NULL,
	[create_at] [datetime2](0) NULL,
	[ip_address] [nvarchar](255) NULL,
 CONSTRAINT [PK_attempt_logs_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[categories]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[categories](
	[id] [int] IDENTITY(17,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[name] [nvarchar](255) NULL,
 CONSTRAINT [PK_categories_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[category_movie]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[category_movie](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NOT NULL,
	[movie_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[comments]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[comments](
	[id] [int] IDENTITY(315,1) NOT NULL,
	[content] [nvarchar](max) NULL,
	[create_at] [datetime2](0) NULL,
	[episode_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_comments_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[email_confirmation]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[email_confirmation](
	[id] [int] IDENTITY(90,1) NOT NULL,
	[confirmation_type] [nvarchar](255) NULL,
	[create_at] [datetime2](0) NULL,
	[email] [nvarchar](255) NULL,
	[expired_date] [datetime2](0) NULL,
	[otp_code] [nvarchar](255) NULL,
	[status] [nvarchar](255) NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_email_confirmation_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[episodes]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[episodes](
	[id] [int] IDENTITY(282,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[enable] [smallint] NULL,
	[premium_required] [smallint] NULL,
	[resource] [nvarchar](255) NULL,
	[resource_do] [nvarchar](255) NULL,
	[resource_public_id] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
	[total_view] [bigint] NULL,
	[series_id] [int] NULL,
	[num_episodes] [int] NULL,
 CONSTRAINT [PK_episodes_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[favorites]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[favorites](
	[id] [int] IDENTITY(77,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[movie_series_id] [int] NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_favorites_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[gift_codes]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[gift_codes](
	[id] [int] IDENTITY(77,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[redemption_code] [nvarchar](255) NULL,
	[subcription_package_id] [int] NOT NULL,
 CONSTRAINT [PK_gift_codes_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[log_histories]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[log_histories](
	[id] [int] IDENTITY(2,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[last_second] [bigint] NULL,
	[episode_id] [int] NULL,
	[series_id] [int] NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_log_histories_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[movie_series]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[movie_series](
	[id] [int] IDENTITY(150,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[date_aired] [datetime2](0) NULL,
	[description] [nvarchar](max) NULL,
	[image] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[total_episode] [int] NOT NULL,
	[movie_id] [int] NULL,
 CONSTRAINT [PK_movie_series_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[movies]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[movies](
	[id] [int] IDENTITY(152,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[studio_name] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
 CONSTRAINT [PK_movies_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[order_premium]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[order_premium](
	[id] [int] IDENTITY(43,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[description] [nvarchar](255) NULL,
	[method] [nvarchar](255) NULL,
	[status] [nvarchar](255) NULL,
	[bill_id] [int] NULL,
	[subcription_package_id] [int] NOT NULL,
	[user_id] [int] NULL,
 CONSTRAINT [PK_order_premium_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[paypal_order]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[paypal_order](
	[id] [int] IDENTITY(30,1) NOT NULL,
	[currency] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[intent] [nvarchar](255) NULL,
	[method] [nvarchar](255) NULL,
	[payer_id] [nvarchar](255) NULL,
	[payment_id] [nvarchar](255) NULL,
	[price] [float] NOT NULL,
	[status] [nvarchar](255) NULL,
	[token] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_paypal_order_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[roles]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[roles](
	[id] [int] IDENTITY(3,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[name] [nvarchar](255) NULL,
	[permission] [nvarchar](255) NULL,
 CONSTRAINT [PK_roles_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[subscription_packages]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[subscription_packages](
	[id] [int] IDENTITY(4,1) NOT NULL,
	[day] [bigint] NULL,
	[description] [nvarchar](255) NULL,
	[enable] [bit] NULL,
	[name] [nvarchar](255) NULL,
	[price] [float] NULL,
 CONSTRAINT [PK_subscription_packages_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[user_premiums]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[user_premiums](
	[id] [int] IDENTITY(51,1) NOT NULL,
	[expired_at] [datetime2](0) NULL,
	[subscribe_date] [datetime2](0) NULL,
	[subscription_package_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
 CONSTRAINT [PK_user_premiums_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[users]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[users](
	[id] [int] IDENTITY(41,1) NOT NULL,
	[avatar] [nvarchar](255) NULL,
	[create_at] [datetime2](0) NULL,
	[email] [nvarchar](255) NULL,
	[enable] [smallint] NULL,
	[full_name] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL,
	[user_role_id] [int] NOT NULL,
 CONSTRAINT [PK_users_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hcmutemyanime].[view_statistics]    Script Date: 4/27/2023 6:27:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hcmutemyanime].[view_statistics](
	[id] [int] IDENTITY(309,1) NOT NULL,
	[create_at] [datetime2](0) NULL,
	[ip_address] [nvarchar](255) NULL,
	[episode_id] [int] NULL,
 CONSTRAINT [PK_view_statistics_id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [hcmutemyanime].[attempt_logs] ADD  DEFAULT (NULL) FOR [attempt_type]
GO
ALTER TABLE [hcmutemyanime].[attempt_logs] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[attempt_logs] ADD  DEFAULT (NULL) FOR [ip_address]
GO
ALTER TABLE [hcmutemyanime].[categories] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[categories] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [hcmutemyanime].[comments] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [confirmation_type]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [expired_date]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [otp_code]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT ((0)) FOR [premium_required]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [resource]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [resource_do]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [resource_public_id]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT ((0)) FOR [total_view]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT (NULL) FOR [series_id]
GO
ALTER TABLE [hcmutemyanime].[episodes] ADD  DEFAULT ((-1)) FOR [num_episodes]
GO
ALTER TABLE [hcmutemyanime].[favorites] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[favorites] ADD  DEFAULT (NULL) FOR [movie_series_id]
GO
ALTER TABLE [hcmutemyanime].[gift_codes] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[gift_codes] ADD  DEFAULT (NULL) FOR [redemption_code]
GO
ALTER TABLE [hcmutemyanime].[log_histories] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[log_histories] ADD  DEFAULT (NULL) FOR [last_second]
GO
ALTER TABLE [hcmutemyanime].[log_histories] ADD  DEFAULT (NULL) FOR [episode_id]
GO
ALTER TABLE [hcmutemyanime].[log_histories] ADD  DEFAULT (NULL) FOR [series_id]
GO
ALTER TABLE [hcmutemyanime].[movie_series] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[movie_series] ADD  DEFAULT (NULL) FOR [date_aired]
GO
ALTER TABLE [hcmutemyanime].[movie_series] ADD  DEFAULT (NULL) FOR [image]
GO
ALTER TABLE [hcmutemyanime].[movie_series] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [hcmutemyanime].[movie_series] ADD  DEFAULT (NULL) FOR [movie_id]
GO
ALTER TABLE [hcmutemyanime].[movies] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[movies] ADD  DEFAULT (NULL) FOR [studio_name]
GO
ALTER TABLE [hcmutemyanime].[movies] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [method]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [bill_id]
GO
ALTER TABLE [hcmutemyanime].[order_premium] ADD  DEFAULT (NULL) FOR [user_id]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (N'USD') FOR [currency]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (N'sale') FOR [intent]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (N'paypal') FOR [method]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (NULL) FOR [payer_id]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (NULL) FOR [payment_id]
GO
ALTER TABLE [hcmutemyanime].[paypal_order] ADD  DEFAULT (N'pending') FOR [status]
GO
ALTER TABLE [hcmutemyanime].[roles] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[roles] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [hcmutemyanime].[roles] ADD  DEFAULT (NULL) FOR [permission]
GO
ALTER TABLE [hcmutemyanime].[subscription_packages] ADD  CONSTRAINT [DF__subscriptio__day__1AD3FDA4]  DEFAULT (NULL) FOR [day]
GO
ALTER TABLE [hcmutemyanime].[subscription_packages] ADD  CONSTRAINT [DF__subscript__descr__1BC821DD]  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [hcmutemyanime].[subscription_packages] ADD  CONSTRAINT [DF__subscript__enabl__1CBC4616]  DEFAULT (NULL) FOR [enable]
GO
ALTER TABLE [hcmutemyanime].[subscription_packages] ADD  CONSTRAINT [DF__subscripti__name__1DB06A4F]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [hcmutemyanime].[subscription_packages] ADD  CONSTRAINT [DF__subscript__price__1EA48E88]  DEFAULT (NULL) FOR [price]
GO
ALTER TABLE [hcmutemyanime].[user_premiums] ADD  DEFAULT (NULL) FOR [expired_at]
GO
ALTER TABLE [hcmutemyanime].[user_premiums] ADD  DEFAULT (NULL) FOR [subscribe_date]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [avatar]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [full_name]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [password]
GO
ALTER TABLE [hcmutemyanime].[users] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [hcmutemyanime].[view_statistics] ADD  DEFAULT (NULL) FOR [create_at]
GO
ALTER TABLE [hcmutemyanime].[view_statistics] ADD  DEFAULT (NULL) FOR [ip_address]
GO
ALTER TABLE [hcmutemyanime].[view_statistics] ADD  DEFAULT (NULL) FOR [episode_id]
GO
ALTER TABLE [dbo].[category_movie]  WITH NOCHECK ADD  CONSTRAINT [category_movie$FKk688wshqwmqx2tonomm3qllta] FOREIGN KEY([movie_id])
REFERENCES [hcmutemyanime].[movies] ([id])
GO
ALTER TABLE [dbo].[category_movie] CHECK CONSTRAINT [category_movie$FKk688wshqwmqx2tonomm3qllta]
GO
ALTER TABLE [dbo].[category_movie]  WITH NOCHECK ADD  CONSTRAINT [category_movie$FKqqveu4voyswj4kqfwumo8xgyu] FOREIGN KEY([category_id])
REFERENCES [hcmutemyanime].[categories] ([id])
GO
ALTER TABLE [dbo].[category_movie] CHECK CONSTRAINT [category_movie$FKqqveu4voyswj4kqfwumo8xgyu]
GO
ALTER TABLE [hcmutemyanime].[comments]  WITH NOCHECK ADD  CONSTRAINT [comments$FK8omq0tc18jd43bu5tjh6jvraq] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[comments] CHECK CONSTRAINT [comments$FK8omq0tc18jd43bu5tjh6jvraq]
GO
ALTER TABLE [hcmutemyanime].[comments]  WITH NOCHECK ADD  CONSTRAINT [comments$FKe1y835b37nm5wwrm2wwoxykhk] FOREIGN KEY([episode_id])
REFERENCES [hcmutemyanime].[episodes] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[comments] CHECK CONSTRAINT [comments$FKe1y835b37nm5wwrm2wwoxykhk]
GO
ALTER TABLE [hcmutemyanime].[email_confirmation]  WITH NOCHECK ADD  CONSTRAINT [email_confirmation$FKjgs74pu45i7a3e1cb5g7280yg] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[email_confirmation] CHECK CONSTRAINT [email_confirmation$FKjgs74pu45i7a3e1cb5g7280yg]
GO
ALTER TABLE [hcmutemyanime].[episodes]  WITH NOCHECK ADD  CONSTRAINT [episodes$FKhgushpuihey5i9ff1vvr1l680] FOREIGN KEY([series_id])
REFERENCES [hcmutemyanime].[movie_series] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[episodes] CHECK CONSTRAINT [episodes$FKhgushpuihey5i9ff1vvr1l680]
GO
ALTER TABLE [hcmutemyanime].[favorites]  WITH NOCHECK ADD  CONSTRAINT [favorites$FK7qwimfan4fp4mvkknv8qlk885] FOREIGN KEY([movie_series_id])
REFERENCES [hcmutemyanime].[movie_series] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[favorites] CHECK CONSTRAINT [favorites$FK7qwimfan4fp4mvkknv8qlk885]
GO
ALTER TABLE [hcmutemyanime].[favorites]  WITH NOCHECK ADD  CONSTRAINT [favorites$FKk7du8b8ewipawnnpg76d55fus] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[favorites] CHECK CONSTRAINT [favorites$FKk7du8b8ewipawnnpg76d55fus]
GO
ALTER TABLE [hcmutemyanime].[gift_codes]  WITH NOCHECK ADD  CONSTRAINT [gift_codes$FKliyy5s5f973bn0fjvx9ibbn6t] FOREIGN KEY([subcription_package_id])
REFERENCES [hcmutemyanime].[subscription_packages] ([id])
GO
ALTER TABLE [hcmutemyanime].[gift_codes] CHECK CONSTRAINT [gift_codes$FKliyy5s5f973bn0fjvx9ibbn6t]
GO
ALTER TABLE [hcmutemyanime].[log_histories]  WITH NOCHECK ADD  CONSTRAINT [log_histories$FKex5yf2uqudhu613eye2mg4jwv] FOREIGN KEY([series_id])
REFERENCES [hcmutemyanime].[movie_series] ([id])
GO
ALTER TABLE [hcmutemyanime].[log_histories] CHECK CONSTRAINT [log_histories$FKex5yf2uqudhu613eye2mg4jwv]
GO
ALTER TABLE [hcmutemyanime].[log_histories]  WITH NOCHECK ADD  CONSTRAINT [log_histories$FKn0spkbdfk8ot6xt7nlwh6kulq] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[log_histories] CHECK CONSTRAINT [log_histories$FKn0spkbdfk8ot6xt7nlwh6kulq]
GO
ALTER TABLE [hcmutemyanime].[log_histories]  WITH NOCHECK ADD  CONSTRAINT [log_histories$FKrw2up6i4hrhn70ak9dsnng221] FOREIGN KEY([episode_id])
REFERENCES [hcmutemyanime].[episodes] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[log_histories] CHECK CONSTRAINT [log_histories$FKrw2up6i4hrhn70ak9dsnng221]
GO
ALTER TABLE [hcmutemyanime].[movie_series]  WITH NOCHECK ADD  CONSTRAINT [movie_series$FKfowgph3de8wuelojrdmvhsg65] FOREIGN KEY([movie_id])
REFERENCES [hcmutemyanime].[movies] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[movie_series] CHECK CONSTRAINT [movie_series$FKfowgph3de8wuelojrdmvhsg65]
GO
ALTER TABLE [hcmutemyanime].[order_premium]  WITH NOCHECK ADD  CONSTRAINT [order_premium$FKb0d3s99j3yft0pyawhqvdyq2d] FOREIGN KEY([subcription_package_id])
REFERENCES [hcmutemyanime].[subscription_packages] ([id])
GO
ALTER TABLE [hcmutemyanime].[order_premium] CHECK CONSTRAINT [order_premium$FKb0d3s99j3yft0pyawhqvdyq2d]
GO
ALTER TABLE [hcmutemyanime].[order_premium]  WITH NOCHECK ADD  CONSTRAINT [order_premium$FKs95xak7c9ghccna5amk3pr7kp] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[order_premium] CHECK CONSTRAINT [order_premium$FKs95xak7c9ghccna5amk3pr7kp]
GO
ALTER TABLE [hcmutemyanime].[order_premium]  WITH NOCHECK ADD  CONSTRAINT [order_premium$FKsomvaoqoxjped8yui8o50ximw] FOREIGN KEY([bill_id])
REFERENCES [hcmutemyanime].[paypal_order] ([id])
GO
ALTER TABLE [hcmutemyanime].[order_premium] CHECK CONSTRAINT [order_premium$FKsomvaoqoxjped8yui8o50ximw]
GO
ALTER TABLE [hcmutemyanime].[user_premiums]  WITH NOCHECK ADD  CONSTRAINT [user_premiums$FKjyl89cnhx3wwmt5tnf0g3kdcw] FOREIGN KEY([user_id])
REFERENCES [hcmutemyanime].[users] ([id])
GO
ALTER TABLE [hcmutemyanime].[user_premiums] CHECK CONSTRAINT [user_premiums$FKjyl89cnhx3wwmt5tnf0g3kdcw]
GO
ALTER TABLE [hcmutemyanime].[user_premiums]  WITH NOCHECK ADD  CONSTRAINT [user_premiums$FKr8wwghvegr5cgtl3ti3x00g7u] FOREIGN KEY([subscription_package_id])
REFERENCES [hcmutemyanime].[subscription_packages] ([id])
GO
ALTER TABLE [hcmutemyanime].[user_premiums] CHECK CONSTRAINT [user_premiums$FKr8wwghvegr5cgtl3ti3x00g7u]
GO
ALTER TABLE [hcmutemyanime].[users]  WITH NOCHECK ADD  CONSTRAINT [users$FKeiotsurvwt38o0qs1w3kj32c9] FOREIGN KEY([user_role_id])
REFERENCES [hcmutemyanime].[roles] ([id])
GO
ALTER TABLE [hcmutemyanime].[users] CHECK CONSTRAINT [users$FKeiotsurvwt38o0qs1w3kj32c9]
GO
ALTER TABLE [hcmutemyanime].[view_statistics]  WITH NOCHECK ADD  CONSTRAINT [view_statistics$FKltthi0ki2va5qbkhhr6mloxj3] FOREIGN KEY([episode_id])
REFERENCES [hcmutemyanime].[episodes] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [hcmutemyanime].[view_statistics] CHECK CONSTRAINT [view_statistics$FKltthi0ki2va5qbkhhr6mloxj3]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.category_movie' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'category_movie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.attempt_logs' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'attempt_logs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.categories' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'categories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.comments' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'comments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.email_confirmation' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'email_confirmation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.episodes' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'episodes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.favorites' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'favorites'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.gift_codes' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'gift_codes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.log_histories' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'log_histories'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.movie_series' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'movie_series'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.movies' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'movies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.order_premium' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'order_premium'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.paypal_order' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'paypal_order'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.roles' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'roles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.subscription_packages' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'subscription_packages'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.user_premiums' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'user_premiums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.users' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'users'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'hcmutemyanime.view_statistics' , @level0type=N'SCHEMA',@level0name=N'hcmutemyanime', @level1type=N'TABLE',@level1name=N'view_statistics'
GO
