USE Keeley

create table DBO.FXTradeEvent_hst(
	EventID int not null,
	ReceiveCurrencyId int not null,
	PayCurrencyId int not null,
	ReceiveAmount decimal not null,
	PayAmount decimal not null,
	IsProp bit not null,
	EnteredMultiply bit not null,
	Ticket varchar(100),
	IsCancelled bit not null,
	CounterpartyId int not null,
	AmendmentNumber int not null,
	MaturityDate datetime not null,
	TraderId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TradeDate datetime not null,
	IsForward bit not null,
	EndDt datetime,
	LastActionUserID int)