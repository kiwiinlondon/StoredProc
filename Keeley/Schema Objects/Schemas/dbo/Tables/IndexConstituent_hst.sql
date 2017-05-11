USE Keeley

create table DBO.IndexConstituent_hst(
	IndexConstituentId int not null,
	InstrumentId int not null,
	ConstituentInstrumentMarketId int not null,
	ReferenceDate datetime not null,
	OpenWeight numeric(19,16) not null,
	CumulativeOpenWeight numeric(19,16),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TotalReturn numeric(28,8),
	RebasedTotalReturn numeric(28,16),
	RebasedFxReturnEUR numeric(28,16),
	RebasedFxReturnGBP numeric(28,16),
	RebasedFxReturnUSD numeric(28,16),
	FxReturnEUR numeric(28,16),
	FxReturnGBP numeric(28,16),
	FxReturnUSD numeric(18,16),
	EndDt datetime,
	LastActionUserID int)