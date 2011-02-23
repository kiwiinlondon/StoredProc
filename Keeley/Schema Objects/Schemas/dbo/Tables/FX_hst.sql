USE Keeley

create table DBO.FX_hst(
	InstrumentID int not null,
	ReceiveCurrencyId int not null,
	PayCurrencyId int not null,
	CounterpartyId int not null,
	ReceiveAmount decimal not null,
	PayAmount decimal not null,
	IsProp bit not null,
	EnteredMultiply bit not null,
	MaturityDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)