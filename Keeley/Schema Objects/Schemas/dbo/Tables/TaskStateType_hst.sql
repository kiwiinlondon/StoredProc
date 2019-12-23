USE Keeley

create table DBO.TaskStateType_hst(
	TaskStateTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Description varchar(1000),
	EndDt datetime,
	LastActionUserID int)