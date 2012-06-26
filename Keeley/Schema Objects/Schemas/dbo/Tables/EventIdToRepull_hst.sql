USE Keeley

create table DBO.EventIdToRepull_hst(
	EventId int not null,
	EndDt datetime,
	LastActionUserID int)