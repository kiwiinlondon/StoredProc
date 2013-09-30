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
			ClientPortfolioPeriodReturnID, StartDt, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioPeriodReturnID, StartDt, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID

	DELETE	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		DataVersion = @DataVersion
GO
