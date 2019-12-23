USE Keeley

create table DBO.Task_hst(
	TaskId int not null,
	TaskTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TaskNotCompleteBehaviourId int,
	MaxRetryAttempts int not null,
	EndDt datetime,
	LastActionUserID int)