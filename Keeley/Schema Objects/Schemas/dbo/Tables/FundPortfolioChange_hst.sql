USE Keeley

create table DBO.FundPortfolioChange_hst(
	FundPortfolioChangeId int not null,
	FundId int not null,
	FundPortfolioChangeTypeId int not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)