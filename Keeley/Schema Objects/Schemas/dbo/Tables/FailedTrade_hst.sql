USE Keeley

create table DBO.FailedTrade_hst(
	EventId int not null,
	DaysToSettle int not null,
	FailedTradeReasonId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)