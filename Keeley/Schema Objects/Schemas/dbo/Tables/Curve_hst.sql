USE Keeley

create table DBO.Curve_hst(
	CurveId int not null,
	Name varchar(100) not null,
	BloombergGlobalId varchar(100) not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)