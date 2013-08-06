USE Keeley

create table DBO.FileToBeCollectedGroup_hst(
	FilesToBeCollectedGroupId int not null,
	Name varchar(200),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)