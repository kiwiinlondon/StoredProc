USE Keeley

create table DBO.EnforcePositionEvent_hst(
	EventID int not null,
	ReferenceDate datetime not null,
	AmendmentNumber int not null,
	InstrumentMarketId int not null,
	IsCancelled bit not null,
	CurrencyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InputDate datetime not null,
	MustExistEntityTypeId int not null,
	EndDt datetime,
	LastActionUserID int)