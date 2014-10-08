USE Keeley

create table DBO.AssetManagementCompany_hst(
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	LegalEntityID int not null,
	EndDt datetime,
	LastActionUserID int)