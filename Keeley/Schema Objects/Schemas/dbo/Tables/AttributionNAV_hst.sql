USE Keeley

create table DBO.AttributionNav_hst(
	AttributionNavId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	AttributionSourceId int not null,
	OpeningNAV numeric(15,2) not null,
	NAV numeric(15,2) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PercentageOfFund numeric(9,8) not null,
	KeeleyIsMaster bit not null,
	CurrencyId int not null,
	TodayPNL numeric(15,2) not null,
	EndDt datetime,
	LastActionUserID int)