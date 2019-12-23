USE Keeley

create table DBO.ExtractEntityPropertyValue_hst(
	ExtractEntityPropertyValueID int not null,
	ExtractEntityID int not null,
	EntityPropertyId int not null,
	PreviousIntValue int,
	IntValue int,
	StringValue varchar(1000),
	PreviousStringValue varchar(1000),
	DecimalValue numeric(27,8),
	PreviousDecimalValue numeric(27,8),
	DateTimeValue datetime,
	PreviousDateTimeValue datetime,
	BitValue bit,
	PreviousBitValue bit,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)