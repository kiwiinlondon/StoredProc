USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Insert]
GO

CREATE PROCEDURE DBO.[Position_Insert]
		@BookID int, 
		@StrategyID int, 
		@InstrumentMarketID int, 
		@TradeTypeID int, 
		@CurrencyID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Position
			(BookID, StrategyID, InstrumentMarketID, TradeTypeID, CurrencyID, UpdateUserID, StartDt)
	VALUES
			(@BookID, @StrategyID, @InstrumentMarketID, @TradeTypeID, @CurrencyID, @UpdateUserID, @StartDt)

	SELECT	PositionID, StartDt, DataVersion
	FROM	Position
	WHERE	PositionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
