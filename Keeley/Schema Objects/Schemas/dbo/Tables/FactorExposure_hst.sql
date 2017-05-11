USE Keeley

create table DBO.FactorExposure_hst(
	FactorExposureId int not null,
	FactorRelationshipId int not null,
	FactorBenchmarkId int,
	ReferenceDate datetime not null,
	FundId int not null,
	InstrumentMarketId int,
	PortfolioVolatility numeric(16,4),
	BenchmarkVolatility numeric(16,4),
	TrackingError numeric(16,4),
	ActiveExposure numeric(16,4),
	MarginalX100 numeric(16,4),
	FactorVolatility numeric(16,4),
	TotalActiveVolatility numeric(16,4),
	VolatilityContribution numeric(16,4),
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)