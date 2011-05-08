USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioEvent_Update]
GO

CREATE PROCEDURE DBO.[PortfolioEvent_Update]
		@PortfolioEventID int, 
		@InternalAllocationId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@PortfolioAggregationLevelId int, 
		@PortfolioEventTypeId int, 
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
		@TodayNetPositionChange numeric(27,8), 
		@TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@TodayNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayNetCostChangeBookCurrency numeric(27,8), 
		@NetPosition numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioEvent_hst (
			PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioEventID, InternalAllocationId, PositionId, ReferenceDate, PortfolioAggregationLevelId, PortfolioEventTypeId, ChangeNumber, Quantity, FXRate, Price, NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, NetPosition, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID

	UPDATE	PortfolioEvent
	SET		InternalAllocationId = @InternalAllocationId, PositionId = @PositionId, ReferenceDate = @ReferenceDate, PortfolioAggregationLevelId = @PortfolioAggregationLevelId, PortfolioEventTypeId = @PortfolioEventTypeId, ChangeNumber = @ChangeNumber, Quantity = @Quantity, FXRate = @FXRate, Price = @Price, NetCostChangeInstrumentCurrency = @NetCostChangeInstrumentCurrency, NetCostChangeBookCurrency = @NetCostChangeBookCurrency, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostChangeInstrumentCurrency = @DeltaNetCostChangeInstrumentCurrency, DeltaNetCostChangeBookCurrency = @DeltaNetCostChangeBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPositionChange = @TodayNetPositionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, NetPosition = @NetPosition, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioEventID = @PortfolioEventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioEvent
	WHERE	PortfolioEventID = @PortfolioEventID
	AND		@@ROWCOUNT > 0

GO
