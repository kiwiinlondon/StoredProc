USE Keeley

create table DBO.CapitalEvent_hst(
	EventID int not null,
	TradeDate datetime not null,
	SettlementDate datetime not null,
	Quantity numeric(27,8) not null,
	AmendmentNumber int not null,
	IsCancelled bit not null,
	CurrencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InputDate datetime not null,
	AdministratorTradeDate datetime not null,
	EndDt datetime,
	LastActionUserID int)