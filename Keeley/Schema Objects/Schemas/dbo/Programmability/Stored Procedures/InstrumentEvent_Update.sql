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
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InputDate datetime, 
		@ExDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentEvent_hst (
			EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, ExDate, EndDt, LastActionUserID)
	SELECT	EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, AmendmentNumber, IsCancelled, CurrencyId, StartDt, UpdateUserID, DataVersion, InputDate, ExDate, @StartDt, @UpdateUserID
	FROM	InstrumentEvent
	WHERE	EventID = @EventID

	UPDATE	InstrumentEvent
	SET		InstrumentMarketID = @InstrumentMarketID, InstrumentEventTypeID = @InstrumentEventTypeID, EventDate = @EventDate, ValueDate = @ValueDate, Quantity = @Quantity, AmendmentNumber = @AmendmentNumber, IsCancelled = @IsCancelled, CurrencyId = @CurrencyId, UpdateUserID = @UpdateUserID, InputDate = @InputDate, ExDate = @ExDate,  StartDt = @StartDt
	WHERE	EventID = @EventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
