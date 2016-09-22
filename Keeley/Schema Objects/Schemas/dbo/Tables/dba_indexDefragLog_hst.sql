USE Keeley

create table DBO.dba_indexDefragLog_hst(
	indexDefrag_id int not null,
	databaseID int not null,
	databaseName nvarchar not null,
	objectID int not null,
	objectName nvarchar not null,
	indexID int not null,
	indexName nvarchar not null,
	partitionNumber smallint not null,
	fragmentation float not null,
	page_count int not null,
	dateTimeStart datetime not null,
	dateTimeEnd datetime,
	durationSeconds int,
	sqlStatement varchar(4000),
	errorMessage varchar(1000),
	EndDt datetime,
	LastActionUserID int)