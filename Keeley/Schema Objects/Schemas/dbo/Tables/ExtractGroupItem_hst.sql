USE Keeley

create table DBO.ExtractGroupItem_hst(
	ExtractGroupItemId int not null,
	ExtractGroupId int not null,
	ExtractId int not null,
	Ordering int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)