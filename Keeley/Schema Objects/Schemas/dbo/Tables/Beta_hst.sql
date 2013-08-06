USE Keeley

create table DBO.Beta_hst(
	BetaId int not null,
	AnalyticTypeId int not null,
	InstrumentMarketId int not null,
	RelativeIndexInstrumentMarketId int not null,
	CurrencyId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)