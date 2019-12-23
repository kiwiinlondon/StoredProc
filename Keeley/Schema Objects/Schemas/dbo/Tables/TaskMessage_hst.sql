USE Keeley

create table DBO.TaskMessage_hst(
	TaskMessageId int not null,
	TaskId int not null,
	Message varchar(-1),
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	InitiatingEntityId int,
	InitiatingEntityTypeId int,
	InitiatingTaskId int,
	InitiatingTaskRunId int,
	EndDt datetime,
	LastActionUserID int)