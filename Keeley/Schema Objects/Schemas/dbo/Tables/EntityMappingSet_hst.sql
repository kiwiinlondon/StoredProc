USE Keeley

create table DBO.EntityMappingSet_hst(
	EntityMappingSetId int not null,
	EntityTypeId int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)