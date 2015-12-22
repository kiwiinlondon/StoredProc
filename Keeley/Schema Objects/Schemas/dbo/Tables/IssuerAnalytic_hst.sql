USE Keeley

create table DBO.IssuerAnalytic_hst(
	IssuerAnalyticId int not null,
	AnalyticTypeID int not null,
	IssuerId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	RawIssuerAnalyticId int,
	EndDt datetime,
	LastActionUserID int)