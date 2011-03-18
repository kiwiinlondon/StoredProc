USE Keeley

create table DBO.PortfolioPositionAccountSettlementDate_hst(
	PortfolioPositionAccountSettlementDateId int not null,
	PositionAccountID int not null,
	ReferenceDate datetime not null,
	Quantity numeric(27,8) not null,
	TotalCost numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)