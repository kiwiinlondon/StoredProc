USE Keeley

create table DBO.OpenedClosedPosition_hst(
	PositionId int not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsOpened bit not null,
	PortfolioId int not null,
	IsNetPositionLong bit not null,
	IsExposureLong bit not null,
	IsNetPositionLongChanged bit not null,
	IsExposureLongChanged bit not null,
	IsClosed bit not null,
	EndDt datetime,
	LastActionUserID int)