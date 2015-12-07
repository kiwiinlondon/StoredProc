USE Keeley

create table DBO.AttributionSource_hst(
	AttributionSourceID int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	AdministratorSourced bit not null,
	AdministratorPrevious datetime,
	FactsetSourced bit not null,
	FactsetPrevious datetime,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)