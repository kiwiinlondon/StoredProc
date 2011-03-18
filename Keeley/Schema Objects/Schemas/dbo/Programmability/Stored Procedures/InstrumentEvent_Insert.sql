USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEvent_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEvent_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentEvent_Insert]
		@EventID int, 
		@InstrumentMarketID int, 
		@InstrumentEventTypeID int, 
		@EventDate datetime, 
		@ValueDate datetime, 
		@Quantity numeric(27,8), 
		@Price numeric(35,16), 
		@FXRate numeric(35,16), 
		@CurrencyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentEvent
			(EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, Price, FXRate, CurrencyId, UpdateUserID, StartDt)
	VALUES
			(@EventID, @InstrumentMarketID, @InstrumentEventTypeID, @EventDate, @ValueDate, @Quantity, @Price, @FXRate, @CurrencyId, @UpdateUserID, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	InstrumentEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
