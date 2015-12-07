USE Keeley

create table DBO.ManagerPriceTargetIssuer_hst(
	ManagerPriceTargetIssuerId int not null,
	ManagerId int not null,
	IssuerId int not null,
	StopLossPrice numeric(27,8),
	TargetPrice numeric(27,8),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	StopLossContraToEurRate numeric(27,8),
	StopLossBaseToEurRate numeric(27,8),
	TargetContraToEurRate numeric(27,8),
	TargetBaseToEurRate numeric(27,8),
	EndDt datetime,
	LastActionUserID int)