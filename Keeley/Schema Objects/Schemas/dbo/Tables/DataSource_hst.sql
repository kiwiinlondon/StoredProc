USE Keeley

create table DBO.DataSource_hst(
	DataSourceId int not null,
	Name varchar(250) not null,
	StartDt datetime not null,
	DataVersion binary(8) not null,
	UpdateUserID int not null,
	EndDt datetime,
	LastActionUserID int)