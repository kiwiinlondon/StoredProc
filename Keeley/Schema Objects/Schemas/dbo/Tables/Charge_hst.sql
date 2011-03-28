USE Keeley

create table DBO.Charge_hst(
	ChargeId int not null,
	InternalAllocationID int not null,
	ChargeTypeId int not null,
	CurrencyId int not null,
	Quantity numeric(27,8) not null,
	FXRate numeric(35,16) not null,
	FXRateMultiply bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)