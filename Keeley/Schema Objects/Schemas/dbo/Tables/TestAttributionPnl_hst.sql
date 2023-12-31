﻿USE Keeley

create table DBO.TestAttributionPnl_hst(
	AttributionPnlId int not null,
	PortfolioId int not null,
	FundId int not null,
	PositionID int not null,
	ReferenceDate datetime not null,
	AttributionSourceId int not null,
	MarketValue numeric(15,2) not null,
	NetPosition numeric(15,2) not null,
	IsNetPositionLong bit not null,
	IsExposureLong bit not null,
	Exposure numeric(15,2) not null,
	ExposureDelta numeric(15,2) not null,
	TodayPricePnl numeric(15,2) not null,
	TodayFxPnl numeric(15,2) not null,
	TodayCarryPnl numeric(15,2) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	AttributionNavId int not null,
	CurrencyId int not null,
	TodayOtherPnl numeric(15,2) not null,
	PnlTypeId int not null,
	Price numeric(27,8) not null,
	PriceId int,
	PriceToPositionFXRate numeric(35,16) not null,
	PriceToPositionFXRateId int,
	FXRate numeric(35,16) not null,
	FXRateId int,
	BetaShortTerm numeric(27,8),
	BetaLongTerm numeric(27,8),
	TodayRealisedFXPnl numeric(27,8) not null,
	TodayRealisedPricePnl numeric(27,8) not null,
	TodayCashBenefit numeric(27,8) not null,
	NotionalCost numeric(27,8) not null,
	MarketDataStatus int,
	BetaShortTermId int,
	BetaLongTermId int,
	NavFXRate numeric(35,16),
	PricePnl numeric(27,8),
	FXPnl numeric(27,8),
	MaxExposure numeric(27,8) not null,
	ForwardFXRate numeric(35,16),
	ForwardFXRateId int,
	EndDt datetime,
	LastActionUserID int)