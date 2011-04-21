USE Keeley

create table DBO.ExtractEvent_hst(
	ExtractEventID int not null,
	ExtractId int not null,
	EventId int not null,
	LastSentInExtractRunId int,
	SendInNextRun bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)