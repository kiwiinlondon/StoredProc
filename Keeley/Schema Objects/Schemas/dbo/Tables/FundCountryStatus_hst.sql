USE Keeley

create table DBO.FundCountryStatus_hst(
	FundCountryStatusId int not null,
	FundId int not null,
	CountryId int not null,
	HasReportingStatus bit not null,
	IsRegistered bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)