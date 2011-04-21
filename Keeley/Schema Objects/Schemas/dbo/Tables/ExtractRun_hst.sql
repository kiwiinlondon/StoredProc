USE Keeley

create table DBO.ExtractRun_hst(
	ExtractRunId int not null,
	ExtractId int not null,
	RunTime datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)