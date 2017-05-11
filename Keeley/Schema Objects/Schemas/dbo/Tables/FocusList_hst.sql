﻿USE Keeley

create table DBO.FocusList_hst(
	FocusListId int not null,
	InstrumentMarketId int not null,
	AnalystId int not null,
	InDate datetime not null,
	InPrice numeric(27,8) not null,
	IsLong bit not null,
	OutDate datetime,
	OutPrice numeric(27,8),
	CurrentPrice numeric(27,8) not null,
	CurrentPriceId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CurrentPriceDate datetime not null,
	EndOfYearPrice numeric(27,8) not null,
	RelativeIndexInstrumentMarketId int not null,
	RelativeInPrice numeric(27,8) not null,
	RelativeOutPrice numeric(27,8),
	RelativeEndOfYearPrice numeric(27,8) not null,
	RelativeCurrentPrice numeric(27,8) not null,
	RelativeCurrentPriceId int not null,
	AdjustmentFactorITD numeric(27,8),
	AdjustmentFactorYTD numeric(27,8),
	RelativeCurrentPriceDate datetime not null,
	IssuerId int not null,
	EndDt datetime,
	LastActionUserID int)