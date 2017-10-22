USE Keeley

create table DBO.AnalyticType_hst(
	AnalyticTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FMValueSpecId int,
	BloombergMnemonic varchar(100),
	EndDt datetime,
	LastActionUserID int)