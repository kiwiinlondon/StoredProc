USE Keeley

create table DBO.dba_indexDefragExclusion_hst(
	databaseID int not null,
	databaseName nvarchar not null,
	objectID int not null,
	objectName nvarchar not null,
	indexID int not null,
	indexName nvarchar not null,
	exclusionMask int not null,
	EndDt datetime,
	LastActionUserID int)