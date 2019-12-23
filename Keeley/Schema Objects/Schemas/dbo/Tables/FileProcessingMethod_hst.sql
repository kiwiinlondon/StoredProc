USE Keeley

create table DBO.FileProcessingMethod_hst(
	FileProcessingMethodId int not null,
	Name varchar(70) not null,
	FileTypeId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)