USE Keeley

create table DBO.AttributionPosition_hst(
	AttributionPositionId int not null,
	PositionId int not null,
	ReferenceDate datetime not null,
	OpenWeight numeric(16,8) not null,
	PriceReturn numeric(16,8) not null,
	FxReturn numeric(16,8) not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)