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
	UnderlyingIssuerId int not null,
	DerivedAssetClassId int not null,
	BloombergGlobalId varchar(25),
	BloombergTicker varchar(25),
	BloombergYellowKeyId int,
	Is13F bit not null,
	Cusip varchar(10),
	EndDt datetime,
	LastActionUserID int)