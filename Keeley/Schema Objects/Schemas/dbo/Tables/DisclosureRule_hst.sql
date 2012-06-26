USE Keeley

create table DBO.DisclosureRule_hst(
	DisclosureRuleId int not null,
	Name varchar(70) not null,
	LongLimit numeric(27,8) not null,
	LongStep numeric(27,8) not null,
	ShortLimit numeric(27,8) not null,
	ShortStep numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)