USE Keeley

create table DBO.MessageQueue_hst(
	MessageId int not null,
	MessageTypeId int not null,
	Message varchar(512),
	ChangeType char not null,
	MessageSource varchar(50) not null,
	StartDt datetime not null,
	FundId int,
	AttributionSourceId int,
	ReferenceDate datetime,
	CurrencyId int,
	PositionId int,
	PnlTypeId int,
	CounterpartyId int,
	AttributionPnlId int,
	EndDt datetime,
	LastActionUserID int)