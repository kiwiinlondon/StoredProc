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
	IsActive bit not null,
	FundTypeId int not null,
	IsExternallyVisible bit not null,
	InceptionDate datetime not null,
	RiskFreeInstrumentMarketId int,
	DealingDateDefinitionId int not null,
	EndDt datetime,
	LastActionUserID int)