USE Keeley

create table DBO.MessageProperty_hst(
	MessagePropertyId int not null,
	MessageId int not null,
	FieldName varchar(100) not null,
	OriginalValue varchar(100) not null,
	CurrentValue varchar(100) not null,
	EndDt datetime,
	LastActionUserID int)