USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FX_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FX_Delete]
GO

CREATE PROCEDURE DBO.[FX_Delete]
		@InstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FX_hst (
			InstrumentID, ReceiveCurrencyId, PayCurrencyId, CounterpartyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, MaturityDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, ReceiveCurrencyId, PayCurrencyId, CounterpartyId, ReceiveAmount, PayAmount, IsProp, EnteredMultiply, MaturityDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FX
	WHERE	InstrumentID = @InstrumentID

	DELETE	FX
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
