USE Keeley

create table DBO.ClientPortfolioBridge_hst(
	ClientPortfolioBridgeId int not null,
	ClientAccountId int not null,
	FundId int not null,
	ParentFundId int not null,
	ReferenceDate datetime not null,
	UpdateReturns bit not null,
	ClientFundReturnId int,
	AccountFundReturnId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CurrencyId int not null,
	EndDt datetime,
	LastActionUserID int)