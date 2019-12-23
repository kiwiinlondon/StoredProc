USE Keeley

create table DBO.FundWebsiteCacheTime_hst(
	FundID int not null,
	LastCleared datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)