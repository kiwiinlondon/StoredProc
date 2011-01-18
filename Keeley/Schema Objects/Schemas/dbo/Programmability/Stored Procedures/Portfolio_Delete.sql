USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Portfolio_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Portfolio_Delete]
GO

CREATE PROCEDURE DBO.[Portfolio_Delete]
		@PortfolioID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Portfolio_hst (
			PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, RealisedTotalPNL, UnRealisedTotalPNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, EndDt, LastActionUserID)
	SELECT	PortfolioID, PositionID, ReferenceDate, NetPosition, UnitCost, MarkPrice, FXRate, MarketValue, DeltaEquityPosition, RealisedFXPNL, UnRealisedFXPNL, RealisedPricePNL, UnRealisedPricePNL, RealisedTotalPNL, UnRealisedTotalPNL, Accrual, CashIncome, StartDt, UpdateUserID, DataVersion, FMContViewLadderID, @EndDt, @UpdateUserID
	FROM	Portfolio
	WHERE	PortfolioID = @PortfolioID

	DELETE	Portfolio
	WHERE	PortfolioID = @PortfolioID
	AND		DataVersion = @DataVersion
GO
