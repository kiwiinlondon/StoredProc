USE Keeley

create table DBO.AdditionalFundIndex_hst(
	AdditionalFundIndexId int not null,
	FundId int not null,
	IndexId int not null,
	FundIndexTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)