USE Keeley

create table DBO.ExtractEventFieldConfiguration_hst(
	ExtractFieldConfigurationID int not null,
	ExtractId int not null,
	EventFieldId int not null,
	EventFieldIntValue int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)