USE Keeley

create table DBO.ExtractInputConfiguration_hst(
	ExtractFieldConfigurationID int not null,
	ExtractId int not null,
	EntityPropertyId int not null,
	IntValue int,
	StringValue varchar(1000),
	DecimalValue decimal,
	DateTimeValue datetime,
	BitValue bit,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)