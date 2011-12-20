USE Keeley

create table DBO.InstrumentMarketProxy_hst(
	InstrumentMarketProxyId int not null,
	InstrumentMarketId int not null,
	ProxyInstrumentMarketId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)