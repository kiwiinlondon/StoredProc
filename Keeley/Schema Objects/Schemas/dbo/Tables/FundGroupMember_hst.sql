USE Keeley

create table DBO.FundGroupMember_hst(
	FundGroupMemberId int not null,
	FundGroupId int not null,
	FundId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)