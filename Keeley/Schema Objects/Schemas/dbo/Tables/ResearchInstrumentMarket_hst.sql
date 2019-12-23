USE Keeley

create table DBO.ResearchInstrumentMarket_hst(
	ResearchInstrumentMarketId int not null,
	ResearchId int not null,
	InstrumentMarketId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsPrimary bit not null,
	EndDt datetime,
	LastActionUserID int)