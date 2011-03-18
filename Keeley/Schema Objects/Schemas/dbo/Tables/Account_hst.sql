USE Keeley

create table DBO.Account_hst(
	AccountID int not null,
	Name varchar(100) not null,
	ExternalId varchar(30) not null,
	CustodianId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FundId int not null,
	EndDt datetime,
	LastActionUserID int)