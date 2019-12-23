USE Keeley

create table DBO.KeltPriorHolding_hst(
	KeltPriorHoldingId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime not null,
	Weighting numeric(27,8) not null,
	NumberOfShares numeric(27,8) not null,
	Price numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)