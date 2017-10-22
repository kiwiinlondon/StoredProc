USE Keeley

create table DBO.PortfolioFX_hst(
	PortfolioFXId int not null,
	PortfolioId int not null,
	CurrencyId int not null,
	FXRate numeric(27,8) not null,
	FXRateId int not null,
	NotionalCost numeric(27,8) not null,
	TodayRealisedFXPNL numeric(27,8) not null,
	TodayUnRealisedFXPNL numeric(27,8) not null,
	TodayRealisedPricePNL numeric(27,8) not null,
	TodayUnRealisedPricePNL numeric(27,8) not null,
	TodayCashBenefit numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	Exposure numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)