USE Keeley

create table DBO.ResearchInstrumentMarketAnalytic_hst(
	ResearchInstrumentMarketAnalyticId int not null,
	ResearchInstrumentMarketId int not null,
	AnalyticTypeId int not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	AsOfDt datetime,
	EndDt datetime,
	LastActionUserID int)