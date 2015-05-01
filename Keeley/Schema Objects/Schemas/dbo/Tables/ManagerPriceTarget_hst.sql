USE Keeley

create table DBO.ManagerPriceTarget_hst(
	ManagerPriceRangeId int not null,
	ManagerId int not null,
	InstrumentMarketId int not null,
	StopLossPrice numeric(27,8),
	TargetPrice numeric(27,8),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)