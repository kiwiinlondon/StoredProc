USE Keeley

create table DBO.Fund_hst(
	LegalEntityID int not null,
	CurrencyID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PositionsExist bit not null,
	PerfFundName varchar(100),
	InstrumentMarketId int,
	BenchmarkInstrumentMarketId int,
	ParentFundId int,
	EndDt datetime,
	LastActionUserID int)