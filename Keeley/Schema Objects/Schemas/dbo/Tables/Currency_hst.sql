USE Keeley

create table DBO.Currency_hst(
	InstrumentID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Ordering int,
	IsDeliverable bit not null,
	EndDt datetime,
	LastActionUserID int)