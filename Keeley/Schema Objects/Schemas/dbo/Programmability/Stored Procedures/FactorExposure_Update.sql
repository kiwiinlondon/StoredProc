USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorExposure_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorExposure_Update]
GO

CREATE PROCEDURE DBO.[FactorExposure_Update]
		@FactorExposureId int, 
		@FactorRelationshipId int, 
		@FactorBenchmarkId int, 
		@ReferenceDate datetime, 
		@FundId int, 
		@InstrumentMarketId int, 
		@PortfolioVolatility numeric(16,4), 
		@BenchmarkVolatility numeric(16,4), 
		@TrackingError numeric(16,4), 
		@ActiveExposure numeric(16,4), 
		@MarginalX100 numeric(16,4), 
		@FactorVolatility numeric(16,4), 
		@TotalActiveVolatility numeric(16,4), 
		@VolatilityContribution numeric(16,4), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactorExposure_hst (
			FactorExposureId, FactorRelationshipId, FactorBenchmarkId, ReferenceDate, FundId, InstrumentMarketId, PortfolioVolatility, BenchmarkVolatility, TrackingError, ActiveExposure, MarginalX100, FactorVolatility, TotalActiveVolatility, VolatilityContribution, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorExposureId, FactorRelationshipId, FactorBenchmarkId, ReferenceDate, FundId, InstrumentMarketId, PortfolioVolatility, BenchmarkVolatility, TrackingError, ActiveExposure, MarginalX100, FactorVolatility, TotalActiveVolatility, VolatilityContribution, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId

	UPDATE	FactorExposure
	SET		FactorRelationshipId = @FactorRelationshipId, FactorBenchmarkId = @FactorBenchmarkId, ReferenceDate = @ReferenceDate, FundId = @FundId, InstrumentMarketId = @InstrumentMarketId, PortfolioVolatility = @PortfolioVolatility, BenchmarkVolatility = @BenchmarkVolatility, TrackingError = @TrackingError, ActiveExposure = @ActiveExposure, MarginalX100 = @MarginalX100, FactorVolatility = @FactorVolatility, TotalActiveVolatility = @TotalActiveVolatility, VolatilityContribution = @VolatilityContribution, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactorExposureId = @FactorExposureId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId
	AND		@@ROWCOUNT > 0

GO
