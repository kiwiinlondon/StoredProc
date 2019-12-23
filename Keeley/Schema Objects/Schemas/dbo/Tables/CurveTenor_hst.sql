USE Keeley

create table DBO.CurveTenor_hst(
	CurveTenorId int not null,
	CurveId int not null,
	ReferenceDate datetime not null,
	TenorDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)