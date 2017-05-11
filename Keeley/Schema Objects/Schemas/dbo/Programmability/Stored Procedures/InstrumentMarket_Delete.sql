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
		@InstrumentMarketID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentMarket_hst (
			InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, ExposureCurrencyId, AdministratorId, IsReverse, RiskCurrencyId, EndDt, LastActionUserID)
	SELECT	InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, ExposureCurrencyId, AdministratorId, IsReverse, RiskCurrencyId, @EndDt, @UpdateUserID
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID

	DELETE	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		DataVersion = @DataVersion
GO
