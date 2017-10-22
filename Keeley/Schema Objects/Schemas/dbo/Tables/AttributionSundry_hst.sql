USE Keeley

create table DBO.AttributionSundry_hst(
	AttributionSundryId int not null,
	PortfolioId int not null,
	FundId int not null,
	PositionID int not null,
	ReferenceDate datetime not null,
	AttributionSourceId int not null,
	Value numeric(15,2) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	AttributionNavId int not null,
	SundryTypeId int not null,
	PercentageOfFund numeric(9,8) not null,
	CurrencyId int not null,
	EndDt datetime,
	LastActionUserID int)