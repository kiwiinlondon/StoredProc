USE Keeley

create table DBO.RestrictedList_hst(
	RestrictedListId int not null,
	InstrumentId int not null,
	EffvFromDt datetime not null,
	EffvToDt datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)