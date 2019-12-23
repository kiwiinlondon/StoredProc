USE Keeley

create table DBO.ReportDefinition_hst(
	ReportDefinitionId int not null,
	JSON varchar(-1) not null,
	ReportTypeId int not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)