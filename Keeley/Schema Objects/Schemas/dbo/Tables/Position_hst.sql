USE Keeley

create table DBO.Position_hst(
	PositionID int not null,
	BookID int not null,
	StrategyID int not null,
	InstrumentMarketID int not null,
	TradeTypeID int not null,
	CurrencyID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)