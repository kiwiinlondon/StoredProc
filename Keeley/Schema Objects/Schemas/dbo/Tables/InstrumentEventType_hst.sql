USE Keeley

create table DBO.InstrumentEventType_hst(
	InstrumentEventTypeID int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FmCnevSubType varchar(70) not null,
	EndDt datetime,
	LastActionUserID int)