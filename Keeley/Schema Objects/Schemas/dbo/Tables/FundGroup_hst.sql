USE Keeley

create table DBO.FundGroup_hst(
	FundGroupId int not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	LongName varchar(70) not null,
	Description varchar(200),
	EndDt datetime,
	LastActionUserID int)