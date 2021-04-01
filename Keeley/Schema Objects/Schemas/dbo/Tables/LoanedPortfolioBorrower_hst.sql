USE Keeley

create table DBO.LoanedPortfolioBorrower_hst(
	BorrowerId int not null,
	Name varchar(100) not null,
	PBIdentfier varchar(20) not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)