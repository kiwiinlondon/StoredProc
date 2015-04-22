USE Keeley

create table DBO.TransferEvent_hst(
	EventID int not null,
	FromAccountId int not null,
	ToAccountId int not null,
	Quantity numeric(27,8) not null,
	InstrumentMarketID int not null,
	AmendmentNumber int not null,
	IsCancelled bit not null,
	TradeDate datetime not null,
	SettlementDate datetime not null,
	InputDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Notes varchar(150),
	ApprovedByUserId int,
	EndDt datetime,
	LastActionUserID int)