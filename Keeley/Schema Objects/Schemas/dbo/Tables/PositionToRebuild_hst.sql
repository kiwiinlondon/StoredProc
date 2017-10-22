USE Keeley

create table DBO.PositionToRebuild_hst(
	PositionId int not null,
	FundId int not null,
	Ordering int not null,
	IsErrored bit not null,
	EndDt datetime,
	LastActionUserID int)