USE Keeley

create table DBO.ClientPortfolio2_hst(
	ClientPortfolioId varchar(50) not null,
	ReferenceDate int not null,
	ClientName varchar(100) not null,
	AccountName varchar(20),
	Value numeric(27,8),
	EndDt datetime,
	LastActionUserID int)