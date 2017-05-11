USE Keeley

create table DBO.InstrumentEvent_hst(
	EventID int not null,
	InstrumentMarketID int not null,
	InstrumentEventTypeID int not null,
	EventDate datetime not null,
	ValueDate datetime not null,
	Quantity numeric(27,8) not null,
	AmendmentNumber int not null,
	IsCancelled bit not null,
	CurrencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InputDate datetime not null,
	ExDate datetime not null,
	Price numeric(27,8),
	EndDt datetime,
	LastActionUserID int)