﻿USE Keeley

create table DBO.FileToBeCollectedGroup_hst(
	FileToBeCollectedGroupId int not null,
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FileGroupTypeId int not null,
	Email varchar(100),
	EndDt datetime,
	LastActionUserID int)