USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attributionnav2_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attributionnav2_Delete]
GO

CREATE PROCEDURE DBO.[Attributionnav2_Delete]
		@AttributionNavId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Attributionnav2_hst (
			AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, Updated, EndDt, LastActionUserID)
	SELECT	AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, Updated, @EndDt, @UpdateUserID
	FROM	Attributionnav2
	WHERE	AttributionNavId = @AttributionNavId

	DELETE	Attributionnav2
	WHERE	AttributionNavId = @AttributionNavId
	AND		DataVersion = @DataVersion
GO
