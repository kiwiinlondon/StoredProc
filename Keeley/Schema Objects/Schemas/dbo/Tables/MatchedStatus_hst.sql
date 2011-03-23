USE Keeley

create table DBO.MatchedStatus_hst(
	MatchedStatusID int not null,
	Code varchar(30),
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)