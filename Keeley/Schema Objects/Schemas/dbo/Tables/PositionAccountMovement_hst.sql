USE Keeley

create table DBO.PositionAccountMovement_hst(
	PositionAccountMovementID int not null,
	InternalAllocationId int not null,
	PositionAccountId int not null,
	ReferenceDate datetime not null,
	PortfolioAggregationLevelId int not null,
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
	NetPosition numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)