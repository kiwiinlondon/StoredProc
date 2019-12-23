USE Keeley

create table DBO.TaskRun_hst(
	TaskRunId int not null,
	InitiatingTaskId int not null,
	InitiatingTime datetime not null,
	CompletionTime datetime,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TaskRunStateId int not null,
	EndDt datetime,
	LastActionUserID int)