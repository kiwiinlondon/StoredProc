USE Keeley

create table DBO.ClientPortfolioPeriodReturn_hst(
	ClientPortfolioPeriodReturnID int not null,
	StartDt datetime not null,
	CurrentUnrealisedPnl numeric(27,8) not null,
	ITDNumberDays int not null,
	ITDRealisedPnl numeric(27,8) not null,
	TwelveMonthNumberDays int not null,
	TwelveMonthSumCost numeric(27,8) not null,
	TwelveMonthRealisedPnl numeric(27,8) not null,
	IsLast bit not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)