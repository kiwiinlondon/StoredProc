use Keeley

create table DBO.ApplicationUser(
	UserID int identity(1,1) not null CONSTRAINT ApplicationUserPK PRIMARY KEY,
	FMPersID int,
	Name varchar(100) not null,
	Email varchar(100) not null,
	WindowsLogin varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ApplicationUserUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null	
)

create unique index ApplicationUserNameUK on ApplicationUser(Name)
create unique index ApplicationUserWindowsLoginUK on ApplicationUser(WindowsLogin)
create unique index ApplicationUserEmailUK on ApplicationUser(Email)
create unique index ApplicationUserFMPersIdUK on ApplicationUser(FMPersID) where FMPersID is not null

create table DBO.Region (
	RegionID int identity(1,1) not null CONSTRAINT RegionPK PRIMARY KEY,
	Name varchar(100) not null,
	IsoCode varchar(5) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT RegionUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index RegionNameUK on Region(Name)
create unique index RegionIsoCodeUK on Region(IsoCode)

create table DBO.Country (
	CountryID int identity(1,1) not null CONSTRAINT CountryPK PRIMARY KEY,
	Name varchar(100) not null,
	IsoCode varchar(5) not null,
	RegionID int not null CONSTRAINT CountryRegionIDFK FOREIGN KEY REFERENCES Region(RegionID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT CountryUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index CountryNameUK on Country(Name)
create unique index CountryIsoCodeUK on Country(IsoCode)

create table DBO.LegalEntity (
	LegalEntityID int identity(1,1) not null CONSTRAINT LegalEntityPK PRIMARY KEY,
	FMOrgId int not null,
	Name varchar(70) not null,
	LongName varchar(100) not null,
	CountryID int CONSTRAINT LegalEntityCountryIDFK FOREIGN KEY REFERENCES Country(CountryID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT LegalEntityUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index LegalEntityNameUK on LegalEntity(Name)
create unique index LegalEntityLongNameUK on LegalEntity(LongName)
create unique index LegalEntityFMOrgIdUK on LegalEntity(FMOrgId) where FMOrgId is not null

create table DBO.Currency
(
	InstrumentID int not null CONSTRAINT CurrencyPK PRIMARY KEY, 
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT CurrencyUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.Issuer
(
	LegalEntityID int not null CONSTRAINT IssuerPK PRIMARY KEY,
							   CONSTRAINT IssuerLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT IssuerUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.InstrumentClass (
	InstrumentClassID int identity(1,1) not null CONSTRAINT InstrumentClassPK PRIMARY KEY,	
	ParentInstrumentClassID int null CONSTRAINT InstrumentClassParentInstrumentClassIDFK FOREIGN KEY REFERENCES InstrumentClass(InstrumentClassID), 
	FMInstClass varchar(100),
	Name varchar(100) not null,	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentClassUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index InstrumentClassNameUK on InstrumentClass(Name)
create unique index InstrumentClassFMInstClassUK on InstrumentClass(FMInstClass) where FMInstClass is not null

create table DBO.Instrument (
	InstrumentID int identity(1000,1) not null CONSTRAINT InstrumentPK PRIMARY KEY,
	IssuerID int not null CONSTRAINT InstrumentIssuerIDFK FOREIGN KEY REFERENCES Issuer(LegalEntityID),
	InstrumentClassID int not null CONSTRAINT InstrumentInstrumentClassIDFK FOREIGN KEY REFERENCES InstrumentClass(InstrumentClassID),
	IssueCurrencyID int not null CONSTRAINT InstrumentIssueCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),
	FMInstId int,
	Name varchar(200) not null,	
	LongName varchar(250) not null,
	Isin varchar(150),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
alter table Currency ADD CONSTRAINT CurrencyInstrumentIDFK FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID)

create unique index InstrumentNameUK on Instrument(Name)
create unique index InstrumentLongNameUK on Instrument(LongName)
create unique index InstrumentIsinUK on Instrument(Isin) where Isin is not null
create unique index InstrumentClassFMInstIdUK on Instrument(FMInstId) where FMInstId is not null

create table DBO.Market
(
	LegalEntityID int not null CONSTRAINT MarketPK PRIMARY KEY,
							   CONSTRAINT MarketLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT MarketUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.InstrumentMarket (
	InstrumentMarketID int identity(1,1) not null CONSTRAINT InstrumentMarketPK PRIMARY KEY,
	InstrumentID int not null CONSTRAINT InstrumentMarketInstrumentIDFK FOREIGN KEY REFERENCES Instrument(InstrumentID),
	MarketID  int not null CONSTRAINT InstrumentMarketMarketIDFK FOREIGN KEY REFERENCES Market(LegalEntityID),
	BenefitCurrencyID int not null CONSTRAINT InstrumentMarketBenefitCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),
	FMSecId int,
	PriceDivisor numeric(33,18) not null,
	BloombergTicker varchar(150),
	Sedol varchar(150),
	IsPrimary bit not null,	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentMarketUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
create unique index InstrumentMarketBloombergTickerUK on InstrumentMarket(BloombergTicker) where BloombergTicker is not null
create unique index InstrumentMarketSedolUK on InstrumentMarket(Sedol) where Sedol is not null
create unique index InstrumentMarketInstrumentIDMarketIDUK on InstrumentMarket(InstrumentID,MarketID)
create unique index InstrumentMarketFMSecIDUK on InstrumentMarket(FMSecID) where FMSecID is not null

create table DBO.Fund (
	LegalEntityID int not null CONSTRAINT FundPK PRIMARY KEY,
							   CONSTRAINT FundLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
	InstrumentMarketID int CONSTRAINT FundInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	ParentFundID int CONSTRAINT FundParentFundIDFK FOREIGN KEY REFERENCES Fund(LegalEntityID),	
	CurrencyID int not null CONSTRAINT FundCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT FundUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
create unique index FundInstrumentMarketIDUK on Fund(InstrumentMarketID) where InstrumentMarketID is not null

create table DBO.Book (
	BookID int identity(1,1) not null CONSTRAINT BookPK PRIMARY KEY,
	FMOrgId int,
	Name varchar(70) not null,
	FundID int not null CONSTRAINT BookFundIDFK FOREIGN KEY REFERENCES Fund(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT BookUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index BookNameUK on Book(Name)
create unique index BookFMOrgIDUK on Book(FMOrgID) where FMOrgId is not null

create table DBO.InstrumentRelationship (
	UnderlyingInstrumentID int not null  CONSTRAINT InstrumentRelationshipPK PRIMARY KEY, 
										 CONSTRAINT InstrumentRelationshipUnderlyingInstrumentIDFK FOREIGN KEY (UnderlyingInstrumentID) REFERENCES Instrument(InstrumentID),
	OverlyingInstrumentID int not null CONSTRAINT InstrumentRelationshipOverlyingInstrumentIDFK FOREIGN KEY REFERENCES Instrument(InstrumentID),	
	UnderlyerPerOverlyer numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentRelationshipUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.Strategy(
	StrategyID int identity(1,1) not null CONSTRAINT StrategyPK PRIMARY KEY,
	FMStrategy varchar(15),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT StrategyUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index StrategyNameUK on Strategy(Name)
create unique index StrategyFMStrategyUK on Strategy(FMStrategy) where FMStrategy is not null

create table DBO.TradeType(
	TradeTypeID int identity(1,1) not null CONSTRAINT TradeTypePK PRIMARY KEY,
	FMTradType varchar(100),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT TradeTypeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index TradeTypeNameUK on TradeType(Name)
create unique index TradeTypeFMTradTypeUK on TradeType(FMTradType) where FMTradType is not null

create table DBO.Position (
	PositionID int identity(1,1) not null CONSTRAINT PositionPK PRIMARY KEY,
	BookID int not null CONSTRAINT PositionBookIDFK FOREIGN KEY REFERENCES Book(BookID),
	StrategyID  int not null CONSTRAINT PositionStrategyIDFK FOREIGN KEY REFERENCES Strategy(StrategyID),
	InstrumentMarketID int not null CONSTRAINT PositionInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	TradeTypeID int not null CONSTRAINT PositionTradeTypeIDFK FOREIGN KEY REFERENCES TradeType(TradeTypeID),
	CurrencyID int not null CONSTRAINT PositionCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
create unique index PositionUK on Position(BookId,StrategyID,InstrumentMarketID,TradeTypeID,CurrencyID)

create table DBO.Portfolio (
	PortfolioID int identity(1,1) not null CONSTRAINT PortfolioPK PRIMARY KEY,
	PositionID int not null CONSTRAINT PositionIDFK FOREIGN KEY REFERENCES Position(PositionID),
	ReferenceDate datetime not null,
	NetPosition numeric(27,8) not null,
	UnitCost numeric(35,16) not null,
	MarkPrice numeric(35,16) not null,
	FXRate numeric(35,16) not null,
	MarketValue numeric(27,8) not null,
	DeltaEquityPosition numeric(27,8) not null,
	RealisedFXPNL numeric(27,8) not null,
	UnRealisedFXPNL numeric(27,8) not null,
	RealisedPricePNL numeric(27,8) not null,
	UnRealisedPricePNL numeric(27,8) not null,
	RealisedTotalPNL numeric(27,8) not null,
	UnRealisedTotalPNL numeric(27,8) not null,
	Accrual numeric(27,8) not null,
	CashIncome numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null,
	FMContViewLadderID int not null,
)

create unique index PortfolioUK on Portfolio(PositionID,ReferenceDate)
create unique index PortfolioFMContViewLadderIDUK on Portfolio(FMContViewLadderID)

