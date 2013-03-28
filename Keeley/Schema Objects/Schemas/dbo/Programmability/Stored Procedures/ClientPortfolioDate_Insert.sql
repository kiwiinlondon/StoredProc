USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioDate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioDate_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolioDate_Insert]
		@ClientAccountId int, 
		@FundId int, 
		@FirstTradeDate datetime, 
		@OriginalInvestment numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioDate
			(ClientAccountId, FundId, FirstTradeDate, OriginalInvestment, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @FirstTradeDate, @OriginalInvestment, @StartDt)

	SELECT	ClientPortfolioDateId, StartDt, DataVersion
	FROM	ClientPortfolioDate
	WHERE	ClientPortfolioDateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
