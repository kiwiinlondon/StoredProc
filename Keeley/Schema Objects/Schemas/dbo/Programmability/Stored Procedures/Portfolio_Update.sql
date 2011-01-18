USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Update]
GO

CREATE PROCEDURE DBO.[Portfolio_Update]
		@PortfolioID int, 
		@PositionID int, 
		@ReferenceDate datetime, 
		@NetPosition numeric, 
		@UnitCost numeric, 
		@MarkPrice numeric, 
		@FXRate numeric, 
		@MarketValue numeric, 
		@DeltaEquityPosition numeric, 
		@RealisedFXPNL numeric, 
		@UnRealisedFXPNL numeric, 
		@RealisedPricePNL numeric, 
		@UnRealisedPricePNL numeric, 
		@RealisedTotalPNL numeric, 
		@UnRealisedTotalPNL numeric, 
		@Accrual numeric, 
		@CashIncome numeric, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FMContViewLadderID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, RealisedTotalPNL, UnRealisedTotalPNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, EndDt, LastActionUserID)
	SELECT	PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, RealisedTotalPNL, UnRealisedTotalPNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, @StartDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioID = PortfolioID

	UPDATE	Portfolio
	SET		PositionID = @PositionID, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, UnitCost = @UnitCost, MarkPrice = @MarkPrice, FXRate = @FXRate, MarketValue = @MarketValue, DeltaEquityPosition = @DeltaEquityPosition, RealisedFXPNL = @RealisedFXPNL, UnRealisedFXPNL = @UnRealisedFXPNL, RealisedPricePNL = @RealisedPricePNL, UnRealisedPricePNL = @UnRealisedPricePNL, RealisedTotalPNL = @RealisedTotalPNL, UnRealisedTotalPNL = @UnRealisedTotalPNL, Accrual = @Accrual, CashIncome = @CashIncome, UpdateUserID = @UpdateUserID, FMContViewLadderID = @FMContViewLadderID,  StartDt = @StartDt
	WHERE	PortfolioID = @PortfolioID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioID = @PortfolioID
	AND		@@ROWCOUNT > 0

GO
