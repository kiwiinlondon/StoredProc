USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorExposure_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorExposure_Insert]
GO

CREATE PROCEDURE DBO.[FactorExposure_Insert]
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
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactorExposure
			(FactorRelationshipId, FactorBenchmarkId, ReferenceDate, FundId, InstrumentMarketId, PortfolioVolatility, BenchmarkVolatility, TrackingError, ActiveExposure, MarginalX100, FactorVolatility, TotalActiveVolatility, VolatilityContribution, UpdateUserId, StartDt)
	VALUES
			(@FactorRelationshipId, @FactorBenchmarkId, @ReferenceDate, @FundId, @InstrumentMarketId, @PortfolioVolatility, @BenchmarkVolatility, @TrackingError, @ActiveExposure, @MarginalX100, @FactorVolatility, @TotalActiveVolatility, @VolatilityContribution, @UpdateUserId, @StartDt)

	SELECT	FactorExposureId, StartDt, DataVersion
	FROM	FactorExposure
	WHERE	FactorExposureId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
