USE Keeley

create table DBO.FundAnalytic_hst(
	FundAnalyticId int not null,
	FundAnalyticTypeId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsLast bit not null,
	EndDt datetime,
	LastActionUserID int)