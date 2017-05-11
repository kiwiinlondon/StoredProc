USE Keeley

create table DBO.Future_hst(
	InstrumentId int not null,
	MaturityDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)