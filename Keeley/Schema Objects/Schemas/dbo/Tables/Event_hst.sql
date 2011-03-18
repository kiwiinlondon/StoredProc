USE Keeley

create table DBO.Event_hst(
	EventID int not null,
	EventTypeID int not null,
	IsCancelled bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)