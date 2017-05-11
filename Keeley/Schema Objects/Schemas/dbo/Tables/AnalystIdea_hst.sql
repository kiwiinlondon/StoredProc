USE Keeley

create table DBO.AnalystIdea_hst(
	AnalystIdeaId int not null,
	AnalystId int,
	ResearchNoteLastReceived datetime,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IssuerId int not null,
	ExternalOriginatorId int,
	InternalOriginatorId int,
	InternalOriginatorId2 int,
	OriginatingDate datetime,
	IsOriginatedLong bit,
	EndDt datetime,
	LastActionUserID int)