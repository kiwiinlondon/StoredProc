USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CompanySize_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CompanySize_Insert]
GO

CREATE PROCEDURE DBO.[CompanySize_Insert]
		@Name varchar(100), 
		@MarketCapUSD numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CompanySize
			(Name, MarketCapUSD, UpdateUserID, StartDt)
	VALUES
			(@Name, @MarketCapUSD, @UpdateUserID, @StartDt)

	SELECT	CompanySizeId, StartDt, DataVersion
	FROM	CompanySize
	WHERE	CompanySizeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
