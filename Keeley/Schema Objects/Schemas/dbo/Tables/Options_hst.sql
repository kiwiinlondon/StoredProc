USE Keeley

create table DBO.Options_hst(
	InstrumentId int not null,
	IsPut bit not null,
	StrikePrice numeric(27,8) not null,
	ExpiryDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)