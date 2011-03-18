USE Keeley

create table DBO.CapitalEvent_hst(
	EventID int not null,
	TradeDate datetime not null,
	SettlementDate datetime not null,
	Quantity numeric(27,8) not null,
	FXRate numeric(35,16) not null,
	CurrencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)