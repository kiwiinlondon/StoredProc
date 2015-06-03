USE Keeley

create table DBO.Client_hst(
	ClientId int not null,
	ExternalReference varchar(150),
	ClientSubTypeId int not null,
	Name varchar(150) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Unconfirmed bit not null,
	SalesPersonId int,
	CountryId int not null,
	EndDt datetime,
	LastActionUserID int)