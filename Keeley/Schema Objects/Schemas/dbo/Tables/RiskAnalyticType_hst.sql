USE Keeley

create table DBO.RiskAnalyticType_hst(
	RiskAnalyticTypeId int not null,
	Name varchar(160) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)