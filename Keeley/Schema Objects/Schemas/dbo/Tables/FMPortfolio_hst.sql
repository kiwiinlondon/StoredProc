USE Keeley

create table DBO.FMPortfolio_hst(
	FMPortfolioID int not null,
	ReferenceDate datetime not null,
	ISecID int not null,
	BookId int not null,
	Currency varchar(3) not null,
	MaturityDate datetime,
	NetPosition decimal not null,
	Price decimal not null,
	FXRate decimal not null,
	MarketValue decimal not null,
	DeltaMarketValue decimal not null,
	TotalAccrual decimal not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)