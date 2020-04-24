USE Keeley

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
		@ResolveFromExternalSource bit, 
		@ExposureCurrencyId int, 
		@AdministratorId varchar(150), 
		@IsReverse bit, 
		@RiskCurrencyId int, 
		@ValuationMethodologyId int, 
		@CICCode varchar(4), 
		@BloombergCleanTicker varchar(50), 
		@LocalExchangeSymbol varchar(50), 
		@MicCode varchar(10), 
		@AlwaysUseManualPrice bit, 
		@IsExposureLong bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentMarket_hst (
			InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, ExposureCurrencyId, AdministratorId, IsReverse, RiskCurrencyId, ValuationMethodologyId, CICCode, BloombergCleanTicker, LocalExchangeSymbol, MicCode, AlwaysUseManualPrice, IsExposureLong, EndDt, LastActionUserID)
	SELECT	InstrumentMarketID, InstrumentID, MarketID, FMSecId, PriceDivisor, BloombergTicker, Sedol, IsPrimary, StartDt, UpdateUserID, DataVersion, PriceCurrencyId, ListingStatusId, UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier, BloombergGlobalId, LastRepulledFromSourceDate, FactsetId, UltimateUnderlyerPerOverlyer, ResolveFromExternalSource, ExposureCurrencyId, AdministratorId, IsReverse, RiskCurrencyId, ValuationMethodologyId, CICCode, BloombergCleanTicker, LocalExchangeSymbol, MicCode, AlwaysUseManualPrice, IsExposureLong, @StartDt, @UpdateUserID
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID

	UPDATE	InstrumentMarket
	SET		InstrumentID = @InstrumentID, MarketID = @MarketID, FMSecId = @FMSecId, PriceDivisor = @PriceDivisor, BloombergTicker = @BloombergTicker, Sedol = @Sedol, IsPrimary = @IsPrimary, UpdateUserID = @UpdateUserID, PriceCurrencyId = @PriceCurrencyId, ListingStatusId = @ListingStatusId, UnderlyingInstrumentMarketId = @UnderlyingInstrumentMarketId, UltimateUnderlyingInstrumentMarketId = @UltimateUnderlyingInstrumentMarketId, PriceQuoteMultiplier = @PriceQuoteMultiplier, BloombergGlobalId = @BloombergGlobalId, LastRepulledFromSourceDate = @LastRepulledFromSourceDate, FactsetId = @FactsetId, UltimateUnderlyerPerOverlyer = @UltimateUnderlyerPerOverlyer, ResolveFromExternalSource = @ResolveFromExternalSource, ExposureCurrencyId = @ExposureCurrencyId, AdministratorId = @AdministratorId, IsReverse = @IsReverse, RiskCurrencyId = @RiskCurrencyId, ValuationMethodologyId = @ValuationMethodologyId, CICCode = @CICCode, BloombergCleanTicker = @BloombergCleanTicker, LocalExchangeSymbol = @LocalExchangeSymbol, MicCode = @MicCode, AlwaysUseManualPrice = @AlwaysUseManualPrice, IsExposureLong = @IsExposureLong,  StartDt = @StartDt
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentMarket
	WHERE	InstrumentMarketID = @InstrumentMarketID
	AND		@@ROWCOUNT > 0

GO
