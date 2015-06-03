USE Keeley

create table DBO.EntityType_hst(
	EntityTypeID int not null,
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FullyQualifiedName varchar(500) not null,
	EndDt datetime,
	LastActionUserID int)