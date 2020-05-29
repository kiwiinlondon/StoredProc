﻿USE Keeley

create table DBO.Financing_hst(
	FinancingId int not null,
	FundId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	CurrencyId int not null,
	CustodianId int not null,
	NetPosition numeric(27,8),
	Price numeric(27,8),
	Notional numeric(27,8),
	FinancingRate numeric(27,8),
	BorrowRate numeric(27,8),
	FinancingAccrual numeric(27,8),
	BorrowAccrual numeric(27,8),
	AllInAccrual numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	OverborrowNotional numeric(27,8),
	OverborrowUnits numeric(27,8),
	OverborrowRate numeric(27,8),
	OverborrowAccrual numeric(27,8),
	MarginInterest numeric(27,8),
	CashInterest numeric(27,8),
	RehypothecationEarning numeric(27,8),
	CashInterestRate numeric(27,8),
	CashBalance numeric(27,8),
	MarginBalance numeric(27,8),
	CashInterestCredit numeric(27,8),
	MarginRequirement numeric(27,8),
	SwapFinancingCashBalanceDebit numeric(27,8),
	SwapFinancingCashBalanceCredit numeric(27,8),
	CashInterestDebit numeric(27,8),
	RehypothecationValue numeric(27,8),
	RehypothecationUnits numeric(27,8),
	MarginRequirementRate numeric(27,8),
	MarginRequirementNotional numeric(27,8),
	SwapFinancingCashInterestRateDebit numeric(27,8),
	SwapFinancingCashInterestRateCredit numeric(27,8),
	EndDt datetime,
	LastActionUserID int)