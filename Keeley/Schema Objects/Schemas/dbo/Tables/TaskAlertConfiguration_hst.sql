USE Keeley

create table DBO.TaskAlertConfiguration_hst(
	TaskAlertConfigurationId int not null,
	TaskAlertConfigurationTypeId int not null,
	TaskAlertId int not null,
	StringValue varchar(1000),
	IntValue int,
	TimeValue time,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)