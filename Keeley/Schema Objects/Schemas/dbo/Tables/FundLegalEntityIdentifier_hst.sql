USE Keeley

create table DBO.FundLegalEntityIdentifier_hst(
	FundLegalEntityIdentifierId int not null,
	FundId int not null,
	LegalEntityId int not null,
	Identifier varchar(50) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IdentifierTypeId int,
	EndDt datetime,
	LastActionUserID int)