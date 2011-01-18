USE Keeley

create table DBO.Instrument_hst(
	InstrumentID int not null,
	IssuerID int not null,
	InstrumentClassID int not null,
	IssueCurrencyID int not null,
	FMInstId int,
	Name varchar(200) not null,
	LongName varchar(250) not null,
	Isin varchar(150),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)