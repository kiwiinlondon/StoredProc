USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioFX_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioFX_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioFX_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioFX
			(PortfolioId, CurrencyId, FXRate, FXRateId, NotionalCost, TodayRealisedFXPNL, TodayUnRealisedFXPNL, TodayRealisedPricePNL, TodayUnRealisedPricePNL, TodayCashBenefit, MarketValue, Exposure, UpdateUserID, StartDt)
	VALUES
			(@PortfolioId, @CurrencyId, @FXRate, @FXRateId, @NotionalCost, @TodayRealisedFXPNL, @TodayUnRealisedFXPNL, @TodayRealisedPricePNL, @TodayUnRealisedPricePNL, @TodayCashBenefit, @MarketValue, @Exposure, @UpdateUserID, @StartDt)

	SELECT	PortfolioFXId, StartDt, DataVersion
	FROM	PortfolioFX
	WHERE	PortfolioFXId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
