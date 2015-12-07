USE Keeley

create table DBO.OpenedClosedPosition_hst(
	PositionId int not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsOpened bit,
	PortfolioId int not null,
	EndDt datetime,
	LastActionUserID int)