USE Keeley

create table DBO.InstrumentRelationship_hst(
	UnderlyingInstrumentID int not null,
	OverlyingInstrumentID int not null,
	UnderlyerPerOverlyer numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)