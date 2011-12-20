USE Keeley

create table DBO.Analytic_hst(
	AnalyticId int not null,
	AnalyticTypeID int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	rawanalyticId int,
	EndDt datetime,
	LastActionUserID int)