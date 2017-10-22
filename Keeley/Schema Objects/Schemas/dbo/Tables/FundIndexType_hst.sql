USE Keeley

create table DBO.FundIndexType_hst(
	FundIndexTypeId int not null,
	Name varchar(150) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)