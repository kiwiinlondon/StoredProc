USE Keeley

create table DBO.MessageQueue_hst(
	MessageId int not null,
	MessageTypeId int not null,
	Message varchar(512) not null,
	ChangeType char not null,
	MessageSource varchar(50) not null,
	StartDt datetime not null,
	EndDt datetime,
	LastActionUserID int)