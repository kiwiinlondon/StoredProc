USE Keeley

create table DBO.PeriodicityType_hst(
	PeriodicityTypeId int not null,
	Name varchar(200) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)