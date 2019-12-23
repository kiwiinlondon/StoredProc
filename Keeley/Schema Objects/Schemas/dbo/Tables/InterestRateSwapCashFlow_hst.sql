USE Keeley

create table DBO.InterestRateSwapCashFlow_hst(
	InstrumentId int not null,
	CashFlowDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)