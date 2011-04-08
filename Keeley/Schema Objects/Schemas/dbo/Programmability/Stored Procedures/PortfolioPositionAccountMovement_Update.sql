USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountMovement_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountMovement_Update]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountMovement_Update]
		@PortfolioPositionAccountMovementID int, 
		@PositionAccountMovementId int, 
		@PositionAccountId int, 
		@ReferenceDate datetime, 
		@PortfolioAggregationLevelId int, 
		@ChangeNumber int, 
		@Quantity numeric(27,8), 
		@FXRate numeric(35,16), 
		@Price numeric(35,16), 
		@NetCostChangeInstrumentCurrency numeric(27,8), 
		@NetCostChangeBookCurrency numeric(27,8), 
		@NetCostInstrumentCurrency numeric(27,8), 
		@NetCostBookCurrency numeric(27,8), 
		@DeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@DeltaNetCostChangeBookCurrency numeric(27,8), 
		@DeltaNetCostInstrumentCurrency numeric(27,8), 
		@DeltaNetCostBookCurrency numeric(27,8), 
		@NetPosition numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioPositionAccountMovement_hst (
			PortfolioPositionAccountMovementID, PositionAccountMovementId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioPositionAccountMovementID, PositionAccountMovementId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioPositionAccountMovement
	WHERE	PortfolioPositionAccountMovementID = @PortfolioPositionAccountMovementID

	UPDATE	PortfolioPositionAccountMovement
	SET		PositionAccountMovementId = @PositionAccountMovementId, PositionAccountId = @PositionAccountId, ReferenceDate = @ReferenceDate, PortfolioAggregationLevelId = @PortfolioAggregationLevelId, ChangeNumber = @ChangeNumber, Quantity = @Quantity, FXRate = @FXRate, Price = @Price, NetCostChangeInstrumentCurrency = @NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency = @NetCostChangeBookCurrency, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency = @DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency = @DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, NetPosition = @NetPosition, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioPositionAccountMovementID = @PortfolioPositionAccountMovementID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioPositionAccountMovement
	WHERE	PortfolioPositionAccountMovementID = @PortfolioPositionAccountMovementID
	AND		@@ROWCOUNT > 0

GO
