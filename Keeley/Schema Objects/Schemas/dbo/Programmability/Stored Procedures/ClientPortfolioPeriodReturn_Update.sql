USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioPeriodReturn_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioPeriodReturn_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolioPeriodReturn_Update]
		@ClientPortfolioPeriodReturnID int, 
		@CurrentUnrealisedPnl numeric(27,8), 
		@ITDNumberDays int, 
		@ITDRealisedPnl numeric(27,8), 
		@TwelveMonthNumberDays int, 
		@TwelveMonthSumCost numeric(27,8), 
		@TwelveMonthRealisedPnl numeric(27,8), 
		@IsLast bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioPeriodReturn_hst (
			ClientPortfolioPeriodReturnID, StartDt, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioPeriodReturnID, StartDt, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID

	UPDATE	ClientPortfolioPeriodReturn
	SET		CurrentUnrealisedPnl = @CurrentUnrealisedPnl, ITDNumberDays = @ITDNumberDays, ITDRealisedPnl = @ITDRealisedPnl, TwelveMonthNumberDays = @TwelveMonthNumberDays, TwelveMonthSumCost = @TwelveMonthSumCost, TwelveMonthRealisedPnl = @TwelveMonthRealisedPnl, IsLast = @IsLast, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		@@ROWCOUNT > 0

GO
