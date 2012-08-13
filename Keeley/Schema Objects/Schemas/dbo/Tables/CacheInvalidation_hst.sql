USE Keeley

create table DBO.CacheInvalidation_hst(
	CacheName varchar(50) not null,
	DataVersion binary(8) not null,
	CacheTime datetime not null,
	EndDt datetime,
	LastActionUserID int)