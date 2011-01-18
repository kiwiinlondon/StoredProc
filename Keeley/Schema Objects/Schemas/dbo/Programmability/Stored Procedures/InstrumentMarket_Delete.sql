USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarket_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarket_Delete]

GO
CREATE PROCEDURE DBO.[InstrumentMarket_Delete]
		@InstrumentMarketID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentMarket_hst (
			InstrumentMarketID, InstrumentID, MarketID, BenefitCurrencyID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentMarketID, InstrumentID, MarketID, BenefitCurrencyID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = InstrumentMarketID

	DELETE	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		DataVersion = @DataVersion
GO
