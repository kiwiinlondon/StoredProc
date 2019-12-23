USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEventFX_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEventFX_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioEventFX_Insert]
		@PortfolioEventId int, 
		@CurrencyId int, 
		@FromBookFXRate numeric(27,8), 
		@NotionalCost numeric(27,8), 
		@RealisedFXPNL numeric(27,8), 
		@TodayRealisedFXPNL numeric(27,8), 
		@TodayRealisedPricePNL numeric(27,8), 
		@TodayCashBenefit numeric(27,8), 
		@UpdateUserID int, 
		@FXRateId int, 
		@OriginalNotionalCost numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioEventFX
			(PortfolioEventId, CurrencyId, FromBookFXRate, NotionalCost, RealisedFXPNL, TodayRealisedFXPNL, TodayRealisedPricePNL, TodayCashBenefit, UpdateUserID, FXRateId, OriginalNotionalCost, StartDt)
	VALUES
			(@PortfolioEventId, @CurrencyId, @FromBookFXRate, @NotionalCost, @RealisedFXPNL, @TodayRealisedFXPNL, @TodayRealisedPricePNL, @TodayCashBenefit, @UpdateUserID, @FXRateId, @OriginalNotionalCost, @StartDt)

	SELECT	PortfolioEventFXId, StartDt, DataVersion
	FROM	PortfolioEventFX
	WHERE	PortfolioEventFXId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
