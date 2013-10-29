USE Keeley

create table DBO.OfficialNetAssetValue_hst(
	OfficialNetAssetValueId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)