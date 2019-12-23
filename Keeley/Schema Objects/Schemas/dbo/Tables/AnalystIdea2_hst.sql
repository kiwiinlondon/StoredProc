USE Keeley

create table DBO.AnalystIdea2_hst(
	AnalystIdeaId int not null,
	IssuerId int not null,
	IsLong bit not null,
	EffectiveFromDate datetime not null,
	EffectiveToDate datetime,
	AnalystId int,
	OriginatiorId int,
	FocusListId int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)