USE Keeley

create table DBO.EventField_hst(
	EventFieldID int not null,
	EventTypeId int not null,
	FieldOnInternalAllocaion bit not null,
	Name varchar(70) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)