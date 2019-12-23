USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionNav_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionNav_Delete]
GO

CREATE PROCEDURE DBO.[AttributionNav_Delete]
		@AttributionNavId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionNav_hst (
			AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, EndDt, LastActionUserID)
	SELECT	AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, @EndDt, @UpdateUserID
	FROM	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId

	DELETE	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId
	AND		DataVersion = @DataVersion
GO
