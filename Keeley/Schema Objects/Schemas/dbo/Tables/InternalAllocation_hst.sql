USE Keeley

create table DBO.InternalAllocation_hst(
	EventID int not null,
	FMContEventInd varchar(1),
	FMContEventId int,
	FMOriginalContEventId int,
	MatchedStatusId int not null,
	AccountID int not null,
	BookID int not null,
	Quantity numeric(27,8) not null,
	IsCancelled bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ParentEventId int not null,
	EndDt datetime,
	LastActionUserID int)