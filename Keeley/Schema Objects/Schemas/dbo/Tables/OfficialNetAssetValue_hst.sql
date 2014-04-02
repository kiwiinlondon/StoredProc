USE Keeley

create table DBO.OfficialNetAssetValue_hst(
	OfficialNetAssetValueId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InSpecieTransfer numeric(27,8),
	UnitsInIssue numeric(27,8),
	GrossAssetValue numeric(27,8),
	TodayManagementFee numeric(27,8),
	ValueIsForReferenceDate bit not null,
	EndDt datetime,
	LastActionUserID int)