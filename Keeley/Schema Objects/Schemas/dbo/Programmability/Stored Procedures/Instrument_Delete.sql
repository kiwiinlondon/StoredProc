USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Instrument_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Instrument_Delete]
GO

CREATE PROCEDURE DBO.[Instrument_Delete]
		@InstrumentID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Instrument_hst (
			InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Instrument
	WHERE	InstrumentID = @InstrumentID

	DELETE	Instrument
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion
GO
