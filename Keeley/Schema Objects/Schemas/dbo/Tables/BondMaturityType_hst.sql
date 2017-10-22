USE Keeley

create table DBO.BondMaturityType_hst(
	BondMaturityTypeId int not null,
	Name varchar(50),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)