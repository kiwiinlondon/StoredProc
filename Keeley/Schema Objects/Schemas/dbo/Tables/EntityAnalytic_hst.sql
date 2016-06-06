USE Keeley

create table DBO.EntityAnalytic_hst(
	EntityAnalyticId int not null,
	EntityAnalyticTypeId int not null,
	EntityTypeId int not null,
	EntityId int not null,
	SubEntityTypeId int,
	SubEntityId int,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsLast bit not null,
	EndDt datetime,
	LastActionUserID int)