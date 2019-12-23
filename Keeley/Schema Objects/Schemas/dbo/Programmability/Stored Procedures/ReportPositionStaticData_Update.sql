USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportPositionStaticData_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportPositionStaticData_Update]
GO

CREATE PROCEDURE DBO.[ReportPositionStaticData_Update]
		@PositionId int, 
		@IsEnvironmentPROD bit, 
		@InstrumentName varchar(200), 
		@AssetClass varchar(70), 
		@IssuerName varchar(70), 
		@Sedol varchar(150), 
		@BloombergTicker varchar(150), 
		@InstrumentClassId int, 
		@DerivedAssetClassId int, 
		@Custodian varchar(70), 
		@AccountType varchar(100), 
		@Fund varchar(70), 
		@Region varchar(100), 
		@Country varchar(100), 
		@GICSSector varchar(100), 
		@GICSIndustry varchar(100), 
		@GICSIndustryGroup varchar(100), 
		@GICSSubIndustry varchar(100), 
		@DefaultSector varchar(100), 
		@IndustryName varchar(100), 
		@Account varchar(100), 
		@InstrumentClassName varchar(100), 
		@PositionCurrency varchar(200), 
		@Book varchar(70), 
		@Isin varchar(150), 
		@ParentInstrumentClass varchar(100), 
		@FundCurrency varchar(200), 
		@FundType varchar(70), 
		@CompanySize varchar(100), 
		@Analyst varchar(100), 
		@Strategy varchar(100), 
		@Manager varchar(100), 
		@ListingStatus varchar(100), 
		@IsProp bit, 
		@IsPrimary bit, 
		@MarketCapUSD numeric(15,0), 
		@IsAccrual bit, 
		@CountryOfDomicile varchar(100), 
		@BaseCurrencyId int, 
		@ExposureCurrency varchar(200), 
		@InstrumentMarketId int, 
		@FundInstrumentMarketId int, 
		@IssuerId int, 
		@CisFundId int, 
		@CisFundShareClassId int, 
		@PriceCurrency varchar(200), 
		@UnderlyingInstrumentMarketId int, 
		@UnderlyingInstrumentId int, 
		@CustodianId int, 
		@AccountTypeId int, 
		@RegionId int, 
		@CountryId int, 
		@GICSSectorId int, 
		@GICSIndustryId int, 
		@GICSIndustryGroupId int, 
		@GICSSubIndustryId int, 
		@DefaultSectorId int, 
		@DefaultIndustryId int, 
		@AccountId int, 
		@PositionCurrencyId int, 
		@BookId int, 
		@FundCurrencyId int, 
		@AnalystId int, 
		@StrategyId int, 
		@ManagerId int, 
		@CountryOfDomicileId int, 
		@PriceCurrencyId int, 
		@FundStructure varchar(100), 
		@ForwardFxContraCurrencyId int, 
		@ForwardFxBaseCurrencyId int, 
		@CountryOfListingId int, 
		@CountryOfListing varchar(100), 
		@ListingStatusId int, 
		@MaturityDate datetime, 
		@IsPut bit, 
		@ParentInstrumentClassId int, 
		@FundIsLongOnly bit, 
		@InternalOriginatorId int, 
		@InternalOriginatorType int, 
		@InternalOriginator varchar(100), 
		@InternalOriginatorId2 int, 
		@InternalOriginatorType2 int, 
		@InternalOriginator2 varchar(100), 
		@ExternalOriginatorId int, 
		@ExternalOriginator varchar(100), 
		@ExternalOriginatorEntity varchar(100), 
		@OriginatingDate datetime, 
		@IsOriginatedLong bit, 
		@FundManager varchar(100), 
		@FundManagerId int, 
		@DefaultIndustry varchar(100), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ReportPositionStaticData_hst (
			PositionId, IsEnvironmentPROD, InstrumentName, AssetClass, IssuerName, Sedol, BloombergTicker, InstrumentClassId, DerivedAssetClassId, Custodian, AccountType, Fund, Region, Country, GICSSector, GICSIndustry, GICSIndustryGroup, GICSSubIndustry, DefaultSector, IndustryName, Account, InstrumentClassName, PositionCurrency, Book, Isin, ParentInstrumentClass, FundCurrency, FundType, CompanySize, Analyst, Strategy, Manager, ListingStatus, IsProp, IsPrimary, MarketCapUSD, IsAccrual, CountryOfDomicile, BaseCurrencyId, ExposureCurrency, InstrumentMarketId, FundInstrumentMarketId, IssuerId, CisFundId, CisFundShareClassId, PriceCurrency, UnderlyingInstrumentMarketId, UnderlyingInstrumentId, CustodianId, AccountTypeId, RegionId, CountryId, GICSSectorId, GICSIndustryId, GICSIndustryGroupId, GICSSubIndustryId, DefaultSectorId, DefaultIndustryId, AccountId, PositionCurrencyId, BookId, FundCurrencyId, AnalystId, StrategyId, ManagerId, CountryOfDomicileId, PriceCurrencyId, FundStructure, ForwardFxContraCurrencyId, ForwardFxBaseCurrencyId, CountryOfListingId, CountryOfListing, ListingStatusId, MaturityDate, IsPut, ParentInstrumentClassId, FundIsLongOnly, InternalOriginatorId, InternalOriginatorType, InternalOriginator, InternalOriginatorId2, InternalOriginatorType2, InternalOriginator2, ExternalOriginatorId, ExternalOriginator, ExternalOriginatorEntity, OriginatingDate, IsOriginatedLong, FundManager, FundManagerId, DefaultIndustry, DataVersion, StartDt, UpdateUserID, EndDt, LastActionUserID)
	SELECT	PositionId, IsEnvironmentPROD, InstrumentName, AssetClass, IssuerName, Sedol, BloombergTicker, InstrumentClassId, DerivedAssetClassId, Custodian, AccountType, Fund, Region, Country, GICSSector, GICSIndustry, GICSIndustryGroup, GICSSubIndustry, DefaultSector, IndustryName, Account, InstrumentClassName, PositionCurrency, Book, Isin, ParentInstrumentClass, FundCurrency, FundType, CompanySize, Analyst, Strategy, Manager, ListingStatus, IsProp, IsPrimary, MarketCapUSD, IsAccrual, CountryOfDomicile, BaseCurrencyId, ExposureCurrency, InstrumentMarketId, FundInstrumentMarketId, IssuerId, CisFundId, CisFundShareClassId, PriceCurrency, UnderlyingInstrumentMarketId, UnderlyingInstrumentId, CustodianId, AccountTypeId, RegionId, CountryId, GICSSectorId, GICSIndustryId, GICSIndustryGroupId, GICSSubIndustryId, DefaultSectorId, DefaultIndustryId, AccountId, PositionCurrencyId, BookId, FundCurrencyId, AnalystId, StrategyId, ManagerId, CountryOfDomicileId, PriceCurrencyId, FundStructure, ForwardFxContraCurrencyId, ForwardFxBaseCurrencyId, CountryOfListingId, CountryOfListing, ListingStatusId, MaturityDate, IsPut, ParentInstrumentClassId, FundIsLongOnly, InternalOriginatorId, InternalOriginatorType, InternalOriginator, InternalOriginatorId2, InternalOriginatorType2, InternalOriginator2, ExternalOriginatorId, ExternalOriginator, ExternalOriginatorEntity, OriginatingDate, IsOriginatedLong, FundManager, FundManagerId, DefaultIndustry, DataVersion, StartDt, UpdateUserID, @StartDt, @UpdateUserID
	FROM	ReportPositionStaticData
	WHERE	IsEnvironmentPROD = @IsEnvironmentPROD

	UPDATE	ReportPositionStaticData
	SET		InstrumentName = @InstrumentName, AssetClass = @AssetClass, IssuerName = @IssuerName, Sedol = @Sedol, BloombergTicker = @BloombergTicker, InstrumentClassId = @InstrumentClassId, DerivedAssetClassId = @DerivedAssetClassId, Custodian = @Custodian, AccountType = @AccountType, Fund = @Fund, Region = @Region, Country = @Country, GICSSector = @GICSSector, GICSIndustry = @GICSIndustry, GICSIndustryGroup = @GICSIndustryGroup, GICSSubIndustry = @GICSSubIndustry, DefaultSector = @DefaultSector, IndustryName = @IndustryName, Account = @Account, InstrumentClassName = @InstrumentClassName, PositionCurrency = @PositionCurrency, Book = @Book, Isin = @Isin, ParentInstrumentClass = @ParentInstrumentClass, FundCurrency = @FundCurrency, FundType = @FundType, CompanySize = @CompanySize, Analyst = @Analyst, Strategy = @Strategy, Manager = @Manager, ListingStatus = @ListingStatus, IsProp = @IsProp, IsPrimary = @IsPrimary, MarketCapUSD = @MarketCapUSD, IsAccrual = @IsAccrual, CountryOfDomicile = @CountryOfDomicile, BaseCurrencyId = @BaseCurrencyId, ExposureCurrency = @ExposureCurrency, InstrumentMarketId = @InstrumentMarketId, FundInstrumentMarketId = @FundInstrumentMarketId, IssuerId = @IssuerId, CisFundId = @CisFundId, CisFundShareClassId = @CisFundShareClassId, PriceCurrency = @PriceCurrency, UnderlyingInstrumentMarketId = @UnderlyingInstrumentMarketId, UnderlyingInstrumentId = @UnderlyingInstrumentId, CustodianId = @CustodianId, AccountTypeId = @AccountTypeId, RegionId = @RegionId, CountryId = @CountryId, GICSSectorId = @GICSSectorId, GICSIndustryId = @GICSIndustryId, GICSIndustryGroupId = @GICSIndustryGroupId, GICSSubIndustryId = @GICSSubIndustryId, DefaultSectorId = @DefaultSectorId, DefaultIndustryId = @DefaultIndustryId, AccountId = @AccountId, PositionCurrencyId = @PositionCurrencyId, BookId = @BookId, FundCurrencyId = @FundCurrencyId, AnalystId = @AnalystId, StrategyId = @StrategyId, ManagerId = @ManagerId, CountryOfDomicileId = @CountryOfDomicileId, PriceCurrencyId = @PriceCurrencyId, FundStructure = @FundStructure, ForwardFxContraCurrencyId = @ForwardFxContraCurrencyId, ForwardFxBaseCurrencyId = @ForwardFxBaseCurrencyId, CountryOfListingId = @CountryOfListingId, CountryOfListing = @CountryOfListing, ListingStatusId = @ListingStatusId, MaturityDate = @MaturityDate, IsPut = @IsPut, ParentInstrumentClassId = @ParentInstrumentClassId, FundIsLongOnly = @FundIsLongOnly, InternalOriginatorId = @InternalOriginatorId, InternalOriginatorType = @InternalOriginatorType, InternalOriginator = @InternalOriginator, InternalOriginatorId2 = @InternalOriginatorId2, InternalOriginatorType2 = @InternalOriginatorType2, InternalOriginator2 = @InternalOriginator2, ExternalOriginatorId = @ExternalOriginatorId, ExternalOriginator = @ExternalOriginator, ExternalOriginatorEntity = @ExternalOriginatorEntity, OriginatingDate = @OriginatingDate, IsOriginatedLong = @IsOriginatedLong, FundManager = @FundManager, FundManagerId = @FundManagerId, DefaultIndustry = @DefaultIndustry, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IsEnvironmentPROD = @IsEnvironmentPROD
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ReportPositionStaticData
	WHERE	IsEnvironmentPROD = @IsEnvironmentPROD
	AND		@@ROWCOUNT > 0

GO
