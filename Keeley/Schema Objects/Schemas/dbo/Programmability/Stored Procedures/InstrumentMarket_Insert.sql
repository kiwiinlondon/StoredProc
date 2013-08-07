USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarket_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarket_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentMarket_Insert]
		@InstrumentID int, 
		@MarketID int, 
		@FMSecId int, 
		@PriceDivisor numeric(33,18), 
		@BloombergTicker varchar(150), 
		@Sedol varchar(150), 
		@IsPrimary bit, 
		@UpdateUserID int, 
		@PriceCurrencyId int, 
		@ListingStatusId int, 
		@UnderlyingInstrumentMarketId int, 
		@UltimateUnderlyingInstrumentMarketId int, 
		@PriceQuoteMultiplier decimal, 
		@BloombergGlobalId varchar(25), 
		@LastRepulledFromSourceDate datetime, 
		@FactsetId varchar(150)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentMarket
			(InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, UpdateUserID, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, StartDt)
	VALUES
			(@InstrumentID, @MarketID, @FMSecId, @PriceDivisor, @BloombergTicker, @Sedol, @IsPrimary, @UpdateUserID, @PriceCurrencyId, @ListingStatusId, @UnderlyingInstrumentMarketId, @UltimateUnderlyingInstrumentMarketId, @PriceQuoteMultiplier, @BloombergGlobalId, @LastRepulledFromSourceDate, @FactsetId, @StartDt)

	SELECT	InstrumentMarketID, StartDt, DataVersion
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
