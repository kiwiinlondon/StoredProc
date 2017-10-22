USE Keeley

create table DBO.InstrumentClass_hst(
	InstrumentClassID int not null,
	FMInstClass varchar(100),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CICSuffix varchar(2),
	EndDt datetime,
	LastActionUserID int)