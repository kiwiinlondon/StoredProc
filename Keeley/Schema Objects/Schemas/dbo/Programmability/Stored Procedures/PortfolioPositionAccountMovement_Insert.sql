USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountMovement_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountMovement_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioPositionAccountMovement_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioPositionAccountMovement
			(PositionAccountMovementId, PositionAccountId, ReferenceDate, PortfolioAggregationLevelId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, NetPosition, UpdateUserID, StartDt)
	VALUES
			(@PositionAccountMovementId, @PositionAccountId, @ReferenceDate, @PortfolioAggregationLevelId, @ChangeNumber, @Quantity, @FXRate, @Price, @NetCostChangeInstrumentCurrency, @NetCostChangeBookCurrency, @NetCostInstrumentCurrency, @NetCostBookCurrency, @DeltaNetCostChangeInstrumentCurrency, @DeltaNetCostChangeBookCurrency, @DeltaNetCostInstrumentCurrency, @DeltaNetCostBookCurrency, @NetPosition, @UpdateUserID, @StartDt)

	SELECT	PortfolioPositionAccountMovementID, StartDt, DataVersion
	FROM	PortfolioPositionAccountMovement
	WHERE	PortfolioPositionAccountMovementID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
