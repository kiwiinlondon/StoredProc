USE Keeley

create table DBO.ClientTrail_hst(
	ClientTrailId int not null,
	ClientAccountId int not null,
	FundId int not null,
	Rate numeric(27,8) not null,
	Quantity numeric(27,8) not null,
	EffectiveStartDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)