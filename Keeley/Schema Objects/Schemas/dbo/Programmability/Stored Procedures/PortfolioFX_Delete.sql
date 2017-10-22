USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioFX_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioFX_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioFX_Delete]
		@PortfolioFXId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioFX_hst (
			PortfolioFXId, PortfolioId, CurrencyId, FXRate, FXRateId, NotionalCost, TodayRealisedFXPNL, TodayUnRealisedFXPNL, TodayRealisedPricePNL, TodayUnRealisedPricePNL, TodayCashBenefit, MarketValue, Exposure, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioFXId, PortfolioId, CurrencyId, FXRate, FXRateId, NotionalCost, TodayRealisedFXPNL, TodayUnRealisedFXPNL, TodayRealisedPricePNL, TodayUnRealisedPricePNL, TodayCashBenefit, MarketValue, Exposure, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioFX
	WHERE	PortfolioFXId = @PortfolioFXId

	DELETE	PortfolioFX
	WHERE	PortfolioFXId = @PortfolioFXId
	AND		DataVersion = @DataVersion
GO
