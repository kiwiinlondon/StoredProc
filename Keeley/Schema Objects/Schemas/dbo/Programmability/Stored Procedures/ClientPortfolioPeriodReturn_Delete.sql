USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioPeriodReturn_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioPeriodReturn_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolioPeriodReturn_Delete]
		@ClientPortfolioPeriodReturnID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolioPeriodReturn_hst (
			ClientPortfolioPeriodReturnID, ClientAccountId, FundId, ReferenceDate, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, StartDt, UpdateUserID, DataVersion, ITDSumCost, UnrealisedPnlTwelveMonthsAgo, EndDt, LastActionUserID)
	SELECT	ClientPortfolioPeriodReturnID, ClientAccountId, FundId, ReferenceDate, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, StartDt, UpdateUserID, DataVersion, ITDSumCost, UnrealisedPnlTwelveMonthsAgo, @EndDt, @UpdateUserID
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID

	DELETE	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		DataVersion = @DataVersion
GO
