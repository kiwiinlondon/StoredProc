﻿USE Keeley

create table DBO.Portfolio_hst(
	PortfolioId int not null,
	PositionId int not null,
	ReferenceDate datetime not null,
	NetPosition numeric(27,8) not null,
	NetCostInstrumentCurrency numeric(27,8) not null,
	NetCostBookCurrency numeric(27,8) not null,
	DeltaNetCostInstrumentCurrency numeric(27,8) not null,
	DeltaNetCostBookCurrency numeric(27,8) not null,
	TodayNetPostionChange numeric(27,8) not null,
	TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8) not null,
	TodayDeltaNetCostChangeBookCurrency numeric(27,8) not null,
	TodayNetCostChangeInstrumentCurrency numeric(27,8) not null,
	TodayNetCostChangeBookCurrency numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Price numeric(27,8) not null,
	PriceId int,
	FXRate numeric(35,16) not null,
	FXRateId int,
	DeltaMarketValue numeric(27,8) not null,
	TodayCashBenefit numeric(27,8) not null,
	TodayCashBenefitBookCurrency numeric(27,8) not null,
	TodayAccrual numeric(27,8) not null,
	TodayRealisedPricePnl numeric(27,8) not null,
	TodayRealisedFxPnl numeric(27,8) not null,
	TotalAccrual numeric(27,8) not null,
	TodayRealisedPricePnlBookCurrency numeric(27,8) not null,
	TodayUnrealisedFXPnl numeric(27,8) not null,
	TodayUnrealisedPricePnl numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	PriceToPositionFXRate numeric(35,16) not null,
	PriceToPositionFXRateId int,
	PriceIsLastTradePrice bit not null,
	PreviousPortfolioId int,
	BondNominal numeric(28,7),
	TodayCarryAccrual numeric(27,8),
	Delta numeric(27,8),
	UnderlyingPrice numeric(27,8),
	DeltaId int,
	UnderlyingPriceId int,
	UnderlyingPriceToPositionFXRate numeric(27,8),
	UnderlyingPriceToPositionFXRateId int,
	ValuationFXRate numeric(35,16) not null,
	ValuationNetPosition numeric(27,8) not null,
	ValuationDeltaNetCostInstrumentCurrency numeric(27,8) not null,
	ValuationPrice numeric(27,8) not null,
	ValuationPriceToPositionFXRate numeric(27,8) not null,
	ValuationMarketValue numeric(27,8) not null,
	HedgeRatio numeric(27,8),
	HedgeRatioId int,
	BetaShortTerm numeric(27,8),
	BetaShortTermId int,
	BetaLongTerm numeric(27,8),
	BetaLongTermId int,
	PreviousReferenceDate datetime not null,
	TodayCapitalChange numeric(27,8),
	IndexRatio numeric(27,8),
	IndexRatioID int,
	DisclosedNetPosition numeric(27,8) not null,
	ValuationDeltaNetCostBookCurrency numeric(27,8),
	ValuationTodayDeltaNetCostChangeBookCurrency numeric(27,8),
	ValuationTodayDeltaNetCostChangeInstrumentCurrency numeric(27,8),
	ValuationTodayRealisedFxPnl numeric(27,8),
	ValuationTodayRealisedPricePnl numeric(27,8),
	ValuationTomorrowDeltaNetCostChangeBookCurrency numeric(27,8),
	ValuationTomorrowDeltaNetCostChangeInstrumentCurrency numeric(27,8),
	ValuationTomorrowRealisedFxPnl numeric(27,8),
	ValuationTomorrowRealisedPricePnl numeric(27,8),
	ValuationDeltaMarketValue numeric(27,8),
	ValuationTodayUnrealisedFxPnl numeric(27,8),
	ValuationTodayUnrealisedPricePnl numeric(27,8),
	EndDt datetime,
	LastActionUserID int)