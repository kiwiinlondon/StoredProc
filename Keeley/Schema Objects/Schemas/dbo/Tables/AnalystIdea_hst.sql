USE Keeley

create table DBO.AnalystIdea_hst(
	AnalystIdeaId int not null,
	InstrumentMarketId int not null,
	AnalystId int not null,
	ResearchNoteLastReceived datetime not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)