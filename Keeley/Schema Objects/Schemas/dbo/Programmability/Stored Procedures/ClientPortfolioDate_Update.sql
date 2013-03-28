USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioDate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioDate_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolioDate_Update]
		@ClientPortfolioDateId int, 
		@ClientAccountId int, 
		@FundId int, 
		@FirstTradeDate datetime, 
		@OriginalInvestment numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioDate_hst (
			ClientPortfolioDateId, ClientAccountId, FundId, FirstTradeDate, OriginalInvestment, EndDt, LastActionUserID)
	SELECT	ClientPortfolioDateId, ClientAccountId, FundId, FirstTradeDate, OriginalInvestment, @StartDt, @UpdateUserID
	FROM	ClientPortfolioDate
	WHERE	ClientPortfolioDateId = @ClientPortfolioDateId

	UPDATE	ClientPortfolioDate
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, FirstTradeDate = @FirstTradeDate, OriginalInvestment = @OriginalInvestment,  StartDt = @StartDt
	WHERE	ClientPortfolioDateId = @ClientPortfolioDateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioDate
	WHERE	ClientPortfolioDateId = @ClientPortfolioDateId
	AND		@@ROWCOUNT > 0

GO
