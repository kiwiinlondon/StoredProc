USE Keeley

create table DBO.EntityMapping_hst(
	EntityMappingID int not null,
	EntityId int not null,
	EntityMappingProxyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)