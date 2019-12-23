USE Keeley

create table DBO.BuySellReason_hst(
	BuySellReasonID int not null,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)