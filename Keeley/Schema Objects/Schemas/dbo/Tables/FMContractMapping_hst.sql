USE Keeley

create table DBO.FMContractMapping_hst(
	FMContId int not null,
	InstrumentID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)