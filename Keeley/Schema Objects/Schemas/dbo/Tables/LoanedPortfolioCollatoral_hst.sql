USE Keeley

create table DBO.LoanedPortfolioCollatoral_hst(
	LoanedPortfolioCollatoralId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	BorrowerId int not null,
	InstrumentMarketId int not null,
	Quantity numeric(27,8) not null,
	Price numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)