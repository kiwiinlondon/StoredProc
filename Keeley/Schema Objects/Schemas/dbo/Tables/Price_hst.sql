USE Keeley

create table DBO.Price_hst(
	PriceId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	EntityRankingSchemeId int not null,
	RawPriceId int not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)