USE Keeley

create table DBO.ReportBaseline_hst(
	ReportBaselineId int not null,
	Name varchar(250),
	FundIds varchar(250),
	JSON varchar(-1) not null,
	GenerateEndOfLastYear bit not null,
	GenerateEndOfLastMonth bit not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)