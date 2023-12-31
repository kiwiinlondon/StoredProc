﻿USE Keeley

create table DBO.ClientAccount_hst(
	ClientAccountId int not null,
	ClientId int not null,
	AccountReference varchar(150),
	AdministratorId int not null,
	Name varchar(150) not null,
	CountryId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsActive bit not null,
	ParentClientAccountId int,
	StaffId int,
	FundId int,
	ManualUpdate bit not null,
	ClientHasChanged bit not null,
	ClientPlatformId int,
	EndDt datetime,
	LastActionUserID int)