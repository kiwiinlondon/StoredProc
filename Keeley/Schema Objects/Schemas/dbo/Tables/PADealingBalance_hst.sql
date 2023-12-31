﻿USE Keeley

create table DBO.PADealingBalance_hst(
	PADealingBalanceID int not null,
	UserID int not null,
	InstrumentMarketID int not null,
	UserAccountID int not null,
	Quantity numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	LastPADealDate datetime not null,
	CurrentPrice numeric(27,8) not null,
	CurrentPriceId int not null,
	BookCost numeric(27,8) not null,
	RealisedPNL numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)