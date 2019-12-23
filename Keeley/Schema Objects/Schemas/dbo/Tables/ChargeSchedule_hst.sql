USE Keeley

create table DBO.ChargeSchedule_hst(
	ChargeScheduleId int not null,
	InstrumentClassId int not null,
	Name varchar(100) not null,
	ChargeTypeId int not null,
	IssuerId int,
	CurrencyId int,
	ApplyToQuantity bit not null,
	PercentageToApply numeric(27,8),
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)