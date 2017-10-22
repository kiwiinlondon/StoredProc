USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioFX_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioFX_Update]
GO

CREATE PROCEDURE DBO.[PortfolioFX_Update]
		@PortfolioFXId int, 
		@PortfolioId int, 
		@CurrencyId int, 
		@FXRate numeric(27,8), 
		@FXRateId int, 
		@NotionalCost numeric(27,8), 
		@TodayRealisedFXPNL numeric(27,8), 
		@TodayUnRealisedFXPNL numeric(27,8), 
		@TodayRealisedPricePNL numeric(27,8), 
		@TodayUnRealisedPricePNL numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@MarketValue numeric(27,8), 
		@Exposure numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioFX_hst (
			PortfolioFXId, PortfolioId, CurrencyId, FXRate, FXRateId, NotionalCost, TodayRealisedFXPNL, TodayUnRealisedFXPNL, TodayRealisedPricePNL, TodayUnRealisedPricePNL, TodayCashBenefit, MarketValue, Exposure, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioFXId, PortfolioId, CurrencyId, FXRate, FXRateId, NotionalCost, TodayRealisedFXPNL, TodayUnRealisedFXPNL, TodayRealisedPricePNL, TodayUnRealisedPricePNL, TodayCashBenefit, MarketValue, Exposure, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioFX
	WHERE	PortfolioFXId = @PortfolioFXId

	UPDATE	PortfolioFX
	SET		PortfolioId = @PortfolioId, CurrencyId = @CurrencyId, FXRate = @FXRate, FXRateId = @FXRateId, NotionalCost = @NotionalCost, TodayRealisedFXPNL = @TodayRealisedFXPNL, TodayUnRealisedFXPNL = @TodayUnRealisedFXPNL, TodayRealisedPricePNL = @TodayRealisedPricePNL, TodayUnRealisedPricePNL = @TodayUnRealisedPricePNL, TodayCashBenefit = @TodayCashBenefit, MarketValue = @MarketValue, Exposure = @Exposure, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioFXId = @PortfolioFXId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioFX
	WHERE	PortfolioFXId = @PortfolioFXId
	AND		@@ROWCOUNT > 0

GO
