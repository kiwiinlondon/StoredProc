USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ReportPositionStaticData_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ReportPositionStaticData_Delete]
GO

CREATE PROCEDURE DBO.[ReportPositionStaticData_Delete]
		@IsEnvironmentPROD bit,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ReportPositionStaticData_hst (
			PositionId, IsEnvironmentPROD, InstrumentName, AssetClass, IssuerName, Sedol, BloombergTicker, InstrumentClassId, DerivedAssetClassId, Custodian, AccountType, Fund, Region, Country, GICSSector, GICSIndustry, GICSIndustryGroup, GICSSubIndustry, DefaultSector, IndustryName, Account, InstrumentClassName, PositionCurrency, Book, Isin, ParentInstrumentClass, FundCurrency, FundType, CompanySize, Analyst, Strategy, Manager, ListingStatus, IsProp, IsPrimary, MarketCapUSD, IsAccrual, CountryOfDomicile, BaseCurrencyId, ExposureCurrency, InstrumentMarketId, FundInstrumentMarketId, IssuerId, CisFundId, CisFundShareClassId, PriceCurrency, UnderlyingInstrumentMarketId, UnderlyingInstrumentId, CustodianId, AccountTypeId, RegionId, CountryId, GICSSectorId, GICSIndustryId, GICSIndustryGroupId, GICSSubIndustryId, DefaultSectorId, DefaultIndustryId, AccountId, PositionCurrencyId, BookId, FundCurrencyId, AnalystId, StrategyId, ManagerId, CountryOfDomicileId, PriceCurrencyId, FundStructure, ForwardFxContraCurrencyId, ForwardFxBaseCurrencyId, CountryOfListingId, CountryOfListing, ListingStatusId, MaturityDate, IsPut, ParentInstrumentClassId, FundIsLongOnly, InternalOriginatorId, InternalOriginatorType, InternalOriginator, InternalOriginatorId2, InternalOriginatorType2, InternalOriginator2, ExternalOriginatorId, ExternalOriginator, ExternalOriginatorEntity, OriginatingDate, IsOriginatedLong, FundManager, FundManagerId, DefaultIndustry, DataVersion, StartDt, UpdateUserID, EndDt, LastActionUserID)
	SELECT	PositionId, IsEnvironmentPROD, InstrumentName, AssetClass, IssuerName, Sedol, BloombergTicker, InstrumentClassId, DerivedAssetClassId, Custodian, AccountType, Fund, Region, Country, GICSSector, GICSIndustry, GICSIndustryGroup, GICSSubIndustry, DefaultSector, IndustryName, Account, InstrumentClassName, PositionCurrency, Book, Isin, ParentInstrumentClass, FundCurrency, FundType, CompanySize, Analyst, Strategy, Manager, ListingStatus, IsProp, IsPrimary, MarketCapUSD, IsAccrual, CountryOfDomicile, BaseCurrencyId, ExposureCurrency, InstrumentMarketId, FundInstrumentMarketId, IssuerId, CisFundId, CisFundShareClassId, PriceCurrency, UnderlyingInstrumentMarketId, UnderlyingInstrumentId, CustodianId, AccountTypeId, RegionId, CountryId, GICSSectorId, GICSIndustryId, GICSIndustryGroupId, GICSSubIndustryId, DefaultSectorId, DefaultIndustryId, AccountId, PositionCurrencyId, BookId, FundCurrencyId, AnalystId, StrategyId, ManagerId, CountryOfDomicileId, PriceCurrencyId, FundStructure, ForwardFxContraCurrencyId, ForwardFxBaseCurrencyId, CountryOfListingId, CountryOfListing, ListingStatusId, MaturityDate, IsPut, ParentInstrumentClassId, FundIsLongOnly, InternalOriginatorId, InternalOriginatorType, InternalOriginator, InternalOriginatorId2, InternalOriginatorType2, InternalOriginator2, ExternalOriginatorId, ExternalOriginator, ExternalOriginatorEntity, OriginatingDate, IsOriginatedLong, FundManager, FundManagerId, DefaultIndustry, DataVersion, StartDt, UpdateUserID, @EndDt, @UpdateUserID
	FROM	ReportPositionStaticData
	WHERE	IsEnvironmentPROD = @IsEnvironmentPROD

	DELETE	ReportPositionStaticData
	WHERE	IsEnvironmentPROD = @IsEnvironmentPROD
	AND		DataVersion = @DataVersion
GO
