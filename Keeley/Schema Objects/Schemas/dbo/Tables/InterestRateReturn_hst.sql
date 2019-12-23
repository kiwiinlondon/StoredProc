USE Keeley

create table DBO.InterestRateReturn_hst(
	InterestRateReturnId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	PriceId int,
	StartDt datetime not null,
	Value numeric(27,8) not null,
	CurrencyId int not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)