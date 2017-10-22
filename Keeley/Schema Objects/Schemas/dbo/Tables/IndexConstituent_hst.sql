USE Keeley

create table DBO.IndexConstituent_hst(
	IndexConstituentId int not null,
	InstrumentId int not null,
	ConstituentInstrumentMarketId int not null,
	CurrencyId int not null,
	ReferenceDate datetime not null,
	OpenWeight numeric(19,16) not null,
	PriceReturn numeric(19,16),
	TotalReturn numeric(19,16),
	FxReturn numeric(19,16),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)