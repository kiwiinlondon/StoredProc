USE Keeley

create table DBO.FundHighWaterMark_hst(
	FundID int not null,
	HighWaterMark numeric(27,8) not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)