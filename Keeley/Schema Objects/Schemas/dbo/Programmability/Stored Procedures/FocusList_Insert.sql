USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList_Insert]
GO

CREATE PROCEDURE DBO.[FocusList_Insert]
		@InstrumentMarketId int, 
		@AnalystId int, 
		@InDate datetime, 
		@InPrice numeric(27,8), 
		@IsLong bit, 
		@OutDate datetime, 
		@OutPrice numeric(27,8), 
		@CurrentPrice numeric(27,8), 
		@CurrentPriceId int, 
		@UpdateUserID int, 
		@CurrentPriceDate datetime, 
		@EndOfYearPrice numeric(27,8), 
		@RelativeIndexInstrumentMarketId int, 
		@RelativeInPrice numeric(27,8), 
		@RelativeOutPrice numeric(27,8), 
		@RelativeEndOfYearPrice numeric(27,8), 
		@RelativeCurrentPrice numeric(27,8), 
		@RelativeCurrentPriceId int, 
		@AdjustmentFactorITD numeric(27,8) = null, 
		@AdjustmentFactorYTD numeric(27,8)= null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FocusList
			(InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, UpdateUserID, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, StartDt)
	VALUES
			(@InstrumentMarketId, @AnalystId, @InDate, @InPrice, @IsLong, @OutDate, @OutPrice, @CurrentPrice, @CurrentPriceId, @UpdateUserID, @CurrentPriceDate, @EndOfYearPrice, @RelativeIndexInstrumentMarketId, @RelativeInPrice, @RelativeOutPrice, @RelativeEndOfYearPrice, @RelativeCurrentPrice, @RelativeCurrentPriceId, @AdjustmentFactorITD, @AdjustmentFactorYTD, @StartDt)

	SELECT	FocusListId, StartDt, DataVersion
	FROM	FocusList
	WHERE	FocusListId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
