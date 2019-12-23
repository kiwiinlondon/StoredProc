USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioSettlementDate_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioSettlementDate_Update]
GO

CREATE PROCEDURE DBO.[PortfolioSettlementDate_Update]
		@PortfolioSettlementDateId int, 
		@PositionId int, 
		@ReferenceDate datetime, 
		@NetPosition numeric(27,8), 
		@NetCostInstrumentCurrency numeric(27,8), 
		@NetCostBookCurrency numeric(27,8), 
		@DeltaNetCostInstrumentCurrency numeric(27,8), 
		@DeltaNetCostBookCurrency numeric(27,8), 
		@TodayNetPostionChange numeric(27,8), 
		@TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayDeltaNetCostChangeBookCurrency numeric(27,8), 
		@TodayNetCostChangeInstrumentCurrency numeric(27,8), 
		@TodayNetCostChangeBookCurrency numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioSettlementDate_hst (
			PortfolioSettlementDateId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PortfolioSettlementDateId, PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PortfolioSettlementDate
	WHERE	PortfolioSettlementDateId = @PortfolioSettlementDateId

	UPDATE	PortfolioSettlementDate
	SET		PositionId = @PositionId, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, NetCostInstrumentCurrency = @NetCostInstrumentCurrency, NetCostBookCurrency = @NetCostBookCurrency, DeltaNetCostInstrumentCurrency = @DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency = @DeltaNetCostBookCurrency, TodayNetPostionChange = @TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency = @TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency = @TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency = @TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency = @TodayNetCostChangeBookCurrency, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PortfolioSettlementDateId = @PortfolioSettlementDateId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioSettlementDate
	WHERE	PortfolioSettlementDateId = @PortfolioSettlementDateId
	AND		@@ROWCOUNT > 0

GO
