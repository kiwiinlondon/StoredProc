USE Keeley

create table DBO.FactsetPortfolio_hst(
	FactSetPortfolioId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	CurrencyId int not null,
	InstrumentName varchar(250) not null,
	OriginalIdentifier varchar(100) not null,
	InstrumentMarketId int,
	InstrumentClassId int,
	FMContId int,
	ReturnContribution numeric(27,8),
	PriceReturnContribution numeric(27,8),
	CurrencyReturnContribution numeric(27,8),
	CarryReturnContribution numeric(27,8),
	IsItd bit not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)