USE Keeley

create table DBO.IssuerIndustry_hst(
	IssuerIndustryID int not null,
	IssuerID int not null,
	IndustryID int not null,
	IndustryClassificationID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)