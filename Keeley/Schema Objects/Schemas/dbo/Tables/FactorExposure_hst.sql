USE Keeley

create table DBO.FactorExposure_hst(
	FactorExposureId int not null,
	FactorRelationshipId int not null,
	ReferenceDate datetime not null,
	FundId int not null,
	InstrumentMarketId int,
	RiskContribution numeric(8,2),
	Risk numeric(9,2),
	Exposure numeric(28,2),
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)