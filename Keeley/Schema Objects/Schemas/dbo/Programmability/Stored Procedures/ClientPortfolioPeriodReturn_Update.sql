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
		@ClientAccountId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@CurrentUnrealisedPnl numeric(27,8), 
		@ITDNumberDays int, 
		@ITDRealisedPnl numeric(27,8), 
		@TwelveMonthNumberDays int, 
		@TwelveMonthSumCost numeric(27,8), 
		@TwelveMonthRealisedPnl numeric(27,8), 
		@IsLast bit, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ITDSumCost numeric(27,8), 
		@UnrealisedPnlTwelveMonthsAgo numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioPeriodReturn_hst (
			ClientPortfolioPeriodReturnID, ClientAccountId, FundId, ReferenceDate, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, StartDt, UpdateUserID, DataVersion, ITDSumCost, UnrealisedPnlTwelveMonthsAgo, EndDt, LastActionUserID)
	SELECT	ClientPortfolioPeriodReturnID, ClientAccountId, FundId, ReferenceDate, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, StartDt, UpdateUserID, DataVersion, ITDSumCost, UnrealisedPnlTwelveMonthsAgo, @StartDt, @UpdateUserID
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID

	UPDATE	ClientPortfolioPeriodReturn
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ReferenceDate = @ReferenceDate, CurrentUnrealisedPnl = @CurrentUnrealisedPnl, ITDNumberDays = @ITDNumberDays, ITDRealisedPnl = @ITDRealisedPnl, TwelveMonthNumberDays = @TwelveMonthNumberDays, TwelveMonthSumCost = @TwelveMonthSumCost, TwelveMonthRealisedPnl = @TwelveMonthRealisedPnl, IsLast = @IsLast, UpdateUserID = @UpdateUserID, ITDSumCost = @ITDSumCost, UnrealisedPnlTwelveMonthsAgo = @UnrealisedPnlTwelveMonthsAgo,  StartDt = @StartDt
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = @ClientPortfolioPeriodReturnID
	AND		@@ROWCOUNT > 0

GO
