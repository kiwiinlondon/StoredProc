USE Keeley

create table DBO.FundPortfolioChange_hst(
	FundPortfolioChangeID int not null,
	StartDt datetime not null,
	FundId int not null,
	ReferenceDate datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)