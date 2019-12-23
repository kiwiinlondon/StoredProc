USE Keeley

create table DBO.TaskDependency_hst(
	TaskDependencyId int not null,
	TaskId int not null,
	DependentTaskId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)