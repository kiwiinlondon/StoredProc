USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPerformance_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPerformance_Insert]
GO

CREATE PROCEDURE DBO.[FundPerformance_Insert]
		@FundId int, 
		@ValuationBusinessDate datetime, 
		@ValuationCalandarDate datetime, 
		@ValidUntil datetime, 
		@IsInception bit, 
		@FundPrice numeric(27,8), 
		@FundPriceId int, 
		@RiskFreeRate numeric(27,8), 
		@RiskFreeRatePriceId int, 
		@BenchmarkPrice numeric(27,8), 
		@BenchmarkPriceId int, 
		@BenchmarkFundFXRate numeric(27,8), 
		@BenchmarkFundFXRateId int, 
		@UpdateUserID int, 
		@BenchmarkPriceExistsOnDay bit, 
		@BenchmarkPriceValidUntil datetime, 
		@MaxFundPrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundPerformance
			(FundId, ValuationBusinessDate, ValuationCalandarDate, ValidUntil, IsInception, FundPrice, FundPriceId, RiskFreeRate, RiskFreeRatePriceId, BenchmarkPrice, BenchmarkPriceId, BenchmarkFundFXRate, BenchmarkFundFXRateId, UpdateUserID, BenchmarkPriceExistsOnDay, BenchmarkPriceValidUntil, MaxFundPrice, StartDt)
	VALUES
			(@FundId, @ValuationBusinessDate, @ValuationCalandarDate, @ValidUntil, @IsInception, @FundPrice, @FundPriceId, @RiskFreeRate, @RiskFreeRatePriceId, @BenchmarkPrice, @BenchmarkPriceId, @BenchmarkFundFXRate, @BenchmarkFundFXRateId, @UpdateUserID, @BenchmarkPriceExistsOnDay, @BenchmarkPriceValidUntil, @MaxFundPrice, @StartDt)

	SELECT	FundPerformanceId, StartDt, DataVersion
	FROM	FundPerformance
	WHERE	FundPerformanceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
