USE Keeley

create table DBO.ClientPortfolio_hst(
	ClientPortfolioId int not null,
	ClientAccountId int not null,
	FundId int,
	ReferenceDate datetime not null,
	Quantity numeric(27,8) not null,
	ChangeInQuantity numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	PriceId int not null,
	Price numeric(27,8) not null,
	Cost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TodayRealisedPnl numeric(27,8) not null,
	OpeningValue numeric(27,8) not null,
	TodayUnRealisedPnl numeric(27,8) not null,
	ChangeInCost numeric(27,8) not null,
	EqualisationFactor numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)