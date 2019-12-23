USE Keeley

create table DBO.ResearchContributor_hst(
	UserId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)