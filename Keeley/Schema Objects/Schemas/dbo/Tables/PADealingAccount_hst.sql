USE Keeley

create table DBO.PADealingAccount_hst(
	PADealingAccountID int not null,
	UserID int not null,
	Name varchar(100) not null,
	Number varchar(100) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	IsOdeyWealthAccount bit not null,
	EndDt datetime,
	LastActionUserID int)