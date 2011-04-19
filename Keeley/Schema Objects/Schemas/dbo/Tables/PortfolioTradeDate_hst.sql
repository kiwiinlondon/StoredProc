USE Keeley

create table DBO.PortfolioTradeDate_hst(
	PortfolioTradeDateId int not null,
	PositionAccountID int not null,
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
	EndDt datetime,
	LastActionUserID int)