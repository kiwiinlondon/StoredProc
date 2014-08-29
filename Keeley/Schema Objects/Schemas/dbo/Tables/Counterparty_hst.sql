USE Keeley

create table DBO.Counterparty_hst(
	LegalEntityID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsElectronic bit,
	UbsCsaName varchar(50),
	UbsCsaRateOverride numeric(27,8),
	EndDt datetime,
	LastActionUserID int)