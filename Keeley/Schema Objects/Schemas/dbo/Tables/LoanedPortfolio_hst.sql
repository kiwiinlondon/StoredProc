USE Keeley

create table DBO.LoanedPortfolio_hst(
	LoanedPortfolioId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	BorrowerId int not null,
	InstrumentMarketId int not null,
	Quantity numeric(27,8) not null,
	Price numeric(27,8),
	MarketValue numeric(27,8),
	Rate numeric(27,8),
	GrossFee numeric(27,8),
	PBFee numeric(27,8),
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)