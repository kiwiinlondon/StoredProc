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
	EndDt datetime,
	LastActionUserID int)