USE Keeley

create table DBO.Client_hst(
	ClientId int not null,
	ExternalReference varchar(20),
	ClientSubTypeId int not null,
	Name varchar(100) not null,
	CountryId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Unconfirmed bit not null,
	EndDt datetime,
	LastActionUserID int)