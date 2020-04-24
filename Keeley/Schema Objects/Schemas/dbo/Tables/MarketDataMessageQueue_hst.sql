USE Keeley

create table DBO.MarketDataMessageQueue_hst(
	MessageId int not null,
	EndPointId int not null,
	MarketDataEntityTypeId int not null,
	MarketDataEntityId int not null,
	Message varchar(-1),
	StartDt datetime not null,
	EndDt datetime,
	LastActionUserID int)