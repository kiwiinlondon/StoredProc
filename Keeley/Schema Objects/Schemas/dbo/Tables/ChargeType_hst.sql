USE Keeley

create table DBO.ChargeType_hst(
	ChargeTypeId int not null,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PaidToCustodian bit,
	EndDt datetime,
	LastActionUserID int)