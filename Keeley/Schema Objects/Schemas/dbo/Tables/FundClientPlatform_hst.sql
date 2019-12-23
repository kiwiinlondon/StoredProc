USE Keeley

create table DBO.FundClientPlatform_hst(
	FundClientPlatformId int not null,
	FundId int not null,
	ClientPlatformId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)