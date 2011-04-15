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
	FmCnevSubType varchar(70) not null,
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
	FXRate numeric(35,16) not null,
	FXRateMultiply bit not null,
	AmendmentNumber int not null,
	IsCancelled bit not null,
	CurrencyId int not null  CONSTRAINT InstrumentEventCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),		
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InstrumentEventUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)
	
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

create table DBO.InternalAccountingEventType (
	InternalAccountingEventTypeID int identity(1,1) not null CONSTRAINT InternalAccountingEventTypePK PRIMARY KEY nonclustered,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InternalAccountingEventTypeUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)

create table DBO.InternalAccountingEvent(
	EventID int not null CONSTRAINT InternalAccountingEventPK PRIMARY KEY,
							   CONSTRAINT InternalAccountingEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	InstrumentMarketID int not null CONSTRAINT InternalAccountingEventInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	InternalAccountingEventTypeId int not null  CONSTRAINT InternalAccountingEventInternalAccountingEventTypeIdFK FOREIGN KEY REFERENCES InternalAccountingEventType(InternalAccountingEventTypeID),
	TradeDate DateTime not null,
	SettlementDate DateTime not null,
	TraderId  int not null CONSTRAINT InternalAccountingEventTraderIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	NetPrice numeric(35,16) not null,
	GrossPrice numeric(35,16) not null,
	Quantity  numeric(27,8) not null,	
	NetConsideration numeric(27,8) not null,
	InstrumentBookFXRate numeric(35,16) not null,
	IsCancelled bit not null,
	AmendmentNumber int not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT InternalAccountingEventUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
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
	IsForward bit not null,
	CounterpartyId  int not null CONSTRAINT FXTradeEventCounterpartyIDFK FOREIGN KEY REFERENCES Counterparty(LegalEntityID),
	AmendmentNumber int not null,
	IsCancelled bit not null,
	TradeDate datetime not null,
	MaturityDate datetime not null,
	PayBookXrate numeric(35,16) not null,
	ReceiveBookXrate numeric(35,16) not null,
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
	FXRateMultiply bit not null,
	AmendmentNumber int not null,
	IsCancelled bit not null,
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

create unique index AccountNameUK on Account(Name,CustodianId)
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
          

create table DBO.InternalAllocation(
	EventID int not null CONSTRAINT InternalAllocationEventPK PRIMARY KEY,
							   CONSTRAINT InternalAllocationEventFK FOREIGN KEY (EventID) REFERENCES Event(EventID),
	ParentEventId int not null CONSTRAINT InternalAllocationParentEventIdFK FOREIGN KEY (ParentEventID) REFERENCES Event(EventID),
	FMContEventInd varchar(1) not null,
	FMContEventId int not null,
	FMOriginalContEventId int not null,
	MatchedStatusId int not null CONSTRAINT InternalAllocationMatchedStatusIdFK FOREIGN KEY (MatchedStatusID) REFERENCES MatchedStatus(MatchedStatusID),
	AccountID int not null CONSTRAINT InternalAllocationAccountIDFK FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	BookID int not null CONSTRAINT InternalAllocationBookIDFK FOREIGN KEY (BookID) REFERENCES Book(BookID),
	Quantity  numeric(27,8) not null,
	IsCancelled bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT AccountAllocationUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)			


create unique index InternalAllocationFMContEventIdUK on InternalAllocation(FMContEventInd,FMContEventId)
create unique index InternalAllocationFMOriginalContEventIdUK on InternalAllocation(FMContEventInd,FMOriginalContEventId)
create unique index InternalAllocationUK on InternalAllocation(ParentEventId,BookID,AccountID)


create table PositionAccount(
	PositionAccountID int identity(1,1) not null CONSTRAINT PositionAccountPK PRIMARY KEY,
	AccountID int not null CONSTRAINT PositionAccountAccountIDFK FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
	BookID int not null CONSTRAINT PositionAccountBookIDFK FOREIGN KEY REFERENCES Book(BookID),
	InstrumentMarketID int not null CONSTRAINT PositionAccountInstrumentMarketIDFK FOREIGN KEY REFERENCES InstrumentMarket(InstrumentMarketID),
	CurrencyID int not null CONSTRAINT PositionAccountCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentID),	
	PositionId int not null CONSTRAINT PositionAccountPositionIDFK FOREIGN KEY (PositionID) REFERENCES Position(PositionID),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionAccountUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	
create unique index PositionAccountUK on PositionAccount(positionId, AccountId)
create unique index PositionAccountUK2 on PositionAccount(BookId,InstrumentMarketID,CurrencyID, AccountId)



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

INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Internal Allocation',GETDATE(),1) 

INSERT INTO [Keeley].[dbo].[EventType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Internal Accounting Event',GETDATE(),1) 
GO

create table ChargeType(
	ChargeTypeId  int identity(1,1) not null CONSTRAINT ChargeTypePK PRIMARY KEY,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ChargeTypeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null)

create table Charge(
	ChargeId  int identity(1,1) not null CONSTRAINT ChargePK PRIMARY KEY,
	EventID int not null CONSTRAINT ChargeEventIDFK FOREIGN KEY REFERENCES Event(EventID),
	ReferenceDate DateTime not null,
	ChargeTypeId int not null CONSTRAINT ChargeChargeTypeIDFK FOREIGN KEY REFERENCES ChargeType(ChargeTypeId),
	CurrencyId int not null CONSTRAINT ChargeCurrencyIDFK FOREIGN KEY REFERENCES Currency(InstrumentId),
	Quantity  numeric(27,8) not null,
	FXRate numeric(35,16) not null,
	FXRateMultiply bit not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT ChargeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null)

create table PortfolioAggregationLevel (
	PortfolioAggregationLevelId int identity(1,1) not null CONSTRAINT PortfolioAggregationLevelPK PRIMARY KEY,
	Name varchar(50) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioAggregationLevelUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null)

create unique index PortfolioAggregationLevelUK on PortfolioAggregationLevel(Name)

create table PositionAccountMovementType (
	PositionAccountMovementTypeId int identity(1,1) not null CONSTRAINT PositionAccountMovementTypePK PRIMARY KEY,
	Name varchar(50) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionAccountMovementTypeUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null)

create unique index PositionAccountMovementTypeUK on PositionAccountMovementType(Name)

create table DBO.PositionAccountMovement(
	PositionAccountMovementID int identity(1,1) not null CONSTRAINT PositionAccountMovementPK PRIMARY KEY,
	InternalAllocationId int not null CONSTRAINT PositionAccountMovementPositionInternalAllocationIdFK FOREIGN KEY REFERENCES InternalAllocation(EventId),
	PositionAccountId int not null CONSTRAINT PositionAccountMovementPositionAccountIdFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountId),
	ReferenceDate DateTime not null,
	PortfolioAggregationLevelId int not null CONSTRAINT PositionAccountMovementPortfolioAggregationLevelIdFK FOREIGN KEY REFERENCES PortfolioAggregationLevel(PortfolioAggregationLevelId),
	PositionAccountMovementTypeId int not null CONSTRAINT PositionAccountMovementPositionAccountMovementTypeIdFK FOREIGN KEY REFERENCES PositionAccountMovementType(PositionAccountMovementTypeId),
	ChangeNumber int not null,
	Quantity numeric(27, 8) NOT NULL,
	FXRate numeric(35, 16) NOT NULL,
	Price numeric(35, 16) NOT NULL,
	NetCostChangeInstrumentCurrency numeric(27, 8) NOT NULL,
	NetCostChangeBookCurrency numeric(27, 8) NOT NULL,	
	NetCostInstrumentCurrency numeric(27, 8) NOT NULL,
	NetCostBookCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostChangeInstrumentCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostChangeBookCurrency numeric(27, 8) NOT NULL,	
	DeltaNetCostInstrumentCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostBookCurrency numeric(27, 8) NOT NULL,
	NetPosition numeric (27, 8) NOT NULL,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PositionAccountMovementUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null)

	create unique index PositionAccountMovementUK on PositionAccountMovement(PositionAccountMovementId,PortfolioAggregationLevelId)
	create index PositionAccountMovement1 on PositionAccountMovement(PositionAccountId,ReferenceDate,PortfolioAggregationLevelId)
	create index PositionAccountMovement2 on PositionAccountMovement(PositionAccountId,ChangeNumber,PortfolioAggregationLevelId)

create table PortfolioPositionAccountTradeDate(
	PortfolioPositionAccountTradeDateId  int identity(1,1) not null CONSTRAINT PortfolioPositionAccountTradeDatePK PRIMARY KEY,
	PositionAccountID int not null CONSTRAINT PortfolioPositionAccountTradeDatePositionAccountIDFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountID),
	ReferenceDate DateTime not null,
	NetPosition  numeric(27,8) not null,
	TotalCost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioPositionAccountTradeDateUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

create table PortfolioPositionAccountSettlementDate(
	PortfolioPositionAccountSettlementDateId  int identity(1,1) not null CONSTRAINT PortfolioPositionAccountSettlementDatePK PRIMARY KEY,
	PositionAccountID int not null CONSTRAINT PortfolioPositionAccountSettlementDatePositionAccountIDFK FOREIGN KEY REFERENCES PositionAccount(PositionAccountID),
	ReferenceDate DateTime not null,
	NetPosition  numeric(27,8) not null,	
	NetPostionChange numeric(27,8) not null,	
	NetCostInstrumentCurrency numeric(27, 8) NOT NULL,
	NetCostBookCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostInstrumentCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostBookCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostChangeInstrumentCurrency numeric(27, 8) NOT NULL,
	DeltaNetCostChangeBookCurrency numeric(27, 8) NOT NULL,	
	NetCostChangeInstrumentCurrency numeric(27, 8) NOT NULL,
	NetCostChangeBookCurrency numeric(27, 8) NOT NULL,	
	StartDt datetime not null,
	UpdateUserID int not null CONSTRAINT PortfolioPositionAccountSettlementDateUpdateUserIDFK FOREIGN KEY REFERENCES ApplicationUser(UserID),
	DataVersion rowversion not null
)	

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Equity Trade',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Non Equity Trade',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Proprietary FX Trade',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Hedging FX Trade',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Subscription',GETDATE(),1)
           
INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Redemption',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Internal Accounting',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Instrument Event',GETDATE(),1)

INSERT INTO [Keeley].[dbo].[PositionAccountMovementType]
           ([Name],[StartDt],[UpdateUserID])
     VALUES
           ('Cash From Trading',GETDATE(),1)