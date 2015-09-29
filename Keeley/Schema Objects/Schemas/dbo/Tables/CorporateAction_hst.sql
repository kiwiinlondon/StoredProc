USE Keeley

create table DBO.CorporateAction_hst(
	CorporateActionId int not null,
	CorporateActionTypeId int not null,
	Multiplier numeric(27,8),
	InputDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InstrumentMarketId int not null,
	AnnounceDate datetime not null,
	ExDate datetime not null,
	PayDate datetime not null,
	EndDt datetime,
	LastActionUserID int)