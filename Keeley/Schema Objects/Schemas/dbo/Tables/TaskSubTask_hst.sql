USE Keeley

create table DBO.TaskSubTask_hst(
	TaskSubTaskId int not null,
	ParentTaskId int not null,
	SubTaskId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)