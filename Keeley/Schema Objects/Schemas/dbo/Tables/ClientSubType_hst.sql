USE Keeley

create table DBO.ClientSubType_hst(
	ClientSubTypeId int not null,
	Name varchar(100) not null,
	ClientTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)