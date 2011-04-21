USE Keeley

create table DBO.ExtractEventConfiguration_hst(
	ExtractEventConfigurationID int not null,
	ExtractId int not null,
	BuildForInternalAllocationOnly bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)