USE Keeley

create table DBO.FactorHierarchy_hst(
	FactorHierarchyId int not null,
	HierarchyName varchar(256) not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)