USE Keeley

create table DBO.RawPrice_hst(
	RawPriceId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	EntityRankingSchemeItemId int not null,
	BidValue numeric(27,8) not null,
	BidUpdateDate datetime not null,
	AskValue numeric(27,8) not null,
	AskUpdateDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	RawPriceUsedId int,
	EndDt datetime,
	LastActionUserID int)