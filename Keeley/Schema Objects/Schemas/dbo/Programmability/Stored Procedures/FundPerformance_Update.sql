USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPerformance_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPerformance_Update]
GO

CREATE PROCEDURE DBO.[FundPerformance_Update]
		@FundPerformanceId int, 
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
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundPerformance_hst (
			FundPerformanceId, FundId, ValuationBusinessDate, ValuationCalandarDate, ValidUntil, IsInception, FundPrice, FundPriceId, RiskFreeRate, RiskFreeRatePriceId, BenchmarkPrice, BenchmarkPriceId, BenchmarkFundFXRate, BenchmarkFundFXRateId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPerformanceId, FundId, ValuationBusinessDate, ValuationCalandarDate, ValidUntil, IsInception, FundPrice, FundPriceId, RiskFreeRate, RiskFreeRatePriceId, BenchmarkPrice, BenchmarkPriceId, BenchmarkFundFXRate, BenchmarkFundFXRateId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundPerformance
	WHERE	FundPerformanceId = @FundPerformanceId

	UPDATE	FundPerformance
	SET		FundId = @FundId, ValuationBusinessDate = @ValuationBusinessDate, ValuationCalandarDate = @ValuationCalandarDate, ValidUntil = @ValidUntil, IsInception = @IsInception, FundPrice = @FundPrice, FundPriceId = @FundPriceId, RiskFreeRate = @RiskFreeRate, RiskFreeRatePriceId = @RiskFreeRatePriceId, BenchmarkPrice = @BenchmarkPrice, BenchmarkPriceId = @BenchmarkPriceId, BenchmarkFundFXRate = @BenchmarkFundFXRate, BenchmarkFundFXRateId = @BenchmarkFundFXRateId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundPerformanceId = @FundPerformanceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundPerformance
	WHERE	FundPerformanceId = @FundPerformanceId
	AND		@@ROWCOUNT > 0

GO
