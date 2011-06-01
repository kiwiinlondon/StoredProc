USE Keeley

create table DBO.RawFXRate_hst(
	RawFXRateId int not null,
	CurrencyId int not null,
	ReferenceDate datetime not null,
	ForwardDate datetime not null,
	EntityRankingSchemeItemId int not null,
	BidValue numeric(27,8) not null,
	BidUpdateDate datetime not null,
	AskValue numeric(27,8) not null,
	AskUpdateDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)