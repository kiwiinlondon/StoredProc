USE Keeley

create table DBO.FocusListPrices_hst(
	FocusListPriceId int not null,
	FocusListId int not null,
	ReferenceDate datetime not null,
	Price numeric(27,8) not null,
	AdjustmentFactor numeric(27,8),
	RelativePrice numeric(27,8) not null,
	EndDt datetime,
	LastActionUserID int)