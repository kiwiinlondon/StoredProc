USE Keeley

create table DBO.Industry_hst(
	IndustryID int not null,
	ParentIndustryID int,
	IndustryClassificationID int not null,
	Name varchar(100) not null,
	Code varchar(100),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)