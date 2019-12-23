USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList2014_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList2014_Update]
GO

CREATE PROCEDURE DBO.[FocusList2014_Update]
		@FocusListId int, 
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
		@DataVersion rowversion, 
		@CurrentPriceDate datetime, 
		@EndOfYearPrice numeric(27,8), 
		@RelativeIndexInstrumentMarketId int, 
		@RelativeInPrice numeric(27,8), 
		@RelativeOutPrice numeric(27,8), 
		@RelativeEndOfYearPrice numeric(27,8), 
		@RelativeCurrentPrice numeric(27,8), 
		@RelativeCurrentPriceId int, 
		@AdjustmentFactorITD numeric(27,8), 
		@AdjustmentFactorYTD numeric(27,8), 
		@RelativeCurrentPriceDate datetime, 
		@IssuerId int, 
		@ExternalBrokerId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FocusList2014_hst (
			FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, IssuerId, ExternalBrokerId, EndDt, LastActionUserID)
	SELECT	FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, IssuerId, ExternalBrokerId, @StartDt, @UpdateUserID
	FROM	FocusList2014
	WHERE	 = @

	UPDATE	FocusList2014
	SET		FocusListId = @FocusListId, InstrumentMarketId = @InstrumentMarketId, AnalystId = @AnalystId, InDate = @InDate, InPrice = @InPrice, IsLong = @IsLong, OutDate = @OutDate, OutPrice = @OutPrice, CurrentPrice = @CurrentPrice, CurrentPriceId = @CurrentPriceId, UpdateUserID = @UpdateUserID, CurrentPriceDate = @CurrentPriceDate, EndOfYearPrice = @EndOfYearPrice, RelativeIndexInstrumentMarketId = @RelativeIndexInstrumentMarketId, RelativeInPrice = @RelativeInPrice, RelativeOutPrice = @RelativeOutPrice, RelativeEndOfYearPrice = @RelativeEndOfYearPrice, RelativeCurrentPrice = @RelativeCurrentPrice, RelativeCurrentPriceId = @RelativeCurrentPriceId, AdjustmentFactorITD = @AdjustmentFactorITD, AdjustmentFactorYTD = @AdjustmentFactorYTD, RelativeCurrentPriceDate = @RelativeCurrentPriceDate, IssuerId = @IssuerId, ExternalBrokerId = @ExternalBrokerId,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FocusList2014
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
