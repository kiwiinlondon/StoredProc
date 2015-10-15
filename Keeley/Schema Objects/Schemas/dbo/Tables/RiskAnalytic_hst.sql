USE Keeley

create table DBO.RiskAnalytic_hst(
	RiskAnalyticId int not null,
	InstrumentMarketId int not null,
	RiskAnalyticTypeId int not null,
	ReferenceDate datetime not null,
	CurrencyId int,
	Value1Day numeric(27,8),
	Value20Day numeric(27,8),
	Value1DayMixedModel numeric(27,8),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)