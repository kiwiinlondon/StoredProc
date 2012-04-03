USE Keeley

create table DBO.FundPerformance_hst(
	FundPerformanceId int not null,
	FundId int not null,
	ValuationBusinessDate datetime not null,
	ValuationCalandarDate datetime not null,
	ValidUntil datetime not null,
	IsInception bit not null,
	FundPrice numeric(27,8) not null,
	FundPriceId int not null,
	RiskFreeRate numeric(27,8) not null,
	RiskFreeRatePriceId int not null,
	BenchmarkPrice numeric(27,8) not null,
	BenchmarkPriceId int not null,
	BenchmarkFundFXRate numeric(27,8) not null,
	BenchmarkFundFXRateId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)