﻿USE Keeley

create table DBO.IdentifierType_hst(
	IdentifierTypeID int not null,
	FMIdentType varchar(20),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)