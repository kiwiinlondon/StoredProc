﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarket_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarket_Update]
GO

CREATE PROCEDURE DBO.[InstrumentMarket_Update]
		@InstrumentMarketID int, 
		@InstrumentID int, 
		@MarketID int, 
		@FMSecId int, 
		@PriceDivisor numeric(33,18), 
		@BloombergTicker varchar(150), 
		@Sedol varchar(150), 
		@IsPrimary bit, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PriceCurrencyId int, 
		@ListingStatusId int, 
		@UnderlyingInstrumentMarketId int, 
		@UltimateUnderlyingInstrumentMarketId int, 
		@PriceQuoteMultiplier decimal, 
		@BloombergGlobalId varchar(25), 
		@LastRepulledFromSourceDate datetime, 
		@FactsetId varchar(150), 
		@UltimateUnderlyerPerOverlyer numeric(27,8), 
		@ResolveFromExternalSource bit =null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentMarket_hst (
			InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, EndDt, LastActionUserID)
	SELECT	InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, @StartDt, @UpdateUserID
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID

	UPDATE	InstrumentMarket
	SET		InstrumentID = @InstrumentID, MarketID = @MarketID, FMSecId = @FMSecId, PriceDivisor = @PriceDivisor, BloombergTicker = @BloombergTicker, Sedol = @Sedol, IsPrimary = @IsPrimary, UpdateUserID = @UpdateUserID, PriceCurrencyId = @PriceCurrencyId, ListingStatusId = @ListingStatusId, UnderlyingInstrumentMarketId = @UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId = @UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier = @PriceQuoteMultiplier, BloombergGlobalId = @BloombergGlobalId, LastRepulledFromSourceDate = @LastRepulledFromSourceDate, FactsetId = @FactsetId, UltimateUnderlyerPerOverlyer = @UltimateUnderlyerPerOverlyer, ResolveFromExternalSource = @ResolveFromExternalSource,  StartDt = @StartDt
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		@@ROWCOUNT > 0

GO
