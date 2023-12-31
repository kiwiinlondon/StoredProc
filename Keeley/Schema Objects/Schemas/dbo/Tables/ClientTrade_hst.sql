﻿USE Keeley

create table DBO.ClientTrade_hst(
	ClientTradeId int not null,
	SettlementDate datetime not null,
	TradeDate datetime not null,
	ClientTradeTypeId int not null,
	FundId int not null,
	TradeReference varchar(20) not null,
	Quantity numeric(27,8) not null,
	Price numeric(27,8) not null,
	CurrencyId int not null,
	Discount numeric(27,8) not null,
	NetConsideration numeric(27,8) not null,
	Commission numeric(27,8) not null,
	DilutionLevy numeric(27,8) not null,
	ClientAccountId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	HWMPrice numeric(27,8) not null,
	CurrentQuantity numeric(27,8) not null,
	EqFactor numeric(27,8) not null,
	Balance numeric(27,8) not null,
	TotalCost numeric(27,8) not null,
	AdministratorCurrentQuantity numeric(27,8),
	Cost numeric(27,8) not null,
	RelatedTradeId int,
	TransferPriceOverride numeric(27,8),
	BalanceEndOfDay numeric(27,8) not null,
	NavDate datetime not null,
	NetConsiderationEuro numeric(27,8) not null,
	IndexUnits numeric(27,8) not null,
	EqFactorEuro numeric(27,8) not null,
	NetConsiderationGBP numeric(27,8) not null,
	EqFactorGBP numeric(27,8) not null,
	NetConsiderationUSD numeric(27,8) not null,
	EqFactorUSD numeric(27,8) not null,
	CostEuro numeric(27,8) not null,
	CostUSD numeric(27,8) not null,
	CostGBP numeric(27,8) not null,
	IsEstimate bit not null,
	CashSettlementDate datetime,
	EndDt datetime,
	LastActionUserID int)