USE Keeley

create table DBO.ClientAccount_hst(
	ClientAccountId int not null,
	ClientId int not null,
	AccountReference varchar(50),
	AdministratorId int not null,
	Name varchar(100) not null,
	CountryId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)