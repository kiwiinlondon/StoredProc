USE Keeley

create table DBO.FocusListPrice_hst(
	FocusListPriceId int not null,
	FocusListId int not null,
	ReferenceDate datetime not null,
	Price numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	RelativePrice numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)