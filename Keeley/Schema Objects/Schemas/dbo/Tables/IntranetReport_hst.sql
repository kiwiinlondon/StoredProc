USE Keeley

create table DBO.IntranetReport_hst(
	IntranetReportId int not null,
	Name varchar(100) not null,
	Path varchar(300) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)