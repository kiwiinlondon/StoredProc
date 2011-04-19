USE Keeley

create table DBO.Event_hst(
	EventID int not null,
	EventTypeID int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IdentifierTypeId int not null,
	Identifier varchar(100) not null,
	IsTopLevel bit not null,
	EndDt datetime,
	LastActionUserID int)