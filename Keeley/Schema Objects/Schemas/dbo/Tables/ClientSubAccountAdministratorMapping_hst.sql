USE Keeley

create table DBO.ClientSubAccountAdministratorMapping_hst(
	SubAccountAdministratorMappingId int not null,
	SubAccountAdministratorId int not null,
	FundAdministratorId int not null,
	ParentClientId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	MappingCodes varchar(500),
	AssetManagementCompanyId int,
	EndDt datetime,
	LastActionUserID int)