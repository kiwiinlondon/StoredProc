USE Keeley

create table DBO.PeriodicityInterval_hst(
	PeriodicityIntervalId int not null,
	PeriodicityId int not null,
	OccuranceInPeriod int not null,
	DayOfWeek int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)