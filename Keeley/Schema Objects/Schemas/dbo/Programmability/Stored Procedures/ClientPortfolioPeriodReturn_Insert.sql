USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioPeriodReturn_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioPeriodReturn_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolioPeriodReturn_Insert]
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
		@ITDSumCost numeric(27,8), 
		@UnrealisedPnlTwelveMonthsAgo numeric(27,8), 
		@FirstTradeDate datetime, 
		@TwelveMonthsAgo datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioPeriodReturn
			(ClientAccountId, FundId, ReferenceDate, CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, ITDSumCost, UnrealisedPnlTwelveMonthsAgo, FirstTradeDate, TwelveMonthsAgo, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ReferenceDate, @CurrentUnrealisedPnl, @ITDNumberDays, @ITDRealisedPnl, @TwelveMonthNumberDays, @TwelveMonthSumCost, @TwelveMonthRealisedPnl, @IsLast, @UpdateUserID, @ITDSumCost, @UnrealisedPnlTwelveMonthsAgo, @FirstTradeDate, @TwelveMonthsAgo, @StartDt)

	SELECT	ClientPortfolioPeriodReturnID, StartDt, DataVersion
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
