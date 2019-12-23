USE Keeley

create table DBO.EntityPropertyOverride_hst(
	EntityPropertyOverrideId int not null,
	EntityID int not null,
	EntityPropertyId int not null,
	IntValue int,
	StringValue varchar(1000),
	DecimalValue numeric(27,8),
	DateTimeValue datetime,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)