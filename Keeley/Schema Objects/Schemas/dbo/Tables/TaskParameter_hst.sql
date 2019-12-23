USE Keeley

create table DBO.TaskParameter_hst(
	TaskParameterId int not null,
	TaskId int not null,
	TaskParameterTypeId int not null,
	IntValue int,
	StringValue varchar(1000),
	DecimalValue numeric(27,8),
	DateTimeValue datetime,
	BitValue bit,
	IntValues varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)