USE Keeley

create table DBO.ReportType_hst(
	ReportTypeId int not null,
	Name varchar(256) not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)