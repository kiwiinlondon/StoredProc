USE Keeley

create table DBO.IdentifierType_hst(
	IdentifierTypeID int not null,
	FMIdentTypeId varchar(20),
	Name varchar(100) not null,
	KeeleyTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)