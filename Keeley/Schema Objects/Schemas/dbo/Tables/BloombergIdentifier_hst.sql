USE Keeley

create table DBO.BloombergIdentifier_hst(
	BloombergIdentifierId int not null,
	InstrumentMarketId int not null,
	CurrencyId int not null,
	Id509 varchar(250) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)