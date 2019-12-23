USE Keeley

create table DBO.FundType_hst(
	FundTypeID int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ExternalTopHoldingCount int not null,
	ExternalDelay int not null,
	ExternalDisplayNonEquity bit not null,
	EndDt datetime,
	LastActionUserID int)