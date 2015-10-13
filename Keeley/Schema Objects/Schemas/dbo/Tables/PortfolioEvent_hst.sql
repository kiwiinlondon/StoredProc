﻿USE Keeley

create table DBO.PortfolioEvent_hst(
	PortfolioEventID int not null,
	InternalAllocationId int not null,
	PositionId int not null,
	ReferenceDate datetime not null,
	PortfolioAggregationLevelId int not null,
	PortfolioEventTypeId int not null,
	ChangeNumber int not null,
	Quantity numeric(27,8) not null,
	FXRate numeric(35,16) not null,
	Price numeric(35,16) not null,
	NetCostChangeInstrumentCurrency numeric(27,8) not null,
	NetCostChangeBookCurrency numeric(27,8) not null,
	NetCostInstrumentCurrency numeric(27,8) not null,
	NetCostBookCurrency numeric(27,8) not null,
	DeltaNetCostChangeInstrumentCurrency numeric(27,8) not null,
	DeltaNetCostChangeBookCurrency numeric(27,8) not null,
	DeltaNetCostInstrumentCurrency numeric(27,8) not null,
	DeltaNetCostBookCurrency numeric(27,8) not null,
	TodayNetPositionChange numeric(27,8) not null,
	TodayDeltaNetCostChangeInstrumentCurrency numeric(27,8) not null,
	TodayDeltaNetCostChangeBookCurrency numeric(27,8) not null,
	TodayNetCostChangeInstrumentCurrency numeric(27,8) not null,
	TodayNetCostChangeBookCurrency numeric(27,8) not null,
	NetPosition numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InputDate datetime not null,
	OrderingResolution int not null,
	Accrual numeric(27,8) not null,
	TodayAccrual numeric(27,8) not null,
	CashBenefit numeric(27,8) not null,
	TodayCashBenefit numeric(27,8) not null,
	TodayCashBenefitBookCurrency numeric(27,8) not null,
	RealisedPricePnl numeric(27,8) not null,
	TodayRealisedPricePnl numeric(27,8) not null,
	RealisedFxPnl numeric(27,8) not null,
	TodayRealisedFxPnl numeric(27,8) not null,
	TotalAccrual numeric(27,8) not null,
	TodayRealisedPricePnlBookCurrency numeric(27,8) not null,
	RealisePnl bit not null,
	TradeInstrumentFXRate numeric(35,16) not null,
	ZeroOutAccrual bit not null,
	BondNominal numeric(28,7),
	BondNominalChange numeric(28,7),
	CapitalChange numeric(27,8),
	TodayCapitalChange numeric(27,8),
	FXRateId int,
	UseFXRateForDay bit not null,
	RealisedCash numeric(27,8),
	ExternalRealisedPnl numeric(27,8),
	OriginalDeltaNetCostBookCurrency numeric(27,8),
	OriginalDeltaNetCostInstrumentCurrency numeric(27,8),
	ITDRealisedPricePnl numeric(27,8) not null,
	ITDRealisedFXPnl numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)