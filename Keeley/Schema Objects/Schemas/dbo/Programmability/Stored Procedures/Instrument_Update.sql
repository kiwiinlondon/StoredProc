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
		@Name varchar(200), 
		@LongName varchar(250), 
		@Isin varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@UnderlyingIssuerId int, 
		@DerivedAssetClassId int, 
		@BloombergGlobalId varchar(25), 
		@BloombergTicker varchar(25), 
		@BloombergYellowKeyId int, 
		@Is13F bit, 
		@Cusip varchar(10)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Instrument_hst (
			InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, UnderlyingIssuerId, DerivedAssetClassId, BloombergGlobalId, BloombergTicker, BloombergYellowKeyId, Is13F, Cusip, EndDt, LastActionUserID)
	SELECT	InstrumentID, IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, StartDt, UpdateUserID, DataVersion, UnderlyingIssuerId, DerivedAssetClassId, BloombergGlobalId, BloombergTicker, BloombergYellowKeyId, Is13F, Cusip, @StartDt, @UpdateUserID
	FROM	Instrument
	WHERE	InstrumentID = @InstrumentID

	UPDATE	Instrument
	SET		IssuerID = @IssuerID, InstrumentClassID = @InstrumentClassID, IssueCurrencyID = @IssueCurrencyID, FMInstId = @FMInstId, Name = @Name, LongName = @LongName, Isin = @Isin, UpdateUserID = @UpdateUserID, UnderlyingIssuerId = @UnderlyingIssuerId, DerivedAssetClassId = @DerivedAssetClassId, BloombergGlobalId = @BloombergGlobalId, BloombergTicker = @BloombergTicker, BloombergYellowKeyId = @BloombergYellowKeyId, Is13F = @Is13F, Cusip = @Cusip,  StartDt = @StartDt
	WHERE	InstrumentID = @InstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Instrument
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
