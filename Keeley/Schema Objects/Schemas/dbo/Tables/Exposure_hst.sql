USE Keeley

create table DBO.Exposure_hst(
	ExposureId int not null,
	PositionId int not null,
	InstrumentId int not null,
	PortfolioId int not null,
	ReferenceDate datetime not null,
	NetPosition numeric(27,8) not null,
	EquityExposure numeric(27,8) not null,
	FXExposure numeric(27,8) not null,
	CommodityExposure numeric(27,8) not null,
	FixedIncomeExposure numeric(27,8) not null,
	OtherExposure numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)