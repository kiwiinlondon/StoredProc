USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioSettlementDate_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioSettlementDate_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioSettlementDate_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioSettlementDate
			(PositionId, ReferenceDate, NetPosition, NetCostInstrumentCurrency, NetCostBookCurrency, DeltaNetCostInstrumentCurrency, DeltaNetCostBookCurrency, TodayNetPostionChange, TodayDeltaNetCostChangeInstrumentCurrency, TodayDeltaNetCostChangeBookCurrency, TodayNetCostChangeInstrumentCurrency, TodayNetCostChangeBookCurrency, UpdateUserID, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @NetPosition, @NetCostInstrumentCurrency, @NetCostBookCurrency, @DeltaNetCostInstrumentCurrency, @DeltaNetCostBookCurrency, @TodayNetPostionChange, @TodayDeltaNetCostChangeInstrumentCurrency, @TodayDeltaNetCostChangeBookCurrency, @TodayNetCostChangeInstrumentCurrency, @TodayNetCostChangeBookCurrency, @UpdateUserID, @StartDt)

	SELECT	PortfolioSettlementDateId, StartDt, DataVersion
	FROM	PortfolioSettlementDate
	WHERE	PortfolioSettlementDateId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
