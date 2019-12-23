USE Keeley

create table DBO.TaskAlert_hst(
	TaskAlertId int not null,
	TaskAlertTypeId int not null,
	TaskId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ApplyToSubTask bit not null,
	EndDt datetime,
	LastActionUserID int)