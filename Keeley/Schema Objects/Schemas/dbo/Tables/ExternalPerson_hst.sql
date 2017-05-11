USE Keeley

create table DBO.ExternalPerson_hst(
	ExternalPersonId int not null,
	Name varchar(100) not null,
	ExternalEntityId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)