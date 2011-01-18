USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Update]
GO

CREATE PROCEDURE DBO.[Position_Update]
		@PositionID int, 
		@BookID int, 
		@StrategyID int, 
		@InstrumentMarketID int, 
		@TradeTypeID int, 
		@CurrencyID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Position_hst (
			PositionID, BookID, StrategyID, InstrumentMarketID, TradeTypeID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PositionID, BookID, StrategyID, InstrumentMarketID, TradeTypeID, CurrencyID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Position
	WHERE	PositionID = PositionID

	UPDATE	Position
	SET		BookID = @BookID, StrategyID = @StrategyID, InstrumentMarketID = @InstrumentMarketID, TradeTypeID = @TradeTypeID, CurrencyID = @CurrencyID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PositionID = @PositionID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Position
	WHERE	PositionID = @PositionID
	AND		@@ROWCOUNT > 0

GO
