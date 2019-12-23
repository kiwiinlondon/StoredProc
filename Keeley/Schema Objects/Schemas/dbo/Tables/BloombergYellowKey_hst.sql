USE Keeley

create table DBO.BloombergYellowKey_hst(
	BloombergYellowKeyId int not null,
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	Code varchar(10) not null,
	EndDt datetime,
	LastActionUserID int)