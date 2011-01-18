USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Insert]
GO

CREATE PROCEDURE DBO.[Portfolio_Insert]
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
		@FMContViewLadderID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Portfolio
			(PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, RealisedTotalPNL, UnRealisedTotalPNL, Accrual, CashIncome, UpdateUserID, FMContViewLadderID, StartDt)
	VALUES
			(@PositionID, @ReferenceDate, @NetPosition, @UnitCost, @MarkPrice, @FXRate, @MarketValue, @DeltaEquityPosition, @RealisedFXPNL, @UnRealisedFXPNL, @RealisedPricePNL, @UnRealisedPricePNL, @RealisedTotalPNL, @UnRealisedTotalPNL, @Accrual, @CashIncome, @UpdateUserID, @FMContViewLadderID, @StartDt)

	SELECT	PortfolioID, StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
