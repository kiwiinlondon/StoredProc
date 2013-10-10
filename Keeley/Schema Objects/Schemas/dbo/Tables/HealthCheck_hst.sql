USE Keeley

create table DBO.HealthCheck_hst(
	HealthCheckId int not null,
	HealthCheckTypeId int not null,
	Name varchar(100) not null,
	ErrorInProgress bit not null,
	LastCheckTime datetime not null,
	EmailFrequencyMins int not null,
	Arguments varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	ErrorEmailSendTime datetime,
	EndDt datetime,
	LastActionUserID int)