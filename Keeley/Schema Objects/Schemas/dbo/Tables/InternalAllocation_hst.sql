USE Keeley

create table DBO.InternalAllocation_hst(
	InternalAllocationID int not null,
	EventID int not null,
	FMContEventInd varchar(1) not null,
	FMContEventId int not null,
	AccountID int not null,
	BookID int not null,
	Quantity numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FMOriginalContEventId int not null,
	IsCancelled bit not null,
	MatchedStatusId int not null,
	EndDt datetime,
	LastActionUserID int)