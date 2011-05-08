USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioOld_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioOld_Update]
GO

CREATE PROCEDURE DBO.[PortfolioOld_Update]
		@PortfolioID int, 
		@PositionID int, 
		@ReferenceDate datetime, 
		@NetPosition numeric(27,8), 
		@UnitCost numeric(35,16), 
		@MarkPrice numeric(35,16), 
		@FXRate numeric(35,16), 
		@MarketValue numeric(27,8), 
		@DeltaEquityPosition numeric(27,8), 
		@RealisedFXPNL numeric(27,8), 
		@UnRealisedFXPNL numeric(27,8), 
		@RealisedPricePNL numeric(27,8), 
		@UnRealisedPricePNL numeric(27,8), 
		@Accrual numeric(27,8), 
		@CashIncome numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FMContViewLadderID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioOld_hst (
			PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, EndDt, LastActionUserID)
	SELECT	PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, @StartDt, @UpdateUserID
	FROM	PortfolioOld
	WHERE	PortfolioID = @PortfolioID

	UPDATE	PortfolioOld
	SET		PositionID = @PositionID, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, UnitCost = @UnitCost, MarkPrice = @MarkPrice, FXRate = @FXRate, MarketValue = @MarketValue, DeltaEquityPosition = @DeltaEquityPosition, RealisedFXPNL = @RealisedFXPNL, UnRealisedFXPNL = @UnRealisedFXPNL, RealisedPricePNL = @RealisedPricePNL, UnRealisedPricePNL = @UnRealisedPricePNL, Accrual = @Accrual, CashIncome = @CashIncome, UpdateUserID = @UpdateUserID, FMContViewLadderID = @FMContViewLadderID,  StartDt = @StartDt
	WHERE	PortfolioID = @PortfolioID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioOld
	WHERE	PortfolioID = @PortfolioID
	AND		@@ROWCOUNT > 0

GO
