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
		@Name varchar, 
		@LongName varchar, 
		@Isin varchar, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Instrument
			(IssuerID, InstrumentClassID, IssueCurrencyID, FMInstId, Name, LongName, Isin, UpdateUserID, StartDt)
	VALUES
			(@IssuerID, @InstrumentClassID, @IssueCurrencyID, @FMInstId, @Name, @LongName, @Isin, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	Instrument
	WHERE	InstrumentID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
