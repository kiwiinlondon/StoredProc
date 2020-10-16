USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventFX_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventFX_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioEventFX_Delete]
		@PortfolioEventFXId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioEventFX_hst (
			PortfolioEventFXId, PortfolioEventId, CurrencyId, FromBookFXRate, NotionalCost, RealisedFXPNL, TodayRealisedFXPNL, TodayRealisedPricePNL, TodayCashBenefit, StartDt, UpdateUserID, DataVersion, FXRateId, OriginalNotionalCost, TodayCapitalChange, CapitalChange, EndDt, LastActionUserID)
	SELECT	PortfolioEventFXId, PortfolioEventId, CurrencyId, FromBookFXRate, NotionalCost, RealisedFXPNL, TodayRealisedFXPNL, TodayRealisedPricePNL, TodayCashBenefit, StartDt, UpdateUserID, DataVersion, FXRateId, OriginalNotionalCost, TodayCapitalChange, CapitalChange, @EndDt, @UpdateUserID
	FROM	PortfolioEventFX
	WHERE	PortfolioEventFXId = @PortfolioEventFXId

	DELETE	PortfolioEventFX
	WHERE	PortfolioEventFXId = @PortfolioEventFXId
	AND		DataVersion = @DataVersion
GO
