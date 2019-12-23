USE Keeley

create table DBO.IdentifierMapping_hst(
	IdentifierMappingId int not null,
	IdentifierTypeId int not null,
	OriginalValue varchar(200),
	MappedValue varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)