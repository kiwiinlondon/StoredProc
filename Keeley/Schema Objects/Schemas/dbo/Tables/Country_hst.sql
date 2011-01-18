USE Keeley

create table DBO.Country_hst(
	CountryID int not null,
	Name varchar(100) not null,
	IsoCode varchar(5) not null,
	RegionID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)