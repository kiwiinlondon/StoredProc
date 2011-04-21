USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionAccountMovement_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionAccountMovement_Delete]
GO

CREATE PROCEDURE DBO.[PositionAccountMovement_Delete]
		@PositionAccountMovementID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionAccountMovement_hst (
			PositionAccountMovementID, InternalAllocationId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, PositionAccountMovementTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionAccountMovementID, InternalAllocationId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, PositionAccountMovementTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PositionAccountMovement
	WHERE	PositionAccountMovementID = @PositionAccountMovementID

	DELETE	PositionAccountMovement
	WHERE	PositionAccountMovementID = @PositionAccountMovementID
	AND		DataVersion = @DataVersion
GO
