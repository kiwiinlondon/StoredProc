USE Keeley

create table DBO.ExtractConfiguration_hst(
	ExtractConfigurationId int not null,
	ExtractId int not null,
	ConfigurationKey varchar(100) not null,
	ConfigurationValue varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)