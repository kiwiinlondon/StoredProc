USE Keeley

create table DBO.EventInstrumentMap_hst(
	EventID int not null,
	InstrumentID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)