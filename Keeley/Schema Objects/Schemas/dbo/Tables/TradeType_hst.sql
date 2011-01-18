USE Keeley

create table DBO.TradeType_hst(
	TradeTypeID int not null,
	FMTradType varchar(100),
	Name varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)