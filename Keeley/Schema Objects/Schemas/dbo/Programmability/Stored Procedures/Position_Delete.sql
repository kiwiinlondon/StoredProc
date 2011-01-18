USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Delete]
GO

CREATE PROCEDURE DBO.[Position_Delete]
		@PositionID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Position_hst (
			PositionID, BookID, StrategyID, InstrumentMarketID, TradeTypeID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionID, BookID, StrategyID, InstrumentMarketID, TradeTypeID, CurrencyID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Position
	WHERE	PositionID = PositionID

	DELETE	Position
	WHERE	PositionID = @PositionID
	AND		DataVersion = @DataVersion
GO
