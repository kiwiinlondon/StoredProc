USE Keeley

create table DBO.ClientPortfolioByClientShareClass_hst(
	ClientPortfolioByClientShareClassId int not null,
	ClientId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	ITDReturn numeric(27,8) not null,
	TodayReturn numeric(27,8) not null,
	TodayRedemptionPnl numeric(27,8) not null,
	OpeningValue numeric(27,8) not null,
	OpeningValueAfterTodaysTrades numeric(27,8) not null,
	TodayPnl numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)