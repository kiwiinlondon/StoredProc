USE Keeley

create table DBO.Strategy_hst(
	StrategyID int not null,
	FMStrategy varchar(15),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)