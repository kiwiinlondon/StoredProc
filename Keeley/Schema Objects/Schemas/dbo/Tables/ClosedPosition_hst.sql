USE Keeley

create table DBO.ClosedPosition_hst(
	ClosedPositionID int not null,
	PositionId int not null,
	ReferenceDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)