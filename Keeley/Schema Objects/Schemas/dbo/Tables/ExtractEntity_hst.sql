USE Keeley

create table DBO.ExtractEntity_hst(
	ExtractEntityID int not null,
	ExtractId int not null,
	EntityId int not null,
	LastSentInExtractRunId int,
	IsCancelled bit not null,
	SendInNextRun bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EntityTypeId int not null,
	EndDt datetime,
	LastActionUserID int)