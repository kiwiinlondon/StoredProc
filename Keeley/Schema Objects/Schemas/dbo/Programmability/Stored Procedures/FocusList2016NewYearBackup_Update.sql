﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList2016NewYearBackup_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList2016NewYearBackup_Update]
GO

CREATE PROCEDURE DBO.[FocusList2016NewYearBackup_Update]
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
		@RelativeCurrentPriceDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FocusList2016NewYearBackup_hst (
			FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, EndDt, LastActionUserID)
	SELECT	FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, @StartDt, @UpdateUserID
	FROM	FocusList2016NewYearBackup
	WHERE	 = @

	UPDATE	FocusList2016NewYearBackup
	SET		FocusListId = @FocusListId, InstrumentMarketId = @InstrumentMarketId, AnalystId = @AnalystId, InDate = @InDate, InPrice = @InPrice, IsLong = @IsLong, OutDate = @OutDate, OutPrice = @OutPrice, CurrentPrice = @CurrentPrice, CurrentPriceId = @CurrentPriceId, UpdateUserID = @UpdateUserID, CurrentPriceDate = @CurrentPriceDate, EndOfYearPrice = @EndOfYearPrice, RelativeIndexInstrumentMarketId = @RelativeIndexInstrumentMarketId, RelativeInPrice = @RelativeInPrice, RelativeOutPrice = @RelativeOutPrice, RelativeEndOfYearPrice = @RelativeEndOfYearPrice, RelativeCurrentPrice = @RelativeCurrentPrice, RelativeCurrentPriceId = @RelativeCurrentPriceId, AdjustmentFactorITD = @AdjustmentFactorITD, AdjustmentFactorYTD = @AdjustmentFactorYTD, RelativeCurrentPriceDate = @RelativeCurrentPriceDate,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FocusList2016NewYearBackup
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO