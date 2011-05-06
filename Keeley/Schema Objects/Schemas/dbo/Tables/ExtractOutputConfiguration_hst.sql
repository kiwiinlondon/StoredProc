USE Keeley

create table DBO.ExtractOutputConfiguration_hst(
	ExtractOutputConfigurationID int not null,
	ExtractId int not null,
	Label varchar(1000),
	ChangesCanBeIgnored bit not null,
	OrderBy int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EntityPropertyId int not null,
	EntityPropertyToWriteId int not null,
	EndDt datetime,
	LastActionUserID int)