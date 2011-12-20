USE Keeley

create table DBO.CountryHoliday_hst(
	CountryHolidayId int not null,
	CountryId int not null,
	ReferenceDate datetime not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)