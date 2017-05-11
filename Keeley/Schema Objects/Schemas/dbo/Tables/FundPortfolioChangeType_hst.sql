USE Keeley

create table DBO.FundPortfolioChangeType_hst(
	FundPortfolioChangeTypeId int not null,
	Name varchar(50) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)