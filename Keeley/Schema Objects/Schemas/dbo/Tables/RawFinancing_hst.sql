USE Keeley

create table DBO.RawFinancing_hst(
	RawFinancingId int not null,
	FinancingId int not null,
	RawFinancingTypeId int not null,
	Notional numeric(27,8),
	Rate numeric(27,8),
	Accrual numeric(27,8),
	Units numeric(27,8),
	Price numeric(27,8),
	DayCount int not null,
	DayBasis int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FinancingControlId int not null,
	EndDt datetime,
	LastActionUserID int)