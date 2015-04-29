USE Keeley

create table DBO.PADealingBroker_hst(
	LegalEntityId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)