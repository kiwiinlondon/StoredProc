﻿USE Keeley

create table DBO.Strategy_hst(
	StrategyId int not null,
	Name varchar(100) not null,
	FMCode varchar(5) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)