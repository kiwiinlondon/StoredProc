USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Instrument_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Instrument_Update]
GO

CREATE PROCEDURE DBO.[Instrument_Update]
		@InstrumentID int, 
		@IssuerID int, 
		@InstrumentClassID int, 
		@IssueCurrencyID int, 
		@FMInstId int, 
		@Name varchar, 
		@LongName varchar, 
		@Isin varchar, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Instrument_hst (
			InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Instrument
	WHERE	InstrumentID = InstrumentID

	UPDATE	Instrument
	SET		IssuerID = @IssuerID, InstrumentClassID = @InstrumentClassID, IssueCurrencyID = @IssueCurrencyID, FMInstId = @FMInstId, Name = @Name, LongName = @LongName, Isin = @Isin, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Instrument
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
