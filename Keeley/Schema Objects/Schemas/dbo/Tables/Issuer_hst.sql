USE Keeley

create table DBO.Issuer_hst(
	LegalEntityID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	FactsetId varchar(150),
	GicsLevel3IndustryID int not null,
	IssuerTypeId int not null,
	EndDt datetime,
	LastActionUserID int)