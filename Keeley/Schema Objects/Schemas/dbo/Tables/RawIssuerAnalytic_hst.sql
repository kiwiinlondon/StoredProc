﻿USE Keeley

create table DBO.RawIssuerAnalytic_hst(
	RawIssuerAnalyticId int not null,
	IssuerId int not null,
	AnalyticTypeId int not null,
	ReferenceDate datetime not null,
	EntityRankingSchemeItemId int not null,
	Value numeric(27,8) not null,
	UpdateDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)