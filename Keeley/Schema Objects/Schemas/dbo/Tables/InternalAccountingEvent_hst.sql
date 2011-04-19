USE Keeley

create table DBO.InternalAccountingEvent_hst(
	EventID int not null,
	InstrumentMarketID int not null,
	InternalAccountingEventTypeId int not null,
	TradeDate datetime not null,
	SettlementDate datetime not null,
	TraderId int not null,
	NetPrice numeric(35,16) not null,
	GrossPrice numeric(35,16) not null,
	Quantity numeric(27,8) not null,
	NetConsideration numeric(27,8) not null,
	InstrumentBookFXRate numeric(35,16) not null,
	IsCancelled bit not null,
	AmendmentNumber int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	SettlementCurrencyId int not null,
	EndDt datetime,
	LastActionUserID int)