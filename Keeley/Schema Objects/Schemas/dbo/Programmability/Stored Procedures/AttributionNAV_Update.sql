USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionNav_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionNav_Update]
GO

CREATE PROCEDURE DBO.[AttributionNav_Update]
		@AttributionNavId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@AttributionSourceId int, 
		@OpeningNAV numeric(15,2), 
		@NAV numeric(15,2), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PercentageOfFund numeric(9,8), 
		@KeeleyIsMaster bit, 
		@CurrencyId int, 
		@TodayPNL numeric(15,2), 
		@KeeleyNav numeric(15,2), 
		@EURFXRateId int, 
		@EURFXRate numeric(27,8), 
		@USDFXRateId int, 
		@USDFXRate numeric(27,8), 
		@GBPFXRateId int, 
		@GBPFXRate numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionNav_hst (
			AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, EndDt, LastActionUserID)
	SELECT	AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, KeeleyNav, EURFXRateId, EURFXRate, USDFXRateId, USDFXRate, GBPFXRateId, GBPFXRate, @StartDt, @UpdateUserID
	FROM	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId

	UPDATE	AttributionNav
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, AttributionSourceId = @AttributionSourceId, OpeningNAV = @OpeningNAV, NAV = @NAV, UpdateUserID = @UpdateUserID, PercentageOfFund = @PercentageOfFund, KeeleyIsMaster = @KeeleyIsMaster, CurrencyId = @CurrencyId, TodayPNL = @TodayPNL, KeeleyNav = @KeeleyNav, EURFXRateId = @EURFXRateId, EURFXRate = @EURFXRate, USDFXRateId = @USDFXRateId, USDFXRate = @USDFXRate, GBPFXRateId = @GBPFXRateId, GBPFXRate = @GBPFXRate,  StartDt = @StartDt
	WHERE	AttributionNavId = @AttributionNavId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId
	AND		@@ROWCOUNT > 0

GO
