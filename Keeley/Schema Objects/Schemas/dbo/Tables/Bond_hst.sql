USE Keeley

create table DBO.Bond_hst(
	InstrumentId int not null,
	DayCountConventionID int not null,
	FirstCouponDate datetime,
	CouponFrequency int not null,
	Coupon numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InDefault bit not null,
	MaturityDate datetime not null,
	ParAmount numeric(27,8) not null,
	IssueDate datetime,
	IssuePrice numeric(27,8),
	IsFixed bit,
	BondMaturityTypeId int,
	ConversionPrice numeric(27,8),
	MaturityValue numeric(27,8),
	IsCovered bit,
	EndDt datetime,
	LastActionUserID int)