﻿USE Keeley

create table DBO.EntityMappingProxy_hst(
	EntityMappingProxyId int not null,
	EntityMappingSetId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)