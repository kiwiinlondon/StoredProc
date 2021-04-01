USE Keeley

create table DBO.ClientPlatform_hst(
	ClientPlatformId int not null,
	Name varchar(150) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	URL varchar(200),
	EndDt datetime,
	LastActionUserID int)