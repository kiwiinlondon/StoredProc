USE Keeley

create table DBO.DealingDateDefinition_hst(
	DealingDateDefinitionId int not null,
	Name varchar(100) not null,
	PeriodicityId int not null,
	CutOffTime time,
	CutOffDaysPrior int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)