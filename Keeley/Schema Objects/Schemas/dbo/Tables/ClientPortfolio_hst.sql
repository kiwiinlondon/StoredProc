﻿USE Keeley

create table DBO.ClientPortfolio_hst(
	ClientPortfolioId int not null,
	ClientAccountId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Quantity numeric(27,8) not null,
	ChangeInQuantity numeric(27,8) not null,
	MarketValue numeric(27,8) not null,
	PriceId int not null,
	Price numeric(27,8) not null,
	Cost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	TodayRealisedPnl numeric(27,8) not null,
	OpeningValue numeric(27,8) not null,
	TodayUnRealisedPnl numeric(27,8) not null,
	ChangeInCost numeric(27,8) not null,
	EqualisationFactor numeric(27,8) not null,
	FirstTradeDate datetime not null,
	IsLast bit not null,
	ManagerQuantity numeric(27,8),
	ManagerValue numeric(27,8),
	SubscriptionRedemptionValue numeric(27,8) not null,
	TodayRedemptionPnl numeric(27,8) not null,
	OpeningValueAfterTodaysTrades numeric(27,8) not null,
	TodayPnl numeric(27,8) not null,
	ClientPortfolioByClientShareClassId int not null,
	TodayReturn numeric(27,8) not null,
	ITDReturn numeric(27,8) not null,
	TodayRedemptionValue numeric(27,8),
	TodayRedemptionQuantity numeric(27,8),
	TodaySubscriptionValue numeric(27,8),
	TodaySubscriptionQuantity numeric(27,8),
	ValueOfTodaysSubscriptionRedeemed numeric(27,8),
	EndDt datetime,
	LastActionUserID int)