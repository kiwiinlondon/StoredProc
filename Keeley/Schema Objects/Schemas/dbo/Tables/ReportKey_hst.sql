USE Keeley

create table DBO.ReportKey_hst(
	ReportKeyId int not null,
	HashKey varchar(-1) not null,
	ReportKeyTypeId int not null,
	ReportDefinitionId int not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)