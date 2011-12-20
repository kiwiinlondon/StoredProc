USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPerformance_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPerformance_Delete]
GO

CREATE PROCEDURE DBO.[FundPerformance_Delete]
		@FundPerformanceId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundPerformance_hst (
			FundPerformanceId, FundId, ValuationBusinessDate, ValuationCalandarDate, ValidUntil, IsInception, FundPrice, FundPriceId, RiskFreeRate, RiskFreeRatePriceId, BenchmarkPrice, BenchmarkPriceId, BenchmarkFundFXRate, BenchmarkFundFXRateId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundPerformanceId, FundId, ValuationBusinessDate, ValuationCalandarDate, ValidUntil, IsInception, FundPrice, FundPriceId, RiskFreeRate, RiskFreeRatePriceId, BenchmarkPrice, BenchmarkPriceId, BenchmarkFundFXRate, BenchmarkFundFXRateId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundPerformance
	WHERE	FundPerformanceId = @FundPerformanceId

	DELETE	FundPerformance
	WHERE	FundPerformanceId = @FundPerformanceId
	AND		DataVersion = @DataVersion
GO
