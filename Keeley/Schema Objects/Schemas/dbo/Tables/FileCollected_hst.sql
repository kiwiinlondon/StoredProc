﻿USE Keeley

create table DBO.FileCollected_hst(
	FileCollectedId int not null,
	FileToBeCollectedId int not null,
	ResolvedFileName varchar(150) not null,
	FileCreatedDate datetime not null,
	Processed bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FileHash varchar(64),
	EndDt datetime,
	LastActionUserID int)