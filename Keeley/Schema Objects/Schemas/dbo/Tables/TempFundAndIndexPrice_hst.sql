USE Keeley

create table DBO.TempFundAndIndexPrice_hst(
	PriceId int not null,
	InstrumentMarketId int not null,
	ReferenceDate datetime,
	Value numeric(27,8),
	EndDt datetime,
	LastActionUserID int)