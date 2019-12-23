USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList2014_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList2014_Insert]
GO

CREATE PROCEDURE DBO.[FocusList2014_Insert]
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
		@AdjustmentFactorITD numeric(27,8), 
		@AdjustmentFactorYTD numeric(27,8), 
		@RelativeCurrentPriceDate datetime, 
		@IssuerId int, 
		@ExternalBrokerId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FocusList2014
			(InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, UpdateUserID, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, IssuerId, ExternalBrokerId, StartDt)
	VALUES
			(@InstrumentMarketId, @AnalystId, @InDate, @InPrice, @IsLong, @OutDate, @OutPrice, @CurrentPrice, @CurrentPriceId, @UpdateUserID, @CurrentPriceDate, @EndOfYearPrice, @RelativeIndexInstrumentMarketId, @RelativeInPrice, @RelativeOutPrice, @RelativeEndOfYearPrice, @RelativeCurrentPrice, @RelativeCurrentPriceId, @AdjustmentFactorITD, @AdjustmentFactorYTD, @RelativeCurrentPriceDate, @IssuerId, @ExternalBrokerId, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	FocusList2014
	WHERE	 = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
