USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FocusList_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FocusList_Delete]
GO

CREATE PROCEDURE DBO.[FocusList_Delete]
		@FocusListId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FocusList_hst (
			FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, EndDt, LastActionUserID)
	SELECT	FocusListId, InstrumentMarketId, AnalystId, InDate, InPrice, IsLong, OutDate, OutPrice, CurrentPrice, CurrentPriceId, StartDt, UpdateUserID, DataVersion, CurrentPriceDate, EndOfYearPrice, RelativeIndexInstrumentMarketId, RelativeInPrice, RelativeOutPrice, RelativeEndOfYearPrice, RelativeCurrentPrice, RelativeCurrentPriceId, AdjustmentFactorITD, AdjustmentFactorYTD, RelativeCurrentPriceDate, @EndDt, @UpdateUserID
	FROM	FocusList
	WHERE	FocusListId = @FocusListId

	DELETE	FocusList
	WHERE	FocusListId = @FocusListId
	AND		DataVersion = @DataVersion
GO
