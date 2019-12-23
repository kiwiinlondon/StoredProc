USE Keeley

create table DBO.Originator_hst(
	OriginatorId int not null,
	ExternalOriginatorId int,
	InternalOriginatorId int,
	InternalOriginatorId2 int,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)