USE Keeley

create table DBO.dba_indexDefragStatus_hst(
	databaseID int not null,
	databaseName nvarchar not null,
	objectID int not null,
	indexID int not null,
	partitionNumber smallint not null,
	fragmentation float not null,
	page_count int not null,
	range_scan_count bigint not null,
	schemaName nvarchar,
	objectName nvarchar,
	indexName nvarchar,
	scanDate datetime not null,
	defragDate datetime,
	printStatus bit not null,
	exclusionMask int not null,
	EndDt datetime,
	LastActionUserID int)