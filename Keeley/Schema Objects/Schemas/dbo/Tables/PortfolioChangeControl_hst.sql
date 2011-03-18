USE Keeley

create table DBO.PortfolioChangeControl_hst(
	PortfolioChangeControlId int not null,
	PositionID int not null,
	ReferenceDate date not null,
	ChangeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)