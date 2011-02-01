USE Keeley

create table DBO.KeeleyType_hst(
	KeeleyTypeID int not null,
	Name varchar(100) not null,
	AssemblyName varchar(400) not null,
	TypeName varchar(400) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)