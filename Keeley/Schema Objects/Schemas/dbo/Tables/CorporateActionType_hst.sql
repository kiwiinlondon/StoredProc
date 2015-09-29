USE Keeley

create table DBO.CorporateActionType_hst(
	CorporateActionTypeId int not null,
	Name varchar(128) not null,
	InputDate datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)