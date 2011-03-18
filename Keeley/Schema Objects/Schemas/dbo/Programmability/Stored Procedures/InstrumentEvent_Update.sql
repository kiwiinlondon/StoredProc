USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEvent_Update]
GO

CREATE PROCEDURE DBO.[InstrumentEvent_Update]
		@EventID int, 
		@InstrumentMarketID int, 
		@InstrumentEventTypeID int, 
		@EventDate datetime, 
		@ValueDate datetime, 
		@Quantity numeric(27,8), 
		@Price numeric(35,16), 
		@FXRate numeric(35,16), 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentEvent_hst (
			EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, Price, FXRate, CurrencyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, Price, FXRate, CurrencyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentEvent
	WHERE	EventID = @EventID

	UPDATE	InstrumentEvent
	SET		InstrumentMarketID = @InstrumentMarketID, InstrumentEventTypeID = @InstrumentEventTypeID, EventDate = @EventDate, ValueDate = @ValueDate, Quantity = @Quantity, Price = @Price, FXRate = @FXRate, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
