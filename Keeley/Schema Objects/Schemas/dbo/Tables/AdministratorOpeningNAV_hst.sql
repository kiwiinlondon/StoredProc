USE Keeley

create table DBO.AdministratorOpeningNAV_hst(
	AdministratorOpeningValueID int not null,
	FundId int,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)