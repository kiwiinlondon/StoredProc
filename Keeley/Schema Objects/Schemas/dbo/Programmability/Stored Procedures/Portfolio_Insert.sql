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
		@FMContViewLadderID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Portfolio
			(PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, Accrual, CashIncome, UpdateUserID, FMContViewLadderID, StartDt)
	VALUES
			(@PositionID, @ReferenceDate, @NetPosition, @UnitCost, @MarkPrice, @FXRate, @MarketValue, @DeltaEquityPosition, @RealisedFXPNL, @UnRealisedFXPNL, @RealisedPricePNL, @UnRealisedPricePNL, @Accrual, @CashIncome, @UpdateUserID, @FMContViewLadderID, @StartDt)

	SELECT	PortfolioID, StartDt, DataVersion
	FROM	Portfolio
	WHERE	PortfolioID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
