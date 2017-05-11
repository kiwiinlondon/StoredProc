USE Keeley

create table DBO.EntityAnalyticType_hst(
	EntityAnalyticTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InputMonthCount int,
	EndDt datetime,
	LastActionUserID int)