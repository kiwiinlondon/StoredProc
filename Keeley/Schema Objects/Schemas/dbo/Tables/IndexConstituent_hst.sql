USE Keeley

create table DBO.IndexConstituent_hst(
	IndexConstituentId int not null,
	InstrumentId int not null,
	ConstituentInstrumentMarketId int not null,
	CurrencyId int not null,
	ReferenceDate datetime not null,
	OpenWeight numeric(25,19) not null,
	PriceReturn numeric(25,19) not null,
	TotalReturn numeric(25,19) not null,
	FxReturn numeric(25,19) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ConstituentCurrencyId int,
	EndDt datetime,
	LastActionUserID int)