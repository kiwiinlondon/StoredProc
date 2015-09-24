USE Keeley

create table DBO.FundCountryHoliday_hst(
	FundCountryHoldayId int not null,
	CountryId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	AdministratorId int not null,
	EndDt datetime,
	LastActionUserID int)