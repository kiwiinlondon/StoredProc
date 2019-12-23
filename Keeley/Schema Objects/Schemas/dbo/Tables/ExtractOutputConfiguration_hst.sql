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
	EntityPropertyId int,
	EntityPropertyToWriteId int,
	Format varchar(1000),
	FXRateEntityPropertyToApply int,
	Absolute bit not null,
	IncludeForInstrumentClassId bit,
	InstrumentClassIds varchar(50),
	IncludeForEntityStatusId bit,
	EntityStatusIds varchar(10),
	EndDt datetime,
	LastActionUserID int)