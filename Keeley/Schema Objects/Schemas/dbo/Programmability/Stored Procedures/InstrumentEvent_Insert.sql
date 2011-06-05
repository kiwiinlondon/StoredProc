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
		@FXRate numeric(35,16), 
		@FXRateMultiply bit, 
		@AmendmentNumber int, 
		@IsCancelled bit, 
		@CurrencyId int, 
		@UpdateUserID int, 
		@InputDate datetime, 
		@IsPending bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentEvent
			(EventID, InstrumentMarketID, InstrumentEventTypeID, EventDate, ValueDate, Quantity, FXRate, FXRateMultiply, AmendmentNumber, IsCancelled, CurrencyId, UpdateUserID, InputDate, IsPending, StartDt)
	VALUES
			(@EventID, @InstrumentMarketID, @InstrumentEventTypeID, @EventDate, @ValueDate, @Quantity, @FXRate, @FXRateMultiply, @AmendmentNumber, @IsCancelled, @CurrencyId, @UpdateUserID, @InputDate, @IsPending, @StartDt)

	SELECT	EventID, StartDt, DataVersion
	FROM	InstrumentEvent
	WHERE	EventID = @EventID
	AND		@@ROWCOUNT > 0

GO
