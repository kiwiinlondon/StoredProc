USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventFX_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventFX_Update]
GO

CREATE PROCEDURE DBO.[PortfolioEventFX_Update]
		@PortfolioEventFXId int, 
		@PortfolioEventId int, 
		@CurrencyId int, 
		@FromBookFXRate numeric(27,8), 
		@NotionalCost numeric(27,8), 
		@RealisedFXPNL numeric(27,8), 
		@TodayRealisedFXPNL numeric(27,8), 
		@TodayRealisedPricePNL numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioEventFX_hst (
			PortfolioEventFXId, PortfolioEventId, CurrencyId, FromBookFXRate, NotionalCost, RealisedFXPNL, TodayRealisedFXPNL, TodayRealisedPricePNL, TodayCashBenefit, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioEventFXId, PortfolioEventId, CurrencyId, FromBookFXRate, NotionalCost, RealisedFXPNL, TodayRealisedFXPNL, TodayRealisedPricePNL, TodayCashBenefit, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioEventFX
	WHERE	PortfolioEventFXId = @PortfolioEventFXId

	UPDATE	PortfolioEventFX
	SET		PortfolioEventId = @PortfolioEventId, CurrencyId = @CurrencyId, FromBookFXRate = @FromBookFXRate, NotionalCost = @NotionalCost, RealisedFXPNL = @RealisedFXPNL, TodayRealisedFXPNL = @TodayRealisedFXPNL, TodayRealisedPricePNL = @TodayRealisedPricePNL, TodayCashBenefit = @TodayCashBenefit, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioEventFXId = @PortfolioEventFXId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioEventFX
	WHERE	PortfolioEventFXId = @PortfolioEventFXId
	AND		@@ROWCOUNT > 0

GO
