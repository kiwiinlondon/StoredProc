﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList_Update]
GO

CREATE PROCEDURE DBO.[FocusList_Update]
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
		@ExternalBrokerId int, 
		@AdjustedInPrice numeric(27,8), 
		@AdjustedOutPrice numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FocusList_hst (
			FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, IssuerId, ExternalBrokerId, AdjustedInPrice, AdjustedOutPrice, EndDt, LastActionUserID)
	SELECT	FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, IssuerId, ExternalBrokerId, AdjustedInPrice, AdjustedOutPrice, @StartDt, @UpdateUserID
	FROM	FocusList
	WHERE	FocusListId = @FocusListId

	UPDATE	FocusList
	SET		InstrumentMarketId = @InstrumentMarketId, AnalystId = @AnalystId, InDate = @InDate, InPrice = @InPrice, IsLong = @IsLong, OutDate = @OutDate, OutPrice = @OutPrice, CurrentPrice = @CurrentPrice, CurrentPriceId = @CurrentPriceId, UpdateUserID = @UpdateUserID, CurrentPriceDate = @CurrentPriceDate, EndOfYearPrice = @EndOfYearPrice, RelativeIndexInstrumentMarketId = @RelativeIndexInstrumentMarketId, RelativeInPrice = @RelativeInPrice, RelativeOutPrice = @RelativeOutPrice, RelativeEndOfYearPrice = @RelativeEndOfYearPrice, RelativeCurrentPrice = @RelativeCurrentPrice, RelativeCurrentPriceId = @RelativeCurrentPriceId, AdjustmentFactorITD = @AdjustmentFactorITD, AdjustmentFactorYTD = @AdjustmentFactorYTD, RelativeCurrentPriceDate = @RelativeCurrentPriceDate, IssuerId = @IssuerId, ExternalBrokerId = @ExternalBrokerId, AdjustedInPrice = @AdjustedInPrice, AdjustedOutPrice = @AdjustedOutPrice,  StartDt = @StartDt
	WHERE	FocusListId = @FocusListId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FocusList
	WHERE	FocusListId = @FocusListId
	AND		@@ROWCOUNT > 0

GO
