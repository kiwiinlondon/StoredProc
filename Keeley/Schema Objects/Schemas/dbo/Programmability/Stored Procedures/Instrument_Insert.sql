USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Instrument_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Instrument_Insert]
GO

CREATE PROCEDURE DBO.[Instrument_Insert]
		@IssuerID int, 
		@InstrumentClassID int, 
		@IssueCurrencyID int, 
		@FMInstId int, 
		@Name varchar(200), 
		@LongName varchar(250), 
		@Isin varchar(150), 
		@UpdateUserID int, 
		@UnderlyingIssuerId int, 
		@DerivedAssetClassId int, 
		@BloombergGlobalId varchar(25), 
		@BloombergTicker varchar(25), 
		@BloombergYellowKeyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Instrument
			(IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, UpdateUserID, UnderlyingIssuerId, DerivedAssetClassId, BloombergGlobalId, BloombergTicker, BloombergYellowKeyId, StartDt)
	VALUES
			(@IssuerID, @InstrumentClassID, @IssueCurrencyID, @FMInstId, @Name, @LongName, @Isin, @UpdateUserID, @UnderlyingIssuerId, @DerivedAssetClassId, @BloombergGlobalId, @BloombergTicker, @BloombergYellowKeyId, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	Instrument
	WHERE	InstrumentID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
