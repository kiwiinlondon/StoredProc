﻿USE Keeley

create table DBO.Book_hst(
	BookID int not null,
	FMOrgId int,
	Name varchar(70) not null,
	FundID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ManagerId int not null,
	EZEIdentifier varchar(100),
	IsPrimary bit not null,
	IsActive bit not null,
	NavIsNotUsable bit not null,
	SignOffManagerId int not null,
	EndDt datetime,
	LastActionUserID int)