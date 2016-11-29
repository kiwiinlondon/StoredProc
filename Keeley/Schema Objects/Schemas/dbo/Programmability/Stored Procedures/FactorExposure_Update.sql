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
		@ReferenceDate datetime, 
		@FundId int, 
		@InstrumentMarketId int, 
		@RiskContribution numeric(8,2), 
		@Risk numeric(9,2), 
		@Exposure numeric(28,2), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactorExposure_hst (
			FactorExposureId, FactorRelationshipId, ReferenceDate, FundId, InstrumentMarketId, RiskContribution, Risk, Exposure, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorExposureId, FactorRelationshipId, ReferenceDate, FundId, InstrumentMarketId, RiskContribution, Risk, Exposure, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId

	UPDATE	FactorExposure
	SET		FactorRelationshipId = @FactorRelationshipId, ReferenceDate = @ReferenceDate, FundId = @FundId, InstrumentMarketId = @InstrumentMarketId, RiskContribution = @RiskContribution, Risk = @Risk, Exposure = @Exposure, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactorExposureId = @FactorExposureId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId
	AND		@@ROWCOUNT > 0

GO
