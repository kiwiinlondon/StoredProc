USE Keeley

create table DBO.FactorRelationship_hst(
	FactorRelationshipId int not null,
	FactorHierarchyId int not null,
	FactorName varchar(256) not null,
	BloombergFactorName varchar(256),
	ParentFactorRelationshipId int,
	EntityTypeId int,
	EntityId int,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)