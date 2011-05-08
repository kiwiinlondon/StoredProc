USE Keeley

create table DBO.PortfolioOld_hst(
	PortfolioID int not null,
	PositionID int not null,
	ReferenceDate datetime not null,
	NetPosition numeric(27,8) not null,
	UnitCost numeric(35,16) not null,
	MarkPrice numeric(35,16) not null,
	FXRate numeric(35,16) not null,
	MarketValue numeric(27,8) not null,
	DeltaEquityPosition numeric(27,8) not null,
	RealisedFXPNL numeric(27,8) not null,
	UnRealisedFXPNL numeric(27,8) not null,
	RealisedPricePNL numeric(27,8) not null,
	UnRealisedPricePNL numeric(27,8) not null,
	Accrual numeric(27,8) not null,
	CashIncome numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FMContViewLadderID int,
	EndDt datetime,
	LastActionUserID int)