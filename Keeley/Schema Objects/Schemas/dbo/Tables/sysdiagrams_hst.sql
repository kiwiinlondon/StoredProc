USE Keeley

create table DBO.sysdiagrams_hst(
	name sysname not null,
	principal_id int not null,
	diagram_id int not null,
	version int,
	definition varbinary,
	EndDt datetime,
	LastActionUserID int)