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
		@ReferenceDate datetime, 
		@FundId int, 
		@InstrumentMarketId int, 
		@RiskContribution numeric(8,2), 
		@Risk numeric(9,2), 
		@Exposure numeric(28,2), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactorExposure
			(FactorRelationshipId, ReferenceDate, FundId, InstrumentMarketId, RiskContribution, Risk, Exposure, UpdateUserId, StartDt)
	VALUES
			(@FactorRelationshipId, @ReferenceDate, @FundId, @InstrumentMarketId, @RiskContribution, @Risk, @Exposure, @UpdateUserId, @StartDt)

	SELECT	FactorExposureId, StartDt, DataVersion
	FROM	FactorExposure
	WHERE	FactorExposureId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
