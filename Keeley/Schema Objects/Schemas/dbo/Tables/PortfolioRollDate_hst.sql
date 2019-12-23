USE Keeley

create table DBO.PortfolioRollDate_hst(
	PortfolioRollDateId int not null,
	PortfolioAggregationLevelId int not null,
	RollDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)