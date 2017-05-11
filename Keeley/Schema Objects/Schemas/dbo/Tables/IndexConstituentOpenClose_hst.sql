USE Keeley

create table DBO.IndexConstituentOpenClose_hst(
	IndexConstituentOpenCloseId int not null,
	ReferenceDate datetime not null,
	InstrumentMarketId int not null,
	IndexInstrumentId int not null,
	IsOpen bit not null,
	IsClose bit not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	StartDt datetime not null,
	EndDt datetime,
	LastActionUserID int)