USE Keeley

create table DBO.ExtractEventFieldOutputConfiguration_hst(
	ExtractFieldOutputConfigurationID int not null,
	ExtractId int not null,
	EventFieldId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)