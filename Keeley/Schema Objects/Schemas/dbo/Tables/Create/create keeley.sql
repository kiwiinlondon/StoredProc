use Keeley

create table DBO.ApplicationUser(
	UserID int identity(2,1) not null CONSTRAINT ApplicationUserPK PRIMARY KEY,
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
	FMOrgId int,
	Name varchar(70) not null,
	BBCompany int null,
	LongName varchar(100) not null,
	CountryID int CONSTRAINT LegalEntityCountryIDFK FOREIGN KEY REFERENCES Country(CountryID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT LegalEntityUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index LegalEntityNameUK on LegalEntity(Name)
create unique index LegalEntityLongNameUK on LegalEntity(LongName)
create unique index LegalEntityFMOrgIdUK on LegalEntity(FMOrgId) where FMOrgId is not null
create unique index LegalEntityBBCompanyUK on LegalEntity(BBCompany) where BBCompany is not null

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
	InstrumentID int identity(1,1) not null CONSTRAINT InstrumentPK PRIMARY KEY,
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
create unique index InstrumentIsinUK on Instrument(Isin,instrumentClassId) where Isin is not null
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
	FMSecId int,
	PriceDivisor numeric(33,18) not null,
	BloombergTicker varchar(150),
	Sedol varchar(150),
	IsPrimary bit not null,	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentMarketUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
create index InstrumentMarketBloombergTickerIDX on InstrumentMarket(BloombergTicker)
create index InstrumentMarketSedolIDX on InstrumentMarket(Sedol)
create unique index InstrumentMarketInstrumentIDMarketIDUK on InstrumentMarket(InstrumentID,MarketID)
create unique index InstrumentMarketFMSecIDUK on InstrumentMarket(FMSecID) where FMSecID is not null

CREATE VIEW SedolInstrumentClassView WITH SCHEMABINDING AS
SELECT Sedol,InstrumentClassId
  FROM dbo.Instrument i,
	   dbo.InstrumentMarket im
 WHERE i.InstrumentID = im.InstrumentID 
   AND im.sedol is not null
   
CREATE UNIQUE CLUSTERED INDEX SedolInstrumentClassViewUK on SedolInstrumentClassView (Sedol,InstrumentClassId)

CREATE VIEW BBTickerInstrumentClassView WITH SCHEMABINDING AS
SELECT BloombergTicker,InstrumentClassId
  FROM dbo.Instrument i,
	   dbo.InstrumentMarket im
 WHERE i.InstrumentID = im.InstrumentID 
   AND im.BloombergTicker is not null
   
CREATE UNIQUE CLUSTERED INDEX BBTickerInstrumentClassViewUK on BBTickerInstrumentClassView (BloombergTicker,InstrumentClassId)


create table DBO.Fund (
	LegalEntityID int not null CONSTRAINT FundPK PRIMARY KEY,
							   CONSTRAINT FundLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
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
	OverlyingInstrumentID int not null  CONSTRAINT InstrumentRelationshipPK PRIMARY KEY, 
	  									CONSTRAINT InstrumentRelationshipOverlyingInstrumentIDFK FOREIGN KEY (OverlyingInstrumentID) REFERENCES Instrument(InstrumentID),
	UnderlyingInstrumentID int not null CONSTRAINT InstrumentRelationshipUnderlyingInstrumentIDFK FOREIGN KEY REFERENCES Instrument(InstrumentID),	
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
	InstrumentMarketID int not null CONSTRAINT PositionInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	CurrencyID int not null CONSTRAINT PositionCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index PositionUK on Position(BookId,InstrumentMarketID,CurrencyID)

create table DBO.Portfolio (
	PortfolioID int identity(1,1) not null CONSTRAINT PortfolioPK PRIMARY KEY nonclustered,
	PositionID int not null CONSTRAINT PortfolioPositionIDFK FOREIGN KEY REFERENCES Position(PositionID),
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
	Accrual numeric(27,8) not null,
	CashIncome numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null,
	FMContViewLadderID int
)

create  unique clustered index PortfolioUK on Portfolio(PositionID,ReferenceDate)
create unique index PortfolioFMContViewLadderIDUK on Portfolio(FMContViewLadderID) where FMContViewLadderID is not null

create table DBO.PortfolioChangeControl
(
	PortfolioChangeControlId int identity(1,1) not null CONSTRAINT PortfolioChangeControlPK PRIMARY KEY nonclustered,
	PositionID int not null CONSTRAINT PortfolioChangeControlPositionIDFK FOREIGN KEY REFERENCES Position(PositionID),	
	ReferenceDate date not null,
	ChangeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioChangeControlUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null,
)

create unique clustered index PortfolioChangeControlUK on PortfolioChangeControl(PositionID,ReferenceDate)

create table KeeleyType
(
	KeeleyTypeID int identity(1,1) not null CONSTRAINT KeeleyTypePK PRIMARY KEY,
	Name varchar(100) not null,
	AssemblyName varchar(400) not null,
	TypeName varchar(400) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT KeeleyTypeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null	
)

create unique index KeeleyTypeNameUK on KeeleyType(Name)
create unique index AssemblyTypeNameUK on KeeleyType(AssemblyName,TypeName)

create table DBO.IdentifierType(
	IdentifierTypeID int identity(1,1) not null CONSTRAINT IdentifierTypePK PRIMARY KEY,
	FMIdentType varchar(20),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT IdentifierTypeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null	
)
create unique index IdentifierTypeNameUK on IdentifierType(Name)
create unique index IdentifierTypeFMIdentTypeIdNameUK on IdentifierType(FMIdentType,Name) where FMIdentType is not null

create table DBO.FX
(
	EventID int not null CONSTRAINT FXPK PRIMARY KEY,
			 			 CONSTRAINT FXEventIDFK FOREIGN KEY (EventId) REFERENCES FXTradeEvent(EventID) ,
	InstrumentID int not null  CONSTRAINT FXInstrumentIdFK FOREIGN KEY REFERENCES Instrument(InstrumentID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT FXUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
create unique index FXInstrumentIDUK on FX(InstrumentID)

create table DBO.Counterparty
(
	LegalEntityID int not null CONSTRAINT CounterpartyPK PRIMARY KEY,
							   CONSTRAINT CounterpartyLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT CounterpartyUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.FX
(
	InstrumentID int not null CONSTRAINT FXPK PRIMARY KEY,
			 			   CONSTRAINT FXFK FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),
	ReceiveCurrencyId int not null CONSTRAINT FXReceiveCurrencyFK FOREIGN KEY (ReceiveCurrencyID) REFERENCES Currency(InstrumentID),
	PayCurrencyId int not null CONSTRAINT FXPayCurrencyFK FOREIGN KEY (PayCurrencyID) REFERENCES Currency(InstrumentID),
	CounterpartyId  int not null CONSTRAINT FXcounterpartyFK FOREIGN KEY (CounterpartyID) REFERENCES Counterparty(LegalEntityID),
	ReceiveAmount decimal(27,8) not null, 
	PayAmount decimal(27,8) not null,
	IsProp bit not null,
	EnteredMultiply bit not null,
	MaturityDate datetime not null,	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT FXUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)


create table DBO.FMContractMapping
(
	FMContId int not null CONSTRAINT FMContractMappingPK PRIMARY KEY,
	InstrumentID int not null  CONSTRAINT FMContractMappingInstrumentFK FOREIGN KEY (InstrumentID) REFERENCES Instrument(InstrumentID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT FMContractMappingUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index FMContractMappingUK on FMContractMapping(InstrumentID,FMContId)