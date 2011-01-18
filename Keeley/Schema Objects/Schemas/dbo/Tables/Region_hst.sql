USE Keeley

create table DBO.Region_hst(
	RegionID int not null,
	Name varchar(100) not null,
	IsoCode varchar(5) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)