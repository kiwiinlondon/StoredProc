USE Keeley

create table DBO.PublishedReport_hst(
	PublishedReportId int not null,
	ReportGuid varchar(250) not null,
	ReportName varchar(250) not null,
	FundIds varchar(250),
	RelativeDateId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)