USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioDate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioDate_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolioDate_Delete]
		@ClientPortfolioDateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolioDate_hst (
			ClientPortfolioDateId, ClientAccountId, FundId, FirstTradeDate, OriginalInvestment, EndDt, LastActionUserID)
	SELECT	ClientPortfolioDateId, ClientAccountId, FundId, FirstTradeDate, OriginalInvestment, @EndDt, @UpdateUserID
	FROM	ClientPortfolioDate
	WHERE	ClientPortfolioDateId = @ClientPortfolioDateId

	DELETE	ClientPortfolioDate
	WHERE	ClientPortfolioDateId = @ClientPortfolioDateId
	AND		DataVersion = @DataVersion
GO
