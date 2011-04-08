USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountMovement_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountMovement_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountMovement_Delete]
		@PortfolioPositionAccountMovementID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioPositionAccountMovement_hst (
			PortfolioPositionAccountMovementID, PositionAccountMovementId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountMovementID, PositionAccountMovementId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PortfolioPositionAccountMovement
	WHERE	PortfolioPositionAccountMovementID = @PortfolioPositionAccountMovementID

	DELETE	PortfolioPositionAccountMovement
	WHERE	PortfolioPositionAccountMovementID = @PortfolioPositionAccountMovementID
	AND		DataVersion = @DataVersion
GO
