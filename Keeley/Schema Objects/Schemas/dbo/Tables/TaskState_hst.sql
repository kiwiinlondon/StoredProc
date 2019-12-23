USE Keeley

create table DBO.TaskState_hst(
	TaskId int not null,
	TaskStateTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	LastTaskRunId int not null,
	ExecutionSet int not null,
	RetryAttempts int not null,
	InitiatingTime datetime not null,
	CompletionTime datetime,
	Acknowledged bit not null,
	EndDt datetime,
	LastActionUserID int)