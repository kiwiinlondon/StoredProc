USE Keeley

create table DBO.ClientPortfolioBridge_hst(
	ClientPortfolioBridgeId int not null,
	ClientAccountId int not null,
	FundId int not null,
	ParentFundId int not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsFirst bit not null,
	MarketValue numeric(27,8) not null,
	Cost numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)