USE Keeley

create table DBO.LegalEntityChargeSchedule_hst(
	LegalEntityChargeScheduleId int not null,
	CounterpartyId int,
	CustodianId int,
	ChargeScheduleId int not null,
	EffectiveFromDt datetime not null,
	EffectiveToDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CountryId int,
	EndDt datetime,
	LastActionUserID int)