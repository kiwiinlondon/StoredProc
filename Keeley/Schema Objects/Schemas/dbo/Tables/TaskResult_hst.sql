USE Keeley

create table DBO.TaskResult_hst(
	TaskResultId int not null,
	TaskId int not null,
	TaskResultTypeId int not null,
	Notes varchar(2000) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TaskRunId int not null,
	AffectedEntityCount int,
	RetryAttempt int not null,
	EndDt datetime,
	LastActionUserID int)