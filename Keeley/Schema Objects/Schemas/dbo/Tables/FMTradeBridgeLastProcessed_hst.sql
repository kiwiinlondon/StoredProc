USE Keeley

create table DBO.FMTradeBridgeLastProcessed_hst(
	FMTradeBridgeLastProcessedId int not null,
	LastContEventId int not null,
	MaxInputDate datetime not null,
	DataVersion binary(8) not null,
	IsTrade bit,
	LastProcessedTime datetime not null,
	EndDt datetime,
	LastActionUserID int)