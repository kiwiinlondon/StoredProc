﻿USE Keeley

create table DBO.InstrumentMarket_hst(
	InstrumentMarketID int not null,
	InstrumentID int not null,
	MarketID int not null,
	FMSecId int,
	PriceDivisor numeric(33,18) not null,
	BloombergTicker varchar(150),
	Sedol varchar(150),
	IsPrimary bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PriceCurrencyId int not null,
	ListingStatusId int not null,
	UnderlyingInstrumentMarketId int not null,
	UltimateUnderlyingInstrumentMarketId int not null,
	PriceQuoteMultiplier decimal not null,
	BloombergGlobalId varchar(25),
	LastRepulledFromSourceDate datetime,
	FactsetId varchar(150),
	EndDt datetime,
	LastActionUserID int)