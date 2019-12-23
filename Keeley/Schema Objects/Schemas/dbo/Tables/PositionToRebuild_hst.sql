USE Keeley

create table DBO.PositionToRebuild_hst(
	PositionId int not null,
	FundId int not null,
	Ordering int not null,
	IsErrored bit not null,
	RebuildFromDate datetime,
	EndDt datetime,
	LastActionUserID int)