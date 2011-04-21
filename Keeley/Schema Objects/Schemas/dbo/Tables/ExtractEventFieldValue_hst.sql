USE Keeley

create table DBO.ExtractEventFieldValue_hst(
	ExtractEventFieldValueID int not null,
	ExtractEventID int not null,
	EventFieldId int not null,
	EventFieldIntValue int,
	EventFieldStringValue varchar(1000),
	EventFieldDecimalValue decimal,
	EventFieldDateTimeValue datetime,
	EventFieldBitValue bit,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)