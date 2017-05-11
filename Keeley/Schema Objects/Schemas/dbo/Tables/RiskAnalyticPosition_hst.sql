USE Keeley

create table DBO.RiskAnalyticPosition_hst(
	RiskAnalyticPositionId int not null,
	RiskAnalyticTypeId int not null,
	ReferenceDate datetime not null,
	InstrumentMarketId int not null,
	FundId int not null,
	Value1d numeric(28,16) not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)