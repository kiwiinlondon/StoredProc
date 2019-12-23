USE Keeley

create table DBO.EntityRankingScheme_hst(
	EntityRankingSchemeId int not null,
	Name varchar(100) not null,
	FMValueSchemeId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)