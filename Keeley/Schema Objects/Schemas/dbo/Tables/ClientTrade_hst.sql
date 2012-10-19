USE Keeley

create table DBO.ClientTrade_hst(
	ClientTradeId int not null,
	SettlementDate datetime not null,
	TradeDate datetime not null,
	ClientTradeTypeId int not null,
	FundId int not null,
	TradeReference varchar(20) not null,
	Quantity numeric(27,8) not null,
	Price numeric(27,8) not null,
	CurrencyId int not null,
	Discount numeric(27,8) not null,
	NetConsideration numeric(27,8) not null,
	Commission numeric(27,8) not null,
	DilutionLevy numeric(27,8) not null,
	ClientAccountId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)