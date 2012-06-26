USE Keeley

create table DBO.DisclosureRuleInstrument_hst(
	DisclosureRuleInstrumentId int not null,
	DisclosureRuleId int not null,
	Exclude bit not null,
	CountryId int,
	InstrumentMarketId int,
	InstrumentClassId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)