USE Keeley

create table DBO.Position_hst(
	PositionId int not null,
	AccountID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	BookID int not null,
	InstrumentMarketID int not null,
	CurrencyID int not null,
	EntityRankingSchemeId int not null,
	EndDt datetime,
	LastActionUserID int)