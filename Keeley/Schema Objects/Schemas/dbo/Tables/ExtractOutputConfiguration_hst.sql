USE Keeley

create table DBO.ExtractOutputConfiguration_hst(
	ExtractOutputConfigurationID int not null,
	ExtractId int not null,
	EntityPropertyId int not null,
	Label varchar(1000),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ChangesCanBeIgnored bit not null,
	EndDt datetime,
	LastActionUserID int)