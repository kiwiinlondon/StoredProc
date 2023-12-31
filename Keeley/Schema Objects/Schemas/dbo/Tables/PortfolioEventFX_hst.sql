﻿USE Keeley

create table DBO.PortfolioEventFX_hst(
	PortfolioEventFXId int not null,
	PortfolioEventId int not null,
	CurrencyId int not null,
	FromBookFXRate numeric(27,8) not null,
	NotionalCost numeric(27,8) not null,
	RealisedFXPNL numeric(27,8) not null,
	TodayRealisedFXPNL numeric(27,8) not null,
	TodayRealisedPricePNL numeric(27,8) not null,
	TodayCashBenefit numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FXRateId int,
	OriginalNotionalCost numeric(27,8),
	TodayCapitalChange numeric(27,8),
	CapitalChange numeric(27,8),
	EndDt datetime,
	LastActionUserID int)