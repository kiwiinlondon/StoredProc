USE Keeley

create table DBO.ApplicationUser_hst(
	UserID int not null,
	FMPersID int,
	Name varchar(100) not null,
	Email varchar(100) not null,
	WindowsLogin varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)