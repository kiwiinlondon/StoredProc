USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Insert]
GO

CREATE PROCEDURE DBO.[FX_Insert]
		@InstrumentID int, 
		@ReceiveCurrencyId int, 
		@PayCurrencyId int, 
		@CounterpartyId int, 
		@ReceiveAmount decimal, 
		@PayAmount decimal, 
		@IsProp bit, 
		@EnteredMultiply bit, 
		@MaturityDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FX
			(InstrumentID, ReceiveCurrencyId, PayCurrencyId, CounterpartyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, MaturityDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentID, @ReceiveCurrencyId, @PayCurrencyId, @CounterpartyId, @ReceiveAmount, @PayAmount, @IsProp, @EnteredMultiply, @MaturityDate, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	FX
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
