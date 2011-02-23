USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Update]
GO

CREATE PROCEDURE DBO.[FX_Update]
		@InstrumentID int, 
		@ReceiveCurrencyId int, 
		@PayCurrencyId int, 
		@CounterpartyId int, 
		@ReceiveAmount decimal, 
		@PayAmount decimal, 
		@IsProp bit, 
		@EnteredMultiply bit, 
		@MaturityDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FX_hst (
			InstrumentID, ReceiveCurrencyId, PayCurrencyId, CounterpartyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, MaturityDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, ReceiveCurrencyId, PayCurrencyId, CounterpartyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, MaturityDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FX
	WHERE	InstrumentID = @InstrumentID

	UPDATE	FX
	SET		ReceiveCurrencyId = @ReceiveCurrencyId, PayCurrencyId = @PayCurrencyId, CounterpartyId = @CounterpartyId, ReceiveAmount = @ReceiveAmount, PayAmount = @PayAmount, IsProp = @IsProp, EnteredMultiply = @EnteredMultiply, MaturityDate = @MaturityDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FX
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
