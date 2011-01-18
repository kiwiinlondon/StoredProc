USE Keeley

create table DBO.LegalEntity_hst(
	LegalEntityID int not null,
	FMOrgId int not null,
	Name varchar(70) not null,
	LongName varchar(100) not null,
	CountryID int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)