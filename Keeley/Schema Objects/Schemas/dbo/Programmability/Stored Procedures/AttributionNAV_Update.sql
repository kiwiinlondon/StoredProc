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
		@TodayPNL numeric(15,2)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionNav_hst (
			AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, EndDt, LastActionUserID)
	SELECT	AttributionNavId, FundId, ReferenceDate, AttributionSourceId, OpeningNAV, NAV, StartDt, UpdateUserID, DataVersion, PercentageOfFund, KeeleyIsMaster, CurrencyId, TodayPNL, @StartDt, @UpdateUserID
	FROM	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId

	UPDATE	AttributionNav
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, AttributionSourceId = @AttributionSourceId, OpeningNAV = @OpeningNAV, NAV = @NAV, UpdateUserID = @UpdateUserID, PercentageOfFund = @PercentageOfFund, KeeleyIsMaster = @KeeleyIsMaster, CurrencyId = @CurrencyId, TodayPNL = @TodayPNL,  StartDt = @StartDt
	WHERE	AttributionNavId = @AttributionNavId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionNav
	WHERE	AttributionNavId = @AttributionNavId
	AND		@@ROWCOUNT > 0

GO
