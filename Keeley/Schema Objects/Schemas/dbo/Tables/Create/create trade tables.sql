create table DBO.EventType (
	EventTypeID int identity(1,1) not null CONSTRAINT EventTypePK PRIMARY KEY,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT EventTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index EventTypeNameUK on EventType(Name)	

create table DBO.InstrumentEventType (
	InstrumentEventTypeID int identity(1,1) not null CONSTRAINT InstrumentEventTypePK PRIMARY KEY nonclustered,
	Name varchar(70) not null,
	FmContClass varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentEventTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create unique index InstrumentEventTypeNameUK on InstrumentEventType(Name)
create unique index InstrumentEventTypeFmContClassUK on InstrumentEventType(FmContClass)
	
create table DBO.Event (
	EventID int identity(1,1) not null CONSTRAINT EventPK PRIMARY KEY,
	EventTypeID int not null CONSTRAINT EventEventTypeIDFK FOREIGN KEY REFERENCES EventType(EventTypeID),
	IdentifierTypeId int not null  CONSTRAINT EventIdentifierTypeIDFK FOREIGN KEY REFERENCES IdentifierType(IdentifierTypeID),
	Identifier varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT EventUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	


create table DBO.InstrumentEvent(
	EventID int not null CONSTRAINT InstrumentEventPK PRIMARY KEY,
							   CONSTRAINT InstrumentEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	InstrumentMarketID int not null CONSTRAINT InstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	InstrumentEventTypeID int not null  CONSTRAINT InstrumentEventTypeIDFK FOREIGN KEY REFERENCES InstrumentEventType(InstrumentEventTypeID),
	EventDate DateTime not null,
	ValueDate DateTime not null,
	Quantity  numeric(27,8) not null,
	Price numeric(35,16) not null,
	FXRate numeric(35,16) not null,
	CurrencyId int not null  CONSTRAINT InstrumentEventCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),		
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentEventUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
	
drop table TradeEvent
create table DBO.TradeEvent(
	EventID int not null CONSTRAINT TradeEventPK PRIMARY KEY,
							   CONSTRAINT TradeEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	InstrumentMarketID int not null CONSTRAINT TradeEventInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	TradeDate DateTime not null,
	SettlementDate DateTime not null,
	TraderId  int not null CONSTRAINT TradeEventTraderIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	GrossPrice numeric(35,16) not null,
	NetPrice numeric(35,16) not null,
	Quantity  numeric(27,8) not null,
	BuySellReasonId int not null CONSTRAINT TradeEventBuySellReasonIdFK FOREIGN KEY REFERENCES BuySellReason(BuySellReasonID),
	TradedNet bit not null,
	PriceIsClean bit not null,
	TradeCurrencyId int not null CONSTRAINT TradeEventTradeCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	SettlementCurrencyId int not null CONSTRAINT TradeEventSettlementCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	NetConsideration numeric(27,8) not null,
	GrossConsideration numeric(27,8) not null,
	CounterpartyId int not null CONSTRAINT TradeEventCounterpartyIDFK FOREIGN KEY REFERENCES Counterparty(LegalEntityID),
	TradeSettlementFXRate numeric(35,16) not null,
	TradeSettlementFXRateMultiply bit not null,
	TradeInstrumentFXRate numeric(35,16) not null,
	TradeInstrumentFXRateMultiply bit not null,
	InstrumentBookFXRate numeric(35,16) not null,
	Ticket varchar(100),
	IsCancelled bit not null,
	AmendmentNumber int not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT TradeEventUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.FXTradeEvent
(
	EventID int not null CONSTRAINT FXTradeEventPK PRIMARY KEY,
			 			   CONSTRAINT FXTradeEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	ReceiveCurrencyId int not null CONSTRAINT FXTradeReceiveCurrencyFK FOREIGN KEY REFERENCES Currency(InstrumentID),
	PayCurrencyId int not null CONSTRAINT FXTradePayCurrencyFK FOREIGN KEY REFERENCES Currency(InstrumentID),
	ReceiveAmount decimal(27,8) not null, 
	PayAmount decimal(27,8) not null,
	IsProp bit not null,
	EnteredMultiply bit not null,
	Ticket varchar(100),
	IsCancelled bit not null,
	IsForward bit not null,
	CounterpartyId  int not null CONSTRAINT FXTradeEventCounterpartyIDFK FOREIGN KEY REFERENCES Counterparty(LegalEntityID),
	AmendmentNumber int not null,
	TradeDate datetime not null,
	MaturityDate datetime not null,
	TraderId  int not null CONSTRAINT FXTradeEventTraderIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT FXTradeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

	
create table DBO.CapitalEvent(
	EventID int not null CONSTRAINT CapitalEventPK PRIMARY KEY,
							   CONSTRAINT CapitalEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	TradeDate DateTime not null,
	SettlementDate DateTime not null,
	Quantity  numeric(27,8) not null,
	FXRate numeric(35,16) not null,
	CurrencyId int not null CONSTRAINT CapitalEventCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT CapitalEventUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
	)

create table DBO.Custodian
(
	LegalEntityID int not null CONSTRAINT CustodianPK PRIMARY KEY,
							   CONSTRAINT CustodianLegalEntiyFK FOREIGN KEY (LegalEntityID) REFERENCES LegalEntity(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT CustodianUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table Account (
	AccountID int identity(1,1) not null CONSTRAINT AccountPK PRIMARY KEY,
	Name varchar(100) not null,
	FundId  int not null CONSTRAINT AccountFundIDFK FOREIGN KEY REFERENCES Fund(LegalEntityID),
	ExternalId varchar(30) not null,
	CustodianId int not null CONSTRAINT AccountCustodianIDFK FOREIGN KEY REFERENCES Custodian(LegalEntityID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT AccountUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index AccountNameUK on Account(Name)
create unique index AccountExternalIdCustodianIdUK on Account(CustodianId,ExternalId)

create table BuySellReason(
	BuySellReasonID int identity(1,1) not null CONSTRAINT BuySellReasonPK PRIMARY KEY,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT BuySellReasonUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index BuySellReasonCodeUK on BuySellReason(Code)
create unique index BuySellReasonNameUK on BuySellReason(Name)

create table MatchedStatus(
	MatchedStatusID int identity(1,1) not null CONSTRAINT MatchedStatusPK PRIMARY KEY,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT MatchedStatusUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create unique index MatchedStatusCodeUK on MatchedStatus(Code)
create unique index MatchedStatusNameUK on MatchedStatus(Name)
          

create table InternalAllocation(
	InternalAllocationID int identity(1,1) not null CONSTRAINT InternalAllocationPK PRIMARY KEY,
	EventID int not null CONSTRAINT InternalAllocationEventIDFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	FMContEventInd varchar(1) not null,
	FMContEventId int not null,
	FMOriginalContEventId int not null,
	MatchedStatusId int not null CONSTRAINT InternalAllocationMatchedStatusIdFK FOREIGN KEY (MatchedStatusID) REFERENCES MatchedStatus(MatchedTypeID),
	AccountID int not null CONSTRAINT InternalAllocationAccountIDFK FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	BookID int not null CONSTRAINT InternalAllocationBookIDFK FOREIGN KEY (BookID) REFERENCES Book(BookID),
	Quantity  numeric(27,8) not null,
	IsCancelled bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT AccountAllocationUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)			

alter table InternalAllocation add IsCancelled bit not null,

create unique index InternalAllocationFMContEventIdUK on InternalAllocation(FMContEventInd,FMContEventId)
create unique index InternalAllocationFMOriginalContEventIdUK on InternalAllocation(FMContEventInd,FMOriginalContEventId)

create table PositionAccount(
	PositionAccountID int identity(1,1) not null CONSTRAINT PositionAccountPK PRIMARY KEY,
	AccountID int not null CONSTRAINT PositionAccountAccountIDFK FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	PositionId int not null CONSTRAINT PositionAccountPositionIDFK FOREIGN KEY (PositionID) REFERENCES Position(PositionID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionAccountUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create table PositionAccountMovement(
	PositionAccountMovementID int identity(1,1) not null CONSTRAINT PositionAccountMovementPK PRIMARY KEY,
	InternalAllocationID int not null CONSTRAINT PositionAccountMovementInternalAllocationIDFK FOREIGN KEY REFERENCES InternalAllocation(InternalAllocationID),
	PositionAccountID int not null CONSTRAINT PositionAccountMovementPositionAccountIDFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountID),
	Quantity  numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionAccountMovementUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create table PortfolioPositionAccountTradeDate(
	PortfolioPositionAccountTradeDateId  int identity(1,1) not null CONSTRAINT PortfolioPositionAccountTradeDatePK PRIMARY KEY,
	PositionAccountID int not null CONSTRAINT PortfolioPositionAccountTradeDatePositionAccountIDFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountID),
	ReferenceDate DateTime not null,
	Quantity  numeric(27,8) not null,
	TotalCost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioPositionAccountTradeDateUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create table PortfolioPositionAccountSettlementDate(
	PortfolioPositionAccountSettlementDateId  int identity(1,1) not null CONSTRAINT PortfolioPositionAccountSettlementDatePK PRIMARY KEY,
	PositionAccountID int not null CONSTRAINT PortfolioPositionAccountSettlementDatePositionAccountIDFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountID),
	ReferenceDate DateTime not null,
	Quantity  numeric(27,8) not null,
	TotalCost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioPositionAccountSettlementDateUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Trade Event',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Instrument Event',GETDATE(),1)           

INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Capital Event',GETDATE(),1)      
		   
INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('FX Trade Event',GETDATE(),1)   		        
GO

create table DBO.PositionAccountMovement_hst(
	PositionAccountMovementID int not null,
	InternalAllocationID int not null,
	PositionAccountID int not null,
	Quantity numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)