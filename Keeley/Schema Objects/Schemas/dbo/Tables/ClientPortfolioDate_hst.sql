USE Keeley

create table DBO.ClientPortfolioDate_hst(
	ClientPortfolioDateId int not null,
	ClientAccountId int not null,
	FundId int not null,
	FirstTradeDate datetime not null,
	OriginalInvestment numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)