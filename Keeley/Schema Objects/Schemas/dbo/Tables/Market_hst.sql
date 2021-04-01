﻿USE Keeley

create table DBO.Market_hst(
	LegalEntityID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	BBExchangeCode varchar(30),
	MicCode varchar(10),
	FixedIncomeMicCode varchar(20),
	TimeZoneId varchar(100),
	OpenTime time,
	CloseTime time,
	EndDt datetime,
	LastActionUserID int)