USE Keeley

create table DBO.IndexConstituent_hst(
	IndexConstituentId int not null,
	InstrumentId int not null,
	ConstituentInstrumentId int not null,
	ReferenceDate datetime not null,
	Weighting numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)