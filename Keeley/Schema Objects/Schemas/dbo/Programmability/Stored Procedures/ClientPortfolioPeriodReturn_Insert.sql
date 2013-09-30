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
		@CurrentUnrealisedPnl numeric(27,8), 
		@ITDNumberDays int, 
		@ITDRealisedPnl numeric(27,8), 
		@TwelveMonthNumberDays int, 
		@TwelveMonthSumCost numeric(27,8), 
		@TwelveMonthRealisedPnl numeric(27,8), 
		@IsLast bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioPeriodReturn
			(CurrentUnrealisedPnl, ITDNumberDays, ITDRealisedPnl, TwelveMonthNumberDays, TwelveMonthSumCost, TwelveMonthRealisedPnl, IsLast, UpdateUserID, StartDt)
	VALUES
			(@CurrentUnrealisedPnl, @ITDNumberDays, @ITDRealisedPnl, @TwelveMonthNumberDays, @TwelveMonthSumCost, @TwelveMonthRealisedPnl, @IsLast, @UpdateUserID, @StartDt)

	SELECT	ClientPortfolioPeriodReturnID, StartDt, DataVersion
	FROM	ClientPortfolioPeriodReturn
	WHERE	ClientPortfolioPeriodReturnID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
