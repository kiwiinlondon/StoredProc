﻿USE Keeley

create table DBO.LegalEntity_hst(
	LegalEntityID int not null,
	FMOrgId int,
	Name varchar(70) not null,
	LongName varchar(100) not null,
	CountryID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	BBCompany int,
	CountryOfIncorporationId int,
	CountryOfDomicileId int not null,
	ParentLegalEntityId int,
	PulseIdentifier varchar(100),
	CompanySizeId int not null,
	MarketCapUSD numeric(15,0),
	UltimateParentName varchar(100),
	UltimateParentLEI varchar(100),
	LEI varchar(100),
	EndDt datetime,
	LastActionUserID int)