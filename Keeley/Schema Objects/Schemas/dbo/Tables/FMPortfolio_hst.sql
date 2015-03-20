USE Keeley

create table DBO.FMPortfolio_hst(
	FMPortfolioID int not null,
	ReferenceDate datetime not null,
	ISecID int not null,
	BookId int not null,
	Currency varchar(3) not null,
	MaturityDate datetime,
	NetPosition numeric(27,8) not null,
	Price numeric(27,8) not null,
	FXRate numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	DeltaMarketValue numeric(27,8) not null,
	TotalAccrual numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)