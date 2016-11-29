USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorExposure_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorExposure_Delete]
GO

CREATE PROCEDURE DBO.[FactorExposure_Delete]
		@FactorExposureId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FactorExposure_hst (
			FactorExposureId, FactorRelationshipId, ReferenceDate, FundId, InstrumentMarketId, RiskContribution, Risk, Exposure, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorExposureId, FactorRelationshipId, ReferenceDate, FundId, InstrumentMarketId, RiskContribution, Risk, Exposure, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId

	DELETE	FactorExposure
	WHERE	FactorExposureId = @FactorExposureId
	AND		DataVersion = @DataVersion
GO
