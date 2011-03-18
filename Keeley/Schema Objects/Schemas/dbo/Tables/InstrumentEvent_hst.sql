USE Keeley

create table DBO.InstrumentEvent_hst(
	EventID int not null,
	InstrumentMarketID int not null,
	InstrumentEventTypeID int not null,
	EventDate datetime not null,
	ValueDate datetime not null,
	Quantity numeric(27,8) not null,
	Price numeric(35,16) not null,
	FXRate numeric(35,16) not null,
	CurrencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)